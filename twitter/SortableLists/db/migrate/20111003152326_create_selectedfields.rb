class CreateSelectedfields < ActiveRecord::Migration
  def self.up
    create_table :selectedfields do |t|
      t.string :parField
      t.string :sfdcField
      t.string :orgId

      t.timestamps
    end
  end

  def self.down
    drop_table :selectedfields
  end
end
