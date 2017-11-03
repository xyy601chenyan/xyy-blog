class CreateLabelships < ActiveRecord::Migration[5.0]
  def change
    create_table :labelships do |t|
      t.integer :article_id, :index => true
      t.integer :label_id ,:index => true
      t.timestamps
    end
  end
end
