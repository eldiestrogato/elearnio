module Api
  module V1
    class AuthorsController < ApplicationController

      def index
        @authors = Author.all
        render json: {
                      status: 'SUCCESS',
                      message: 'Loaded Authors with their courses',
                      data: AuthorBlueprint.render_as_json(@authors, view: :all)
                      },
                      status: :ok
      end

      def show
        @author = Author.find(params[:id])
        render json: {
                      status: 'SUCCESS',
                      message: 'Loaded Author with their courses',
                      data: AuthorBlueprint.render_as_json(@author, view: :all)
                      },
                      status: :ok
      end

      def create
        @author = Author.new(author_params)

        if @author.save
          render json: {
                        status: 'SUCCESS',
                        message: 'author is saved',
                        data: AuthorBlueprint.render_as_json(@author, view: :all)
                        },
                        status: :created
        else
          render json: {
                        status: 'Error',
                        message: 'author is not saved',
                        data:@author.errors
                        },
                        status: :unprocessable_entity
        end
      end

      def update
        @author = Author.find(params[:id])

        if @author.update_attributes(author_params)
          render json: {
                        status: 'SUCCESS',
                        message: 'author is updated',
                        data: AuthorBlueprint.render_as_json(@author, view: :all)
                        },
                        status: :ok
        else
          render json: {
                        status: 'Error',
                        message: 'author is not updated',
                        data:@author.errors
                        },
                        status: :unprocessable_entity
        end
      end

      def destroy
        @author = Author.find(params[:id])
        @author.change_author(params[:new_author_id])
        @author.destroy

        render json: {
                      status: 'SUCCESS',
                      message: 'author successfully deleted'                      
                      },
                      status: :no_content
      end

      private
        def author_params
          params.require(:author).permit(:name)
        end
    end
  end
end
