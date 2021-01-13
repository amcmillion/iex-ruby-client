module CloudQuote
  module Cloud
    module Request
      def get(path, options = {})
        request(:get, path, options)
      end

      def post(path, options = {})
        request(:post, path, options)
      end

      def put(path, options = {})
        request(:put, path, options)
      end

      def delete(path, options = {})
        request(:delete, path, options)
      end

      private

      def request(method, path, options)
        # path = if options[:use_sandbox]
        #          options.delete(:use_sandbox)
        #          ['https://sandbox.iexapis.com/stable', path].join('/')
        #        else
        path = [endpoint, path].join('/')
         # end
        response = connection.send(method) do |request|
          case method
          when :get, :delete
            request.url(path, options)
          when :post, :put
            request.path = path
            request.body = options.to_json unless options.empty?
          end
          request.options.merge!(options.delete(:request)) if options.key?(:request)
        end
        response.body
      end
    end
  end
end
