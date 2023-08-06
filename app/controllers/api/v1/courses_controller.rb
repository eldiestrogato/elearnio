module Api
  module V1
    class CoursesController < ApplicationController

      def index
        @courses = Course.all
        render json: {
                      status: 'SUCCESS',
                      message: 'Loaded Courses',
                      data: CourseBlueprint.render_as_json(@courses, view: :all)
                      },
                      status: :ok
      end

      def show
        @course = Course.find(params[:id])
        render json: {
                      status: 'SUCCESS',
                      message: 'Loaded Course',
                      data: CourseBlueprint.render_as_json(@course, view: :all)
                      },
                      status: :ok
      end

      def create
        @course = Course.new(course_params)

        if @course.save
          render json: {
                        status: 'SUCCESS',
                        message: 'course is saved',
                        data: CourseBlueprint.render_as_json(@course, view: :all)
                        },
                        status: :created
        else
          render json: {
                        status: 'Error',
                        message: 'course is not saved',
                        data:@course.errors
                        },
                        status: :unprocessable_entity
        end
      end

      def update
        @course = Course.find(params[:id])

        if @course.update_attributes(course_params)
          render json: {
                        status: 'SUCCESS',
                        message: 'course is updated',
                        data: CourseBlueprint.render_as_json(@course, view: :all)
                        },
                        status: :ok
        else
          render json: {
                        status: 'Error',
                        message: 'course is not updated',
                        data:@course.errors
                        },
                        status: :unprocessable_entity
        end
      end

      def destroy
        @course = Course.find(params[:id])
        @course.destroy

        render json: {
                      status: 'SUCCESS',
                      message: 'course successfully deleted'
                      },
                      status: :no_content
      end

      private
        def course_params
          params.require(:course).permit(:title, :body, :author_id, learning_path_ids:[])
        end
    end
  end
end
