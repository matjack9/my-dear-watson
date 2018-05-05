class CreateNeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :needs do |t|
      t.integer :twitter_account_id

      t.integer :challenge
      t.integer :closeness
      t.integer :curiosity
      t.integer :excitement
      t.integer :harmony
      t.integer :ideal
      t.integer :liberty
      t.integer :love
      t.integer :practicality
      t.integer :self_expression
      t.integer :stability
      t.integer :structure

      t.timestamps
    end
  end
end
