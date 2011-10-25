class CreatePartables < ActiveRecord::Migration
  def self.up
    create_table :partables do |t|
      t.string :fieldname
      t.string :orgId

      t.timestamps
    end
  end

  def self.down
    drop_table :partables
  end
end
