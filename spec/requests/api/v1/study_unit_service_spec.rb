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
    @lp_two = Fabricate(:learning_path) do
      title 'LP Test'
      learning_path_courses_attributes [
                              {
                                course_id: course_one.id,
                                course_number: 2
                              },
                              {
                                course_id: course_two.id,
                                course_number: 1
                              }
                            ]
      end
    @study_learning_path = Fabricate(:study_learning_path) do
        learning_path lp_one
        talent talent
      end
    @study_unit_1 = Fabricate(:study_unit, talent: talent, course: course_one, is_course_completed: "false")
    Fabricate(:study_unit, talent: talent, course: course_two, is_course_completed: "true")
  end

  describe 'get_start_course method' do
    context 'given valid params' do
      it 'give start course of current Learning Path to talent' do
        new_talent = Fabricate(:talent)
        params = {
                      talent_id: new_talent.id,
                      learning_path_id: @lp_two.id
                  }
        StudyUnitService.new(params).get_start_course
       expect(new_talent.study_units.last.course_id).to eq(@lp_two.courses.order(:course_number).first.id)
      end

      it 'If the first course of Learning Path is already exists on talent but is not completed - do nothing' do
       params = {
                  talent_id: @study_unit_1.talent.id,
                  learning_path_id: @study_learning_path.learning_path.id
                }
       expect { StudyUnitService.new(params).get_start_course }.not_to change { @talent.study_units.count }
      end

    end
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
