class CreatePardbs < ActiveRecord::Migration
  def self.up
    create_table :pardbs do |t|
      t.string :sfdc_id
      t.string :par_un
      t.string :par_pw
      t.string :orgid

      t.timestamps
    end
  end

  def self.down
    drop_table :pardbs
  end
end