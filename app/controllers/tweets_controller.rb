class TweetsController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :set_tweet, only: %i(show edit update destroy)

  def index
    @tweets = Tweet.page(params[:page]).per(6).latest_updated
  end

  def show
    @user = User.find(@tweet.user_id)
    @comment = Comment.new
    @comments = @tweet.comments.latest_updated
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    Tweet.create(tweet_params)
    redirect_to root_path
  end

  def update
    @tweet.update(tweet_params)
    redirect_to root_path
  end

  def destroy
    @tweet.destroy
    redirect_to root_path
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:title, :description, :image).merge(user_id: current_user.id)
    end

end
