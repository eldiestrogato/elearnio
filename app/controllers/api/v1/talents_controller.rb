module Api
  module V1
    class TalentsController < ApplicationController

      def index
        @talents = Talent.all
        render json: { data: TalentBlueprint.render_as_json(@talents, view: :all) }
      end

      def show
        @talent = Talent.find(params[:id])
        render json: { data: TalentBlueprint.render_as_json(@talent, view: :all) }
      end

      def create
        @talent = Talent.new(talent_params)

        if @talent.save
          if @talent.is_author?
            Author.find_or_create_by(name: @talent.name)
            render json: { data: TalentBlueprint.render_as_json(@talent, view: :all) }
          else
            render json: { data: TalentBlueprint.render_as_json(@talent, view: :all) }
          end
        else
          render json: { data: @talent.errors },
                         status: :unprocessable_entity
        end
      end

      def update
        @talent = Talent.find(params[:id])

        if @talent.update_attributes(talent_params)
          if @talent.is_author?
            Author.find_or_create_by(name: @talent.name)
            render json: { data: TalentBlueprint.render_as_json(@talent, view: :all) }
          else
            render json: { data: TalentBlueprint.render_as_json(@talent, view: :all) }
          end
        else
          render json: { data: @talent.errors },
                         status: :unprocessable_entity
        end
      end

      def destroy
        @talent = Talent.find(params[:id])
        @talent.destroy

        render json: {}, status: :no_content
      end

      private
        def talent_params
          params.require(:talent).permit(:name, :is_author)
        end
    end
  end
end
