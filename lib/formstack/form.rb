require 'formstack/model'

module Formstack
  class Form
    include Model

    def copy
      new_from_response client.copy_form self[:id]
    end

    def fields
      @fields ||= if self[:fields]
                    fields = self[:fields].map { |f| Field.new(f) }
                    Collection.new(fields, klass: Field, context: [self[:id]])
                  else
                    Field.all(self[:id])
                  end
    end

    def submissions
      @submissions ||= Submission.all(self[:id])
    end

    def confirmation_emails
      @confirmation_emails ||= ConfirmationEmail.all(self[:id])
    end

    def notification_emails
      @notification_emails ||= NotificationEmail.all(self[:id])
    end

    def url_key
      URI.parse(self[:url]).path.split("/").last
    end

    def webhooks
      @webhooks ||= Webhook.all(self[:id])
    end

    def self.client_method
      :form
    end

    def self.response_nesting
      "forms"
    end
  end

  class Field
    include Model

    def self.client_method
      :field
    end
  end

  class Submission
    include Model

    def self.client_method
      :submission
    end

    def self.response_nesting
      "submissions"
    end
  end

  class ConfirmationEmail
    include Model

    def self.client_method
      :confirmation_email
    end

    def self.response_nesting
      "confirmations"
    end
  end

  class NotificationEmail
    include Model

    def self.client_method
      :notification_email
    end

    def self.response_nesting
      "notifications"
    end
  end

  class Webhook
    include Model

    def self.client_method
      :webhook
    end

    def self.response_nesting
      "webhooks"
    end
  end
end
