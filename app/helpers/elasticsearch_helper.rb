module ElasticsearchHelper
  puts "elasticsearch initialization"
  class EsRepo
    include Elasticsearch::Persistence::Repository
    include Elasticsearch::Persistence::Repository::DSL
    index_name Rails.application.secrets.elastic_index
    document_type :ggc_registration
  end
  # Configure the Elasticsearch client
  # @repository.client Elasticsearch::Client.new(hosts: [{ host: Rails.application.secrets.elastic_endpoint,
  #   port: Rails.application.secrets.elastic_endpoint_port,
  #   user: Rails.application.secrets.elastic_user,
  #   password: Rails.application.secrets.elastic_password,
  #   scheme: 'https'}], log: true)

  client = Elasticsearch::Client.new(url: "https://"+Rails.application.secrets.elastic_user.to_s+":"+Rails.application.secrets.elastic_password.to_s+"@"+Rails.application.secrets.elastic_endpoint+":"+Rails.application.secrets.elastic_endpoint_port.to_s, log: true)
  @repository = EsRepo.new(client: client)

  def self.included(base)
    puts @repository.inspect
    @repository.create_index!
  end

  def self.store_in_elastic(document)
    @repository.save(document)
  end

  def self.delete_from_elastic(document)
    @repository.delete(document)
  end
end
