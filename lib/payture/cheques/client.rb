# frozen_string_literal: true

module Payture::Cheques
  class Client
    attr_reader :config

    def initialize(**options)
      @config = Config.new(**options)
    end

    def create(**args)
      Methods::Create.new(config).call(**args)
    end

    def status(**args)
      Methods::Status.new(config).call(**args)
    end
  end
end
