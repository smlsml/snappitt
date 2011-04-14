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

  def user_icon(user, size = :thumb)
    link_to(image_tag(user.profile.photo_url(size), :alt => user), user_path(user), :title => user.username_realname)
  end

  def user_link(user)
    link_to(user, user_path(user), :title => user.profile.realname_unless)
  end

  def container(options = {}, &block)
    out = ""
    main_content = capture(&block)
    container_class = options[:class].to_s

    out << <<-HTML.html_safe
    <div class="page_container #{container_class}">
      <div class="container_wrapper">
    HTML

    out << content_tag(:div, content_for(:title), :class => 'container_header') if content_for?(:bottom)

    if content_for?(:left_side)
      out << content_tag(:div, content_for(:left_side), :class => 'container_panel_left' )
      out << '<div class="container_body_right">'.html_safe
    elsif content_for?(:right_side)
      out << content_tag(:div, content_for(:right_side), :class => 'container_panel_right' )
      out << '<div class="container_body_left">'.html_safe
    else
      out << '<div class="container_body_full">'.html_safe
    end

    out << content_tag(:div, main_content, :class => 'container_body_inner')
    out << content_tag(:div, '<br style="clear: both"/>'.html_safe, :class => 'container_end')

    out << '</div>'.html_safe

    out << content_tag(:div, content_for(:bottom), :class => 'container_footer') if content_for?(:title)

    out << <<-HTML.html_safe
      <div class="container_end"><br style="clear: both"/></div>
      </div><!-- container_wrapper -->
    </div><!-- page_container -->
    HTML

    out.html_safe
  end

end
