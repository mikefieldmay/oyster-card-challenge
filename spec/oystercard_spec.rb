require "oystercard.rb"

describe Oystercard do

  subject(:oystercard) { described_class.new }

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
      it "has a limit of 90" do
        expect { oystercard.top_up(91) }.to raise_error(RuntimeError, "Cannot top up above £90")
      end


    end

  end

end
