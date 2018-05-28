class CommentsController < ApplicationController
  def new
    @tweet = tweet
    @user = @tweet.user
    @comment = Comment.new
  end

  def create
    comment = tweet.comments.new(comment_params)
    if comment.save
      redirect_to user_tweets_path(current_user), flash: {success: '返信しました'}
    else
      render 'new', flash: {error: '返信できませんでした'}
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    @tweet = @comment.tweet
    @user = @tweet.user
  end

  def update
    if comment.update(comment_params)
        redirect_to user_tweets_path(current_user), flash: {success: 'コメントを更新しました'}
    else
        render user_tweets_path(current_user), flash: {error: 'コメントの更新に失敗しました'}
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    if comment.destroy
      redirect_to user_tweets_path(current_user), flash: {success: '削除しました'}
    else
        render user_tweets_path(current_user), flash: {error: 'ツイートを削除できませんでした'}
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:tweet, :comment).merge(user: current_user)
    end

    def user
        @user ||= User.find(params[:user_id])
    end

    def tweet
        @tweet ||= Tweet.find(params[:tweet_id])
    end

    def comment
        @comment ||= Comment.find(params[:id])
    end
end
