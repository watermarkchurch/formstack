require 'formstack/version'
require 'formstack/form'
require 'formstack/client'

module Formstack

  def self.client
    @client ||= Client.new
  end

end
