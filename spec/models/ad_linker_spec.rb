RSpec::Matchers.define :link_ads do |ad_import, ad_from_server|
  match do |ad_link|
    ad_link.ad_import == ad_import && ad_link.ad_from_server == ad_from_server
  end
end

describe AdLinker do
  describe '.link_them' do
    let(:ad_import) do
      AdImport.new('external_reference' => 42, 'status' => 'enabled')
    end
    let(:ad_from_server) do
      AdFromServer.new('reference' => 42, 'status' => 'disabled')
    end

    let(:ads_imports) { [ad_import] }
    let(:ads_from_server) { [ad_from_server] }

    let(:linker) { described_class.new(ads_imports, ads_from_server) }
    let(:links) { linker.link_them }
    let(:link)  { links.last }

    it 'links 2 Ad with same id' do
      expect(link).to link_ads(ad_import, ad_from_server)
    end

    context 'when 2 ads with same id' do
      let(:ad_import1) do
        AdImport.new('external_reference' => 42, 'status' => 'enabled')
      end
      let(:ads_imports) { [ad_import1, ad_import] }

      it 'links the first one' do
        expect(link.ad_import).to eq(ad_import1)
      end
    end

    context 'when object does not exist on AdServer' do
      let(:deleted_ad_id) { 43 }
      let(:ad_import2) do
        AdImport.new('external_reference' => deleted_ad_id,
                     'status' => 'deleted')
      end
      let(:ads_imports) { [ad_import, ad_import2] }

      it 'creates a deleted object' do
        expect(link.ad_from_server.id).to eq(deleted_ad_id)
      end
    end

    context 'when object is not provided in the import' do
      let(:unprovided_ad_id) { 43 }
      let(:ad_from_server2) do
        AdFromServer.new('reference' => unprovided_ad_id,
                         'status' => 'disabled')
      end
      let(:ads_imports) { [ad_from_server, ad_from_server2] }

      it 'does not create a deleted object' do
        expect(links.size).to eq(1)
      end
    end
  end
end
