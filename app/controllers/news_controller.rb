class NewsController < ApplicationController
before_action :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @news = News.new
  end

  def create
    @news = current_user.news.build(news_params)
    if @news.save
      redirect_to @news
    else
      render 'new'
    end
  end

  def show
    if News.find_by(id: params[:id])
      @news = News.find_by(id: params[:id])
      @comments = @news.comments
    else
      redirect_to root_url
    end
  end

  def edit
    if News.find_by(id: params[:id])
      @news = News.find_by(id: params[:id])
    else
      redirect_to root_url
    end
  end

  def update
    @news = News.find_by(id: params[:id])

    if @news.update_attributes(news_params)
      flash[:success] = "Artykuł zaktualizowany"
      redirect_to @news
    else
      render 'edit'
    end
  end

  def index
    @news = News.paginate(page: params[:page])
  end

  def destroy
    News.find(params[:id]).destroy
    flash[:success] = "Artykuł usunięty."
    redirect_to news_url
  end

  private

  def news_params
    params.require(:news).permit(:title, :teaser, :content)
  end
end
