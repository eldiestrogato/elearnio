require 'rails_helper'

describe Api::V1::StudyLearningPathsController, type: :request do
  before do
    course_one = Fabricate(:course)
    course_two = Fabricate(:course)
    lp_one = Fabricate(:learning_path) do
      title 'LP One'
      learning_path_courses_attributes [course_id: course_one.id, course_number: 1]
    end
    lp_two = Fabricate(:learning_path) do
      title 'LP Two'
      learning_path_courses_attributes [course_id: course_two.id, course_number: 1]
    end
    talent = Fabricate(:talent)
    @study_lp_1 = Fabricate(:study_learning_path) do
      learning_path lp_one
      talent talent
    end
    @talent = talent
    @lp_one = lp_one
    @lp_two = lp_two
    @course_one = course_one
  end

  describe 'Index Acton - GET /api/v1/study_learning_paths' do
    it 'responds with ok status' do

      get api_v1_study_learning_paths_path

      expect(response).to have_http_status :ok
    end

    it 'responds with study_learning_paths' do

      get api_v1_study_learning_paths_path

      expect(response.body).to match_response_schema('study_learning_paths', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/study_learning_paths/:id' do
    before do
      get api_v1_talent_study_learning_path_path(@talent.id, @study_lp_1.id)
    end

    it 'responds with ok status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with study_learning_path' do
      expect(response.body).to match_response_schema('study_learning_path', strict: true)
    end
  end

  describe 'Create Action - POST /api/v1/study_learning_paths' do
    context 'given valid params' do
      before do
        params = {
                  study_learning_path:
                    {
                      talent_id: @talent.id,
                      learning_path_id: @lp_two.id
                    }
                  }

        post api_v1_talent_study_learning_paths_path(@talent.id), params: params
      end

     it 'responds with created status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('study_learning_path', strict: true)
     end

     it 'return error when talent already has this learning path' do
       params = {
                 study_learning_path:
                   {
                     talent_id: @talent.id,
                     learning_path_id: @lp_one.id
                   }
                 }

       post api_v1_talent_study_learning_paths_path(@talent.id), params: params
       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end

    context 'given invalid params' do
     it 'responds with code and errors when Learning_path is nil' do
       params = {
                 study_learning_path:
                   {
                     talent_id: @talent.id,
                     learning_path_id: nil
                   }
                 }


       post api_v1_talent_study_learning_paths_path(@talent.id), params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Update Action - POST /api/v1/study_learning_paths/:id' do
    context 'given valid params' do
      before do
        params = {
                  study_learning_path:
                    {
                      learning_path_id: @lp_two.id
                    }
                  }

        patch api_v1_talent_study_learning_path_path(@talent.id, @study_lp_1.id), params: params
      end

     it 'responds with ok status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('study_learning_path', strict: true)
     end
    end

    context 'given invalid params' do
      it 'responds with code and errors in learning_path' do
        params = {
                  study_learning_path:
                    {
                      learning_path_id: nil
                    }
                  }

        patch api_v1_talent_study_learning_path_path(@talent.id, @study_lp_1.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end

     end
  end

  describe 'Destroy Action - DELETE /api/v1/study_learning_paths/:id' do
    before do
      delete api_v1_talent_study_learning_path_path(@talent.id, @study_lp_1.id)
    end

    it 'responds with no_content status' do
     expect(response).to have_http_status :no_content
    end

    it 'returns with response body' do
     expect(response.body).to be_empty
    end
 end
end
