module RemoteConnection
  class ConnectionCreatorRemote < RemoteConnection::ConnectionCreator
    def call
      body = {
        data: {
          customer_id: @user.customer_id.to_s,
          country_code: SaltEdge::Client.instance.country_code,
          provider_code: SaltEdge::Client.instance.provider_code,
          consent: {
            scopes: %w[account_details transactions_details]
          },
          attempt: {
            fetch_scopes: %w[accounts transactions]
          },
          credentials: {
            login: 'username',
            password: 'secret'
          }
        }
      }
      SaltEdge::Client.instance.create_connection({ body: body })
    end
  end
end
