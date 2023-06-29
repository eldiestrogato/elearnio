require 'rails_helper'

describe Api::V1::StudyLpsController, type: :request do
  describe 'Index Acton - GET /api/v1/study_lps' do
    it 'responds with ok status' do
      get api_v1_study_lps_path

      expect(response).to have_http_status :ok
    end

    it 'responds with study_lps' do
      talent = Fabricate(:talent)
      course = Fabricate(:course)
      lp = Fabricate(:learning_path) do
        title 'LP One'
        lp_courses_attributes [course_id: course.id, course_number: 1]
      end

      study_lp = Fabricate(:study_lp) do
        learning_path_id lp.id
        talent talent.id
      end

      get api_v1_study_lps_path

      expect(response.body).to match_response_schema('study_lps', strict: true)
    end
  end

  describe 'Show Action - GET /api/v1/study_lps/:id' do
    before do
      course = Fabricate(:course)
      study_lp = Fabricate(:study_lp) do
        title 'LP One'
        lp_courses_attributes [course_id: course.id, course_number: 2]
      end

      get api_v1_talent_study_lp_path(study_lp.id)
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
        talent = Fabricate(:talent, name: 'Talent One')
        course = Fabricate(:course)
        learning_path = Fabricate(:learning_path) do
          title 'LP One'
          lp_courses_attributes [course_id: course.id, course_number: 1]
        end
        params = {
                  study_lp:
                    {
                      talent_id: talent.id,
                      learning_path_id: learning_path.id
                    }
                  }

        post api_v1_talent_study_lps_path, params: params
      end

     it 'responds with created status' do
       expect(response).to have_http_status :created
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('study_lp', strict: true)
     end
    end

    context 'given invalid params' do
     it 'responds with code and errors in title' do
       course_one = Fabricate(:course)
       course_two = Fabricate(:course)
       params = {
                 study_lp:
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

       post api_v1_talent_study_lp_path, params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end

     it 'responds with code and errors in presence of course' do
       course = Fabricate(:course)
       params = {
                 study_lp:
                   {
                     title: 'Some Title',
                     lp_courses_attributes: []
                   }
                 }

       post api_v1_talent_study_lp_path, params: params

       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to match_response_schema('errors', strict: true)
     end
    end
  end

  describe 'Update Action - POST /api/v1/study_lps/:id' do
    context 'given valid params' do
      before do
        course_current = Fabricate(:course)
        course_new = Fabricate(:course)
        study_lp = Fabricate(:study_lp) do
          title 'LP Current title'
          lp_courses_attributes [course_id: course_current.id, course_number: 2]
        end
        params = {
                  study_lp:
                    {
                      title: 'StudyLp New title',
                      lp_courses_attributes:
                      [
                        course_id: course_new.id,
                        course_number: 5
                      ]
                    }
                  }

        patch api_v1_talent_study_lp_path(study_lp.id), params: params
      end

     it 'responds with ok status' do
       expect(response).to have_http_status :ok
     end

     it 'returns with response body' do
       expect(response.body).to match_response_schema('study_lp', strict: true)
     end
    end

    context 'given invalid params' do
      it 'responds with code and errors in title' do
        course_current = Fabricate(:course)
        study_lp = Fabricate(:study_lp) do
          title 'LP Current title'
          lp_courses_attributes [course_id: course_current.id, course_number: 2]
        end
        params = {
                  study_lp:
                    {
                      title: '',
                      lp_courses_attributes:
                      [
                        course_id: course_current.id,
                        course_number: 2
                      ]
                    }
                  }

        patch api_v1_talent_study_lp_path(study_lp.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end

      it 'responds with code and errors in presence of course' do
        course = Fabricate(:course)
        study_lp = Fabricate(:study_lp) do
          title 'LP Current title'
          lp_courses_attributes [course_id: course.id, course_number: 2]
        end
        params = {
                  study_lp:
                    {
                      title: 'Some Title',
                      lp_courses_attributes: [
                        course_id: nil,
                        course_number: 1
                      ]
                    }
                  }

        patch api_v1_talent_study_lp_path(study_lp.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_response_schema('errors', strict: true)
      end
     end
  end

  describe 'Destroy Action - DELETE /api/v1/study_lps/:id' do
    before do
      course = Fabricate(:course)
      study_lp = Fabricate(:study_lp) do
        title 'LP One'
        lp_courses_attributes [course_id: course.id, course_number: 2]
      end

      delete api_v1_talent_study_lp_path(study_lp.id)
    end

    it 'responds with no_content status' do
     expect(response).to have_http_status :no_content
    end

    it 'returns with response body' do
     expect(response.body).to be_empty
    end
 end
end
