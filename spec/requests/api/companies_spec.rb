require 'rails_helper'

RSpec.describe Api::CompaniesController, type: :controller do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, admin: true) }
  let(:valid_attributes) { { name: 'Company C', location: 'Location C' } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Company' do
        sign_in admin_user
        post :create, params: { company: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'without authentication' do
      it 'returns unauthorized' do
        post :create, params: { company: valid_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'without admin privileges' do
      it 'returns unauthorized' do
        sign_in user
        post :create, params: { company: valid_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
