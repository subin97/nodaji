class PostsController < ApplicationController
  def new
  end

  def create
    @new_post = Post.new
    @new_post.user_id = current_user.id
    @new_post.title = params[:input_title]
    @new_post.content = params[:input_content]
    @new_post.start_time = params[:start_time]
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
   
    @settime = @post.start_time # 설정 시간
    @posttime = @post.created_at # 게시물 생성 시간
    @timenow = Time.now # 현재시간
    
    # 초단위
    # 게시물생성시간 + (설정시간 * 60 * 60) => 끝나는 시간
    @time = (@posttime.to_i + (@settime * 3600)) - @timenow.to_i 
  
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
  
  def ex_things
    @posts = Post.all
  end
  
  def expired
    @post = Post.find(params[:id])
    @post.expire = params[:expire]
    @post.save
    
    
  end
end
