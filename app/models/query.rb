class Query < ActiveRecord::Base
  validates :statement, presence: true
  serialize :responses
end
