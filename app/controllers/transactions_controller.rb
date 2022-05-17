class TransactionsController < ApplicationController
  before_action :transactions_params
  def index
    @transactions = Transaction::GetTransactions.call(current_user, @account_id)
    
  end

  def transactions_params
    @account_id = params[:account_id]
  end
end
