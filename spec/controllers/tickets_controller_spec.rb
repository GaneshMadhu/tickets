require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  before(:all) do
    create_list(:ticket, 5)
  end

  describe '#index' do
    it 'gets the list of tickets' do
      get :index
      expect(response).to render_template('index')
      expect(assigns(:tickets).count).to eq(5)
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'creates a new ticket' do
      post :create, params: {ticket: {created_by: "Test Create", description: "Test Ticket", severity: 1}}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to '/tickets'
    end
  end

  describe '#update' do
    it 'updates a ticket' do
      patch :update, params: {id: 5, ticket: {created_by: "Test Update"}}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to '/tickets'
    end
  end
end
