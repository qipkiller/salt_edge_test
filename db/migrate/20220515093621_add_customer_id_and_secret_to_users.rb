class AddCustomerIdAndSecretToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :customer_id, :bigint
    add_column :users, :secret, :string
  end
end
