describe AdServer do
  describe '#statuses' do
    let(:status) { described_class.new.statuses }

    context 'when server responds 200' do
      before do
        url = 'http://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'
        stub_request(:get, url).to_return(body: '{"foo": "bar"}')
      end

      it 'returns a Hash' do
        expect(status).to be_a(Hash)
      end
    end

    context 'when server does not responds 200' do
      before do
        url = 'http://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'
        stub_request(:get, url).to_return(status: 500)
      end

      it 'raises an error' do
        expect { status }.to raise_error(AdServer::Error)
      end
    end
  end
end
