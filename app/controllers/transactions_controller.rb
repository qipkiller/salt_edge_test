class TransactionsController < ApplicationController
  before_action :transactions_params
  before_action :set_status, only: [:index]
  def index
    if @status == 'all'
      @transactions = Transaction::GetTransactions.call(current_user, @account_id)
      pending_transactions = Transaction::GetPendingTransactions.call(current_user, @account_id)
      @transactions.merge(pending_transactions.collection)
    elsif @status == 'pending'
      @transactions = Transaction::GetPendingTransactions.call(current_user, @account_id)
    elsif @status == 'posted'
      @transactions = Transaction::GetTransactions.call(current_user, @account_id)
    end
  end

  private

  def transactions_params
    @account_id = params[:account_id]
  end

  def set_status
    @status = params[:status]
    @status ||= 'all'
  end
end
