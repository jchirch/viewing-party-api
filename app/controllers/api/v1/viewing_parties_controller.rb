class Api::V1::ViewingPartiesController < ApplicationController
  def create
    begin
      host = User.find_by(api_key: params[:api_key])
      party = host.viewing_parties.create!(party_params)
      invite_guests(party)
      render json: PartySerializer.new(party), status: :created
    rescue => error
     
      render json: ErrorSerializer.format_error(ErrorMessage.new("Invalid API Key", 401)), status: :unauthorized
      # render json: {error: error.message}, status: :unprocessable_entity
    end
    
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