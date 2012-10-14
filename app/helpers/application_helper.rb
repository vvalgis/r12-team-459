module ApplicationHelper
  def svg_tag(src)
    %Q{<object class="placeholder" data="/assets/#{src}.svg" type="image/svg+xml"></object>}.html_safe
  end
end
