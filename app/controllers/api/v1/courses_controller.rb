module Api
  module V1
    class CoursesController < ApplicationController

      def index
        @courses = Course.all
        render json: {status: 'SUCCESS', message: 'Loaded courses', data:@courses}, status: :ok
      end

      def show
        @course = Course.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded courses', data:@course}, status: :ok
      end

      def create
        @course = Course.new(course_params)

        if @course.save
          render json: {status: 'SUCCESS', message: 'course is saved', data:@course}, status: :ok
        else
          render json: {status: 'Error', message: 'course is not saved', data:@course.errors}, status: :unprocessable_entity
        end
      end

      def update
        @course = Course.find(params[:id])

        if @course.update_attributes(course_params)
          render json: {status: 'SUCCESS', message: 'course is updated', data:@course}, status: :ok
        else
          render json: {status: 'Error', message: 'course is not updated', data:@course.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @course = Course.find(params[:id])
        @course.destroy

        render json: {status: 'SUCCESS', message: 'course successfully deleted', data:@course}, status: :ok
      end

      private
        def course_params
          params.require(:course).permit(:title, :body, :author_id, learning_path_ids:[])
        end
    end
  end
end
