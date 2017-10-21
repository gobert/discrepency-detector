describe AdLink do
  describe '#sync?' do
    let(:ad_id) { 42 }
    let(:ad_import) { AdImport.new('id' => ad_id, 'status' => status_import) }
    let(:ad_from_server) do
      AdFromServer.new('reference' => ad_id, 'status' => status_from_server)
    end
    let(:ad_linker) { described_class.new(ad_import, ad_from_server) }

    describe 'being synced' do
      describe 'being enabled' do
        let(:status_import) { 'active' }
        let(:status_from_server) { 'enabled' }

        it 'is synced' do
          expect(ad_linker.sync?).to be true
        end
      end

      describe 'being disabled' do
        let(:status_import) { 'paused' }
        let(:status_from_server) { 'disabled' }

        it 'is synced' do
          expect(ad_linker.sync?).to be true
        end
      end

      describe 'being deleted' do
        let(:status_import) { 'deleted' }
        let(:status_from_server) { 'deleted' }

        it 'is synced' do
          expect(ad_linker.sync?).to be true
        end
      end
    end

    describe 'not being synced' do
      let(:status_import) { 'active' }
      let(:status_from_server) { 'disabled' }

      it 'is synced' do
        expect(ad_linker.sync?).to be false
      end
    end
  end
end
