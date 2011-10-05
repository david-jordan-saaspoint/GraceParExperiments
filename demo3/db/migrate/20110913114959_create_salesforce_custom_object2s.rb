class CreateSalesforceCustomObject2s < ActiveRecord::Migration
  def self.up
    create_table :salesforce_custom_object2s do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :salesforce_custom_object2s
  end
end
