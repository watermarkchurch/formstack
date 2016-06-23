require 'delegate'

module Formstack
  class Collection < SimpleDelegator
    def initialize(array, klass:, context: [])
      @klass = klass
      @context = context
      super(array)
    end

    def create(*args)
      @klass.create(*@context, *args)
    end
  end
end
