class Api::V1::TwitterAccountsController < ApplicationController

  def index
    @accounts = TwitterAccount.all
    render json: @accounts
  end

  def show
    @account = TwitterAccount.find(params[:id])
    render json: @account
  end

  def create
    @account = TwitterAccount.new(account_params)

    twitter_controller = Api::V1::TwitterApiController.new
    input = twitter_controller.get_tweet_text(@account.handle)

    if input.length > 0
      watson_controller = Api::V1::WatsonApiController.new
      analysis = watson_controller.analyze(input)

      if !analysis.kind_of?(String)
        if @account.save
          word_counts = @account.build_word_count(analysis[:word_count])
          word_counts.save

          personalities = @account.build_personality(analysis[:personality])
          personalities.save

          needs = @account.build_need(analysis[:need])
          needs.save

          values = @account.build_value(analysis[:value])
          values.save

          consumption_preferences = @account.build_consumption_preference(analysis[:consumption_preference])
          consumption_preferences.save

          return render json: @account
        else
          return render json: {errors: @account.errors.full_messages}, status: 422
        end
      else
        return render json: analysis, status: 422
      end
    else
      return render json: {errors: ["Please confirm this twitter handle has any tweets"]}, status: 422
    end
  end

  private

  def account_params
    params.permit(:handle)
  end
end
