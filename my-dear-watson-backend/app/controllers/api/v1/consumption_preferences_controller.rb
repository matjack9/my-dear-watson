class Api::V1::ConsumptionPreferencesController < ApplicationController

  def consumption_preference
    @consumption_preference = ConsumptionPreference.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @consumption_preference, :methods => :twitter_handle
  end
end
