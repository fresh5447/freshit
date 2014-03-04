class TopicsController < ApplicationController
 
  def index
     # @topics = Topic.all
     @topics = Topic.paginate(page: params[:page], per_page: 10)
  end
  

  def new
      @topic = Topic.new
      authorize! :create, @topic, message: "You need to be an admin to do that."
  end

  def show
      @topic = Topic.find(params[:id])
      #@posts = @topic.posts
      @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
  end

  def edit
      @topic = Topic.find(params[:id])
      authorize! :update, @topic, message: "You need to be an admin to do that."
  end

  def create
      @topic = Topic.new(params[:id])
      authorize! :create, @topic, message: "You need to be an admin to do that."
        if @topic.save
          redirect_to @topic, notice: "Topic was saved successfully"
        else
          flash[:error] = "Error creating topic. Please try again."
          render :new
        end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to own the topic to update it"
    if @topic.update_attributes(params[:topic])
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error saving topic. Please try again."
      render :edit
    end
  end

end