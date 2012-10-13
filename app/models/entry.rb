class Entry < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :shareable, :url
  has_many :user_entries
  has_many :categories, through: :user_entries
  # attr_protected :type
end
