require "spec_helper"
require "rack/test"
require_relative '../app'

describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }

  context 'get /' do
    it 'testing / path' do
      response = get('/')
      expect(response.status).to eq 200
      expect(response.body).to include('<form method="POST" action="/users">')
      expect(response.body).to include('<input type="text" name="name">')
    end
  end

  context 'post/users' do
    it 'testing' do
      response = post('/users', name: 'Tauqeer')
      expect(response.status).to eq 200
      response = get('/users')
      expect(response.body).to include('Tauqeer')
    end
  end

  context 'get/message_form' do
    it 'testing peeps' do
        response = get('/message_form')
        expect(response.status).to eq 200
        expect(response.body).to include('<form method="POST" action="/peeps">')
    end
  end

  context 'post/message_form' do
    it 'testing peeps' do
        response = post('/message_form', subject: 'Exercise', content: 'Do more', time: '12:04', user_id: '1')
        expect(response.status).to eq 200
        response = get('/peeps')
        expect(response.body).to include('Exercise')
    end
  end

  context 'all peeps' do
    it 'testing peeps' do
        response = get('/peeps')
        expect(response.status).to eq 200
        expect(response.body).to include('Exercise')
    end
  end

  


end