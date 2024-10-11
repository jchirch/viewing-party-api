class Api::V1::ViewingPartiesController < ApplicationController
  def create
    begin
      host = User.find_by(api_key: params[:api_key])
      party = host.viewing_parties.create!(party_params)
      invite_guests(party)
      render json: PartySerializer.new(party), status: :created
    rescue
      render json: {error: "Host not found"}
    end
    
    # check to see if self.viewingparty_users.host = true
    # proceed
    # else error, party must have host. - validation?
  end

  private

  def party_params
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title)
  end

  def invite_guests(party)
    params[:invitees].each do |id|
      ViewingPartyUser.create!(viewing_party_id: party.id, user_id: id, host: false)
    end
  end
end