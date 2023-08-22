module Api
  module V1
    class StudyUnitsController < ApplicationController
      before_action :set_talent, except: :index
      def index
        study_units = StudyUnit.all
        render json: { data: StudyUnitBlueprint.render_as_json(study_units, view: :all) }
      end

      def show
        study_unit = StudyUnit.find(params[:id])
        render json: { data: StudyUnitBlueprint.render_as_json(study_unit, view: :all) }
      end

      def create
        study_unit = @talent.study_units.build(study_unit_params)

        if study_unit.save

          render json: { data: StudyUnitBlueprint.render_as_json(study_unit, view: :all) }
        else
          render json: { data: study_unit.errors },
                         status: :unprocessable_entity
        end
      end

      def update
        study_unit = StudyUnit.find(params[:id])

        if study_unit.update_attributes(study_unit_params)
          if study_unit_params[:is_course_completed] == 'true'

            StudyUnitService.new(study_unit_params).next_course

            render json: { data: StudyUnitBlueprint.render_as_json(study_unit, view: :all) }

          else
            render json: { data: StudyUnitBlueprint.render_as_json(study_unit, view: :all) }
          end
        else
          render json: { data: study_unit.errors },
                         status: :unprocessable_entity
        end
      end

      def destroy
        study_unit = StudyUnit.find(params[:id])
        study_unit.destroy

        render json: {}, status: :no_content
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
