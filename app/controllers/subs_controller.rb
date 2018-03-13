class SubsController < ApplicationController
  before_action :require_login, only: [:create, :new, :edit, :update]

  def new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end



  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.moderator == current_user
      if @sub.update(sub_params)
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages
        render :edit
      end
    else
      flash.now[:errors] = ['That is not your sub']
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end


  def index
    render :index
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
