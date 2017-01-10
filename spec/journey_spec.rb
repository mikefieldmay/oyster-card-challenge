require 'journey.rb'

describe Journey do

  subject(:journey) { described_class.new }

  let(:station) {instance_double(Station)}

  describe "#start" do
    it { is_expected.to respond_to(:start) }

    context "when starting journey" do
      it "should take station as an argument" do
        expect{journey.start(station)}.not_to raise_error
      end
      it "it sets the entry station attribute" do
        journey.start(station)
        expect(journey.entry_station).to eq station
      end
    end


  end


end
