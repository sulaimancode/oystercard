require 'journey'
describe Journey do
=begin
  it "should note card is being used on a journey" do
    expect{ subject.start("Fakerloo") }. to change { subject.entry_station }.to eq ("Fakerloo")
  end

  it "should note that journey has ended" do
    subject.start("Westminster Crabby")
    subject.finish("Fakerloo")
    expect(subject.complete?).to eq true
  end
=end

  let (:entry_station){ double :station }
  let (:exit_station){ double :station }
  let (:journey){ described_class.new(entry_station) }

  it "has an entry station" do
    expect(journey.entry_station).to eq entry_station
  end

  it "has an exit station" do
    journey.finish(exit_station)
    expect(journey.exit_station).to eq exit_station
  end

  describe "#fare" do
    it "returns #{described_class::MIN_FARE} if journey is complete" do
      journey.finish(exit_station)
      expect(journey.fare).to eq described_class::MIN_FARE
    end


    it "reutrns #{described_class::PENALTY_FARE} if journey is incomplete" do
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end

  end

  describe '#complete?' do
    context 'With no exit station' do

      it "returns as false" do
        expect(journey).to_not be_complete
      end
    end

    context 'With an exit station' do
      it "returns as true" do
        journey.finish(exit_station)
        expect(journey).to be_complete
      end
    end
  end

end
