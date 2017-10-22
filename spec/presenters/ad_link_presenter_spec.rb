describe AdLinkPresenter do
  describe '#to_h' do
    let(:ad_id) { 42 }
    let(:presenter) { described_class.new([ad_link]) }
    let(:ad_link) { AdLink.new(ad_import, ad_from_server) }
    let(:ad_from_server) do
      AdFromServer.new('reference' => ad_id, 'status' => status)
    end
    let(:ad_import) do
      AdImport.new('external_reference' => ad_id, 'status' => status)
    end

    context 'having an enabled ad' do
      let(:status) { 'enabled' }

      it 'present the enabled ad' do
        expect(presenter.to_h['enabled'].first['id']).to eq(ad_id)
      end
    end

    context 'having an disabled ad' do
      let(:status) { 'disabled' }

      it 'present the enabled ad' do
        expect(presenter.to_h['disabled'].first['id']).to eq(ad_id)
      end
    end

    context 'having an deleted ad' do
      let(:status) { 'deleted' }

      it 'present the enabled ad' do
        expect(presenter.to_h['deleted'].first['id']).to eq(ad_id)
      end
    end

    context 'having discrepency between AdImport and AdFromServer' do
      let(:status) { 'enabled' }
      let(:ad_link) { AdLinker.new([ad_import], []).link_them.first }

      it 'present the discrepencie' do
        expect(presenter.to_h['discrepencies'].first['id']).to eq(ad_id)
      end
    end
  end
end
