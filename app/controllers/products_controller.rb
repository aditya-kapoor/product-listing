class ProductsController < ApplicationController
  before_action :load_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    @products = Product.all.decorate
    @product = Product.new
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
        format.js   { render json: @product, status: :created }
      else
        format.html { render :new }
        format.js   { render json: @product.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_product
      @product = Product.where(id: params[:id]).first
      unless @product
        redirect_to root_path, alert: 'Product not found.'
      end
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
