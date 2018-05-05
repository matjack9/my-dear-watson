class CreateConsumptionPreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :consumption_preferences do |t|
      t.integer :twitter_account_id

      t.integer :"likely_to_be_sensitive_to_ownership_cost_when_buying_auto..."
      t.integer :likely_to_prefer_safety_when_buying_automobiles
      t.integer :likely_to_prefer_quality_when_buying_clothes
      t.integer :likely_to_prefer_style_when_buying_clothes
      t.integer :likely_to_prefer_comfort_when_buying_clothes
      t.integer :"likely_to_be_influenced_by_brand_name_when_making_product..."
      t.integer :"likely_to_be_influenced_by_product_utility_when_making_pr..."
      t.integer :"likely_to_be_influenced_by_online_ads_when_making_product..."
      t.integer :"likely_to_be_influenced_by_social_media_when_making_produ..."
      t.integer :"likely_to_be_influenced_by_family_when_making_product_pur..."
      t.integer :likely_to_indulge_in_spur_of_the_moment_purchases
      t.integer :likely_to_prefer_using_credit_cards_for_shopping
      t.integer :likely_to_eat_out_frequently
      t.integer :likely_to_have_a_gym_membership
      t.integer :likely_to_like_outdoor_activities
      t.integer :likely_to_be_concerned_about_the_environment
      t.integer :likely_to_consider_starting_a_business_in_next_few_years
      t.integer :likely_to_like_romance_movies
      t.integer :likely_to_like_adventure_movies
      t.integer :likely_to_like_horror_movies
      t.integer :likely_to_like_musical_movies
      t.integer :likely_to_like_historical_movies
      t.integer :likely_to_like_science_fiction_movies
      t.integer :likely_to_like_war_movies
      t.integer :likely_to_like_drama_movies
      t.integer :likely_to_like_action_movies
      t.integer :likely_to_like_documentary_movies
      t.integer :likely_to_like_rap_music
      t.integer :likely_to_like_country_music
      t.integer :likely_to_like_r_and_b_music
      t.integer :likely_to_like_hip_hop_music
      t.integer :likely_to_attend_live_musical_events
      t.integer :likely_to_have_experience_playing_music
      t.integer :likely_to_like_latin_music
      t.integer :likely_to_like_rock_music
      t.integer :likely_to_like_classical_music
      t.integer :likely_to_read_often
      t.integer :likely_to_read_entertainment_magazines
      t.integer :likely_to_read_non_fiction_books
      t.integer :likely_to_read_financial_investment_books
      t.integer :likely_to_read_autobiographical_books
      t.integer :likely_to_volunteer_for_social_causes

      t.timestamps
    end
  end
end
