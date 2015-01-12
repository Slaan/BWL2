class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.search(params[:search])
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  def add_to_basket
     a = Basketposition.create(user_id: params[:basketposition][:user_id], 
                               product_id: params[:basketposition][:product_id], 
                               how_many: params[:basketposition][:amount])
     if a.save
       redirect_to root_path 
     else
       redirect_to Product.find(params[:basketposition][:product_id]), notice: 'Coudln\'nt add product.'
     end
  end
  
  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # apriori algorithm
  # minsupp - minimal support
  def assosiation(minsupp = 3)
    # find 1-fi
    fi_set = Product.all.collect {|p| Set.new [p]}
    fi_set = fi_set.to_set.reject do |fi|
      no_of_trans = 0
      Order.all.each do |t| 
        if t.products.to_set.superset?(fi) then
          no_of_trans += 1
        end
        no_of_trans < minsupp
      end
    end
  end

 private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :amount, :since, :until, :picture)
  end

end
