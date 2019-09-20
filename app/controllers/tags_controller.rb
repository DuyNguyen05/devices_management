class TagsController < ApplicationController
  def index
    @tags = Tag.all.page(params[:page]).per(10)
  end

  def create
    @tag = Tag.new device_params
    if @tag.save
      @tags = Tag.page(params[:page]).per(10)
      respond_to do |format|
        format.js
      end
    else
      render "new"
    end
  end

  def update
  end

  def new
    @tag = Tag.new
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def destroy
    @tag = Tag.find params[:id]
    @tag.destroy
    @tags = Tag.page(params[:page]).per(10)
    respond_to do |format|
      format.js
    end
  end

  private
  
  def device_params
    params.require(:tag).permit :name
  end

end