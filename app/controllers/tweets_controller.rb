class TweetsController < ApplicationController

    def index
        @user = user
        if current_user?(@user)
            @tweets = Tweet.where(user_id: @user.followings.ids).or(Tweet.where(user_id: @user.id)).order("updated_at DESC")
        else
            @tweets = @user.tweets.all.order("updated_at DESC")
        end
    end

    def new
        @user = user
        @tweet = user.tweets.new
    end
    
    def create
        tweet = user.tweets.new(tweet_params)
        if tweet.save
          redirect_to user_tweets_path, flash: {success: 'ツイートしました'}
        else
          render :new, flash: {error: 'ツイートできませんでした'}
        end
    end
    
    def edit
        @tweet = Tweet.find_by(id: params[:id])
        @user = @tweet.user
    end

    def update
        @tweet = tweet
        if @tweet.update(tweet_params)
            redirect_to user_tweets_path(@tweet.user), flash: {success: 'ツイートを更新しました'}
        else
            redirect_to edit_tweet_path(@tweet, current_user), flash: {error: 'ツイートの更新に失敗しました'}
        end
    end

    def destroy
        tweet = Tweet.find_by(id: params[:id])
        u = tweet.user
        if tweet.destroy
            redirect_to user_tweets_path(u), flash: {success: 'ツイートを削除しました'}
        else
            redirect_to user_tweets_path(u), flash: {error: 'ツイートを削除できませんでした'}
        end
    end

    private
        def tweet_params
            params.require(:tweet).permit(:user, :body, :picture, :remove_picture)
        end

        def user
            @user ||= User.find(params[:user_id])
        end

        def tweet
            @tweet ||= Tweet.find(params[:id])
        end
end
