class AdsController < ApplicationController
  # POST /ads/status
  def status
    ads_from_server = AdServer.new.statuses.fetch('ads', []).map do |ad_params|
      AdFromServer.new(ad_params)
    end

    ad_linkers = AdLinker.new(ads_from_import, ads_from_server).link_them

    render json: AdLinkPresenter.new(ad_linkers).to_h
  end

  private

  # Only allow a trusted parameter "white list" through.
  def ad_params
    params.require('ads')
  end

  def ads_from_import
    ad_params.map do |ad_params|
      AdImport.new(ad_params)
    end
  end
end
