require 'journey.rb'

describe Journey do

  let(:station) {instance_double(Station)}
  let(:another_station) {instance_double(Station)}

    subject(:journey) { described_class.new(station) }


  describe "#initialize" do

    context "when starting journey" do
      it "should take station as an argument" do
        expect{described_class.new(station)}.not_to raise_error
      end
      it "it sets the entry station attribute" do
        expect(journey.entry_station).to eq station
      end
    end
  end

describe "#end_journey" do

  context "when finishing a journey" do
    it "sets the exit station attribute " do
      journey.end_journey(another_station)
      expect(journey.exit_station).to eq another_station
    end
  end
end

describe "#complete?" do
  context "whilst in a journey" do
  it "returns a boolean" do
    expect(journey.complete?).to eq false
  end
end
end

end
