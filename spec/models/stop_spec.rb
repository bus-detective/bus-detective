require 'rails_helper'

RSpec.describe Stop do
  describe "#direction" do
    let(:stop) { build(:stop, id: stop_id) }
    context "inbound" do
      let(:stop_id) { "8THWALi" }
      specify { expect(stop.direction).to eq("inbound") }
    end
    context "outbound" do
      let(:stop_id) { "8THWALo" }
      specify { expect(stop.direction).to eq("outbound") }
    end
    context "northbound" do
      let(:stop_id) { "8THWALn" }
      specify { expect(stop.direction).to eq("northbound") }
    end
    context "southbound" do
      let(:stop_id) { "8THWALs" }
      specify { expect(stop.direction).to eq("southbound") }
    end
    context "eastbound" do
      let(:stop_id) { "8THWALe" }
      specify { expect(stop.direction).to eq("eastbound") }
    end
    context "westbound" do
      let(:stop_id) { "8THWALw" }
      specify { expect(stop.direction).to eq("westbound") }
    end
    context "unknown" do
      let(:stop_id) { "8THWALR" }
      specify { expect(stop.direction).to eq(nil) }
    end
  end
end