class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
        t.text :title
        t.string :description
    end
  end
end
