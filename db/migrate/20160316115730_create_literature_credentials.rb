class CreateLiteratureCredentials < ActiveRecord::Migration
  def change
    create_table :literature_credentials do |t|
      t.integer :user_id
      t.string :token

      t.timestamps null: false
    end
  end
end
