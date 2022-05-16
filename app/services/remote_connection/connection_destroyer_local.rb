module RemoteConnection
  class ConnectionDestroyerLocal < RemoteConnection::ConnectionDestroyer
    def call
      @user.connections.active.first.arhive
    end
  end
end
