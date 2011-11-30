class CreateSalesforceAccounts < ActiveRecord::Migration
  def self.up
    create_table :salesforce_accounts do |t|
      t.String, :id
      t.String :name

      t.timestamps
    end
  end

  def self.down
    drop_table :salesforce_accounts
  end
end
