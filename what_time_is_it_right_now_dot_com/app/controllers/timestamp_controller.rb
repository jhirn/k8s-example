class TimestampController < ApplicationController
  def show
    render json: {
      message: "Automate all the things!",
      timestamp: Time.now.to_i,
    }
  end
end
