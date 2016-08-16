class CreateRounds < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :statement, null: false
    end
  end
end
