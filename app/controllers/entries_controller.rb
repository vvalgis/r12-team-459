class EntriesController < InheritedResources::Base
  before_filter :authenticate_user!
  respond_to :json

  def search
    query = URI.unescape(params[:q] || "")

    status, type, content = if query.uri? && current_user.entries.find_by_url(query).nil?
      [404, "link", current_user.entries.new(url: query)]
    else
      [200, "results", current_user.entries.search_for(query)]
      # [200, "results", current_user.entries * 10]
    end

    respond_with({ status: status, type: type, content: content })
  end

end
