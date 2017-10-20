class AdServer
  attr_reader :base_url

  class Error < StandardError; end

  def initialize
    @base_url ||= ENV['AD_SERVER_URL'] || 'http://mockbin.org'
  end

  def statuses(id = 'fcb30500-7b98-476f-810d-463a0b8fc3df')
    response = client.get("/bin/#{id}")

    if response.status != 200
      message = "Error communicating with AdServer. status: #{response.status}.
                 body: #{response.body}"
      raise Error, message
    end

    JSON.parse(response.body)
  end

  private

  def client
    @client ||= Faraday.new(base_url)
  end
end
