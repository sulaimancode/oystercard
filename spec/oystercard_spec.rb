require 'oystercard'
describe Oystercard do


  context "With a new card" do

    it "should have default balance of 0" do
      expect(subject.balance).to eq (0)
    end

    it "should not be in use initially" do
      expect(subject.entry_station).to eq nil
    end

    it "should raise an exception if balance is less than £1" do
      expect{ subject.touch_in("Westminster Crabby") }.to raise_error "Insufficient funds for journey"
    end

  end

  context "With £30 already present in Oyster Card" do
    before {subject.top_up (30)}


    it "should top up balance by £20" do
      expect{ subject.top_up (20) }.to change{ subject.balance }.by (20)
    end

    it "should raise an error if card limit is exceeded" do
      expect{ subject.top_up (70) }.to raise_error "Card limit of £#{Oystercard::MAX_BALANCE} exceeded"
    end

    it "should note card is being used on a journey" do
      expect{ subject.touch_in("Fakerloo") }. to change { subject.entry_station }.to eq ("Fakerloo")
    end

    it "should note that journey has ended" do
      subject.touch_in("Westminster Crabby")
      expect{ subject.touch_out("Fakerloo") }. to change { subject.entry_station }.to eq nil
    end

    it "should deduct fare from card when touching out" do
      subject.touch_in("Westminster Crabby")
      expect{ subject.touch_out("Fakerloo") }. to change { subject.balance }.by (-Oystercard::MIN_FARE)
    end

    it "should record one journey from Fulham to Aldgate" do
      subject.top_up(7)
      subject.touch_in("Fulham")
      subject.touch_out("Aldgate")
      expect(subject.history).to eq ["Fulham" => "Aldgate"]
    end
  end
end
