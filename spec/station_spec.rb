require 'station'

describe Station do
  subject(:station) { described_class.new("a_name")}

  it{expect(station).to respond_to(:name)}

  context "when creating a station" do
    it "takes name as an argument" do
      expect{described_class.new("name")}.not_to raise_error
    end
    it "assigns argument to instance variable name" do
      expect(station.name).to eq "a_name"
    end
  end
end
