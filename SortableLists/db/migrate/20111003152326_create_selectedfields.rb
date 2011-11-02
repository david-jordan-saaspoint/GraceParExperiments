class CreateSelectedfields < ActiveRecord::Migration
  def self.up
    create_table :selectedfields do |t|
      t.string :parfield
      t.string :sfdcfield
      t.string :orgid

      t.timestamps
    end
  end

  def self.down
    drop_table :selectedfields
  end
end
