module RemoteConnection
  class ConnectionCreator < ApplicationService
    attr_reader :user, :connection_remote_id

    def initialize(user = nil, connection_remote_id= nil)
      @user = user
      @connection_remote_id = connection_remote_id
    end

    def call
      res = RemoteConnection::ConnectionCreatorRemote.call(@user)
      if res.response.code == 200
        connection = RemoteConnection::ConnectionCreatorLocal.call(@user, res.data.id)
        return true if connection.persisted?
      end
      false
    end
  end
end
