module SaltEdge
  class Client
    module Provider
      def providers
        get('/api/v5/providers')
      end
    end
  end
end
