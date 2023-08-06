require 'rails_helper'

describe Api::V1::StudyLpsController, type: :request do
  before do
    course_one = Fabricate(:course)
    course_two = Fabricate(:course)
    lp_one = Fabricate(:learning_path) do
      title 'LP One'
      lp_courses_attributes [course_id: course_one.id, course_number: 1]
    end
    lp_two = Fabricate(:learning_path) do
      title 'LP Two'
      lp_courses_attributes [course_id: course_two.id, course_number: 1]
    end
    talent = Fabricate(:talent)
    @study_lp_1 = Fabricate(:study_lp) do
      learning_path_id lp_one.id
      talent_id talent.id
    end
    @study_lp_2 = Fabricate(:study_lp) do
      learning_path_id lp_two.id
      talent_id talent.id
    end
    @talent = talent
    @lp_one = lp_one
    @lp_two = lp_two
    @course_one = course_one
  end

  describe 'Index Acton - GET /api/v1/study_lps' do
    it 'responds with ok status' do

      get api_v1_study_lps_path

      expect(response).to have_http_status :ok
    end

    it 'responds with study_lps' do

      get api_v1_study_lps_path

      expect(response.body).to match_response_schema('study_lps', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/study_lps/:id' do
    before do
      get api_v1_talent_study_lp_path(@talent.id, @study_lp_1.id)
    end

    it 'responds with ok status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with study_lp' do
      expect(response.body).to match_response_schema('study_lp', strict: true)
    end
  end

  describe 'Create Action - POST /api/v1/study_lps' do
    context 'given valid params' do
      before do
        params = {
                  study_lp:
                    {
                      talent_id: @talent.id,
                      learning_path_id: @lp_one.id
                    }
                  }

        post api_v1_talent_study_lps_path(@talent.id), params: params
      end

     it 'responds with created status' do
       expect(response).to have_http_status :created
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('study_lp', strict: true)
     end
    end

    context 'given invalid params' do
     it 'responds with code and errors when Learning_path is nil' do
       params = {
                 study_lp:
                   {
                     talent_id: @talent.id,
                     learning_path_id: nil
                   }
                 }


       post api_v1_talent_study_lps_path(@talent.id), params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Update Action - POST /api/v1/study_lps/:id' do
    context 'given valid params' do
      before do
        talent_new = Fabricate(:talent)
        params = {
                  study_lp:
                    {
                      talent_id: talent_new.id,
                      learning_path_id: @lp_two.id
                    }
                  }

        patch api_v1_talent_study_lp_path(@talent.id, @study_lp_1.id), params: params
      end

     it 'responds with ok status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('study_lp', strict: true)
     end
    end

    context 'given invalid params' do
      it 'responds with code and errors in learning_path' do
        params = {
                  study_lp:
                    {
                      learning_path_id: nil
                    }
                  }

        patch api_v1_talent_study_lp_path(@talent.id, @study_lp_1.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end

     end
  end

  describe 'Destroy Action - DELETE /api/v1/study_lps/:id' do
    before do
      delete api_v1_talent_study_lp_path(@talent.id, @study_lp_1.id)
    end

    it 'responds with no_content status' do
     expect(response).to have_http_status :no_content
    end

    it 'returns with response body' do
     expect(response.body).to be_empty
    end
 end
end
