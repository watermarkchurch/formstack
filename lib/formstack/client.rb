require 'forwardable'
require 'formstack/connection'

module Formstack
  class Client
    extend Forwardable
    attr_reader :connection

    def_delegators :connection, :get, :post, :put, :delete

    def initialize(connection: Connection.new)
      @connection = connection
    end

    def forms(args={})
      get("form", args)
    end

    def form(form_id)
      get("form/#{form_id}")
    end

    def create_form(args={})
      post("form", args)
    end

    def update_form(form_id, args={})
      put("form/#{form_id}", args)
    end

    def delete_form(form_id)
      delete("form/#{form_id}")
    end

    def copy_form(form_id)
      post("form/#{form_id}/copy")
    end

    def fields(form_id)
      get("form/#{form_id}/field")
    end

    def field(field_id)
      get("field/#{field_id}")
    end

    def create_field(form_id, args={})
      post("form/#{form_id}/field", args)
    end

    def update_field(field_id, args={})
      put("field/#{field_id}", args)
    end

    def delete_field(field_id)
      delete("field/#{field_id}")
    end

    def submissions(form_id)
      get("form/#{form_id}/submission")
    end

    def submission(submission_id)
      get("submission/#{submission_id}")
    end

    def create_submission(form_id, args={})
      post("form/#{form_id}/submission", args)
    end

    def update_submission(submission_id, args={})
      put("submission/#{submission_id}", args)
    end

    def delete_submission(submission_id)
      delete("submission/#{submission_id}")
    end

    def confirmation_emails(form_id)
      get("form/#{form_id}/confirmation")
    end

    def confirmation_email(confirmation_id)
      get("confirmation/#{confirmation_id}")
    end

    def create_confirmation_email(form_id, args={})
      post("form/#{form_id}/confirmation", args)
    end

    def update_confirmation_email(confirmation_id, args={})
      put("confirmation/#{confirmation_id}", args)
    end

    def delete_confirmation_email(confirmation_id)
      delete("confirmation/#{confirmation_id}")
    end

    def notification_emails(form_id)
      get("form/#{form_id}/notification")
    end

    def notification_email(notification_id)
      get("notification/#{notification_id}")
    end

    def create_notification_email(form_id, args={})
      post("form/#{form_id}/notification", args)
    end

    def update_notification_email(notification_id, args={})
      put("notification/#{notification_id}", args)
    end

    def delete_notification_email(notification_id)
      delete("notification/#{notification_id}")
    end

    def webhooks(form_id)
      get("form/#{form_id}/webhook")
    end

    def webhook(webhook_id)
      get("webhook/#{webhook_id}")
    end

    def create_webhook(form_id, args={})
      post("form/#{form_id}/webhook", args)
    end

    def update_webhook(webhook_id, args={})
      put("webhook/#{webhook_id}", args)
    end

    def delete_webhook(webhook_id)
      delete("webhook/#{webhook_id}")
    end
  end
end
