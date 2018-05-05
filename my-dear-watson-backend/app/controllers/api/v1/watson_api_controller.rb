class Api::V1::WatsonApiController < ApplicationController
  attr_accessor :url, :username, :password

  def initialize
    @url = "https://gateway.watsonplatform.net/personality-insights/api"
    @username = ENV["watson_user"]
    @password = ENV["watson_password"]
  end

  def get_data(input)
    response = Excon.post(@url + "/v3/profile",
    :body     => input,
    :headers  => {
      "Content-Type"            => "text/plain",
      "Content-Language"        => "en",
      "Accept-Language"         => "en"
    },
    :query    => {
      "raw_scores"              => true,
      "consumption_preferences" => true,
      "version"                 => "10-13-2017"
    },
    :user                       => @username,
    :password                   => @password)

    response.body
  end

  def to_symbol_helper(key)
    key.gsub(" ", "_").gsub("-", "_").gsub("&", "_and_").downcase.truncate(60).to_sym
  end

  def percentile_conversion_helper(value)
    (value * 100).to_i
  end

  def parse_personality(raw_personality)
    result = {}

    raw_personality.each do |trait|
      trait_name = self.to_symbol_helper(trait['name'])
      trait_percentile = self.percentile_conversion_helper(trait['percentile'])

      result[trait_name] = trait_percentile

      trait['children'].each do |category|
        category_name = self.to_symbol_helper(category['name'])
        category_percentile = self.percentile_conversion_helper(category['percentile'])

        result[category_name] = category_percentile
      end
    end

    result
  end

  def parse_needs(raw_needs)
    result = {}

    raw_needs.each do |need|
      need_name = self.to_symbol_helper(need['name'])
      need_percentile = self.percentile_conversion_helper(need['percentile'])

      result[need_name] = need_percentile
    end

    result
  end

  def parse_values(raw_values)
    result = {}

    raw_values.each do |value|
      value_name = self.to_symbol_helper(value['name'])
      value_percentile = self.percentile_conversion_helper(value['percentile'])

      result[value_name] = value_percentile
    end

    result
  end

  def parse_consumption_preferences(raw_preferences)
    result = {}

    raw_preferences.each do |category|
      category['consumption_preferences'].each do |pref|
        pref_name = self.to_symbol_helper(pref['name'])
        pref_score = self.percentile_conversion_helper(pref['score']) # will be 0, 50, or 100

        result[pref_name] = pref_score
      end
    end

    result
  end

  def analyze(input)
    result = {}

    raw_data = JSON.parse(self.get_data(input))

    if raw_data['code'] == 400
      return raw_data['error']
    else
      result[:word_count]             = {
                                        word_count: raw_data['word_count'].to_i,
                                        word_count_message: raw_data['word_count_message']
                                        }
      result[:personality]            = self.parse_personality(raw_data['personality'])
      result[:need]                   = self.parse_needs(raw_data['needs'])
      result[:value]                  = self.parse_values(raw_data['values'])
      result[:consumption_preference] = self.parse_consumption_preferences(raw_data['consumption_preferences'])

      return result
    end
  end
end
