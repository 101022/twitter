class TweetsController < ApplicationController

    def index
        @user = user
        if current_user?(@user)
            followings = @user.followings.pluck(:id)
            followings.push(@user.id)
            @tweet = Tweet.where(user_id: followings).order("updated_at DESC")
        else
            @tweet = @user.tweets.all.order("updated_at DESC")
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
          render 'new', flash: {error: 'ツイートできませんでした'}
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
            render 'edit', flash: {error: 'ツイートの更新に失敗しました'}
        end
    end

    def destroy
        tweet = Tweet.find_by(id: params[:id])
        if tweet.destroy
            redirect_to user_tweets_path(tweet.user), flash: {success: 'ツイートを削除しました'}
        else
            render 'index', flash: {error: 'ツイートを削除できませんでした'}
        end
    end

    private
        def tweet_params
            params.require(:tweet).permit(:user, :tweet, :picture, :remove_picture)
        end

        def user
            @user ||= User.find(params[:user_id])
        end

        def tweet
            @tweet ||= Tweet.find(params[:id])
        end

end
