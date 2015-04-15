class Api::StopsController < ApplicationController
  def index
    searcher =  StopSearcher.new(params)
    if searcher.valid?
      render json: searcher.stops
    else
      render json: { errors: "Invalid parameters" }, status: :bad_request
    end
  end
end
