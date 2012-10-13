class Entry < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :shareable, :url, :title
  has_many :user_entries
  has_many :categories, through: :user_entries
  # attr_protected :type

  scope :search_for, ->(query) do
    quoted = "%#{query}%"
    where("url LIKE ? OR (title LIKE ? OR (description LIKE ?))", query, quoted, quoted)
  end

end
