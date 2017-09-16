module ElasticsearchHelper

  puts "elasticsearch initialization"
  @repository = Elasticsearch::Persistence::Repository.new do
    # Configure the Elasticsearch client
    client Elasticsearch::Client.new hosts: [{ host: Rails.application.secrets.elastic_endpoint,
      port: Rails.application.secrets.elastic_endpoint_port,
      user: Rails.application.secrets.elastic_user,
      password: Rails.application.secrets.elastic_password,
      scheme: 'https'}], log: true

      # Set a custom index name
      index Rails.application.secrets.elastic_index

      # Set a custom document type
      type  :ggc_registration

      # Specify the class to initialize when deserializing documents
      # klass Note

      # Configure the settings and mappings for the Elasticsearch index
      # settings number_of_shards: 1 do
      #  mapping do
      #    indexes :text, analyzer: 'snowball'
      #  end
      # end

      # Customize the serialization logic
      def serialize(document)
        super.merge(id: document.id)
      end

      # Customize the de-serialization logic
      # def deserialize(document)
      #   puts "# ***** CUSTOM DESERIALIZE LOGIC KICKING IN... *****"
      #   super
      # end
  end

  def self.included(base)
    @repository.create_index!
  end

  def self.store_in_elastic(document)
    @repository.save(document)
  end

  def self.delete_from_elastic(document)
    @repository.delete(document)
  end
end
