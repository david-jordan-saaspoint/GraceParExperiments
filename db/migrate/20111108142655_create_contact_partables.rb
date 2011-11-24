class CreateContactPartables < ActiveRecord::Migration
  def self.up
    create_table :contact_partables do |t|
      t.string :fieldname
      t.string :orgid

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_partables
  end
end
