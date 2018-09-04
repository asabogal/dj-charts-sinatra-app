class User < ActiveRecord::Base
  has_secure_password

  has_many :charts
  has_many :records, through: :charts, source: :records

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def slug
    self.username.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find {|user| user.slug == slug}
  end

end
