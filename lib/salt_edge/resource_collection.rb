module SaltEdge
  class ResourceCollection < Resource
    include Enumerable

    attr_reader :options

    def initialize(client, data, options = {})
      data = {} unless data.is_a?(Hash)
      data = data.with_indifferent_access

      @client = client

      meta_data = data.delete(:meta) { {} }

      collection = Array(data.values.first).map do |item|
        Resource.new(client, item)
      end

      links = {}

      if meta_data.has_key?('next_id')
        @next_id = meta_data['next_id']
        @next_page = meta_data['next_page']
        links = {
          next: {
            href: meta_data['next_page']
          }
        }
      end

      @data = OpenStruct.new(meta: meta_data, collection: collection)
      @rels = parse_links(links)
      @options = options.with_indifferent_access
    end

    def each(&block)
      return enum_for(:each) unless block_given?

      collection.each(&block)

      return self if @next_id.nil?

      rel = @rels[:next] or return self

      resource_collection = rel.get(@options.except(:page))
      resource_collection.each(&Proc.new)

      @data = OpenStruct.new(meta: resource_collection.meta,
                             collection: collection + resource_collection.collection)
      @rels = resource_collection.rels
    end


    def merge(new_collection)
      @data = OpenStruct.new(meta: @data.meta, collection: @data.collection.push(*new_collection))
    end
  end
end
