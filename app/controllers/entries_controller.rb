class EntriesController < InheritedResources::Base
  before_filter :authenticate_user!
  respond_to :json

  def search
    query = params[:q] || ""
    query = URI.unescape(query)

    if query.uri? && current_user.entries.where(url: query).empty?
      respond_with({ type: "link", link: query, new: true })
    else
      respond_with({ type: "results", results: Entry.search_for_user(current_user, query) })
    end
  end

end
