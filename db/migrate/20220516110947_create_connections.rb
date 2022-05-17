class CreateConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :connections do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :remote_id
      t.boolean :arhived, default: false

      t.timestamps null: false
    end
  end
end
