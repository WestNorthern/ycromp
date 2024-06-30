class BlogPostsController < ApplicationController
    before_action :set_blog_post, except: [:index, :new, :create]
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
    end

    def new
        @blog_post = BlogPost.new
    end

    def edit
    end

    def update
        if @blog_post.update(blog_post_params)
            redirect_to @blog_post
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def create
        @blog_post = BlogPost.new(blog_post_params)
        if @blog_post.save
            redirect_to @blog_post
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end

    def destroy
        @blog_post = BlogPost.find(params[:id])
        @blog_post.destroy
        redirect_to root_path
    end

    private

    def set_blog_post
        user_signed_in? ? @blog_post = BlogPost.find(params[:id]) : @blog_post = BlogPost.published.find(params[:id])
    end

    def blog_post_params
        params.require(:blog_post).permit(:title, :body, :published_at)
    end

end
