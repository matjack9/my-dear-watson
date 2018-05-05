class Api::V1::PersonalitiesController < ApplicationController

  def personality
    @personality = Personality.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @personality, :methods => :twitter_handle
  end
end
