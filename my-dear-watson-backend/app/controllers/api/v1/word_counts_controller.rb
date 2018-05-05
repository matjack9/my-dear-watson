class Api::V1::WordCountsController < ApplicationController

  def word_count
    @word_count = WordCount.find_by(twitter_account_id: params["twitter_account_id"])
    render json: @word_count, :methods => :twitter_handle
  end
end
