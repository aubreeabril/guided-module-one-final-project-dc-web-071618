# Migration to create the Stray Animals create_table
#the columns are Animal ID
#Species can be either a Dog, Cat or Bird
#name - Each Stray animal is given a name

class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.string :species
    end
  end
end
