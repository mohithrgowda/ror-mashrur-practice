class ArticlesController < ApplicationController
  def show
    
    #debugger 

    @article=Article.find(params[:id])
  end

  def index
    @articles=Article.all
  end

  def new
    
  end

  def create
    # render plain: params[:article]
    
    @article=Article.new(params.require(:article).permit(:title,:description))
    @article.save

     # redirect_to ({action:show})
    redirect_to @article
   
  end
  

end
