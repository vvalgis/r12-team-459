class Entry < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :shareable, :url, :title
  has_many :user_entries
  has_many :categories, through: :user_entries
  # attr_protected :type

  def self.search_for_user(user, query)
    where("user_id = ? AND (url = ? OR url LIKE ? OR title LIKE ? OR description LIKE ?)",
      user.id, query, "%#{query}%", "%#{query}%", "%#{query}%")
  end

end
