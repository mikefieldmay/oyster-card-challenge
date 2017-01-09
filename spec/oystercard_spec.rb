require "oystercard.rb"

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it "responds to ::DEFAULT_CREDIT_LIMIT" do
    expect(described_class).to be_const_defined(:DEFAULT_CREDIT_LIMIT)
  end

  it "responds to ::DEFAULT_DEBIT_LIMIT" do
    expect(described_class).to be_const_defined(:DEFAULT_DEBIT_LIMIT)
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

  describe ".in_journey" do
    it { is_expected.to respond_to(:in_journey?) }

    context "is false for new cards" do
      it { is_expected.not_to be_in_journey }
    end
  end

  describe ".touch_in" do
    it { is_expected.to respond_to(:touch_in)}

    context "when touched in" do
      it "changes in_journey? to true" do
        oystercard.touch_in
        expect(oystercard.in_journey?).to eq true
      end
    end

  end

end
