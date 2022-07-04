class ArticlesController < ApplicationController
  before_action :set_article ,only: [:show, :edit ,:update ,:destroy]
  def show
    
    #debugger 
  end

  def index
    @articles=Article.all
  end

  def new
    @article=Article.new
  end

  def edit

  end

  def create
    # render plain: params[:article]

    @article=Article.new(article_params)
    @article.user = User.first 
    if @article.save
      flash[:notice]="Article was successfully created"
      # redirect_to ({action:show})
      redirect_to @article

    else 
      # I just ran into this and found the issue and solution. It looks like the turbo library 
      # doesn't like 200 responses from form POST submissions. https://github.com/hotwired/turbo-rails/issues/12#issuecomment-750326081. 
      # Further down it's mentioned there is a fix in version 0.5.3 of turbo that allows you to pass an unprocessable status (422) status with your render. 
      # I used the below code which worked for me.
      render :new, status: :unprocessable_entity
    end
   
  end
  
  def update
    if @article.update(article_params)
      flash[:notice]="Article was successfully updated"

      # redirect_to action: "show", id: params[:id]
      redirect_to @article
      
    else
      render 'edit'
    end

  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end


  private

  def set_article
    @article=Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
