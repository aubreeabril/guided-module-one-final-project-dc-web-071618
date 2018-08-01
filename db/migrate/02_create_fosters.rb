#This migration creates a table of foster families
#each family has a Foster ID number and a family name

class CreateFosters < ActiveRecord::Migration
  def change
    create_table :fosters do |t|
      t.string :name
    end
  end
end
