--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: start_time(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION start_time(start_date date DEFAULT ('now'::text)::date) RETURNS timestamp without time zone
    LANGUAGE sql
    AS $$ SELECT start_date + interval '12:00:00' - interval '12:00:00' $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: agencies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE agencies (
    id integer NOT NULL,
    remote_id character varying,
    name character varying,
    url character varying,
    fare_url character varying,
    timezone character varying,
    language character varying,
    phone character varying,
    gtfs_endpoint character varying,
    realtime_endpoint character varying
);


--
-- Name: agencies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE agencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE agencies_id_seq OWNED BY agencies.id;


--
-- Name: route_stops; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE route_stops (
    id integer NOT NULL,
    route_id integer NOT NULL,
    stop_id integer NOT NULL
);


--
-- Name: route_stops_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE route_stops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: route_stops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE route_stops_id_seq OWNED BY route_stops.id;


--
-- Name: routes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE routes (
    id integer NOT NULL,
    remote_id character varying,
    short_name character varying,
    long_name character varying,
    description character varying,
    route_type character varying,
    url character varying,
    color character varying,
    text_color character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    agency_id integer
);


--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE routes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE routes_id_seq OWNED BY routes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE services (
    id integer NOT NULL,
    agency_id integer,
    remote_id character varying,
    monday boolean DEFAULT false,
    tuesday boolean DEFAULT false,
    wednesday boolean DEFAULT false,
    thursday boolean DEFAULT false,
    friday boolean DEFAULT false,
    saturday boolean DEFAULT false,
    sunday boolean DEFAULT false,
    start_date date,
    end_date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE services_id_seq OWNED BY services.id;


--
-- Name: stop_times; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stop_times (
    id integer NOT NULL,
    stop_sequence character varying,
    stop_headsign character varying,
    pickup_type integer,
    drop_off_type integer,
    shape_dist_traveled double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    agency_id integer,
    stop_id integer,
    trip_id integer,
    arrival_time interval NOT NULL,
    departure_time interval NOT NULL
);


--
-- Name: stop_times_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stop_times_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stop_times_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stop_times_id_seq OWNED BY stop_times.id;


--
-- Name: stops; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stops (
    id integer NOT NULL,
    remote_id character varying,
    code integer,
    name character varying,
    description character varying,
    latitude double precision,
    longitude double precision,
    zone_id integer,
    url character varying,
    location_type integer,
    parent_station character varying,
    timezone character varying,
    wheelchair_boarding integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    agency_id integer
);


--
-- Name: stops_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stops_id_seq OWNED BY stops.id;


--
-- Name: trips; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trips (
    id integer NOT NULL,
    remote_id character varying,
    service_id integer,
    headsign character varying,
    short_name character varying,
    direction_id integer,
    block_id integer,
    shape_id integer,
    wheelchair_accessible integer,
    bikes_allowed integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    agency_id integer,
    route_id integer
);


--
-- Name: trips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE trips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE trips_id_seq OWNED BY trips.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY agencies ALTER COLUMN id SET DEFAULT nextval('agencies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY route_stops ALTER COLUMN id SET DEFAULT nextval('route_stops_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY routes ALTER COLUMN id SET DEFAULT nextval('routes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY services ALTER COLUMN id SET DEFAULT nextval('services_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stop_times ALTER COLUMN id SET DEFAULT nextval('stop_times_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stops ALTER COLUMN id SET DEFAULT nextval('stops_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY trips ALTER COLUMN id SET DEFAULT nextval('trips_id_seq'::regclass);


--
-- Name: agencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY agencies
    ADD CONSTRAINT agencies_pkey PRIMARY KEY (id);


--
-- Name: route_stops_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY route_stops
    ADD CONSTRAINT route_stops_pkey PRIMARY KEY (id);


--
-- Name: routes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);


--
-- Name: services_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: stop_times_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stop_times
    ADD CONSTRAINT stop_times_pkey PRIMARY KEY (id);


--
-- Name: stops_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (id);


--
-- Name: trips_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (id);


--
-- Name: index_agencies_on_remote_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_agencies_on_remote_id ON agencies USING btree (remote_id);


--
-- Name: index_route_stops_on_stop_id_and_route_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_route_stops_on_stop_id_and_route_id ON route_stops USING btree (stop_id, route_id);


--
-- Name: index_routes_on_agency_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_routes_on_agency_id ON routes USING btree (agency_id);


--
-- Name: index_routes_on_remote_id_and_agency_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_routes_on_remote_id_and_agency_id ON routes USING btree (remote_id, agency_id);


--
-- Name: index_services_on_agency_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_services_on_agency_id ON services USING btree (agency_id);


--
-- Name: index_stop_times_on_agency_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stop_times_on_agency_id ON stop_times USING btree (agency_id);


--
-- Name: index_stop_times_on_agency_id_and_stop_id_and_trip_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stop_times_on_agency_id_and_stop_id_and_trip_id ON stop_times USING btree (agency_id, stop_id, trip_id);


--
-- Name: index_stop_times_on_stop_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stop_times_on_stop_id ON stop_times USING btree (stop_id);


--
-- Name: index_stop_times_on_trip_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stop_times_on_trip_id ON stop_times USING btree (trip_id);


--
-- Name: index_stops_on_agency_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stops_on_agency_id ON stops USING btree (agency_id);


--
-- Name: index_stops_on_remote_id_and_agency_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stops_on_remote_id_and_agency_id ON stops USING btree (remote_id, agency_id);


--
-- Name: index_trips_on_agency_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_trips_on_agency_id ON trips USING btree (agency_id);


--
-- Name: index_trips_on_remote_id_and_agency_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_trips_on_remote_id_and_agency_id ON trips USING btree (remote_id, agency_id);


--
-- Name: index_trips_on_route_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_trips_on_route_id ON trips USING btree (route_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_01d91dfe5b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stop_times
    ADD CONSTRAINT fk_rails_01d91dfe5b FOREIGN KEY (agency_id) REFERENCES agencies(id);


--
-- Name: fk_rails_105982e7f8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trips
    ADD CONSTRAINT fk_rails_105982e7f8 FOREIGN KEY (service_id) REFERENCES services(id);


--
-- Name: fk_rails_141231e2f2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stops
    ADD CONSTRAINT fk_rails_141231e2f2 FOREIGN KEY (agency_id) REFERENCES agencies(id);


--
-- Name: fk_rails_1d59619cdb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trips
    ADD CONSTRAINT fk_rails_1d59619cdb FOREIGN KEY (agency_id) REFERENCES agencies(id);


--
-- Name: fk_rails_1f4cc828f8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY route_stops
    ADD CONSTRAINT fk_rails_1f4cc828f8 FOREIGN KEY (route_id) REFERENCES routes(id);


--
-- Name: fk_rails_7ac710f08a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stop_times
    ADD CONSTRAINT fk_rails_7ac710f08a FOREIGN KEY (stop_id) REFERENCES stops(id);


--
-- Name: fk_rails_9a39561dfd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trips
    ADD CONSTRAINT fk_rails_9a39561dfd FOREIGN KEY (route_id) REFERENCES routes(id);


--
-- Name: fk_rails_a62bf79bbc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY routes
    ADD CONSTRAINT fk_rails_a62bf79bbc FOREIGN KEY (agency_id) REFERENCES agencies(id);


--
-- Name: fk_rails_cc9fde6bb7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY route_stops
    ADD CONSTRAINT fk_rails_cc9fde6bb7 FOREIGN KEY (stop_id) REFERENCES stops(id);


--
-- Name: fk_rails_f0cd5d1f9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services
    ADD CONSTRAINT fk_rails_f0cd5d1f9f FOREIGN KEY (agency_id) REFERENCES agencies(id);


--
-- Name: fk_rails_f5df03eb13; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stop_times
    ADD CONSTRAINT fk_rails_f5df03eb13 FOREIGN KEY (trip_id) REFERENCES trips(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20150317180959');

INSERT INTO schema_migrations (version) VALUES ('20150317183048');

INSERT INTO schema_migrations (version) VALUES ('20150317184449');

INSERT INTO schema_migrations (version) VALUES ('20150317185919');

INSERT INTO schema_migrations (version) VALUES ('20150323125151');

INSERT INTO schema_migrations (version) VALUES ('20150417004014');

INSERT INTO schema_migrations (version) VALUES ('20150417031937');

INSERT INTO schema_migrations (version) VALUES ('20150417033146');

INSERT INTO schema_migrations (version) VALUES ('20150417034339');

INSERT INTO schema_migrations (version) VALUES ('20150417035819');

INSERT INTO schema_migrations (version) VALUES ('20150417040242');

INSERT INTO schema_migrations (version) VALUES ('20150418141347');

INSERT INTO schema_migrations (version) VALUES ('20150425204038');

INSERT INTO schema_migrations (version) VALUES ('20150430224711');

INSERT INTO schema_migrations (version) VALUES ('20150501165537');

INSERT INTO schema_migrations (version) VALUES ('20150503132110');

INSERT INTO schema_migrations (version) VALUES ('20150512134125');

INSERT INTO schema_migrations (version) VALUES ('20150512135655');

INSERT INTO schema_migrations (version) VALUES ('20150512192738');

INSERT INTO schema_migrations (version) VALUES ('20150515140017');
