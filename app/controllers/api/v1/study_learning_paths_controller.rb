module Api
  module V1
    class StudyLearningPathsController < ApplicationController
      before_action :set_talent, except: :index
      def index
        study_learning_paths = StudyLearningPath.all
        render json: { data: StudyLearningPathBlueprint.render_as_json(study_learning_paths, view: :all) }
      end

      def show
        study_learning_path = StudyLearningPath.find(params[:id])
        render json: { data: StudyLearningPathBlueprint.render_as_json(study_learning_path, view: :all) }
      end

      def create
        study_learning_path = @talent.study_learning_paths.build(study_learning_path_params)

        if study_learning_path.save

        StudyUnitService.new(study_learning_path_params).get_start_course

          render json: { data: StudyLearningPathBlueprint.render_as_json(study_learning_path, view: :all) }
        else
          render json: { data: study_learning_path.errors },
                         status: :unprocessable_entity
        end
      end

      def update
        study_learning_path = StudyLearningPath.find(params[:id])

        if study_learning_path.update_attributes(study_learning_path_params)
          render json: { data: StudyLearningPathBlueprint.render_as_json(study_learning_path, view: :all) }
        else
          render json: { data: study_learning_path.errors },
                         status: :unprocessable_entity
        end
      end

      def destroy
        study_learning_path = StudyLearningPath.find(params[:id])
        study_learning_path.destroy

        render json: {}, status: :no_content
      end

      private

        def set_talent
          @talent = Talent.find params[:talent_id]
        end

        def study_learning_path_params
          params.require(:study_learning_path).permit(:talent_id, :learning_path_id)
        end
    end
  end
end
