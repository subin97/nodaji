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
    @new_post.like = 0
    @new_post.view = 0
    @new_post.save
    redirect_to "/posts/show/#{@new_post.id}"
  end

  def index
    @posts = Post.all
  end

  def show
    @user_id = current_user.email.split('@')[0]
    
    @post = Post.find(params[:id])
    
    @post.view += 1
    @post.save
   
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
    @update_post.title = params[:input_title]
    @update_post.content = params[:input_content]
    #@update_post.start_time = params[:start_time] 수정해도 시간은 처음에 올린시간으로?
    @update_post.start_price = params[:st_price]
    @update_post.bn_price = params[:input_bn_price]
    @update_post.up_price = params[:input_up_price]
    @update_post.image1 = params[:image1]
    @update_post.image2 = params[:image2]
    @update_post.image3 = params[:image3]
    @update_post.tags = params[:input_tag]
    @update_post.save
    redirect_to "/posts/show/#{@update_post.id}"
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to "/after_login"
  end
  
  def after_login
    @users = User.all
    @posts = Post.all
    @timenow = Time.now
    
    @posts.each do |post|
      @ll = Post.find(post.id)
      if @ll.created_at.to_i + ( @ll.start_time * 3600) - Time.now.to_i < 0
          @ll.expire = true
      end
      @ll.save
    end
    
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
    
    render :show => false
    
  end
  
  def like
    @post = Post.find(params[:id])
    @post.like += 1
    @post.save
    redirect_to "/after_login"
  end
  
  # 입찰하면 History 모델에 저장되는 액션
  def history
    @post = Post.find(params[:post_id])
    @histroy = History.new
    @history.user_id = params[:user_id]
    @history.post_id = params[:post_id]
    @history.push_time = params[:push_time]
    @history.save
    
  end
  #메일건 관련 액션
      def newmail
        
    end
    
    def sending
        @sender = params[:sender]
        @title = params[:mail_title]
        @content = params[:input_mail]
        
        mg_client = Mailgun::Client.new("key-686b135cdf57d19b496b852ea37f15a3")

        message_params =  {
                   from: @sender,
                   to:   'dku@likelion.org',
                   subject: @title,
                   text:    @content
                  }

        result = mg_client.send_message('sandbox33045e1150864ac090ffbd9d607ac3ea.mailgun.org', message_params).to_h!

        message_id = result['id']
        message = result['message']
        
        redirect_to '/newmail', notice: '전송완료!'
        
    end
  
end
