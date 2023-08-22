class StudyUnitService
  attr_reader :parameters

  def initialize(parameters)
    @parameters = parameters
  end

  # After getting New Learning Path - check if Talent needs first course of Learning Path or he already has it
  def get_start_course
    if has_first_course?
    # If the first course of Learning Path is already exists - give the next course, but only if the first is completed
      if need_for_course?(parameters[:learning_path_id])
        all_courses_of_lp = fetch_courses_of_lp(parameters[:learning_path_id])
        if unstarted_courses(all_courses_of_lp).present?
          get_course(@future_courses)
        else
          puts "All courses in current Learning Path are done"
        end
      else
        puts "Don't need for course"
      end
    else
    # Give the first course
      new_study_unit = talent_courses.build(course_id: @course)
      new_study_unit.save
    end
  end

  # give the next course, but only if other is completed
  # (On each Learning Path if the Course is belongs to several "LP-s")
  def next_course
    talent.study_learning_paths.each do |talent_slp|
      if need_for_course?(talent_slp.learning_path_id)
        all_courses_of_lp = fetch_courses_of_lp(talent_slp.learning_path_id)
        if unstarted_courses(all_courses_of_lp).present?
          get_course(@future_courses)
        else
          puts "All courses in current Learning Path are done"
        end
      else
        puts "Don't need for course"
      end
    end
  end

  private

  # Checking if Talent needs the first course of Learning Path
  def has_first_course?
    talent_courses_ids = talent.study_units.pluck(:course_id)
    @course = fetch_courses_of_lp(parameters[:learning_path_id]).first.id
    talent_courses_ids.include?(@course)
  end

  # check if Talent needs next course of Learning Path or he has uncompleted on it
  def need_for_course?(lp_id)
    talent_courses_of_lp(lp_id).where(is_course_completed: false).empty?
  end

  def unstarted_courses(all_courses_of_lp)
    @future_courses = all_courses_of_lp.where.not(id: talent_courses.pluck(:course_id))
  end

  # Give next course according to sequence in Learning Path
  def get_course(future_courses) # get or build
      new_study_unit = talent_courses.build(course_id: future_courses.first.id)
      new_study_unit.save
  end

  # Get collection of Courses in current Learning Path ordered by course_number
  def fetch_courses_of_lp(lp_id)
    LearningPath.find(lp_id).courses.order(:course_number)
  end

  def talent_courses_of_lp(lp_id)
    talent_courses.where(course_id: fetch_courses_of_lp(lp_id).pluck(:id))
  end

  # Set current talent
  def talent
    Talent.find(parameters[:talent_id])
  end

  # Get all courses of current Talent
  def talent_courses
    talent.study_units
  end

end
