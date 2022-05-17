class ConnectionsController < ApplicationController
  def index
    @connections = current_user.connections.order(:arhived)
  end

  def create
    if current_user.connections.active.count.zero?
      RemoteConnection::ConnectionCreator.call(current_user)
      redirect_to root_path
    end
  end

  def destroy
    RemoteConnection::ConnectionDestroyer.call(current_user)
    redirect_to root_path
  end
end
