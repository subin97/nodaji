class PostsController < ApplicationController
  def new
  end

  def create
    @new_post = Post.new
    @new_post.user_id = current_user.id
    @new_post.title = params[:input_title]
    @new_post.content = params[:input_content]
    #@new_post.start_time = params[:start_time]
    @new_post.start_price = params[:st_price]
    @new_post.bn_price = params[:input_bn_price]
    @new_post.up_price = params[:input_up_price]
    @new_post.image1 = params[:image1]
    @new_post.image2 = params[:image2]
    @new_post.image3 = params[:image3]
    @new_post.tags = params[:input_tag]
    @new_post.save
    redirect_to "/posts/show/#{@new_post.id}"
  end

  def index
    @posts = Post.all
  end

  def show
    @user_id = current_user.email.split('@')[0]
    @post = Post.find(params[:id])
    @utc = Post.find(@post.id).created_at
    @timenow = Time.now
    @time = @timenow.to_i - @utc.to_i
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @update_post = Post.find(params[:id])
    @new_post.content = params[:input_content]
    # @new_post.start_time = params[:start_time]
    @new_post.start_price = params[:st_price]
    @new_post.bn_price = params[:input_bn_price]
    @new_post.up_price = params[:input_up_price]
    @new_post.save
    redirect_to "/posts/show/#{@update_post.id}"
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to "/posts/index"
  end
  
  def after_login
    @users = User.all
    @posts = Post.all
    @timenow = Time.now
  end
  
  def mine
    @users = User.all
    @posts = Post.all
    @timenow = Time.now
  end
  
  def tag
    @users = User.all
    @tag = params[:tag]
    @posts = Post.all
    @timenow = Time.now
  end
  
end
