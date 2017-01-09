require "oystercard.rb"

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe ".balance" do

    it { is_expected.to respond_to(:balance) }

    context "default balance" do
      it {expect(oystercard.balance).to eq 0}
    end

    context "specify balance" do
      subject(:oystercard) { described_class.new(30) }

      it { expect(oystercard.balance).to eq 30 }

    end

  end

  describe ".top_up" do

    it { is_expected.to respond_to(:top_up).with(1).argument }
  end

end
