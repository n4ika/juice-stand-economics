class ApplicationController < ActionController::Base
  before_action :load_dashboard

  private

  def load_dashboard
    @economy            = Economy.first_or_create
    @recent_transactions = Transaction.order(created_at: :desc).limit(5)
    @recent_customers    = Customer.order(created_at: :desc).limit(5)
  end
end
