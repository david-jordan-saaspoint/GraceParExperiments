class CreateSfdctables < ActiveRecord::Migration
  def self.up
    create_table :sfdctables do |t|
      t.string :fieldname
      t.string :fieldtype
      t.string :fieldlabel
      t.string :orgId

      t.timestamps
    end
  end

  def self.down
    drop_table :sfdctables
  end
end
