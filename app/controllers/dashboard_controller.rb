class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recent = {
      gems: current_user.gems.limit(5),
      gists: current_user.gists.limit(5),
      screencasts: current_user.screencasts.limit(5),
      articles: current_user.articles.limit(5),
    }
  end

  def explore
    @categories = current_user.categories
    @entries = current_user.user_entries.includes(:entry).where('user_entries.category_id' => @categories.map{|c| c.id})
  end
end
