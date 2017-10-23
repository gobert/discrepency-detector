RSpec.describe AdsController do
  describe 'POST #status' do
    before do
      url = 'http://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'
      stub_request(:get, url).to_return(body: '{ "ads": [ { "reference": "1",
        "status": "enabled", "description": "Description for campaign 11" },
        { "reference": "2", "status": "disabled", "description":
        "Description for campaign 12" }, { "reference": "3", "status":
        "enabled", "description": "Description for campaign 13" } ] }')
    end

    let(:ad_from_import) do
      {
        'external_reference' => 1,
        'status' => 'active',
        'description' => 'foo',
        'id' => 42,
        'job_id' => 2029
      }
    end

    it 'returns a success response' do
      post '/ads/status', params: { 'ads' => [ad_from_import] }
      expect(response).to be_success
    end

    context 'not having ads' do
      it 'fails with 400' do
        expect do
          post '/ads/status', params: {}
        end.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
