class StopTime < ActiveRecord::Base
  belongs_to :stop
  belongs_to :trip
  belongs_to :agency
  has_one :route, through: :trip
  has_one :service, through: :trip

  # For departures we want to go ahead and calculate the time of the departure
  # on the correct day. This is only going to work with the between below, or
  # other queries that use the 'days' query
  #
  # HINT: If you're using this, you should be using CalculatedStopTime
  #
  # Timezones are hard.
  # They need to go in/out as UTC so Rails will properly convert them to local
  # time. But internally, we want to do comparisons in them at the timezone
  # of the agency, so we have to conver them to the local time in the between
  # query below.
  #
  # Controlling formatting of times coming out of DB because Postgres 9.3 adds
  # on a +00 (timezone) which confuses Rails when we try to parse it to local
  # time.
  def self.select_for_departure
    readonly.select("stop_times.id, stop_times.stop_sequence, stop_times.stop_headsign,
           stop_times.pickup_type, stop_times.drop_off_type,
           stop_times.shape_dist_traveled, stop_times.agency_id,
           stop_times.stop_id, stop_times.trip_id,
           to_char(((start_time(effective_services.date) + stop_times.arrival_time) AT TIME ZONE 'UTC'), 'YYYY-MM-DD HH24:MI:SS') as arrival_time,
           to_char(((start_time(effective_services.date) + stop_times.departure_time) AT TIME ZONE 'UTC'), 'YYYY-MM-DD HH24:MI:SS') as departure_time")
  end

  # Expand the service days into actual dates so that we can use them to calculate
  # the offset for when the bus arrives.
  def self.between(start_time, end_time)
    joins_times(start_time, end_time)
      .where("(start_time(effective_services.date) + stop_times.departure_time) BETWEEN (? AT TIME ZONE agencies.timezone) AND (? AT TIME ZONE agencies.timezone)", start_time, end_time)
      .order("start_time(effective_services.date) + stop_times.departure_time")
  end

  # Effective services are those that are the the normal services for trips
  # where service exceptions are also taken into account
  def self.joins_times(start_time, end_time)
    joins("INNER JOIN agencies ON stop_times.agency_id = agencies.id
           INNER JOIN trips ON stop_times.trip_id = trips.id
           INNER JOIN (
              SELECT coalesce(service_exceptions.service_id, service_days.id) as service_id, d as date, dow
              FROM (SELECT d::date FROM generate_series('#{start_time.to_date}', '#{end_time.to_date}', interval '1 day') d) days
              LEFT JOIN service_days ON service_days.dow = rtrim(to_char(days.d, 'day'))
              LEFT JOIN service_exceptions ON service_exceptions.date = days.d
              WHERE service_exceptions.exception IS NULL OR service_exceptions.exception = 1) effective_services ON trips.service_id = effective_services.service_id")
  end
end

