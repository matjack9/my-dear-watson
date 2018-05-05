class ConsumptionPreference < ApplicationRecord
  belongs_to :twitter_account

  after_save :update_analysis_metadata

  def self.averages
    self.select('
      count(id) as number_of_handles,
      avg("likely_to_be_sensitive_to_ownership_cost_when_buying_auto...") as "likely_to_be_sensitive_to_ownership_cost_when_buying_auto...",
      avg(likely_to_prefer_safety_when_buying_automobiles) as likely_to_prefer_safety_when_buying_automobiles,
      avg(likely_to_prefer_quality_when_buying_clothes) as likely_to_prefer_quality_when_buying_clothes,
      avg(likely_to_prefer_style_when_buying_clothes) as likely_to_prefer_style_when_buying_clothes,
      avg(likely_to_prefer_comfort_when_buying_clothes) as likely_to_prefer_comfort_when_buying_clothes,
      avg("likely_to_be_influenced_by_brand_name_when_making_product...") as "likely_to_be_influenced_by_brand_name_when_making_product...",
      avg("likely_to_be_influenced_by_product_utility_when_making_pr...") as "likely_to_be_influenced_by_product_utility_when_making_pr...",
      avg("likely_to_be_influenced_by_online_ads_when_making_product...") as "likely_to_be_influenced_by_online_ads_when_making_product...",
      avg("likely_to_be_influenced_by_social_media_when_making_produ...") as "likely_to_be_influenced_by_social_media_when_making_produ...",
      avg("likely_to_be_influenced_by_family_when_making_product_pur...") as "likely_to_be_influenced_by_family_when_making_product_pur...",
      avg(likely_to_indulge_in_spur_of_the_moment_purchases) as likely_to_indulge_in_spur_of_the_moment_purchases,
      avg(likely_to_prefer_using_credit_cards_for_shopping) as likely_to_prefer_using_credit_cards_for_shopping,
      avg(likely_to_eat_out_frequently) as likely_to_eat_out_frequently,
      avg(likely_to_have_a_gym_membership) as likely_to_have_a_gym_membership,
      avg(likely_to_like_outdoor_activities) as likely_to_like_outdoor_activities,
      avg(likely_to_be_concerned_about_the_environment) as likely_to_be_concerned_about_the_environment,
      avg(likely_to_consider_starting_a_business_in_next_few_years) as likely_to_consider_starting_a_business_in_next_few_years,
      avg(likely_to_like_romance_movies) as likely_to_like_romance_movies,
      avg(likely_to_like_adventure_movies) as likely_to_like_adventure_movies,
      avg(likely_to_like_horror_movies) as likely_to_like_horror_movies,
      avg(likely_to_like_musical_movies) as likely_to_like_musical_movies,
      avg(likely_to_like_historical_movies) as likely_to_like_historical_movies,
      avg(likely_to_like_science_fiction_movies) as likely_to_like_science_fiction_movies,
      avg(likely_to_like_war_movies) as likely_to_like_war_movies,
      avg(likely_to_like_drama_movies) as likely_to_like_drama_movies,
      avg(likely_to_like_action_movies) as likely_to_like_action_movies,
      avg(likely_to_like_documentary_movies) as likely_to_like_documentary_movies,
      avg(likely_to_like_rap_music) as likely_to_like_rap_music,
      avg(likely_to_like_country_music) as likely_to_like_country_music,
      avg(likely_to_like_r_and_b_music) as likely_to_like_r_and_b_music,
      avg(likely_to_like_hip_hop_music) as likely_to_like_hip_hop_music,
      avg(likely_to_attend_live_musical_events) as likely_to_attend_live_musical_events,
      avg(likely_to_have_experience_playing_music) as likely_to_have_experience_playing_music,
      avg(likely_to_like_latin_music) as likely_to_like_latin_music,
      avg(likely_to_like_rock_music) as likely_to_like_rock_music,
      avg(likely_to_like_classical_music) as likely_to_like_classical_music,
      avg(likely_to_read_often) as likely_to_read_often,
      avg(likely_to_read_entertainment_magazines) as likely_to_read_entertainment_magazines,
      avg(likely_to_read_non_fiction_books) as likely_to_read_non_fiction_books,
      avg(likely_to_read_financial_investment_books) as likely_to_read_financial_investment_books,
      avg(likely_to_read_autobiographical_books) as likely_to_read_autobiographical_books,
      avg(likely_to_volunteer_for_social_causes) as likely_to_volunteer_for_social_causes
      ')
  end

  def twitter_handle
    self.twitter_account.handle
  end

  private

  def update_analysis_metadata
    average_ratings = ConsumptionPreference.averages[0].as_json.except("id")
    AnalysisMetadatum.find_by!(api_version: 1).update(average_ratings)
  end
end
