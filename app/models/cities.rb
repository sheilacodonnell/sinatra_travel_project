class Cities < ActiveRecord::Base
  has_many :interests
  belongs_to :user
end
