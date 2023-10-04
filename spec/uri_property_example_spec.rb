require 'spec_helper'
require 'net/http'

describe 'URI property in HTTP response' do
  context 'without a WebMock stub' do
    it 'exits' do
      uri = URI('https://github.com')
      response = Net::HTTP.get_response(uri)

      expect(response.code).to eq '200'
      expect(response.uri).to eq uri
    end
  end
end
