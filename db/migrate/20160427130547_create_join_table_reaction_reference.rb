class CreateJoinTableReactionReference < ActiveRecord::Migration
  def change
    create_join_table :reactions, :references do |t|
       t.index [:reaction_id, :reference_id]
       t.index [:reference_id, :reaction_id]
    end
  end
end
