require 'rails_helper'

describe Api::V1::CoursesController, type: :request do
  describe 'Index Acton - GET /api/v1/courses' do
    it 'responds with ok status' do
      get api_v1_courses_path

      expect(response).to have_http_status :ok
    end

    it 'responds with courses' do
      Fabricate.times(4, :course)

      get api_v1_courses_path

      expect(response.body).to match_response_schema('courses', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/courses/:id' do
    before do
      course = Fabricate(:course)
      get api_v1_course_path(course.id)
    end

    it 'responds with ok status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with course' do
      expect(response.body).to match_response_schema('course', strict: true)
    end
  end

  describe 'Create Action - POST /api/v1/courses' do
    context 'given valid params' do
      before do
        author = Fabricate(:author)
        params = { course: { title: 'Course One', body: 'Some body is here', author_id: author.id } }

        post api_v1_courses_path, params: params
      end

     it 'responds with created status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('course', strict: true)
     end
    end

    context 'given valid params with learning paths' do
      it 'returns adding to associated Learning Paths' do
        course = Fabricate(:course)
        lp_one = Fabricate(:learning_path, title: 'LP One', lp_courses_attributes: [course_id: course.id, course_number: 1])
        lp_two = Fabricate(:learning_path, title: 'LP Two', lp_courses_attributes: [course_id: course.id, course_number: 1])
        author = Fabricate(:author)
        params = {
                  course: {
                            title: 'Course One',
                            body: 'Some body is here',
                            author_id: author.id,
                            learning_path_ids: [lp_one.id, lp_two.id]
                          }
                 }

        post api_v1_courses_path, params: params

        expect(assigns(:course).learning_paths.first.id).to eq(lp_one.id)
        expect(assigns(:course).learning_paths.last.id).to eq(lp_two.id)
      end
    end

    context 'given invalid params' do
     it 'responds with code and errors in title' do
       author = Fabricate(:author)
       params = { course: { title: '', body: 'Some body is here', author_id: author.id } }

       post api_v1_courses_path, params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end

     it 'responds with code and errors in body' do
       author = Fabricate(:author)
       params = { course: { title: 'Course One', body: '', author_id: author.id } }

       post api_v1_courses_path, params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end

     it 'responds with code and errors in presence of author' do
       author = Fabricate(:author)
       params = { course: { title: 'Course One', body: 'Some body is here' } }

       post api_v1_courses_path, params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Update Action - POST /api/v1/courses/:id' do
    context 'given valid params' do
      before do
        author_one = Fabricate(:author)
        author_two = Fabricate(:author)
        course = Fabricate(:course, author: author_one)
        params = { course: { title: 'Course Two', body: 'Another body is here', author_id: author_two.id } }

        patch api_v1_course_path(course.id), params: params
      end

     it 'responds with ok status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('course', strict: true)
     end
    end

    context 'given invalid params' do
      it 'responds with code and errors in title' do
        course = Fabricate(:course)
        params = { course: { title: '' } }

        patch api_v1_course_path(course.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end

      it 'responds with code and errors in body' do
        course = Fabricate(:course)
        params = { course: { body: '' } }

        patch api_v1_course_path(course.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end

      it 'responds with code and errors in presence of author' do
        course = Fabricate(:course)
        params = { course: { author_id: nil } }

        patch api_v1_course_path(course.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end
     end
  end

  describe 'Destroy Action - DELETE /api/v1/courses/:id' do
    before do
      course = Fabricate(:course)

      delete api_v1_course_path(course.id)
    end

    it 'responds with no_content status' do
     expect(response).to have_http_status :no_content
    end

    it 'returns with response body' do
     expect(response.body).to be_empty
    end
 end
end
