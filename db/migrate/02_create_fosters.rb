class CreateFosters < ActiveRecord::Migration
  def change
    create_table :fosters do |t|
      t.string :name
    end
  end
end
