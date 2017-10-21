class AdLinker
  attr_reader :ads_import, :ads_from_server

  def initialize(ads_import, ads_from_server)
    @ads_import = ads_import
    @ads_from_server = ads_from_server
  end

  def link_them
    ad_couples, ad_singles = pair_by_id(ads_import, ads_from_server)

    links = ad_couples.map do |couple|
      AdLink.new(couple.first, couple.second)
    end
    links << ad_singles.map do |ad|
      next if !ad.respond_to?(:id_from_import)
      ad_from_server = AdFromServer.new('reference' => ad.id,
                                        'status' => 'deleted')
      AdLink.new(ad, ad_from_server)
    end

    links.flatten.compact
  end

  private

  def pair_by_id(ads_import, ads_from_server)
    ads_import = ensure_unicity_on_id(ads_import)
    ads_from_server = ensure_unicity_on_id(ads_from_server)

    couples_grouped, single_grouped = (ads_import + ads_from_server)
                                      .group_by(&:id).partition do |_, ads|
                                        ads.count == 2
                                      end

    ad_couples = couples_grouped.map(&:second)
    ad_singles = single_grouped.map(&:second).flatten

    [ad_couples, ad_singles]
  end

  def ensure_unicity_on_id(ad_list)
    ad_list.uniq(&:id)
  end
end
