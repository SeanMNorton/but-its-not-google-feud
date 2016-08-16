class Query < ActiveRecord::Base
  validates :statement, presence: true
end
