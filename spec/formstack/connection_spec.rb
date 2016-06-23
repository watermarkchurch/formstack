require 'spec_helper'

RSpec.describe Formstack::Connection do

  describe "#initialize" do
    it "takes a base_uri sanitizing with URI and sets to attr" do
      obj = described_class.new base_uri: "http://example.org"
      expect(obj.base_uri).to be_a(URI)
      expect(obj.base_uri.to_s).to eq("http://example.org")
    end

    it "takes a access_token and sets to attr" do
      obj = described_class.new access_token: "secret"
      expect(obj.access_token).to eq("secret")
    end

    it "defaults base_uri to the class constant BASE_URI" do
      obj = described_class.new
      expect(obj.base_uri).to eq(described_class::BASE_URI)
    end

    it "defaults access_token to the environment variable FORMSTACK_ACCESS_TOKEN" do
      previous_value = ENV['FORMSTACK_ACCESS_TOKEN']
      begin
        ENV['FORMSTACK_ACCESS_TOKEN'] = "test-secret"
        obj = described_class.new
        expect(obj.access_token).to eq("test-secret")
      ensure
        ENV['FORMSTACK_ACCESS_TOKEN'] = previous_value
      end
    end
  end

  shared_examples_for "request method" do |method|
    it "calls #{method.to_s.upcase} on the supplied uri appended to the base_uri" do
      shared_stub_request method: method, request: { body: { request: :val }.to_json }, response: { body: { response: :val }.to_json }
      expect(connection.public_send(method, "test", request: :val)).to eq("response" => "val")
    end

    it "sets the bearer token" do
      shared_stub_request method: method, request: { headers: { "Authorization" => "Bearer secret" } }
      connection.public_send(method, "test")
    end

    context "with non-empty args passed" do
      it "sets the Content-Type to application/json" do
        shared_stub_request method: method,
          request: { body: { request: :val }.to_json, headers: { "Content-Type" => "application/json" } }
        connection.public_send(method, "test", request: :val)
      end
    end

    context "error cases" do
      it "returns the parsed error" do
        [400, 403, 404, 500].each do |code|
          shared_stub_request method: method,
            response: { status: code, body: { status: "error", error: "message" }.to_json }
          expect(connection.public_send(method, "test"))
            .to eq("status" => "error", "error" => "message"), "status code #{code} did not return proper value"
        end
      end
    end

    def shared_stub_request(method:, path: "test", request: { body: "" }, response: { body: {}.to_json })
      stub_request(method, base_uri + path)
        .with(request)
        .to_return(response)
    end
  end

  describe "request methods" do
    let(:base_uri) { URI("http://example.org/") }
    subject(:connection) { described_class.new base_uri: base_uri, access_token: "secret" }

    describe "#get" do
      it_behaves_like "request method", :get
    end

    describe "#post" do
      it_behaves_like "request method", :post
    end

    describe "#put" do
      it_behaves_like "request method", :put
    end

    describe "#delete" do
      it_behaves_like "request method", :delete
    end
  end

end
