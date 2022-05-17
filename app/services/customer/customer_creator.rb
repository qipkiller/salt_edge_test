module Customer
  class CustomerCreator < ApplicationService
    attr_reader :email

    def initialize(email)
      @email = email
    end

    def call
      data = {
        data: {
          identifier: @email
        }
      }
      res = SaltEdge::Client.instance.create_customer({ body: data })
      return false unless res.response.code == 200

      res.data
    end
  end
end