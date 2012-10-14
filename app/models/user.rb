class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable,:registerable, :recoverable, :validatable
  devise :database_authenticatable, :rememberable, :trackable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :provider, :uid, :name, :nickname, :avatar_url
  # attr_accessible :title, :body

  scope :find_by_auth, ->(auth) { where(provider: auth.provider, uid: auth.uid) }

  has_many :entries, include: :categories
  has_many :user_entries
  has_many :categories, through: :user_entries

  def entries_for_category(category)
    entries.joins(:user_entries).merge(user_entries.for_category(category))
  end

  (Entry.types || []).each do |type|
    define_method(type.to_s.pluralize) { entries.where(type: type.to_s) }
  end

  def self.create_from_auth(auth)
    args = {
      name: auth.info.name,
      nickname: auth.info.nickname,
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      avatar_url: auth.info.image,
      password: Devise.friendly_token[0,20]
    }
    User.create(args)
  end

  def nick_and_name
    n = ''
    n << nickname if nickname.present?
    n << " (#{name})" if name.present?
    n.present? ? n : 'Unknown person'
  end
end
