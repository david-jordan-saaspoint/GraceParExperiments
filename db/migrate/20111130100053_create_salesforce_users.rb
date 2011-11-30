class CreateSalesforceUsers < ActiveRecord::Migration
  def self.up
    create_table :salesforce_users do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :salesforce_users
  end
end
