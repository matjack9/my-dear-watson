class Api::V1::NeedsController < ApplicationController

  def need
    @need = Need.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @need, :methods => :twitter_handle
  end
end
