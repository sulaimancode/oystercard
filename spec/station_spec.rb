require "station"

describe Station do
  context "Basic Tests: Station" do
    subject = Station.new("Aldgate", 1)

    it "should have a #name" do
      expect(subject).to respond_to :station_name
    end

    it "should have a #zone" do
      expect(subject).to respond_to :zone
    end
  end
end
