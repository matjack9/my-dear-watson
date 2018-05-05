class Api::V1::AnalysisMetadataController < ApplicationController

  def personalities
    all_metadata = AnalysisMetadatum.find_by(api_version: params[:id])
    @analysis_metadata = all_metadata.slice(
      "number_of_handles",
      "personalities_description",
      "openness",
      "adventurousness",
      "artistic_interests",
      "emotionality",
      "imagination",
      "intellect",
      "authority_challenging",
      "conscientiousness",
      "achievement_striving",
      "cautiousness",
      "dutifulness",
      "orderliness",
      "self_discipline",
      "self_efficacy",
      "extraversion",
      "activity_level",
      "assertiveness",
      "cheerfulness",
      "excitement_seeking",
      "outgoing",
      "gregariousness",
      "agreeableness",
      "altruism",
      "cooperation",
      "modesty",
      "uncompromising",
      "sympathy",
      "trust",
      "emotional_range",
      "fiery",
      "prone_to_worry",
      "melancholy",
      "immoderation",
      "self_consciousness",
      "susceptible_to_stress"
    )
    render json: @analysis_metadata
  end

  def needs
    all_metadata = AnalysisMetadatum.find_by(api_version: params[:id])
    @analysis_metadata = all_metadata.slice(
      "number_of_handles",
      "needs_description",
      "challenge",
      "closeness",
      "curiosity",
      "excitement",
      "harmony",
      "ideal",
      "liberty",
      "love",
      "practicality",
      "self_expression",
      "stability",
      "structure"
    )
    render json: @analysis_metadata
  end

  def values
    all_metadata = AnalysisMetadatum.find_by(api_version: params[:id])
    @analysis_metadata = all_metadata.slice(
      "number_of_handles",
      "values_description",
      "conservation",
      "openness_to_change",
      "hedonism",
      "self_enhancement",
      "self_transcendence"
    )
    render json: @analysis_metadata
  end

  def consumption_preferences
    all_metadata = AnalysisMetadatum.find_by(api_version: params[:id])
    @analysis_metadata = all_metadata.slice(
      "number_of_handles",
      "consumption_preferences_description",
      "likely_to_be_sensitive_to_ownership_cost_when_buying_auto...",
      "likely_to_prefer_safety_when_buying_automobiles",
      "likely_to_prefer_quality_when_buying_clothes",
      "likely_to_prefer_style_when_buying_clothes",
      "likely_to_prefer_comfort_when_buying_clothes",
      "likely_to_be_influenced_by_brand_name_when_making_product...",
      "likely_to_be_influenced_by_product_utility_when_making_pr...",
      "likely_to_be_influenced_by_online_ads_when_making_product...",
      "likely_to_be_influenced_by_social_media_when_making_produ...",
      "likely_to_be_influenced_by_family_when_making_product_pur...",
      "likely_to_indulge_in_spur_of_the_moment_purchases",
      "likely_to_prefer_using_credit_cards_for_shopping",
      "likely_to_eat_out_frequently",
      "likely_to_have_a_gym_membership",
      "likely_to_like_outdoor_activities",
      "likely_to_be_concerned_about_the_environment",
      "likely_to_consider_starting_a_business_in_next_few_years",
      "likely_to_like_romance_movies",
      "likely_to_like_adventure_movies",
      "likely_to_like_horror_movies",
      "likely_to_like_musical_movies",
      "likely_to_like_historical_movies",
      "likely_to_like_science_fiction_movies",
      "likely_to_like_war_movies",
      "likely_to_like_drama_movies",
      "likely_to_like_action_movies",
      "likely_to_like_documentary_movies",
      "likely_to_like_rap_music",
      "likely_to_like_country_music",
      "likely_to_like_r_and_b_music",
      "likely_to_like_hip_hop_music",
      "likely_to_attend_live_musical_events",
      "likely_to_have_experience_playing_music",
      "likely_to_like_latin_music",
      "likely_to_like_rock_music",
      "likely_to_like_classical_music",
      "likely_to_read_often",
      "likely_to_read_entertainment_magazines",
      "likely_to_read_non_fiction_books",
      "likely_to_read_financial_investment_books",
      "likely_to_read_autobiographical_books",
      "likely_to_volunteer_for_social_causes"
    )
    render json: @analysis_metadata
  end
end
