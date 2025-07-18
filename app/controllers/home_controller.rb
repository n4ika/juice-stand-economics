class HomeController < ApplicationController
  def index
    @juices              = Juice.order(created_at: :desc).limit(10)
    @economy             = Economy.first_or_create
    @recent_transactions = Transaction.order(created_at: :desc).limit(5)
    @recent_customers    = Customer.order(created_at: :desc).limit(5)
  end
end
