require "oystercard.rb"

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe ".balance" do

    it {expect(oystercard).to respond_to(:balance)}

    context "default balance" do
      it {expect(oystercard.balance).to eq 0}
    end

    context "specify balance" do
      subject(:oystercard) { described_class.new(30)}

      it { expect(oystercard.balance).to eq 30 }

    end

  end

end
