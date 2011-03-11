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

end
