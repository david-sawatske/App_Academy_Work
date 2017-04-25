class PostsController < ApplicationController
  before_filter :logged_in?

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user.id

    if @post.save
      redirect_to sub_url(post.link)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to sub_url(post.link)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to subs_url
  end

  def post_params
    params.require(:post).permit(:title, :content, sub_id: [])
  end
end
