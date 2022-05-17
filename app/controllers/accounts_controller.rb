class AccountsController < ApplicationController
  def index
    @accounts = Account::GetAccounts.call(current_user)
  end
end
