class ViewingParty < ApplicationRecord
  has_many :viewing_party_users
  has_many :users, through: :viewing_party_users

  def invitees
    viewing_party_users.where(host: false).pluck(:id)
  end
end