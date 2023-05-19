module Api
  module V1
    class StudyUnitsController < ApplicationController
      before_action :set_talent
      def index
        @study_units = @talent.study_units
        render json: {status: 'SUCCESS', message: 'Loaded study_units', data:@study_units}, status: :ok
      end

      def show
        @study_unit = StudyUnit.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded study_units', data:@study_unit}, status: :ok
      end

      def create
        @study_unit = @talent.study_units.build(study_unit_params)

        if @study_unit.save
          render json: {status: 'SUCCESS', message: 'study_unit is saved', data:@study_unit}, status: :ok
        else
          render json: {status: 'Error', message: 'study_unit is not saved', data:@study_unit.errors}, status: :unprocessable_entity
        end
      end

      def update
        @study_unit = StudyUnit.find(params[:id])

        if @study_unit.update_attributes(study_unit_params)
          if study_unit_params[:is_course_completed] == 'true'
            StudyUnitService.new(study_unit_params).next_course
            render json: {status: 'SUCCESS', message: 'study_unit is updated and get next course', data:@study_unit}, status: :ok
          else
          render json: {status: 'SUCCESS', message: 'study_unit is updated', data:@study_unit}, status: :ok
          end
        else
          render json: {status: 'Error', message: 'study_unit is not updated', data:@study_unit.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @study_unit = StudyUnit.find(params[:id])
        @study_unit.destroy

        render json: {status: 'SUCCESS', message: 'study_unit successfully deleted', data:@study_unit}, status: :ok
      end

      private

        def set_talent
          @talent = Talent.find params[:talent_id]
        end

        def study_unit_params
          params.require(:study_unit).permit(:talent_id, :course_id, :is_course_completed)
        end
    end
  end
end
