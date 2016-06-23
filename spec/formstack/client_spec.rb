require 'spec_helper'

RSpec.describe Formstack::Client do
  describe "#initialize" do
    it "takes a connection and sets it to attribute" do
      obj = described_class.new connection: :conn
      expect(obj.connection).to eq(:conn)
    end

    it "defaults to a new instance of Connection" do
      allow(Formstack::Connection).to receive(:new).and_return(:conn)
      obj = described_class.new
      expect(obj.connection).to eq(:conn)
    end
  end

  describe "API methods" do
    let(:connection) { instance_spy(Formstack::Connection, get: :get, post: :post, put: :put, delete: :delete) }
    subject(:client) { described_class.new(connection: connection) }

    it "defines #forms(attrs) for GET /form" do
      expect(client.forms(folders: true)).to eq(:get)
      expect(connection).to have_received(:get).with("form", folders: true)
    end

    it "defines #form(id) for  GET /form/:id" do
      expect(client.form(123)).to eq(:get)
      expect(connection).to have_received(:get).with("form/123")
    end

    it "defines #create_form(attrs) for POST /form" do
      expect(client.create_form(arg: :val)).to eq(:post)
      expect(connection).to have_received(:post).with("form", arg: :val)
    end

    it "defines #update_form(id, attrs) for PUT /form/:id" do
      expect(client.update_form(123, arg: :val)).to eq(:put)
      expect(connection).to have_received(:put).with("form/123", arg: :val)
    end

    it "defines #delete_form(id) for DELETE /form/:id" do
      expect(client.delete_form(123)).to eq(:delete)
      expect(connection).to have_received(:delete).with("form/123")
    end

    it "defines #copy_form(id) for POST /form/:id/copy" do
      expect(client.copy_form(123)).to eq(:post)
      expect(connection).to have_received(:post).with("form/123/copy")
    end


    it "defines #fields for GET /form/:id/field" do
      expect(client.fields(123)).to eq(:get)
      expect(connection).to have_received(:get).with("form/123/field")
    end

    it "defines #field(id) for GET /field/:id" do
      expect(client.field(123)).to eq(:get)
      expect(connection).to have_received(:get).with("field/123")
    end

    it "defines #create_field(id, attrs) for POST /form/:id/field" do
      expect(client.create_field(123, arg: :val)).to eq(:post)
      expect(connection).to have_received(:post).with("form/123/field", arg: :val)
    end

    it "defines #update_field(id, attrs) for PUT /field/:id" do
      expect(client.update_field(123, arg: :val)).to eq(:put)
      expect(connection).to have_received(:put).with("field/123", arg: :val)
    end

    it "defines #delete_field(id) for DELETE /field/:id" do
      expect(client.delete_field(123)).to eq(:delete)
      expect(connection).to have_received(:delete).with("field/123")
    end


    it "defines #submissions for GET /form/:id/submission" do
      expect(client.submissions(123)).to eq(:get)
      expect(connection).to have_received(:get).with("form/123/submission")
    end

    it "defines #submission(id) for GET /submission/:id" do
      expect(client.submission(123)).to eq(:get)
      expect(connection).to have_received(:get).with("submission/123")
    end

    it "defines #create_submission(id, attrs) for POST /form/:id/submission" do
      expect(client.create_submission(123, arg: :val)).to eq(:post)
      expect(connection).to have_received(:post).with("form/123/submission", arg: :val)
    end

    it "defines #update_submission(id, attrs) for PUT /submission/:id" do
      expect(client.update_submission(123, arg: :val)).to eq(:put)
      expect(connection).to have_received(:put).with("submission/123", arg: :val)
    end

    it "defines #delete_submission(id) for DELETE /submission/:id" do
      expect(client.delete_submission(123)).to eq(:delete)
      expect(connection).to have_received(:delete).with("submission/123")
    end


    it "defines #confirmation_emails for GET /form/:id/confirmation" do
      expect(client.confirmation_emails(123)).to eq(:get)
      expect(connection).to have_received(:get).with("form/123/confirmation")
    end

    it "defines #confirmation_email(id) for GET /confirmation/:id" do
      expect(client.confirmation_email(123)).to eq(:get)
      expect(connection).to have_received(:get).with("confirmation/123")
    end

    it "defines #create_confirmation_email(id, attrs) for POST /form/:id/confirmation" do
      expect(client.create_confirmation_email(123, arg: :val)).to eq(:post)
      expect(connection).to have_received(:post).with("form/123/confirmation", arg: :val)
    end

    it "defines #update_confirmation_email(id, attrs) for PUT /confirmation/:id" do
      expect(client.update_confirmation_email(123, arg: :val)).to eq(:put)
      expect(connection).to have_received(:put).with("confirmation/123", arg: :val)
    end

    it "defines #delete_confirmation_email(id) for DELETE /confirmation/:id" do
      expect(client.delete_confirmation_email(123)).to eq(:delete)
      expect(connection).to have_received(:delete).with("confirmation/123")
    end


    it "defines #notification_emails for GET /form/:id/notification" do
      expect(client.notification_emails(123)).to eq(:get)
      expect(connection).to have_received(:get).with("form/123/notification")
    end

    it "defines #notification_email(id) for GET /notification/:id" do
      expect(client.notification_email(123)).to eq(:get)
      expect(connection).to have_received(:get).with("notification/123")
    end

    it "defines #create_notification_email(id, attrs) for POST /form/:id/notification" do
      expect(client.create_notification_email(123, arg: :val)).to eq(:post)
      expect(connection).to have_received(:post).with("form/123/notification", arg: :val)
    end

    it "defines #update_notification_email(id, attrs) for PUT /notification/:id" do
      expect(client.update_notification_email(123, arg: :val)).to eq(:put)
      expect(connection).to have_received(:put).with("notification/123", arg: :val)
    end

    it "defines #delete_notification_email(id) for DELETE /notification/:id" do
      expect(client.delete_notification_email(123)).to eq(:delete)
      expect(connection).to have_received(:delete).with("notification/123")
    end


    it "defines #webhooks for GET /form/:id/webhook" do
      expect(client.webhooks(123)).to eq(:get)
      expect(connection).to have_received(:get).with("form/123/webhook")
    end

    it "defines #webhook(id) for GET /webhook/:id" do
      expect(client.webhook(123)).to eq(:get)
      expect(connection).to have_received(:get).with("webhook/123")
    end

    it "defines #create_webhook(id, attrs) for POST /form/:id/webhook" do
      expect(client.create_webhook(123, arg: :val)).to eq(:post)
      expect(connection).to have_received(:post).with("form/123/webhook", arg: :val)
    end

    it "defines #update_webhook(id, attrs) for PUT /webhook/:id" do
      expect(client.update_webhook(123, arg: :val)).to eq(:put)
      expect(connection).to have_received(:put).with("webhook/123", arg: :val)
    end

    it "defines #delete_webhook(id) for DELETE /webhook/:id" do
      expect(client.delete_webhook(123)).to eq(:delete)
      expect(connection).to have_received(:delete).with("webhook/123")
    end
  end
end
