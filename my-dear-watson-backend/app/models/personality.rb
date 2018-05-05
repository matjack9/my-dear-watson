class Personality < ApplicationRecord
  belongs_to :twitter_account

  after_save :update_analysis_metadata

  def self.averages
    self.select('
      count(id) as number_of_handles,
      avg(openness) as openness,
      avg(adventurousness) as adventurousness,
      avg(artistic_interests) as artistic_interests,
      avg(emotionality) as emotionality,
      avg(imagination) as imagination,
      avg(intellect) as intellect,
      avg(authority_challenging) as authority_challenging,
      avg(conscientiousness) as conscientiousness,
      avg(achievement_striving) as achievement_striving,
      avg(cautiousness) as cautiousness,
      avg(dutifulness) as dutifulness,
      avg(orderliness) as orderliness,
      avg(self_discipline) as self_discipline,
      avg(self_efficacy) as self_efficacy,
      avg(extraversion) as extraversion,
      avg(activity_level) as activity_level,
      avg(assertiveness) as assertiveness,
      avg(cheerfulness) as cheerfulness,
      avg(excitement_seeking) as excitement_seeking,
      avg(outgoing) as outgoing,
      avg(gregariousness) as gregariousness,
      avg(agreeableness) as agreeableness,
      avg(altruism) as altruism,
      avg(cooperation) as cooperation,
      avg(modesty) as modesty,
      avg(uncompromising) as uncompromising,
      avg(sympathy) as sympathy,
      avg(trust) as trust,
      avg(emotional_range) as emotional_range,
      avg(fiery) as fiery,
      avg(prone_to_worry) as prone_to_worry,
      avg(melancholy) as melancholy,
      avg(immoderation) as immoderation,
      avg(self_consciousness) as self_consciousness,
      avg(susceptible_to_stress) as susceptible_to_stress
      ')
  end

  def twitter_handle
    self.twitter_account.handle
  end

  private

  def update_analysis_metadata
    average_ratings = Personality.averages[0].as_json.except("id")
    AnalysisMetadatum.find_by!(api_version: 1).update(average_ratings)
  end
end
