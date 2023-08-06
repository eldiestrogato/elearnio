require 'rails_helper'

describe Api::V1::LearningPathsController, type: :request do
  before do
    course = Fabricate(:course)
    lp_one = Fabricate(:learning_path) do
      title 'LP One'
      lp_courses_attributes [course_id: course.id, course_number: 2]
    end
    lp_two = Fabricate(:learning_path) do
      title 'LP Two'
      lp_courses_attributes [course_id: course.id, course_number: 1]
    end
    @lp_test = Fabricate(:learning_path) do
      title 'LP TEST'
      lp_courses_attributes [course_id: course.id, course_number: 1]
    end
    @course = course
  end

  describe 'Index Acton - GET /api/v1/learning_paths' do
    it 'responds with ok status' do
      get api_v1_learning_paths_path

      expect(response).to have_http_status :ok
    end

    it 'responds with learning_paths' do
      get api_v1_learning_paths_path

      expect(response.body).to match_response_schema('learning_paths', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/learning_paths/:id' do
    before do
      get api_v1_learning_path_path(@lp_test.id)
    end

    it 'responds with ok status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with learning_path' do
      expect(response.body).to match_response_schema('learning_path', strict: true)
    end
  end

  describe 'Create Action - POST /api/v1/learning_paths' do
    context 'given valid params' do
      before do
        course_one = Fabricate(:course)
        course_two = Fabricate(:course)
        params = {
                  learning_path:
                    {
                      title: 'LearningPath One',
                      lp_courses_attributes:
                      [
                        {
                          course_id: course_one.id,
                          course_number: 1
                        },
                        {
                          course_id: course_two.id,
                          course_number: 2
                        }
                      ]
                    }
                  }

        post api_v1_learning_paths_path, params: params
      end

     it 'responds with created status' do
       expect(response).to have_http_status :created
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('learning_path', strict: true)
     end
    end

    context 'given invalid params' do
     it 'responds with code and errors in title' do
       course_one = Fabricate(:course)
       course_two = Fabricate(:course)
       params = {
                 learning_path:
                   {
                     title: '',
                     lp_courses_attributes:
                     [
                       {
                         course_id: course_one.id,
                         course_number: 1
                       },
                       {
                         course_id: course_two.id,
                         course_number: 2
                       }
                     ]
                   }
                 }

       post api_v1_learning_paths_path, params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end

     it 'responds with code and errors in presence of course' do
       params = {
                 learning_path:
                   {
                     title: 'Some Title',
                     lp_courses_attributes: []
                   }
                 }

       post api_v1_learning_paths_path, params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Update Action - POST /api/v1/learning_paths/:id' do
    context 'given valid params' do
      before do
        course_current = Fabricate(:course)
        course_new = Fabricate(:course)
        learning_path = Fabricate(:learning_path) do
          title 'LP Current title'
          lp_courses_attributes [course_id: course_current.id, course_number: 2]
        end
        params = {
                  learning_path:
                    {
                      title: 'LearningPath New title',
                      lp_courses_attributes:
                      [
                        course_id: course_new.id,
                        course_number: 5
                      ]
                    }
                  }

        patch api_v1_learning_path_path(learning_path.id), params: params
      end

     it 'responds with ok status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('learning_path', strict: true)
     end
    end

    context 'given invalid params' do
      it 'responds with code and errors in title' do
        course_current = Fabricate(:course)
        learning_path = Fabricate(:learning_path) do
          title 'LP Current title'
          lp_courses_attributes [course_id: course_current.id, course_number: 2]
        end
        params = {
                  learning_path:
                    {
                      title: '',
                      lp_courses_attributes:
                      [
                        course_id: course_current.id,
                        course_number: 2
                      ]
                    }
                  }

        patch api_v1_learning_path_path(learning_path.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end

      it 'responds with code and errors in presence of course' do
        params = {
                  learning_path:
                    {
                      title: 'Some Title',
                      lp_courses_attributes: [
                        course_id: nil,
                        course_number: 1
                      ]
                    }
                  }

        patch api_v1_learning_path_path(@lp_test.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end
     end
  end

  describe 'Destroy Action - DELETE /api/v1/learning_paths/:id' do
    before do
      delete api_v1_learning_path_path(@lp_test.id)
    end

    it 'responds with no_content status' do
     expect(response).to have_http_status :no_content
    end

    it 'returns with response body' do
     expect(response.body).to be_empty
    end
 end
end
