class UserEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry
  belongs_to :category
  attr_accessible :category_id, :entry_id, :user_id
  scope :for_category, ->(category) { where(category_id: category.id) }

  # accepts_nested_attributes_for :category, :entry
end
