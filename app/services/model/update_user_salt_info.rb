module Model
  class UpdateUserSaltInfo < ApplicationService
    # attr_reader :customer_id, :secret, :user

    def initialize(customer_id, secret, user)
      
      @user = user
      @customer_id = customer_id
      @secret = secret
    end

    def call
      @user.update(customer_id: @customer_id, secret: @secret)
    end
  end
end
