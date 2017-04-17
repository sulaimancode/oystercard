require 'oystercard'
describe Oystercard do

  it {is_expected.to respond_to(:balance)}

  it "should have default balance of 0" do
    expect(subject.balance).to eq (0)
  end

  it "should have a default limit of £90" do
    expect(subject.card_limit).to eq (90)
  end

  it "should top up balance by £20" do
    expect{ subject.top_up (20) }.to change{ subject.balance }.by (20)
  end

  it "should raise an error if card limit is exceeded" do
    expect{ subject.top_up (100) }.to raise_error "Card limit of £#{subject.card_limit} exceeded"
  end

  it "should deduct balance by £25" do
    subject.top_up(50)
    expect{ subject.deduct (25)}.to change{ subject.balance}.by (-25)
  end

end
