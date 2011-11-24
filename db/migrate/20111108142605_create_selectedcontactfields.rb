class CreateSelectedcontactfields < ActiveRecord::Migration
  def self.up
    create_table :selectedcontactfields do |t|
      t.string :parfield
      t.string :sfdcfield
      t.string :orgid

      t.timestamps
    end
  end

  def self.down
    drop_table :selectedcontactfields
  end
end
