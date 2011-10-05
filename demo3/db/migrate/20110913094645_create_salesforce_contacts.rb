class CreateSalesforceContacts < ActiveRecord::Migration
  def self.up
    create_table :salesforce_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :salesforce_contacts
  end
end
