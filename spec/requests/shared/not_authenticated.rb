RSpec.shared_examples 'not authenticated' do
  let(:headers) { {Authorization: nil} }
  subject { response }
  it { is_expected.to have_http_status(:unauthorized) }
end 
