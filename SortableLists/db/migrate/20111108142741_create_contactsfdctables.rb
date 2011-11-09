class CreateContactsfdctables < ActiveRecord::Migration
  def self.up
    create_table :contactsfdctables do |t|
      t.string :fieldname
      t.string :fieldtype
      t.string :fieldlabel
      t.string :orgid

      t.timestamps
    end
  end

  def self.down
    drop_table :contactsfdctables
  end
end
