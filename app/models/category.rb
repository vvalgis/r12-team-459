class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :user_entries
  has_many :entries, through: :user_entries

  scope :search_for, ->(query) do
    return [] if query.empty?
    quoted = "%#{query}%"
    where("name like ?", quoted).uniq
  end
end
