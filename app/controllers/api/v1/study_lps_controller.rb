module Api
  module V1
    class StudyLpsController < ApplicationController
      before_action :set_talent, except: :index
      def index
        @study_lps = StudyLp.all
        render json: { data: StudyLpBlueprint.render_as_json(@study_lps, view: :all) }
      end

      def show
        @study_lp = StudyLp.find(params[:id])
        render json: { data: StudyLpBlueprint.render_as_json(@study_lp, view: :all) }
      end

      def create
        @study_lp = @talent.study_lps.build(study_lp_params)

        if @study_lp.save

          StudyUnitService.new(study_lp_params).get_start_course

          render json: { data: StudyLpBlueprint.render_as_json(@study_lp, view: :all) }
        else
          render json: { data: @study_lp.errors },
                         status: :unprocessable_entity
        end
      end

      def update
        @study_lp = StudyLp.find(params[:id])

        if @study_lp.update_attributes(study_lp_params)
          render json: { data: StudyLpBlueprint.render_as_json(@study_lp, view: :all) }
        else
          render json: { data: @study_lp.errors },
                         status: :unprocessable_entity
        end
      end

      def destroy
        @study_lp = StudyLp.find(params[:id])
        @study_lp.destroy

        render json: {}, status: :no_content
      end

      private

        def set_talent
          @talent = Talent.find params[:talent_id]
        end

        def study_lp_params
          params.require(:study_lp).permit(:talent_id, :learning_path_id)
        end
    end
  end
end
