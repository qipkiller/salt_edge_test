module RemoteConnection
  class ConnectionCreatorLocal < RemoteConnection::ConnectionCreator

    def call
      Connection.create(user: @user, remote_id: @connection_remote_id)
    end
  end
end
