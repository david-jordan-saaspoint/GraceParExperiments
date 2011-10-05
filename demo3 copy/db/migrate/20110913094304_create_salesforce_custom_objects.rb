class CreateSalesforceCustomObjects < ActiveRecord::Migration
  def self.up
    create_table :salesforce_custom_objects do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :salesforce_custom_objects
  end
end
