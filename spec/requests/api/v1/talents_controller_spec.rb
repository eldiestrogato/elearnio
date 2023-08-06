require 'rails_helper'

describe Api::V1::TalentsController, type: :request do
  describe 'Index Acton - GET /api/v1/talents' do
    it 'responds with ok status' do
      get api_v1_talents_path

      expect(response).to have_http_status :ok
    end

    it 'responds with talents' do
      Fabricate(:talent, name: 'Talent One')
      Fabricate(:talent, name: 'Talent Two')

      get api_v1_talents_path

      expect(response.body).to match_response_schema('talents', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/talents/:id' do
    it 'responds with ok status' do
      talent = Fabricate(:talent, name: 'Talent One')
      get api_v1_talent_path(talent.id)

      expect(response).to have_http_status :ok
    end

    it 'responds with talent' do
      talent = Fabricate(:talent, name: 'Talent One')
      get api_v1_talent_path(talent.id)

      expect(response.body).to match_response_schema('talent', strict: true)
    end
  end

  describe 'Create Action - POST /api/v1/talents' do
    context 'given valid params' do
     it 'responds with created status' do
       params = {talent: { name: 'Talent One' }}

       post api_v1_talents_path, params: params

       expect(response).to have_http_status :created
     end

     it 'returns with response body. Is not an author' do
       params = {talent: { name: 'Talent One' }}

       post api_v1_talents_path, params: params

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
     it 'responds with ok status' do
       talent = Fabricate(:talent, name: 'Talent One')
       params = {talent: { name: 'Talent Two' }}
       patch api_v1_talent_path(talent.id), params: params

       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       talent = Fabricate(:talent, name: 'Talent One')
       params = {talent: { name: 'Talent Two' }}
       patch api_v1_talent_path(talent.id), params: params

       expect(response.body).to match_response_schema('talent', strict: true)
     end

     it 'returns with response body. Is an author' do
       talent = Fabricate(:talent, name: 'Talent One')
       params = {talent: { name: 'Talent Two', is_author: true }}
       patch api_v1_talent_path(talent.id), params: params

       expect(response.body).to match_response_schema('talent', strict: true)
       expect(assigns(:talent).name).to eq(Author.find_by_name(assigns(:talent).name).name)
     end
    end

    context 'given invalid params' do
     it 'responds with unprocessable_entity status' do
       talent = Fabricate(:talent, name: 'Talent One')
       params = {talent: { name: '' }}
       patch api_v1_talent_path(talent.id), params: params

       expect(response).to have_http_status(:unprocessable_entity)
     end

     it 'responds with an error' do
       talent = Fabricate(:talent, name: 'Talent One')
       params = {talent: { name: '' }}
       patch api_v1_talent_path(talent.id), params: params

       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Destroy Action - DELETE /api/v1/talents/:id' do
   it 'responds with no_content status' do
     talent = Fabricate(:talent, name: 'Talent One')

     delete api_v1_talent_path(talent.id)

     expect(response).to have_http_status :no_content
   end

   it 'returns with response body' do
     talent = Fabricate(:talent, name: 'Talent One')

     delete api_v1_talent_path(talent.id)

     expect(response.body).to be_empty
   end
 end
end
