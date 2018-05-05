class CreatePersonalities < ActiveRecord::Migration[5.1]
  def change
    create_table :personalities do |t|
      t.integer :twitter_account_id

      t.integer :openness
      t.integer :adventurousness
      t.integer :artistic_interests
      t.integer :emotionality
      t.integer :imagination
      t.integer :intellect
      t.integer :authority_challenging

      t.integer :conscientiousness
      t.integer :achievement_striving
      t.integer :cautiousness
      t.integer :dutifulness
      t.integer :orderliness
      t.integer :self_discipline
      t.integer :self_efficacy

      t.integer :extraversion
      t.integer :activity_level
      t.integer :assertiveness
      t.integer :cheerfulness
      t.integer :excitement_seeking
      t.integer :outgoing
      t.integer :gregariousness

      t.integer :agreeableness
      t.integer :altruism
      t.integer :cooperation
      t.integer :modesty
      t.integer :uncompromising
      t.integer :sympathy
      t.integer :trust

      t.integer :emotional_range
      t.integer :fiery
      t.integer :prone_to_worry
      t.integer :melancholy
      t.integer :immoderation
      t.integer :self_consciousness
      t.integer :susceptible_to_stress

      t.timestamps
    end
  end
end
