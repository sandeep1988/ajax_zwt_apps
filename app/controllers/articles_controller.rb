class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  helper_method :sort_column, :sort_direction
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    respond_to do |format|
      format.js
    format.html # index.html.erb
    format.json { render json: @articles }
    format.js
  end
end

  # GET /articles/1
  # GET /articles/1.json
  def show
  @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
      format.js
    end
  end

  # GET /articles/new
  def new
    @articles = Article.paginate(:per_page => 5, :page => params[:page])
    @article = Article.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
      format.js
    end
  end

  # GET /articles/1/edit
  def edit
  @article = Article.find(params[:id])
    respond_to do |format|
        format.html
        format.js
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    #@articles = Article.paginate(:per_page => 5, :page => params[:page])
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
        format.js
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.js
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title)
    end

    def sort_column
      Article.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
