
require 'pry'
class Chart < ActiveRecord::Base
  belongs_to :user
  has_many :records

  validates :name, presence: true

  before_create do
    self.created_on = created_on.to_date
  end

  def delete_records
    self.records.each do |record|
      record.delete
    end
  end

  def slug
    self.name.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find {|chart| chart.slug == slug}
  end

end
