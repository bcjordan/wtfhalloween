class CreateCostumes < ActiveRecord::Migration
  def change
    create_table :costumes do |t|
      t.string :quip
      t.string :short_name
      t.string :amazon_id
      t.string :amazon_link
      t.string :imgur
      t.string :girl
      t.string :slutty
      t.string :scary
      t.string :buy
      t.string :kid
      t.string :prime
    end
  end
end
