class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.date :startdate
      t.boolean :complete

      t.timestamps
    end
  end
end
