require "oystercard.rb"

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it {expect(oystercard).to respond_to(:balance)}

end