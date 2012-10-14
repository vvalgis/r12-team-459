class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :user_entries
  has_many :entries, through: :user_entries
end
