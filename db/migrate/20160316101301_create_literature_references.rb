class CreateLiteratureReferences < ActiveRecord::Migration
  def change
    create_table :literature_references do |t|
      t.string :title
      t.string :author

      t.timestamps null: false
    end
  end
end
