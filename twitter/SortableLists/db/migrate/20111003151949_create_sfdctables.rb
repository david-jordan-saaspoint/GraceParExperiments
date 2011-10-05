class CreateSfdctables < ActiveRecord::Migration
  def self.up
    create_table :sfdctables do |t|
      t.string :fieldname
      t.string :fieldtpe
      t.string :orgId

      t.timestamps
    end
  end

  def self.down
    drop_table :sfdctables
  end
end
