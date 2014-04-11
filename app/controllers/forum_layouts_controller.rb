class ForumLayoutsController < ApplicationController
  before_action :signed_in_user

  def create
    Category.all.each do |category|
      @forum_layout  = ForumLayout.new
      @forum_layout.user_id = current_user.id
      @forum_layout.category_id = category.id
      @forum_layout.user_custom_index = category.id
      @forum_layout.save
    end
    @category = Category.find(params[:forum_layout][:category_id])
    if params[:forum_layout][:change_type] == "collapse"
      @category.collapse!(current_user)
      respond_to do |format|
        format.js
        format.html { redirect_to forum_url }
      end
    elsif params[:forum_layout][:change_type] == "position"
      if params[:forum_layout][:dir] == "up"
        @category.slide_up!(user_id: params[:forum_layout][:user_id])
      elsif params[:forum_layout][:dir] == "down"
        @category.slide_down!(user_id: params[:forum_layout][:user_id])
      end
      redirect_to :back
    end
  end

  def update
    @category = ForumLayout.find_by(id: params[:id]).category
    if params[:forum_layout][:change_type] == "collapse"
      if @category.collapsed?(current_user)
        @category.uncollapse!(current_user)
      else
        @category.collapse!(current_user)
      end
      respond_to do |format|
        format.js
        format.html { redirect_to forum_url }
      end
    elsif params[:forum_layout][:change_type] == "position"
      if params[:forum_layout][:dir] == "up"
        @category.slide_up!(user_id: params[:forum_layout][:user_id])
      elsif params[:forum_layout][:dir] == "down"
        @category.slide_down!(user_id: params[:forum_layout][:user_id])
      end
      redirect_to :back
    end
  end
end