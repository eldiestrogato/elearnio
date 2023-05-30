require 'rails_helper'

describe Api::V1::AuthorsController, type: :request do
  describe 'Index Acton - GET /api/v1/authors' do
    it 'responds with ok status' do
      get api_v1_authors_path

      expect(response).to have_http_status :ok
    end

    it 'responds with authors' do
      Fabricate(:author, name: 'Author One')
      Fabricate(:author, name: 'Author Two')

      get api_v1_authors_path

      expect(response.body).to match_response_schema('authors', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/authors/:id' do
    it 'responds with ok status' do
      author = Fabricate(:author, name: 'Author One')
      get api_v1_author_path(author.id)

      expect(response).to have_http_status :ok
    end

    it 'responds with author' do
      author = Fabricate(:author, name: 'Author One')
      get api_v1_author_path(author.id)

      expect(response.body).to match_response_schema('author', strict: true)
    end
  end

  describe 'Create Action - POST /api/v1/authors' do
    context 'given valid params' do
     it 'responds with created status' do
       params = {author: { name: 'Author One' }}

       post api_v1_authors_path, params: params

       expect(response).to have_http_status :created
     end

     it 'returns with response body' do
       params = {author: { name: 'Author One' }}

       post api_v1_authors_path, params: params

       expect(response.body).to match_response_schema('author', strict: true)
     end
    end

    context 'given invalid params' do
     it 'responds with unprocessable_entity status' do
       params = {author: { name: '' }}

       post api_v1_authors_path, params: params

       expect(response).to have_http_status(:unprocessable_entity)
     end

     it 'responds with an error' do
       params = {author: { name: '' }}

       post api_v1_authors_path, params: params

       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Update Action - POST /api/v1/authors' do
    context 'given valid params' do
     it 'responds with ok status' do
       author = Fabricate(:author, name: 'Author One')
       params = {author: { name: 'Author Two' }}
       patch api_v1_author_path(author.id), params: params

       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       author = Fabricate(:author, name: 'Author One')
       params = {author: { name: 'Author Two' }}
       patch api_v1_author_path(author.id), params: params

       expect(response.body).to match_response_schema('author', strict: true)
     end
    end

    context 'given invalid params' do
     it 'responds with unprocessable_entity status' do
       author = Fabricate(:author, name: 'Author One')
       params = {author: { name: '' }}
       patch api_v1_author_path(author.id), params: params

       expect(response).to have_http_status(:unprocessable_entity)
     end

     it 'responds with an error' do
       author = Fabricate(:author, name: 'Author One')
       params = {author: { name: '' }}
       patch api_v1_author_path(author.id), params: params

       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Destroy Action - DELETE /api/v1/authors/:id' do
   it 'responds with no_content status' do
     author = Fabricate(:author, name: 'Author One')

     delete api_v1_author_path(author.id)

     expect(response).to have_http_status :no_content
   end

   it 'returns with response body' do
     author = Fabricate(:author, name: 'Author One')

     delete api_v1_author_path(author.id)

     expect(response.body).to be_empty
   end
 end
end
