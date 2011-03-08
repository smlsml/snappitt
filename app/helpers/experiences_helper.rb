module ExperiencesHelper

  def render_feed(experiences)
    last_date = nil
    experiences.each do |e|
      current_date = e.updated_at.to_formatted_s(:mdy)
      if current_date != last_date
        concat render :partial => '/partials/date', :locals => {:date => e.updated_at}
        last_date = current_date
      end
      concat render :partial => '/partials/experience', :locals => {:exp => e}
    end
  end

end
