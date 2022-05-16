class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable
  enum role: { customer: 1, admin: 2 }
  after_create :salt_edge_data

  after_destroy :delete_salt_edge_data


  has_many :connections


  def salt_edge_data
    return unless customer_id.nil? && secret.nil?

    data = Customer::CustomerCreator.call(email)
    if data
      self.customer_id = data.id
      self.secret = data.secret
      save
    end
  end

  def delete_salt_edge_data
    Customer::CustomerDestroyer.call(customer_id) if customer_id
  end
end
