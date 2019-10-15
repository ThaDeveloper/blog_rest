require 'test_helper'

module Api
    module V1
        class ArticlesControllerTest < ActionDispatch::IntegrationTest
            test 'creates article' do
                article = articles(:one)
                article_params = {
                    'title': article.title,
                    'body': article.body
                }
                post api_v1_articles_path, params: {article: article_params}
                article = JSON.parse(@response.body)['data']

                assert_response :success
                assert article['title'] == article_params[:title]
            end
            test 'Gets article' do
                get api_v1_articles_path(article_id: 1)
                assert_response :success
            end
        end
    end

end
