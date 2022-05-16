module RemoteConnection
  class ConnectionDestroyerRemote < RemoteConnection::ConnectionDestroyer
    def call
      body = {
        data: {
          fetch_scopes: %i[
            accounts
            transactions
          ]
        }
      }
      remote_id = @user.connections.active.first.remote_id
      SaltEdge::Client.instance.remove_connection(remote_id, { body: body })
    end
  end
end
