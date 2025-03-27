class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.references :student, null: false, foreign_key: true 
      t.references :lesson, null: false, foreign_key: true 
      t.references :enrollment, null: false, foreign_key: true 
      t.references :mentor, null: false, foreign_key: true
      t.string :pull_request_url, null: false 
      t.string :review_result
      t.datetime :reviewed_at
      t.timestamps
    end
  end
end
