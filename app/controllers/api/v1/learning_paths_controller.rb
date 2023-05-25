module Api
  module V1
    class LearningPathsController < ApplicationController

      def index
        @learning_paths = LearningPath.all
        render json: {
                      status: 'SUCCESS',
                      message: 'Loaded Learning Paths with its courses',
                      data: LearningPathBlueprint.render_as_json(@learning_paths, view: :all)
                      },
                      status: :ok
      end

      def show
        @learning_path = LearningPath.find(params[:id])
        render json: {
                      status: 'SUCCESS',
                      message: 'Loaded Learning Path with its courses',
                      data: LearningPathBlueprint.render_as_json(@learning_path, view: :all)
                      },
                      status: :ok
      end

      def create
        @learning_path = LearningPath.new(learning_path_params)

        if @learning_path.save
          render json: {status: 'SUCCESS', message: 'learning_path is saved', data:@learning_path}, status: :ok
        else
          render json: {status: 'Error', message: 'learning_path is not saved', data:@learning_path.errors}, status: :unprocessable_entity
        end
      end

      def update
        @learning_path = LearningPath.find(params[:id])

        if @learning_path.update_attributes(learning_path_params)
          render json: {status: 'SUCCESS', message: 'learning_path is updated', data:@learning_path}, status: :ok
        else
          render json: {status: 'Error', message: 'learning_path is not updated', data:@learning_path.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @learning_path = LearningPath.find(params[:id])
        @learning_path.destroy

        render json: {status: 'SUCCESS', message: 'learning_path successfully deleted', data:@learning_path}, status: :ok
      end

      private

      def learning_path_params
        params.require(:learning_path).permit(:title, lp_courses_attributes: [:course_id, :course_number])
      end
    end
  end
end
