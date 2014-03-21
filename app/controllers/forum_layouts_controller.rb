class ForumLayoutsController < ApplicationController
  before_action :signed_in_user

  def create
    @category = Category.find(params[:forum_layout][:category_id])
    @category.collapse!(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to forum_url }
    end
  end

  def update
    @category = ForumLayout.find(params[:id]).category
    if @category.collapsed?(current_user)
      @category.uncollapse!(current_user)
    else
      @category.collapse!(current_user)
    end
    respond_to do |format|
      format.js
      format.html { redirect_to forum_url }
    end
  end
end