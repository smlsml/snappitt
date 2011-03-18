require 'test_helper'

class ExperiencesControllerTest < ActionController::TestCase

  def setup
    @user = users(:dre)

    @params = {
      :to => 'post@example.com',
      :from => @user.email,
      :subject => 'this is the subject',
      :plain => 'this is a caption!' # passed by cloudmailin
    }

    @mail = Mail.new
    @mail.from = @user.email
    @mail.to = @params[:to]
    @mail.subject = @params[:subject]
    @mail.body = @params[:plain]
    @mail.attachments['rails.png'] = File.read(Rails.root.to_s << '/test/fixtures/rails.png')

    @params[:message] = @mail.to_s
  end

  def get_experience(params = {})
    Experience.where({:creator => @user, :title => @params[:subject]}.merge(params)).first
  end

  test "create_mail: creates experience via email" do
    post :create_mail, @params
    assert_response :success

    @experience = get_experience
    assert_kind_of Experience, @experience
    assert_equal 1, @experience.moments.count
    assert_equal @params[:plain], @experience.moments.first.caption.text
  end

  test "create_mail: strips Re and Fwd from subject" do
    expected_subject = 'new subject! re:'
    @params[:subject] = "Re: RE: #{expected_subject}"

    post :create_mail, @params
    assert_response :success

    @experience = get_experience(:title => expected_subject)
    assert_kind_of Experience, @experience
  end

  test "create_mail: uses reply_to instead of to if supplied" do
    @user = users(:snoop)
    @mail.reply_to '%s <%s>' % [@user.username, @user.email]
    @params[:message] = @mail.to_s

    post :create_mail, @params
    assert_response :success

    @experience = get_experience
    assert_kind_of Experience, @experience
  end

end