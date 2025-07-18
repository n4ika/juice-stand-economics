class TransactionsController < ApplicationController
  def index
    @transactions = Transaction
    .includes(:juice, :customer)
    .order(created_at: :desc)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
end
