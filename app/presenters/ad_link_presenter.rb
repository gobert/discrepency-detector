class AdLinkPresenter
  attr_reader :ad_links, :synced_links, :unsynced_links

  def initialize(ad_links)
    @ad_links = ad_links
    @synced_links, @unsynced_links = ad_links.partition(&:sync?)
  end

  def to_h
    {
      'enabled' => enabled_ad_links.map { |ad_link| present_ad_from(ad_link) },
      'deleted' => deleted_ad_links.map { |ad_link| present_ad_from(ad_link) },
      'disabled' => disabled_ad_links.map do |ad_link|
        present_ad_from(ad_link)
      end,
      'discrepencies' => unsynced_links.map do |ad_link|
        present_ad_from(ad_link)
      end
    }
  end

  private

  def present_ad_from(ad_link)
    {
      'id' => ad_link.ad_import.id,
      'ad_server_reference' => ad_link.ad_import.id_from_import,
      'job_id' => ad_link.ad_import.job_id,
      'status' => ad_link.ad_from_server.status,
      'description' => ad_link.ad_from_server.description
    }
  end

  def enabled_ad_links
    @enabled_ad_links ||= synced_links.select do |link|
      link.ad_import.status == :enabled
    end
  end

  def disabled_ad_links
    @disabled_ad_links ||= synced_links.select do |link|
      link.ad_import.status == :disabled
    end
  end

  def deleted_ad_links
    @deleted_ad_links ||= synced_links.select do |link|
      link.ad_import.status == :deleted
    end
  end
end
