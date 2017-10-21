class AdLink
  attr_reader :ad_import, :ad_from_server

  def initialize(ad_import, ad_from_server)
    @ad_import = ad_import
    @ad_from_server = ad_from_server
  end

  def sync?
    sync_on(:status)
  end

  private

  def sync_on(attribute)
    ad_import.public_send(attribute) == ad_from_server.public_send(attribute)
  end
end
