class Movie < ApplicationRecord
  validates :title, presence: true
  validates :vote_average, presence: true
end