class Api::ArrivalsController < ApplicationController
  def index
    render json: { arrivals: Metro::Connection.arrivals.all }
  end

  def show
    render json: { arrivals: ScheduledArrivals.for_stop(params[:id]) }
  end
end
