class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  # GET /products
  # GET /products.json
  def index
  @products = Product.all.paginate(:per_page => 2, :page => params[:page])
    
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @products }
      format.js
  end
end

  # GET /products/2
  # GET /products/2.json
  def show
  @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
      format.js
    end
  end

  # GET /products/new
  def new
    @products = Product.all.paginate(:per_page => 2, :page => params[:page])
    @product = Product.new
    respond_to do |format|
        format.html
        format.js
    end
  end

  # GET /products/2/edit
  def edit
    @products = Product.all.paginate(:per_page => 2, :page => params[:page])
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js
        format.html
    end
  end

  # POST /products
  # POST /products.json
  def create
    @products = Product.all.paginate(:per_page => 2, :page => params[:page])
    @product = Product.new(product_params)
    @product.color = params[:product][:color].reject! { |c| c.empty? }
    respond_to do |format|
      if @product.save
        format.js
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.js
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
    end

  # PATCH/PUT /products/2
  # PATCH/PUT /products/2.json
  def update
    @products = Product.all.paginate(:per_page => 2, :page => params[:page])
    respond_to do |format|
      if @product.update(product_params)
        format.js
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/2
  # DELETE /products/2.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit([:name, :price, :category_id, :color => []])
    end

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
