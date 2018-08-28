class User < ActiveRecord::Base
  has_secure_password
  has_many :charts
  has_many :records, through: :charts, source: :records 

  def slug
    self.name.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find {|user| user.slug == slug}
  end

end