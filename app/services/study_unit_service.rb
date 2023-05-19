class StudyUnitService
  attr_reader :parameters

  def initialize(parameters)
    @parameters = parameters
  end

  # After getting New Learning Path - check if Talent needs first course of Learning Path or he already has it
  def get_start_course
    if has_first_course?
    # If the first course of Learning Path is already exists - give the next course, but only if the first is completed
      check_course(parameters[:learning_path_id])
    else
    # Give the first course
      new_study_unit = talent_courses.build(course_id: @course)
      new_study_unit.save
    end
  end

  # give the next course, but only if other is completed
  # (On each Learning Path if the Course is belongs to several "LP-s")
  def next_course
    talent.study_lps.each do |talent_lp|
      check_course(talent_lp.learning_path_id)
    end
  end

  private

  # check if Talent needs next course of Learning Path or he has uncompleted on it
  def check_course(lp_id)
    lp_courses = fetch_lp_courses(lp_id)
    talent_courses_of_lp = talent_courses.where(course_id: lp_courses.pluck(:id))
    if talent_courses_of_lp.where(is_course_completed: false).empty?
      get_course(lp_courses)
    else
      puts "Don't need new course"
    end
  end

  # Give next course according to sequence in Learning Path
  def get_course(lp_courses)
    lp_courses_left = lp_courses.where.not(id: talent_courses.pluck(:course_id))
    if lp_courses_left.empty?
      puts "All courses are completed in this LP"
    else
      new_study_unit = talent_courses.build(course_id: lp_courses_left.first.id)
      new_study_unit.save
    end
  end

  # Get collection of Courses in current Learning Path ordered by course_number
  def fetch_lp_courses(lp_id)
    LearningPath.find(lp_id).courses.order(:course_number)
  end

  # Set current talent
  def talent
    Talent.find(parameters[:talent_id])
  end

  # Get all courses of current Talent
  def talent_courses
    talent.study_units
  end

  # Checking if Talent needs the first course of Learning Path
  def has_first_course?
    talent_courses_ids = talent.study_units.pluck(:course_id)
    @course = fetch_lp_courses(parameters[:learning_path_id]).first.id
    talent_courses_ids.include?(@course)
  end

end
