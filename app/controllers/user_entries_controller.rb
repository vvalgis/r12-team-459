class UserEntriesController < InheritedResources::Base
  before_filter :authenticate_user!

  respond_to :json

  def create
    params[:user_entry][:user_id] = current_user.id
    entry = params[:user_entry]
    if entry[:categories].present?
      categories = entry[:categories].split(',').map(&:strip).map do |name|
        current_user.categories.find_or_create_by_name(name).id
      end
    end
  end

end
