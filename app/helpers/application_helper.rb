module ApplicationHelper

  def render_flash_messages
    result = ''
    flash.each do |type, message|
      result += content_tag(:div, message, {:class => "flash #{type.to_s}", :id => type.to_s}) unless type.nil?
    end
    content_tag(:div, result, {:class => 'message', :id => 'flash_message', :style => (result) ? '' : 'display:none;'}, false)
  end

  def nav_class(item)
    (' class="%s%s"' % [item, @nav_location == item.to_s ? ' selected' : '']).html_safe
  end

  def controller_css_name
    '%s_controller' % controller_name.singularize.gsub('-', '_')
  end

  def is_account_page?
    request.path.starts_with?('/accounts')
  end

  def can_edit?(user)
    user_signed_in? && ((user && user == current_user) || current_user.admin?)
  end

  def can_publish?
    user_signed_in? && (current_user.admin? || current_user.publish?)
  end

  # for devise
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  # end devise

  def footer_links
    links = [link_to('Home', root_path)]
    links << link_to('Events', events_path) if user_signed_in?
    links
  end

  def container(options = {}, &block)
    saved_title  = @content_for_title
    saved_bottom = @content_for_bottom
    saved_left   = @content_for_left_side
    saved_right  = @content_for_right_side

    @content_for_title = nil
    @content_for_bottom = nil
    @content_for_left_side = nil
    @content_for_right_side = nil

    main_content = capture(&block)
    container_class = options[:class].to_s

    concat <<-HTML
    <div class="page_container #{container_class}">
      <div class="container_wrapper">
    HTML

    concat content_tag(:div, @content_for_title, :class => 'container_header') if @content_for_title

    if @content_for_left_side
      concat content_tag(:div, @content_for_left_side, :class => 'container_panel_left' )
      concat '<div class="container_body_right">'
    elsif @content_for_right_side
      concat content_tag(:div, @content_for_right_side, :class => 'container_panel_right' )
      concat '<div class="container_body_left">'
    else
      concat '<div class="container_body_full">'
    end

    concat content_tag(:div, main_content, :class => 'container_body_inner')
    concat content_tag(:div, '<br style="clear: both"/>', :class => 'container_end')

    concat '</div>'

    concat content_tag(:div, @content_for_bottom, :class => 'container_footer') if @content_for_bottom

    concat <<-HTML
      <div class="container_end"><br style="clear: both"/></div>
      </div><!-- container_wrapper -->
    </div><!-- page_container -->
    HTML

    @content_for_title = saved_title
    @content_for_bottom = saved_bottom
    @content_for_left_side = saved_left
    @content_for_right_side = saved_right
  end

end
