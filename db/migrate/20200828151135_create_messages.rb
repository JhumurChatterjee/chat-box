class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.references :sender,   null: false, foreign_key: { to_table: :users }
      t.string :content,      null: false

      t.timestamps
    end
  end
end
