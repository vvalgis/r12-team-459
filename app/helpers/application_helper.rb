module ApplicationHelper
  def svg_tag(src)
    %Q{<object class="placeholder" data="/assets/#{src}.svg" type="image/svg+xml"></object>}.html_safe
  end
  def entry_link_to(entry)
    # = link_to user_entry.entry.title, user_entry.entry.url
    %Q{<a href="#{user_entry.entry.url}">#{user_entry.entry.title}</a>}
  end
end
