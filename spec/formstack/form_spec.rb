require 'spec_helper'

RSpec.describe Formstack::Form do
  let(:client) { instance_spy(Formstack::Client) }

  before :each do
    allow(Formstack).to receive(:client).and_return(client)
  end

  it "includes Model module" do
    expect(described_class.included_modules).to include(Formstack::Model)
  end

  it "is configured" do
    expect(described_class.client_method).to eq(:form)
    expect(described_class.response_nesting).to eq("forms")
  end

  describe "#copy" do
    it "calls #copy_form on client and returns a new Form object with result" do
      object = described_class.new("id" => "123")
      expect(client).to receive(:copy_form).with("123").and_return("id" => "456")
      new_object = object.copy
      expect(new_object[:id]).to eq("456")
    end
  end

  describe "#fields" do
    it "initializes from attributes if fields key present" do
      object = described_class.new("fields" => ["id" => "123"])
      fields = object.fields
      expect(fields.size).to eq(1)
      expect(fields.first["id"]).to eq("123")
    end

    it "delegates to Field.all with id attribute if fields key not present" do
      object = described_class.new("id" => "123")
      allow(client).to receive(:fields).with("123").and_return(["id" => "456"])
      fields = object.fields
      expect(fields.size).to eq(1)
      expect(fields.first["id"]).to eq("456")
    end

    it "allows creating on the array when read from cache" do
      allow(client).to receive(:create_field).with("form-123", name: "Foo").and_return("id" => "field-456")
      allow(client).to receive(:field).with("field-456").and_return("id" => "field-456")
      object = described_class.new("id" => "form-123", "fields" => ["id" => "field-123"])
      fields = object.fields
      new_field = fields.create(name: "Foo")
      expect(new_field).to be_a(Formstack::Field)
      expect(new_field["id"]).to eq("field-456")
    end

    it "caches the value" do
      object = described_class.new("fields" => ["id" => "123"])
      fields = object.fields
      expect(fields.object_id).to eq(object.fields.object_id)
    end
  end

  describe "#submissions" do
    it "delegates to Submission.all with id attribute" do
      object = described_class.new("id" => "123")
      expect(Formstack::Submission).to receive(:all).with("123").and_return(:value)
      expect(object.submissions).to eq(:value)
    end

    it "caches the value" do
      object = described_class.new
      allow(Formstack::Submission).to receive(:all) { Array.new }
      expect(object.submissions.object_id).to eq(object.submissions.object_id)
    end
  end

  describe "#confirmation_emails" do
    it "delegates to ConfirmationEmail.all with id attribute" do
      object = described_class.new("id" => "123")
      expect(Formstack::ConfirmationEmail).to receive(:all).with("123").and_return(:value)
      expect(object.confirmation_emails).to eq(:value)
    end

    it "caches the value" do
      object = described_class.new
      allow(Formstack::ConfirmationEmail).to receive(:all) { Array.new }
      expect(object.confirmation_emails.object_id).to eq(object.confirmation_emails.object_id)
    end
  end

  describe "#notification_emails" do
    it "delegates to NotificationEmail.all with id attribute" do
      object = described_class.new("id" => "123")
      expect(Formstack::NotificationEmail).to receive(:all).with("123").and_return(:value)
      expect(object.notification_emails).to eq(:value)
    end

    it "caches the value" do
      object = described_class.new
      allow(Formstack::NotificationEmail).to receive(:all) { Array.new }
      expect(object.notification_emails.object_id).to eq(object.notification_emails.object_id)
    end
  end

  describe "#webhooks" do
    it "delegates to Webhook.all with id attribute" do
      object = described_class.new("id" => "123")
      expect(Formstack::Webhook).to receive(:all).with("123").and_return(:value)
      expect(object.webhooks).to eq(:value)
    end

    it "caches the value" do
      object = described_class.new
      allow(Formstack::Webhook).to receive(:all) { Array.new }
      expect(object.webhooks.object_id).to eq(object.webhooks.object_id)
    end
  end
end


RSpec.describe Formstack::Field do
  it "includes Model module" do
    expect(described_class.included_modules).to include(Formstack::Model)
  end

  it "is configured" do
    expect(described_class.client_method).to eq(:field)
    expect(described_class.response_nesting).to eq("")
  end
end

RSpec.describe Formstack::Submission do
  it "includes Model module" do
    expect(described_class.included_modules).to include(Formstack::Model)
  end

  it "is configured" do
    expect(described_class.client_method).to eq(:submission)
    expect(described_class.response_nesting).to eq("submissions")
  end
end

RSpec.describe Formstack::ConfirmationEmail do
  it "includes Model module" do
    expect(described_class.included_modules).to include(Formstack::Model)
  end

  it "is configured" do
    expect(described_class.client_method).to eq(:confirmation_email)
    expect(described_class.response_nesting).to eq("confirmations")
  end
end

RSpec.describe Formstack::NotificationEmail do
  it "includes Model module" do
    expect(described_class.included_modules).to include(Formstack::Model)
  end

  it "is configured" do
    expect(described_class.client_method).to eq(:notification_email)
    expect(described_class.response_nesting).to eq("notifications")
  end
end

RSpec.describe Formstack::Webhook do
  it "includes Model module" do
    expect(described_class.included_modules).to include(Formstack::Model)
  end

  it "is configured" do
    expect(described_class.client_method).to eq(:webhook)
    expect(described_class.response_nesting).to eq("webhooks")
  end
end

