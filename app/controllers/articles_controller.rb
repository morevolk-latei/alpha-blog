class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    # index method is action used to display all the articles stored in database
    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end


    def new
        @article = Article.new
    end

    # create action handeled by new method i.e on every new form submission
    def create
        # render plain: params[:article].inspect
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:success] = "Article created successfully"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end


    # this method render the @article get from create and display it in view
    def show
    end

    # edit method is used to edit the article by handeling update action
    def edit
    end

    def update
        @article.user = current_user
        if @article.update(article_params)
            flash[:success] = "Article updated successfully"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end


    def destroy
        if @article.destroy
            flash[:danger] = "Article destroyed successfully"
            redirect_to articles_path
        end
    end

    private

        def set_article
            @article = Article.find(params[:id])
        end

    # this article_params method whitelist the title and description and returns to create method
        def article_params
            params.require(:article).permit(:title, :description)
        end

        def require_same_user
            if current_user != @article.user
                flash[:danger] = "you can only edit or delete your own article"
                redirect_to root_path
            end
        end
end