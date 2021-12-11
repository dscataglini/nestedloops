class CreateTodoItems < ActiveRecord::Migration[6.1]
  def change
    create_table :todo_items do |t|
      t.string :description
      t.boolean :completed, default: false
      t.references :todo_list, null: false, foreign_key: true
      t.timestamps
    end
  end
end
