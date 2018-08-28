class Chart < ActiveRecord::Base
  belongs_to :user
  has_many :records
  
  def date
    self.created_on = created_on.to_date
  end

  def slug
    self.name.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find {|chart| chart.slug == slug}
  end

end
