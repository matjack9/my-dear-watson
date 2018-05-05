class Api::V1::ValuesController < ApplicationController

  def value
    @value = Value.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @value, :methods => :twitter_handle
  end
end
