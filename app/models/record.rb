class Record < ActiveRecord::Base
  belongs_to :chart
  belongs_to :user

end
