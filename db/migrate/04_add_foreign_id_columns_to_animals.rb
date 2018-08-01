# The foreign keys are located in the class Animals

class AddForeignIdColumnsToAnimals < ActiveRecord::Migration
  def change
      add_column :animals, :shelter_id, :integer
      add_column :animals, :foster_id, :integer
  end
end
