require 'test_helper'

class ExperiencesControllerTest < ActionController::TestCase

  def setup
    ActionMailer::Base.deliveries.clear

    @user = users(:dre)
    sign_in(@user)

    @params = {
      :to => 'post@example.com',
      :from => @user.email,
      :subject => 'this is the subject',
      :plain => 'this is a caption!' # passed by cloudmailin
    }

    setup_email
  end

  def setup_email
    @mail = Mail.new
    @mail.from = @user.email
    @mail.to = @params[:to]
    @mail.subject = @params[:subject]
    @mail.body = @params[:plain]
    @mail.attachments['rails.png'] = File.read(Rails.root.to_s << '/test/fixtures/rails.png')

    @params[:message] = @mail.to_s
  end

  def get_experience(params = {})
    Experience.where({:user => @user, :title => @params[:subject]}.merge(params)).first
  end

  test "create_mail: creates experience via email" do
    post :create_mail, @params
    assert_response :success

    @experience = get_experience
    assert_kind_of Experience, @experience
    assert_equal 1, @experience.moments.count
    assert_equal @params[:subject], @experience.moments.first.caption.text
    assert_equal @experience.moments.first, @experience.cover
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

  test "create_mail: add to existing experience if to" do
    post :create_mail, @params
    assert_response :success

    @experience = get_experience
    assert_kind_of Experience, @experience

    @snoop = users(:snoop)
    sign_in(@snoop)

    @params[:from] = @snoop.email
    @params[:subject] = 'second exp!'
    @params[:to] = 'post%s@snappitt.com' % @experience.id
    setup_email

    post :create_mail, @params
    assert_response :success

    @experience.reload
    assert_equal @params[:subject], @experience.moments.second.caption.to_s
    assert_equal 2, @experience.moments.count
    assert_equal @snoop, @experience.moments.second.user
  end

  test "create_mail: mail in avatar photo" do
    subject = 'this is a bio yo'
    @params[:to] = 'AVATAR@snappitt.com'
    @params[:subject] = subject
    setup_email

    assert_nil @user.profile.photo_asset

    post :create_mail, @params
    assert_response :success

    @user.reload

    assert_kind_of PhotoAsset, @user.profile.photo_asset
    assert_nil get_experience
    assert_equal subject, @user.profile.bio
  end

  test "create_mail: mail in avatar photo using profile" do
    @params[:to] = 'Profile@snappitt.com'
    setup_email

    assert_nil @user.profile.photo_asset

    post :create_mail, @params
    assert_response :success

    @user.reload

    assert_kind_of PhotoAsset, @user.profile.photo_asset
    assert_nil get_experience
  end

  test "create_mail: event hashtags create and use one experience" do
    @event = events(:artopia)
    @event.experience = nil
    @event.save!

    @params[:to] = '%s@snappitt.com' % @event.hashtag
    setup_email

    post :create_mail, @params
    assert_response :success

    @experience = get_experience(:title => @event.name)
    assert_kind_of Experience, @experience

    email = ActionMailer::Base.deliveries.first
    assert email
    assert_match '%s' % @params[:to], email.body
    assert_match '%s' % @event.prize, email.body

    post :create_mail, @params
    assert_response :success
    assert_equal @experience, get_experience(:title => @event.name)
    assert_equal 2, @experience.reload.moments_count
  end

  test "create_mail: s3 attachments" do
    url = 'http://test.host/test.jpg'
    @params[:attachments] = {'0' =>
                               {:file_name => 'test.jpg',
                                :content_type => 'image/jpg',
                                :url => url,
                                :size => '123',
                                :disposition => 'attachment'}}

    post :create_mail, @params
    assert_response :success

    @experience = get_experience
    assert_kind_of Experience, @experience
    assert_kind_of Moment, @experience.moments.first
    assert_kind_of PhotoAsset, @experience.moments.first.asset
    assert_equal url, @experience.moments.first.asset.tmp_url
  end


end