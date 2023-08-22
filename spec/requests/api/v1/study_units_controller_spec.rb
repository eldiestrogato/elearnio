require 'rails_helper'

describe Api::V1::StudyUnitsController, type: :request do
  before do
    talent = Fabricate(:talent)
    course_one = Fabricate(:course)
    course_two = Fabricate(:course)
    @study_unit_1 = Fabricate(:study_unit, talent: talent)
    @study_unit_2 = Fabricate(:study_unit, talent: talent)
    @talent = talent
    @course_one = course_one
  end

  describe 'Index Acton - GET /api/v1/study_units' do
    it 'responds with ok status' do

      get api_v1_study_units_path

      expect(response).to have_http_status :ok
    end

    it 'responds with study_units' do

      get api_v1_study_units_path

      expect(response.body).to match_response_schema('study_units', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/study_units/:id' do
    before do
      get api_v1_talent_study_unit_path(@talent.id, @study_unit_1.id)
    end

    it 'responds with ok status' do
      expect(response).to have_http_status :ok
    end

    it 'responds with study_unit' do
      expect(response.body).to match_response_schema('study_unit', strict: true)
    end
  end

  describe 'Create Action - POST /api/v1/study_units' do
    context 'given valid params' do
      before do
        params = {
                  study_unit:
                    {
                      talent_id: @talent.id,
                      course_id: @course_one.id
                    }
                  }

        post api_v1_talent_study_units_path(@talent.id), params: params
      end

     it 'responds with created status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('study_unit', strict: true)
     end
    end

    context 'given invalid params' do
     it 'responds with code and errors when Course is nil' do
       params = {
                 study_unit:
                   {
                     talent_id: @talent.id,
                     course_id: nil
                   }
                 }


       post api_v1_talent_study_units_path(@talent.id), params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Update Action - POST /api/v1/study_units/:id' do
    context 'given valid params' do
      before do
        course_new = Fabricate(:course)
        params = {
                  study_unit:
                    {
                      course: course_new.id
                    }
                  }

        patch api_v1_talent_study_unit_path(@talent.id, @study_unit_1.id), params: params
      end

     it 'responds with ok status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('study_unit', strict: true)
     end
    end

    context 'given invalid params' do
      it 'responds with code and errors in course' do
        params = {
                  study_unit:
                    {
                      course_id: nil
                    }
                  }

        patch api_v1_talent_study_unit_path(@talent.id, @study_unit_1.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end

     end
  end

  describe 'Destroy Action - DELETE /api/v1/study_units/:id' do
    before do
      delete api_v1_talent_study_unit_path(@talent.id, @study_unit_1.id)
    end

    it 'responds with no_content status' do
     expect(response).to have_http_status :no_content
    end

    it 'returns with response body' do
     expect(response.body).to be_empty
    end
 end
end
