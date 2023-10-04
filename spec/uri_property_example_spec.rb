# frozen_string_literal: true

require 'net/http'
require 'spec_helper'
require 'webmock/rspec'

describe 'URI property in HTTP response' do
  context 'without a WebMock stub' do
    before do
      WebMock.disable!
    end

    it 'exits' do
      uri = URI('https://github.com')
      response = Net::HTTP.get_response(uri)

      expect(response.code).to eq '200'
      expect(response.uri).to eq uri
    end
  end

  context 'with a WebMock stub' do
    before do
      WebMock.enable!
    end

    it 'does not exit' do
      uri = URI('https://github.com')
      stubbed_body = 'stubbed body'
      stub_request(:get, uri).to_return(status: 200, body: stubbed_body)

      response = Net::HTTP.get_response(uri)

      expect(response.code).to eq '200'
      expect(response.body).to eq stubbed_body
      # what I'd expect:
      #
      # expect(response.uri).to eq uri
      #
      # what I get:
      expect(response.uri).to be_nil
    end
  end
end
