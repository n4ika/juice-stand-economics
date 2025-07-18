class HomeController < ApplicationController
  def index
    @juices              = Juice.order(created_at: :desc)
    @economy             = Economy.first_or_create
    @recent_transactions = Transaction.order(created_at: :desc)
    @recent_customers    = Customer.order(created_at: :desc)
  end
end
