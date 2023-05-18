module Api
  module V1
    class StudyLpsController < ApplicationController
      before_action :set_talent
      def index
        @study_lps = @talent.study_lps
        render json: {status: 'SUCCESS', message: 'Loaded study_lps', data:@study_lps}, status: :ok
      end

      def show
        @study_lp = StudyLp.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded study_lps', data:@study_lp}, status: :ok
      end

      def create
        @study_lp = @talent.study_lps.build(study_lp_params)

        if @study_lp.save

          StudyUnitService.new(study_lp_params).call

          render json: {status: 'SUCCESS', message: 'study_lp is saved', data:@study_lp}, status: :ok
        else
          render json: {status: 'Error', message: 'study_lp is not saved', data:@study_lp.errors}, status: :unprocessable_entity
        end
      end

      def update
        @study_lp = StudyLp.find(params[:id])

        if @study_lp.update_attributes(study_lp_params)
          render json: {status: 'SUCCESS', message: 'study_lp is updated', data:@study_lp}, status: :ok
        else
          render json: {status: 'Error', message: 'study_lp is not updated', data:@study_lp.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @study_lp = StudyLp.find(params[:id])
        @study_lp.destroy

        render json: {status: 'SUCCESS', message: 'study_lp successfully deleted', data:@study_lp}, status: :ok
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
