class UserEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry
  belongs_to :category
  # attr_accessible :title, :body
end
