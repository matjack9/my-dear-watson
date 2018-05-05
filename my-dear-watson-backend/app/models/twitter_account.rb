class TwitterAccount < ApplicationRecord
  validates :handle, presence: true
  validates :handle, uniqueness: true
  has_one :word_count
  has_one :personality
  has_one :need
  has_one :value
  has_one :consumption_preference
end
