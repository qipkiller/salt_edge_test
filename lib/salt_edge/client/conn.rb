module SaltEdge
  class Client
    module Conn
      def get(path, options = {})
        request :get, path, options
      end

      def post(path, options = {})
        request :post, path, options
      end

      def put(path, options = {})
        request :put, path, options
      end

      def delete(path, options = {})
        request :delete, path, options
      end

      private

      def request(http_method, path, options)
        logger.debug("Initiate [#{http_method.upcase}] request to path: [#{path}] with options: #{options.inspect}")
        if options.key? :body
          options[:body] = options[:body].to_json
        end
        response = self.class.send(http_method, path, options)
        data = response.parsed_response
        result = parse_data(data)
        result.response = response
        result
      end

      def parse_data(original_data)
        return unless original_data

        data = original_data.keys.count <= 2 ? original_data.values.first : original_data

        case data
        when Hash  then Resource.new(self, data)
        when Array then ResourceCollection.new(self, original_data)
        when nil   then nil
        else data
        end
      end
    end
  end
end
