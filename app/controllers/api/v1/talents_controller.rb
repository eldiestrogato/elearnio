module Api
  module V1
    class TalentsController < ApplicationController

      def index
        @talents = Talent.all
        render json: {
                      status: 'SUCCESS',
                      message: 'Loaded Talents',
                      data: TalentBlueprint.render_as_json(@talents, view: :all)
                      },
                      status: :ok
      end

      def show
        @talent = Talent.find(params[:id])
        render json: {
                      status: 'SUCCESS',
                      message: 'Loaded Talent',
                      data: TalentBlueprint.render_as_json(@talent, view: :all)
                      },
                      status: :ok
      end

      def create
        @talent = Talent.new(talent_params)

        if @talent.save
          if @talent.is_author?
            Author.create(name: @talent.name)
            render json: {
                          status: 'SUCCESS',
                          message: 'talent is saved and became an author',
                          data: TalentBlueprint.render_as_json(@talent, view: :all)
                          },
                          status: :created
          else
            render json: {
                          status: 'SUCCESS',
                          message: 'talent is saved',
                          data: TalentBlueprint.render_as_json(@talent, view: :all)
                          },
                          status: :created
          end
        else
          render json: {
                        status: 'Error',
                        message: 'talent is not saved',
                        data:@talent.errors
                        },
                        status: :unprocessable_entity
        end
      end

      def update
        @talent = Talent.find(params[:id])

        if @talent.update_attributes(talent_params)
          if @talent.is_author?
            Author.create(name: @talent.name)
            render json: {
                          status: 'SUCCESS',
                          message: 'talent is updated and became an author',
                          data: TalentBlueprint.render_as_json(@talent, view: :all)
                          },
                          status: :ok
          else
            render json: {
                          status: 'SUCCESS',
                          message: 'talent is updated',
                          data: TalentBlueprint.render_as_json(@talent, view: :all)
                          },
                          status: :ok
          end
        else
          render json: {
                        status: 'Error',
                        message: 'talent is not updated',
                        data:@talent.errors
                        },
                        status: :unprocessable_entity
        end
      end

      def destroy
        @talent = Talent.find(params[:id])
        @talent.destroy

        render json: {
                      status: 'SUCCESS',
                      message: 'talent successfully deleted'
                      },
                      status: :no_content
      end

      private
        def talent_params
          params.require(:talent).permit(:name, :is_author)
        end
    end
  end
end
