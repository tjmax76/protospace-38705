class PrototypesController < ApplicationController
  before_action :set_proto, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:new, :edit, :destroy]
  before_action :uncorrect_user, only:[:edit]
  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(permitted_parameters)
    if @prototype.save
      move_top_page
    else
      render action: :new
    end
  end
  
  def show
    @comment = Comment.new
    @comments = Comment.includes(:prototype)
  end

  def edit
  end

  def update
    if @prototype.update(permitted_parameters)
      move_top_page
    else
      render action: :edit
    end
  end

  def destroy
    @prototype.destroy
    move_top_page
  end

  private
  def permitted_parameters
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_proto
    @prototype = Prototype.find(params[:id])
  end

  def move_top_page
    redirect_to root_path
  end

  def uncorrect_user
    prototype = Prototype.find(params[:id])
    unless current_user.id == prototype.user_id
      redirect_to root_path
    end
  end
end
