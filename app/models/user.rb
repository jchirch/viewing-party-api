class User < ApplicationRecord
  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: { require: true }
  has_secure_password
  has_secure_token :api_key

  def invitees
    viewing_party_users.where(user_id: )
  end

  def create_a_party(info)
require 'pry'; binding.pry
  end
end