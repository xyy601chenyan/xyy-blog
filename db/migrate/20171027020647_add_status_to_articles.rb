class AddStatusToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :status, :string, :default => "draft"
  end
end
