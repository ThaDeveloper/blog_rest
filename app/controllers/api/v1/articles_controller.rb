module Api
  module V1
    class ArticlesController < ApplicationController
      def create
        article = Article.new(article_params)
        if article.save
          render json: {status: "SUCCESS", message: "Article created successfully", data: article}, status: :created
        else
          render json: {status: "ERROR", message: "Article was not saved", data: article.errors}, status: :unprocessable_entity
        end
      end
      def index
          articles = Article.order("created_at DESC")
          render json: {status: "SUCCESS", message: "Articles loaded successfully", data: articles}, status: :ok
      end
      def show
        article = Article.find(params[:id])
        render json: {status: "SUCCESS", message: "Article loaded successfully", data: article}, status: :ok
        rescue ActiveRecord::RecordNotFound
          render json: {status: "ERROR", message: "Article does not exist"}, status: :not_found
      end
      def update
        article = Article.find(params[:id])
        if article.update_attributes(article_params)
          render json: {status: "SUCCESS", message: "Article updated successfully", data: article}, status: :ok
        else
          render json: {status: "ERROR", message: "Article was not updated", data: article.errors}, status: :unprocessable_entity
        end
      end
      def destroy
        article = Article.find(params[:id])
        article.destroy
        render json: {status: "SUCCESS", message: "Article deleted successfully"}, status: :ok
      end

      private
      def article_params
        params.require(:article).permit(:title, :body)
      end
    end
  end
end

