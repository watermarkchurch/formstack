require 'spec_helper'

describe Formstack do
  it 'has a version number' do
    expect(Formstack::VERSION).not_to be nil
  end

  describe "#client" do
    it "returns an instance of the Client class" do
      expect(Formstack.client).to be_a(Formstack::Client)
    end

    it "caches the value" do
      expect(Formstack.client.object_id).to eq(Formstack.client.object_id)
    end
  end
end
