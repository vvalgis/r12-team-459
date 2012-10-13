class EntriesController < InheritedResources::Base
  before_filter :authenticate_user!
  respond_to :json

  def search
    query = params[:q] || ""
    query = URI.unescape(query)

    if query.uri?
      resource = current_user.entries.find_or_initialize_by_url(query)
      respond_with({ type: "link", link: query, new: resource.new_record?, resource: resource})
    else
      resources = current_user.entries.search_for(query)
      respond_with({ type: "results", results: resources })
    end
  end

end
