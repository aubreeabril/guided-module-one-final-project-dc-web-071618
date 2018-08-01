

class AddCapacityToShelters < ActiveRecord::Migration

  def change
    add_column :shelters, :capacity, :integer
  end
end
  
