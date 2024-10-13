class ViewingParty < ApplicationRecord
  has_many :viewing_party_users
  has_many :users, through: :viewing_party_users

  def invitees
    viewing_party_users.joins(:user).where(host: false).pluck('users.id', 'users.name', 'users.username')
    # require 'pry'; binding.pry
  end
end