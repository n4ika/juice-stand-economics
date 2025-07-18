class EconomiesController < ApplicationController
  def show
    @economy = Economy.first_or_create
  end

  def reset
    Economy.reset_all!
    redirect_to root_path, notice: "Economy has been reset."
  end
end
