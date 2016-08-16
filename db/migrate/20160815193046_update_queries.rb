class UpdateQueries < ActiveRecord::Migration
  def change
    add_column(:queries, :responses, :text)
  end
end
