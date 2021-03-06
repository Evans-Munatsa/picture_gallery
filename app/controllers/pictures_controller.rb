class PicturesController < ApplicationController
  before_action :find_picture, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:menu].blank?
      @picture = Picture.all.order('created_at DESC')
    else
      @menu_id = Menu.find_by(name: params[:menu]).id
      @picture = Picture.where(menu_id: @menu_id).order("created_at DESC")
    end
  end

  def new
    @picture = current_user.pictures.build
  end

  def create
    @picture = current_user.pictures.build(picture_params)

    if @picture.save
      redirect_to @picture, notice: 'Successfully created a picture'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to @picture, notice: 'Picture was Successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @picture.destroy
    redirect_to root_path
  end

  def upvote
    @picture.upvote_by current_user
    redirect_to :back
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :description, :image, :menu_id)
  end

  def find_picture
    @picture = Picture.find(params[:id])
  end
end
