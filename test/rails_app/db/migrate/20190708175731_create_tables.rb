class CreateTables < ActiveRecord::Migration[5.0]
  def up
    create_table :foos do |t|
      t.timestamps
    end
  end

  def down
    drop_table :foos
  end
end
