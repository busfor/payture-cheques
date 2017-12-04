# frozen_string_literal: true
require 'faraday'
require 'json'

require "payture/cheques/version"

require 'payture/cheques/client'
require 'payture/cheques/config'
require 'payture/cheques/methods/base'
require 'payture/cheques/methods/create'
require 'payture/cheques/methods/status'
require 'payture/cheques/responses/base'
require 'payture/cheques/responses/create'
require 'payture/cheques/responses/status'

module Payture::Cheques
  class Error < StandardError
  end
end

module Payture
  module Cheques
    def self.client(**args)
      Client.new(**args)
    end
  end
end
