class CreateLiteratureReferences < ActiveRecord::Migration
  def change
    create_table :literature_references do |t|
      t.integer :zotero_key
      t.integer :object_id
      t.string :object_type
    end
  end
end
