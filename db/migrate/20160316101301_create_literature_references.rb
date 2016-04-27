class CreateLitReferences < ActiveRecord::Migration
  def change
    create_table :lit_references do |t|
      t.string :zotero_itemKey, limit: 20

      t.timestamps
    end
  end
end
