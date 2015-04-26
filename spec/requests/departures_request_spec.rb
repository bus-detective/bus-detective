require 'rails_helper'

RSpec.describe "departures api" do
  let(:json) { JSON.parse(response.body) }

  describe "api/departures" do
    let(:now) { Time.zone.parse("2015-04-23 7:30am") }
    let!(:trip) { create(:trip, remote_id: 940135, service: create(:service, thursday: true)) }
    let!(:stop) { create(:stop, remote_id: "HAMBELi") }
    let!(:stop_time) { create(:stop_time, stop: stop, trip: trip, departure_time: now + 10.minutes) }

    before do
      fixture = File.read('spec/fixtures/realtime_updates.buf')
      allow(Metro::Connection).to receive(:get).and_return(fixture)
    end

    context "with a rails id" do
      it "returns departures for a given stop" do
        get "/api/departures/?stop_id=#{stop.id}&time=#{now}"
        expect(json["data"]["departures"].first["delay"]).to eq(120)
      end
    end

    context "with a legacy remote_id" do
      it "returns arrivals for given remote_id" do
        get "/api/departures/?stop_id=#{stop.remote_id}&time=#{now}"
        expect(json["data"]["departures"].first["delay"]).to eq(120)
      end
    end
  end
end

