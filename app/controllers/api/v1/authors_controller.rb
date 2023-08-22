module Api
  module V1
    class AuthorsController < ApplicationController

      def index
        authors = Author.all
        render json: { data: AuthorBlueprint.render_as_json(authors, view: :all) }
      end

      def show
        author = Author.find(params[:id])
        render json: { data: AuthorBlueprint.render_as_json(author, view: :all) }
      end

      def create
        author = Author.new(author_params)

        if author.save
          render json: { data: AuthorBlueprint.render_as_json(author, view: :all) }
        else
          render json: { data: author.errors },
                         status: :unprocessable_entity
        end
      end

      def update
        author = Author.find(params[:id])

        if author.update_attributes(author_params)
          render json: { data: AuthorBlueprint.render_as_json(author, view: :all) }
        else
          render json: { data: author.errors },
                         status: :unprocessable_entity
        end
      end

      def destroy
        author = Author.find(params[:id])

        if Author.find(params[:new_author_id])
          author.change_author(params[:new_author_id])
          author.destroy
          render json: {}, status: :no_content
        else
          render json: { data: author.errors },
                         status: :unprocessable_entity
        end
      end

      private
        def author_params
          params.require(:author).permit(:name)
        end
    end
  end
end
