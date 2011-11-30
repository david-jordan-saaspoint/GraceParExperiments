class CreateSalesforceSites < ActiveRecord::Migration
  def self.up
    create_table :salesforce_sites do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :salesforce_sites
  end
end
