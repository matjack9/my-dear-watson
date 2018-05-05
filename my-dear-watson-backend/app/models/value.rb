class Value < ApplicationRecord
  belongs_to :twitter_account

  after_save :update_analysis_metadata

  def self.averages
    self.select('
      count(id) as number_of_handles,
      avg(conservation) as conservation,
      avg(openness_to_change) as openness_to_change,
      avg(hedonism) as hedonism,
      avg(self_enhancement) as self_enhancement,
      avg(self_transcendence) as self_transcendence
      ')
  end

  def twitter_handle
    self.twitter_account.handle
  end

  private

  def update_analysis_metadata
    average_ratings = Value.averages[0].as_json.except("id")
    AnalysisMetadatum.find_by!(api_version: 1).update(average_ratings)
  end
end
