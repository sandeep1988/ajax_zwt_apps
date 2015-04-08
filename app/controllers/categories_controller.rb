class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.paginate(:per_page => 1, :page => params[:page])
  respond_to do |format|
      format.js
    format.html # index.html.erb
    format.json { render json: @categories }
    format.js
  end
end

  # GET /categories/4
  # GET /categories/4.json
  def show
  @categoy = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
      format.js
    end
  end

  # GET /categories/newrole
  def new
    @categories = Category.paginate(:per_page => 1, :page => params[:page])
    @category = Category.new
    respond_to do |format|
        format.html
        format.js
    end
  end

  # GET /categories/4/edit
  def edit
    @categories = Category.paginate(:per_page => 1, :page => params[:page])
  @category = Category.find(params[:id])
    respond_to do |format|
      format.js
        format.html
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    @categories = Category.paginate(:per_page => 1, :page => params[:page])
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.js
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/4
  # PATCH/PUT /categories/4.json
  def update
    @categories = Category.paginate(:per_page => 1, :page => params[:page])
    respond_to do |format|
      if @category.update(category_params)
        format.js
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/4
  # DELETE /categories/4.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :role)
    end

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end