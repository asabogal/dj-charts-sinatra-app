class Record < ActiveRecord::Base
  belongs_to :chart
  belongs_to :user

  validates :title, presence: true
  validates :artist, presence: true
  validates :label, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def slug
    self.title.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find {|record| record.slug == slug}
  end

end
