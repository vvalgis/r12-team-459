class Entry < ActiveRecord::Base
  set_inheritance_column :must_be_type_but_we_not_use_sti

  belongs_to :user
  attr_accessible :description, :shareable, :url, :title
  has_many :user_entries
  has_many :categories, through: :user_entries
  # attr_protected :type
  after_initialize :determinate_type

  scope :search_for, ->(query) do
    quoted = "%#{query}%"
    where("url LIKE ? OR (title LIKE ? OR (description LIKE ?))", query, quoted, quoted)
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
      @domains ||= %w(github.com rubygems.com)
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
