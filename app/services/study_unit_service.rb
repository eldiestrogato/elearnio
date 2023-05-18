class StudyUnitService
  attr_reader :study_unit_params

  def initialize(study_unit_params)
    @study_unit_params = study_unit_params
  end

  def call
    if has_first_course?
      give_course
    else
      new_study_unit = talent.study_units.build(course_id: @course)
      new_study_unit.save
    end
  end

  private

  def give_course

    lp_courses_ids = LearningPath.find(study_unit_params[:learning_path_id]).courses.order(:course_number).pluck(:id)
    talent_courses_ids = talent.study_units.pluck(:course_id)


    new_study_unit = talent.study_units.build(course_id: @course)
    new_study_unit.save
  end

  def next_course

  end

  def talent
    Talent.find(study_unit_params[:talent_id])
  end

  def has_first_course?
    lp_courses = LearningPath.find(study_unit_params[:learning_path_id]).courses.order(:course_number)
    talent_courses_ids = talent.study_units.pluck(:course_id)
    @course = lp_courses.first.id
    talent_courses_ids.include?(@course)
  end

end
