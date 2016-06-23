require 'spec_helper'

RSpec.describe Formstack::Model do
  let(:client) { spy("Test Client instance") }
  subject(:subclass) {
    Class.new do
      include Formstack::Model
      def self.client_method
        :test
      end
    end
  }

  before :each do
    allow(Formstack).to receive(:client).and_return(client)
  end

  describe "::all" do
    it "calls plural client_method passing args to client and initializes list of objects" do
      allow(client).to receive(:tests).with(arg: :val).and_return([{ "id" => 1 }])
      objects = subclass.all(arg: :val)
      expect(objects.size).to eq(1)
      expect(objects.first["id"]).to eq(1)
    end

    it "initializes with list in {response_nesting} if method defined" do
      subclass.class_eval do
        def self.response_nesting
          "nesting"
        end
      end

      allow(client).to receive(:tests).and_return("nesting" => [{ "id" => 1 }])
      objects = subclass.all
      expect(objects.size).to eq(1)
      expect(objects.first["id"]).to eq(1)
    end

    it "allows calling create on returned array" do
      allow(client).to receive(:tests).and_return([{}])
      allow(client).to receive(:create_test).with(123, :attributes).and_return({ "id" => "123" })
      allow(client).to receive(:test).with("123").and_return({ "id" => "123" })
      collection = subclass.all(123)
      created = collection.create(:attributes)
      expect(created[:id]).to eq("123")
    end
  end

  describe "::find" do
    it "calls client_method passing args to client and initializes an object" do
      allow(client).to receive(:test).with(1).and_return({ "id" => 1, "name" => "Foo" })
      object = subclass.find(1)
      expect(object["id"]).to eq(1)
      expect(object["name"]).to eq("Foo")
    end
  end

  describe "::create" do
    it "calls create_{client_method} passing args to client and initializes and loads object" do
      allow(client).to receive(:create_test).with(name: "val").and_return({ "id" => 123 })
      object = subclass.create(name: "val")
      expect(client).to have_received(:test).with(123)
      expect(object).to be_a(subclass)
    end

    it "does not load object on error" do
      allow(client).to receive(:create_test).and_return({ "status" => "error" })
      object = subclass.create
      expect(object["status"]).to eq("error")
    end
  end

  describe "#initialize" do
    it "sets passed args to @attributes" do
      object = subclass.new("name" => "value")
      expect(object.attributes).to eq("name" => "value")
    end
  end

  describe "#[]" do
    it "delegates to @attributes" do
      object = subclass.new("name" => "value")
      expect(object["name"]).to eq("value")
    end

    it "stringifies any symbol passed" do
      object = subclass.new("name" => "value")
      expect(object[:name]).to eq("value")
    end
  end

  describe "#load" do
    it "resets @attributes from a call to client_method with id attr" do
      object = subclass.new("id" => "123")
      expect(client).to receive(:test).with("123").and_return("id" => "123", "name" => "Foo")
      object.load
      expect(object[:name]).to eq("Foo")
    end
  end

  describe "#update" do
    it "updates @attributes with passed hash stringifying keys and calls update_{client_method}" do
      object = subclass.new("id" => "123", "name" => "Bar")
      expect(client).to receive(:update_test).with("123", "id" => "123", "name" => "Foo").and_return("success" => "1")
      object.update(name: "Foo")
      expect(object[:name]).to eq("Foo")
    end
  end

  describe "#delete" do
    it "calls delete_{client_method} on client" do
      object = subclass.new("id" => "123")
      expect(client).to receive(:delete_test).with("123").and_return("success" => "1")
      object.delete
    end
  end
end
