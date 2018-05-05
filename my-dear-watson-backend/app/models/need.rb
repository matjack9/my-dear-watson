class Need < ApplicationRecord
  belongs_to :twitter_account

  after_save :update_analysis_metadata

  def self.averages
    self.select('
      count(id) as number_of_handles,
      avg(challenge) as challenge,
      avg(closeness) as closeness,
      avg(curiosity) as curiosity,
      avg(excitement) as excitement,
      avg(harmony) as harmony,
      avg(ideal) as ideal,
      avg(liberty) as liberty,
      avg(love) as love,
      avg(practicality) as practicality,
      avg(self_expression) as self_expression,
      avg(stability) as stability,
      avg(structure) as structure
      ')
  end

  def twitter_handle
    self.twitter_account.handle
  end

  private

  def update_analysis_metadata
    average_ratings = Need.averages[0].as_json.except("id")
    AnalysisMetadatum.find_by!(api_version: 1).update(average_ratings)
  end
end
