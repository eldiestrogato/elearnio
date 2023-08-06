require 'rails_helper'

describe Api::V1::TalentsController, type: :request do
  before do
    @talent_one = Fabricate(:talent, name: 'Talent One')
    @talent_two = Fabricate(:talent, name: 'Talent Two')
  end

  describe 'Index Acton - GET /api/v1/talents' do
    it 'responds with ok status' do
      get api_v1_talents_path

      expect(response).to have_http_status :ok
    end

    it 'responds with talents' do
      get api_v1_talents_path

      expect(response.body).to match_response_schema('talents', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/talents/:id' do
    it 'responds with ok status' do
      get api_v1_talent_path(@talent_one.id)

      expect(response).to have_http_status :ok
    end

    it 'responds with talent' do
      get api_v1_talent_path(@talent_one.id)

      expect(response.body).to match_response_schema('talent', strict: true)
    end
  end

  describe 'Create Action - POST /api/v1/talents' do
    context 'given valid params' do
      before do
        params = {talent: { name: 'Talent New' }}

        post api_v1_talents_path, params: params
      end
     it 'responds with created status' do
       expect(response).to have_http_status :created
     end

     it 'returns with response body. Is not an author' do
       expect(response.body).to match_response_schema('talent', strict: true)
     end

     it 'returns with response body. Is an author' do
       params = {talent: { name: 'Talent One', is_author: true }}

       post api_v1_talents_path, params: params
       expect(response.body).to match_response_schema('talent', strict: true)
       expect(assigns(:talent).name).to eq(Author.find_by_name(assigns(:talent).name).name)
     end
    end

    context 'given invalid params' do
     it 'responds with unprocessable_entity status' do
       params = {talent: { name: '' }}

       post api_v1_talents_path, params: params

       expect(response).to have_http_status(:unprocessable_entity)
     end

     it 'responds with an error' do
       params = {talent: { name: '' }}

       post api_v1_talents_path, params: params

       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Update Action - POST /api/v1/talents/:id' do
    context 'given valid params' do
      before do
        params = {talent: { name: 'Talent Two' }}
        patch api_v1_talent_path(@talent_one.id), params: params
      end
     it 'responds with ok status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('talent', strict: true)
     end

     it 'returns with response body. Is an author' do
       params = {talent: { name: 'Talent Two', is_author: true }}
       patch api_v1_talent_path(@talent_one.id), params: params

       expect(response.body).to match_response_schema('talent', strict: true)
       expect(assigns(:talent).name).to eq(Author.find_by_name(assigns(:talent).name).name)
     end
    end

    context 'given invalid params' do
     it 'responds with unprocessable_entity status' do
       params = {talent: { name: '' }}
       patch api_v1_talent_path(@talent_one.id), params: params

       expect(response).to have_http_status(:unprocessable_entity)
     end

     it 'responds with an error' do
       params = {talent: { name: '' }}
       patch api_v1_talent_path(@talent_one.id), params: params

       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Destroy Action - DELETE /api/v1/talents/:id' do
    before do
       delete api_v1_talent_path(@talent_one.id)
    end
   it 'responds with no_content status' do
     expect(response).to have_http_status :no_content
   end

   it 'returns with response body' do
     expect(response.body).to be_empty
   end
 end
end
