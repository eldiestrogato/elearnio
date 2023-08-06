require 'rails_helper'

describe Api::V1::AuthorsController, type: :request do
  before do
    @author_one = Fabricate(:author, name: 'Author 1')
    @author_two = Fabricate(:author, name: 'Author 2')
  end
  describe 'Index Acton - GET /api/v1/authors' do
    before do
      get api_v1_authors_path
    end
    it 'responds with ok status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with authors' do
      expect(response.body).to match_response_schema('authors', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/authors/:id' do
    before do
      get api_v1_author_path(@author_one.id)
    end
    it 'responds with ok status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with author' do
      expect(response.body).to match_response_schema('author', strict: true)
    end
  end

  describe 'Create Action - POST /api/v1/authors' do
    context 'given valid params' do
      before do
        params = {author: { name: 'Author One' }}
        post api_v1_authors_path, params: params
      end
     it 'responds with created status' do
       expect(response).to have_http_status :created
     end

     it 'returns with response body' do
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

  describe 'Update Action - POST /api/v1/authors/:id' do
    context 'given valid params' do
      before do
        params = {author: { name: 'Author Two' }}
        patch api_v1_author_path(@author_one.id), params: params

      end
     it 'responds with ok status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('author', strict: true)
     end
    end

    context 'given invalid params' do
      before do
        params = {author: { name: '' }}
        patch api_v1_author_path(@author_one.id), params: params
      end
     it 'responds with unprocessable_entity status' do
       expect(response).to have_http_status(:unprocessable_entity)
     end

     it 'responds with an error' do
       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Destroy Action - DELETE /api/v1/authors/:id' do
    before do
      delete api_v1_author_path(@author_one.id)
    end
   it 'responds with no_content status' do
     expect(response).to have_http_status :no_content
   end

   it 'returns with response body when author has no courses' do
     expect(response.body).to be_empty
   end

    it 'returns with response body when author has some courses' do
      author = Fabricate(:author, name: 'Author for destroying')
      courses = Fabricate.times(2, :course, author: author)
      params = { new_author_id: @author_two.id }
      
      delete api_v1_author_path(author.id), params: params

      expect{courses.each{|c| c.reload}}.to change { courses.first.author_id }.to(@author_two.id)
                                        .and change { courses.last.author_id }.to(@author_two.id)
      expect(response.body).to be_empty

    end
 end
end
