shared_examples_for 'an ad' do
  describe '.new' do
    let(:ad) { described_class.new(params) }

    context 'having status active' do
      let(:params) { Hash['status' => 'active'] }

      it 'created an object with status enabled' do
        expect(ad.status).to eq(:enabled)
      end
    end

    context 'having status paused' do
      let(:params) { Hash['status' => 'paused'] }

      it 'raises an error' do
        expect(ad.status).to eq(:disabled)
      end
    end

    context 'having status deleted' do
      let(:params) { Hash['status' => 'deleted'] }

      it 'raises an error' do
        expect(ad.status).to eq(:deleted)
      end
    end

    context 'having status enabled' do
      let(:params) { Hash['status' => 'enabled'] }

      it 'raises an error' do
        expect(ad.status).to eq(:enabled)
      end
    end

    context 'having status disabled' do
      let(:params) { Hash['status' => 'disabled'] }

      it 'raises an error' do
        expect(ad.status).to eq(:disabled)
      end
    end

    context 'having other statuses' do
      let(:params) { Hash['status' => 'foo'] }

      it 'raises an error' do
        expect { ad } .to raise_error(RuntimeError)
      end
    end
  end
end

describe AdFromServer do
  it_behaves_like 'an ad'
end

describe AdImport do
  it_behaves_like 'an ad'
end
