class CreateValues < ActiveRecord::Migration[5.1]
  def change
    create_table :values do |t|
      t.integer :twitter_account_id

      t.integer :conservation
      t.integer :openness_to_change
      t.integer :hedonism
      t.integer :self_enhancement
      t.integer :self_transcendence

      t.timestamps
    end
  end
end
