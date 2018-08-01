#This migration creates a table of registered shelters
#Each shelter has a Shelter ID number and a Shelter name

class CreateShelters < ActiveRecord::Migration
  def change
    create_table :shelters do |t|
      t.string :name
    end
  end
end
