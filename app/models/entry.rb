class Entry < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :shareable, :url
  attr_protected :type
end
