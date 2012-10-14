class Entry < ActiveRecord::Base
  self.inheritance_column = :must_be_type_but_we_not_use_sti

  belongs_to :user
  attr_accessible :description, :shareable, :url, :title, :type, :user_entries, :user_id
  has_many :user_entries, dependent: :destroy
  has_many :categories, through: :user_entries
  # attr_protected :type
  after_initialize :determinate_type

  accepts_nested_attributes_for :categories

  default_scope order: "entries.id DESC"

  scope :search_for, ->(query) do
    return [] if query.empty?
    quoted = "%#{query}%"
    where("url LIKE ? OR (title LIKE ? OR (description LIKE ?))", quoted, quoted, quoted).uniq
  end

  def to_hash
    {
      id: id,
      title: title,
      url: url,
      type: type,
      category_ids: category_ids,
      description: description
    }
  end

  def self.types
    @types ||= [Gist.new, Gem.new, Screencast.new, Article.new]
  end

  protected

  class Type
    def to_s; self.class.name.demodulize.underscore; end
    def match(uri)
      domains.map{ |d| uri.to_s.match(%r[^https?://#{d}.*]).nil? ? false : true }.any?
    end
    private
    def domains
      @domains ||= []
    end
  end

  class Gist < Type
    private
    def domains
      @domains ||= %w(gist.github.com)
    end
  end

  class Gem < Type
    private
    def domains
      @domains ||= %w(github.com rubygems.org)
    end
  end

  class Screencast < Type
    private
    def domains
      @domains ||= [
        'railscasts.com',
        'railsforzombies.org',
        'rubyonrails.org/screencasts/rails3',
        'peepcode.com',
        'pragprog.com/screencasts'
      ]
    end
  end

  class Article < Type
    def match(_); true; end
  end

  def determinate_type
    if self.new_record? && !self.type.present?
      self.type = self.class.types.select{|tp| tp.match(self.url) }.first.to_s
    end
  end
end
