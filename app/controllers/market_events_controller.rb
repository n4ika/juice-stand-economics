class MarketEventsController < ApplicationController
  def index
    @events = MarketEvent.order(created_at: :desc).limit(200)
  end
end
