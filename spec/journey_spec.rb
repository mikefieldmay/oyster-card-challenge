require 'journey.rb'

describe Journey do

  subject(:journey) { described_class.new }

  let(:station) {instance_double(Station)}
  let(:another_station) {instance_double(Station)}


  describe "#start" do

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

describe "#finish" do

  context "when finishing a journey" do
    it "sets the exit station attribute " do
      journey.finish(another_station)
      expect(journey.exit_station).to eq another_station
    end
  end
end

describe "#complete?" do
  context "whilst in a journey" do
  it "returns a boolean" do
    journey.start(station)
    expect(journey.complete?).to eq false
  end
end
end

end
