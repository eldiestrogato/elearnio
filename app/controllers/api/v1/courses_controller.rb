module Api
  module V1
    class CoursesController < ApplicationController

      def index
        courses = Course.all
        render json: { data: CourseBlueprint.render_as_json(courses, view: :all) }
      end

      def show
        course = Course.find(params[:id])
        render json: { data: CourseBlueprint.render_as_json(course, view: :all) }
      end

      def create
        course = Course.new(course_params)

        if course.save
          render json: { data: CourseBlueprint.render_as_json(course, view: :all) }
        else
          render json: { data: course.errors },
                         status: :unprocessable_entity
        end
      end

      def update
        course = Course.find(params[:id])

        if course.update_attributes(course_params)
          render json: { data: CourseBlueprint.render_as_json(course, view: :all) }
        else
          render json: { data: course.errors },
                         status: :unprocessable_entity
        end
      end

      def destroy
        course = Course.find(params[:id])
        course.destroy

        render json: {}, status: :no_content
      end

      private
        def course_params
          params.require(:course).permit(:title, :body, :author_id, learning_path_ids:[])
        end
    end
  end
end
