class DepartureFetcher
  include ActiveModel::SerializerSupport

  attr_reader :agency, :stop, :time
  def initialize(agency, stop, time, params = {})
    @agency = agency
    @time = time.in_time_zone
    @stop = stop
  end

  def departures
    @departures ||= stop_times.map { |stop_time|
      Departure.new(stop_time: stop_time, stop_time_update: nil)
    }.sort_by(&:time)
  end

  def stop_times
    @stop_times ||= begin
      query = agency.stop_times
        .where(stop: stop)
        .between(start_time, end_time)
        .includes(:trip)
        .select_for_departure.to_sql

      ActiveRecord::Base.connection.select_all(query).map { |h| CalculatedStopTime.new(h.symbolize_keys) }
    end
  end

  def valid?
    @agency.present? && @stop.present?
  end

  protected

  def start_time
    @time - 10.minutes
  end

  def end_time
    @time + 1.hour
  end
end

