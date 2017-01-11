require "oystercard.rb"

describe Oystercard do

  subject(:oystercard) { described_class.new }

  let(:station) {instance_double(Station)}
  let(:second_station) {instance_double(Station)}

  it "responds to ::DEFAULT_CREDIT_LIMIT" do
    expect(described_class).to be_const_defined(:DEFAULT_CREDIT_LIMIT)
  end

  it "responds to ::DEFAULT_DEBIT_LIMIT" do
    expect(described_class).to be_const_defined(:DEFAULT_DEBIT_LIMIT)
  end

  it "responds to ::MINIMUM_FARE" do
    expect(described_class).to be_const_defined(:MINIMUM_FARE)
  end

  describe ".balance" do

    context "default balance" do
      it {expect(oystercard.balance).to eq 0}
    end

    context "specify balance of 30" do
      subject(:oystercard) { described_class.new(30) }

      it { expect(oystercard.balance).to eq 30 }

    end
  end

  describe ".top_up" do

    context "topping up card" do

      it "increases the balance" do
        oystercard.top_up(30)
        expect(oystercard.balance).to eq 30
      end

    end

    context "top up limit" do
      default_limit = described_class::DEFAULT_CREDIT_LIMIT
      message = "Cannot top up above £#{default_limit}"
      it "has a limit of 90" do
        expect { oystercard.top_up(default_limit + 1) }.to raise_error(RuntimeError, message)
      end
      it "will not exceed limit of £#{default_limit}" do
        oystercard.top_up(default_limit)
        expect{oystercard.top_up(1)}.to raise_error(RuntimeError, message)
      end

    end

  end

=begin
  describe ".deduct" do
    subject(:oystercard) { described_class.new(40) }

    context "deducting from card" do

      it "decreases the balance" do
        oystercard.deduct(20)
        expect(oystercard.balance).to eq 20
      end

      context "debit limit" do
        debit_limit = described_class::DEFAULT_DEBIT_LIMIT
        message = "Cannot deduct below £#{debit_limit}"
        it "won't deduct below #{debit_limit}" do
          expect{oystercard.deduct(41)}.to raise_error(RuntimeError, message)
        end
      end

    end
  end
=end

  describe ".in_journey" do
    it { is_expected.to respond_to(:in_journey?) }

    context "is false for new cards" do
      it { is_expected.not_to be_in_journey }
    end
  end

  describe ".touch_in" do
    subject(:oystercard) { described_class.new(Oystercard::MINIMUM_FARE+1) }

    it { is_expected.to respond_to(:touch_in).with(1).argument}

    context "when touched in" do
      xit "changes in_journey? to true" do
        oystercard.touch_in(station)
        expect(oystercard.in_journey?).to eq true
      end
    end

    context "if oystercard is in journey" do
      message = "Touched in already"
      xit "raises an error" do
        oystercard.touch_in(station)
        expect{oystercard.touch_in(station)}.to raise_error(message)
      end
    end

    context "if balance is less than MINIMUM_FARE" do
      subject(:oystercard) { described_class.new(Oystercard::MINIMUM_FARE-1) }
      message = "Balance below minimum fare"
      it 'raises an error' do
        expect{oystercard.touch_in(station)}.to raise_error(message)
      end
    end

  end

  describe "#touch_out" do

    it { is_expected.to respond_to(:touch_out).with(1).argument}
    minimum_fare = Oystercard::MINIMUM_FARE

    context "when oystercard is touched out" do
      before do
        oystercard.top_up(minimum_fare * 2)
        oystercard.touch_in(station)
      end

      it "changes in_journey to false" do
        oystercard.touch_out(second_station)
        expect(oystercard.in_journey?).to eq false
      end

      it "reduces the balance by #{minimum_fare}" do
        expect{oystercard.touch_out(second_station)}.to change{oystercard.balance}.by (-minimum_fare)
      end

      xit "raises an error if not in journey" do
        oystercard.touch_out(second_station)
        expect{oystercard.touch_out(second_station)}.to raise_error("Touched out already")
      end

    end

  end

  describe "#start_station" do

    it { is_expected.to respond_to(:start_station)}

    minimum_fare = Oystercard::MINIMUM_FARE

    before do
      oystercard.top_up(minimum_fare * 2)
      oystercard.touch_in(station)
    end

    context "when in_journey " do
      xit "returns the start station" do
        expect(oystercard.start_station).to eq station
      end
    end

    context "when not in_journey" do
      it "returns nil for start_station" do
        oystercard.touch_out(second_station)
        expect(oystercard.start_station).to eq nil
      end
    end

  end

  describe "#journeys" do
    it{is_expected.to respond_to(:journeys)}

    it "has an empty journeys array" do
      expect(oystercard.journeys).to eq []
    end

    minimum_fare = Oystercard::MINIMUM_FARE

    before do
      oystercard.top_up(minimum_fare * 2)
      oystercard.touch_in(station)
    end

    context "when touching out" do
      xit "should store journey" do
          oystercard.touch_out(second_station)
          journey = {start_station: station, exit_station: second_station}
          expect(oystercard.journeys).to include(journey)
        end
    end

  end


end
