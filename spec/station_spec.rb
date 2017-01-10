require 'station'

describe Station do
  subject(:station) { described_class.new(:a_name, :a_zone)}

  it{expect(station).to respond_to(:name)}
  it{expect(station).to respond_to(:zone)}

  context "when creating a station" do
    it "takes name as an argument" do
      expect{described_class.new("name", "zone")}.not_to raise_error
    end
    it "assigns argument to instance variable name" do
      expect(station.name).to eq :a_name
    end
    it "assigns argument zone to instance variable zone" do
      expect(station.zone).to eq :a_zone
    end
  end
end
