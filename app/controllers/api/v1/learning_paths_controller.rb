module Api
  module V1
    class LearningPathsController < ApplicationController

      def index
        @learning_paths = LearningPath.all
        render json: { data: LearningPathBlueprint.render_as_json(@learning_paths, view: :all) }
      end

      def show
        @learning_path = LearningPath.find(params[:id])
        render json: { data: LearningPathBlueprint.render_as_json(@learning_path, view: :all) }
      end

      def create
        @learning_path = LearningPath.new(learning_path_params)

        if @learning_path.save
          render json: { data: LearningPathBlueprint.render_as_json(@learning_path, view: :all) }
        else
          render json: { data: @learning_path.errors },
                         status: :unprocessable_entity
        end
      end

      def update
        @learning_path = LearningPath.find(params[:id])

        if @learning_path.update_attributes(learning_path_params)
          render json: { data: LearningPathBlueprint.render_as_json(@learning_path, view: :all) }
        else
          render json: { data: @learning_path.errors },
                         status: :unprocessable_entity
        end
      end

      def destroy
        @learning_path = LearningPath.find(params[:id])
        @learning_path.destroy

        render json: {}, status: :no_content
      end

      private

      def learning_path_params
        params.require(:learning_path).permit(:title, lp_courses_attributes: [:course_id, :course_number])
      end
    end
  end
end
