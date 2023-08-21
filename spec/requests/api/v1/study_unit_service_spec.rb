require 'rails_helper'

describe StudyUnitService, type: :request do
  before do
    talent = Fabricate(:talent)
    @talent = talent
    course_one = Fabricate(:course)
    course_two = Fabricate(:course)
    course_three = Fabricate(:course)
    @course_three = course_three
    lp_one = Fabricate(:learning_path) do
      title 'LP Test'
      learning_path_courses_attributes [
                              {
                                course_id: course_one.id,
                                course_number: 1
                              },
                              {
                                course_id: course_two.id,
                                course_number: 2
                              },
                              {
                                course_id: course_three.id,
                                course_number: 3
                              }
                            ]
      end
    Fabricate(:study_learning_path) do
        learning_path lp_one
        talent talent
      end
    @study_unit_1 = Fabricate(:study_unit, talent: talent, course: course_one, is_course_completed: "false")
    Fabricate(:study_unit, talent: talent, course: course_two, is_course_completed: "true")
  end

  describe 'next_course method' do
    context 'given valid params' do
      it 'changes count of study units on talent when other courses is completed' do
       params = {
                  talent_id: @study_unit_1.talent.id,
                  course_id: @study_unit_1.course.id,
                  is_course_completed: "true"
                }
       @study_unit_1.update_attributes(params)
       expect { StudyUnitService.new(params).next_course }.to change { @talent.study_units.count }.by(1)
      end

      it 'doesnt add next course to talent when at least one course isnt completed in current Study Learning Path' do
       params = {
                  talent_id: @study_unit_1.talent.id,
                  course_id: @study_unit_1.course.id
                }
       @study_unit_1.update_attributes(params)
       expect { StudyUnitService.new(params).next_course }.not_to change { @talent.study_units.count }
      end
      it 'doesnt add next course to talent when all courses is completed in current Study Learning Path' do
       Fabricate(:study_unit, talent: @talent, course: @course_three, is_course_completed: "true")
       params = {
                  talent_id: @study_unit_1.talent.id,
                  course_id: @study_unit_1.course.id,
                  is_course_completed: "true"
                }
       @study_unit_1.update_attributes(params)
       expect { StudyUnitService.new(params).next_course }.not_to change { @talent.study_units.count }
      end
    end
  end
end
