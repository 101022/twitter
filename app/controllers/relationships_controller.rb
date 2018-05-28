class RelationshipsController < ApplicationController
 
  def create
    if Relationship.create(create_params)
      redirect_to users_path(current_user), flash: {success: 'フォローしました'}
    else
      redirect_to users_path(current_user), flash: {error: 'フォローできませんでした'}
    end
  end

  def destroy
    relationship =  Relationship.find(params[:id])
    if relationship.destroy
      redirect_to users_path(current_user), flash: {success: 'アンフォローしました'}
    else
      redirect_to users_path(current_user), flash: {error: 'アンフォローできませんでした'}
    end
  end

  private
    def create_params
        params.permit(:following_id).merge(follower_id: current_user.id)
    end
end
