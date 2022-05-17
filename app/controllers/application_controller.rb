class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :connected?

  def connected?
    if current_user
        !current_user.connections.active.count.zero?
    end
  end
end
