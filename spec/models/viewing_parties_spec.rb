require "rails_helper"

RSpec.describe ViewingParty, type: :model do

  it {should have_many(:viewing_party_users)}
  it {should have_many(:users).through(:viewing_party_users)}

  describe "#invitees" do
    it "returns invited non-host users" do
      host = User.create!(
      name: "Host", 
      username: "host123", 
      password: "password1"
    )
    
    invitee1 = User.create!(
      name: "Invitee1", 
      username: "invitee1", 
      password: "password2"
    )
    
    invitee2 = User.create!(
      name: "Invitee2", 
      username: "invitee2", 
      password: "password3"
    )

    viewing_party = ViewingParty.create!(
      "name": "Juliet's Bday Movie Bash!",
      "start_time": "2025-02-01 10:00:00",
      "end_time": "2025-02-01 14:30:00",
      "movie_id": 278,
      "movie_title": "The Shawshank Redemption",
    )

    ViewingPartyUser.create!(
      viewing_party: viewing_party, 
      user: host, 
      host: true
    )

    ViewingPartyUser.create!(
      viewing_party: viewing_party, 
      user: invitee1, 
      host: false
    )

    ViewingPartyUser.create!(
      viewing_party: viewing_party, 
      user: invitee2, 
      host: false
    )

    invitees = viewing_party.invitees

    expected = [
      [invitee1.id, invitee1.name, invitee1.username],
      [invitee2.id, invitee2.name, invitee2.username]
    ]

    expect(invitees).to eq(expected)
    end
  end
end