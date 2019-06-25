# frozen_string_literal: true

module Payture::Cheques
  module Methods
    class Base
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def call(**args)
        http_response = make_request(url, params(**args))
        build_response(http_response)
      end

      private

      def url
        raise NotImplementedError
      end

      def params
        raise NotImplementedError
      end

      def response_class
        raise NotImplementedError
      end

      def make_request(url, params)
        conn = Faraday.new do |builder|
          builder.request :url_encoded
          builder.response(:logger, config.logger) if config.logger
          builder.adapter Faraday.default_adapter
        end
        conn.post(url) do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = compact_hash(params).to_json
          config.logger.debug(req.body) if config.logger
          req.options.timeout = config.timeout if config.timeout
          req.options.open_timeout = config.open_timeout if config.open_timeout
        end
      rescue Faraday::Error => e
        raise Error, "#{e.class}: #{e.message}"
      end

      def build_response(http_response)
        unless http_response.success?
          raise Error, "Invalid http status: #{http_response.status}"
        end

        body =
          begin
            JSON.parse(http_response.body)
          rescue JSON::ParserError => e
            raise Error, "#{e.class}: #{e.message}"
          end

        config.logger.debug(body) if config.logger
        response_class.new(body)
      end

      def encoded_data(**params)
        params_str = compact_hash(params).map { |k, v| "#{k}=#{v}" }.join(';')
        CGI.escape(params_str)
      end

      def compact_hash(hash)
        hash.select { |k, v| k && v }
      end
    end
  end
end
