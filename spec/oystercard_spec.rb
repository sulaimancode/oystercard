require 'oystercard'
describe Oystercard do


  context "With a new card" do
let (:station){ double :station }
let (:journey){ double :journey, station: station}

    it "should have default balance of 0" do
      expect(subject.balance).to eq (0)
    end

    it "should not be in use initially" do
      expect(subject.journey.entry_station).to eq nil
    end

    it "should raise an exception if balance is less than £1" do
      expect{ subject.touch_in(journey) }.to raise_error "Insufficient funds for journey"
    end

  end

  context "With £30 already present in Oyster Card" do
    before {subject.top_up (30)}
    let (:station){ double :station }
    let (:journey){ double :journey, station: station}

    it "should top up balance by £20" do
      expect{ subject.top_up (20) }.to change{ subject.balance }.by (20)
    end

    it "should raise an error if card limit is exceeded" do
      expect{ subject.top_up (70) }.to raise_error "Card limit of £#{described_class::MAX_BALANCE} exceeded"
    end

    it "should deduct fare from card when touching out" do
      allow(journey).to receive(:entry_station)
      allow(journey).to receive(:finish).with (station)
      allow(journey).to receive(:fare) { described_class::MIN_FARE }
      subject.touch_in(journey)
      expect{ subject.touch_out(station) }.to change { subject.balance }.by (-described_class::MIN_FARE)
    end

    it "should charge penalty fare for an incomplete journey" do
      allow(journey).to receive(:entry_station)
      allow(journey).to receive(:finish).with (station)
      allow(journey).to receive(:fare) { 6 }
      expect{ subject.touch_out(station)}.to change { subject.balance}.by -6

    end

    # it "should record one journey from Fulham to Aldgate" do
    #   subject.touch_in(journey)
    #   subject.touch_out("Aldgate")
    #   expect(subject.history).to eq ["Fulham" => "Aldgate"]
    # end
  end
end
