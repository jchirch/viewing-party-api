require "rails_helper"

RSpec.describe ViewingPartyUser, type: :model do
  it {should belong_to(:user)}
  it {should belong_to(:viewing_party)}
end