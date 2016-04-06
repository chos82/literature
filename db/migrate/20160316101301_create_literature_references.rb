class CreateLiteratureReferences < ActiveRecord::Migration
  def change
    create_table :literature_references do |t|
      t.string :zotero_itemKey, limit: 20

      t.timestamps
    end
  end
end
