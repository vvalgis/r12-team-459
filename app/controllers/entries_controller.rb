require 'unicode_utils'

class EntriesController < InheritedResources::Base
  before_filter :authenticate_user!
  respond_to :json

  before_filter :prepare_create_params, only: :create

  def search
    query = URI.unescape(params[:q] || "")

    status, type, content = if query.uri? && current_user.entries.find_by_url(query).nil?
      [404, "link", current_user.entries.new(url: query)]
    else
      cat_ids = current_user.categories.search_for(query).map(&:id)
      results = current_user.entries.search_for(query).map(&:to_hash)
      from_categores = current_user.entries.where('user_entries.category_id' => cat_ids).map(&:to_hash)

      [200, "results", (results + from_categores).uniq]
    end

    respond_with({ status: status, type: type, content: content })
  end

  def prepare_create_params
    params[:entry][:user_id] = current_user.id
    cats = UnicodeUtils.downcase(params[:entry].delete(:categories)).split(',').map(&:strip).map do|name|
      current_user.categories.find_or_create_by_name(name)
    end
    params[:entry][:user_entries] = cats.map do |c|
      UserEntry.new(category_id: c.id, user_id: current_user.id)
    end
  end

end
