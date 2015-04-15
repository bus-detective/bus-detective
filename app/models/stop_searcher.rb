class StopSearcher
  def initialize(params)
    @params = params
  end

  def stops
    @stops ||= filtered_stops
  end

  def valid?
    [
      @params[:query],
      @params[:latitude] && @params[:longitude],
    ].any?
  end

  private

  def filtered_stops
    scope = Stop

    if @params[:query]
      scope = scope.where("name ILIKE ?", "%#{@params[:query]}%")
    end

    if @params[:longitude] && @params[:latitude]
      scope = scope.by_distance(origin: [@params[:latitude], @params[:longitude]]).limit(20)
    end

    scope
  end
end
