class ProductsController < ApplicationController

  include ProductsHelper

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.search(params[:search])
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @association = assosi
  end

  # GET /products/assosiation
  def assosiation
    @association = assosi
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
       redirect_to Product.find(params[:basketposition][:product_id]), 
                                notice: 'Coudln\'nt add product.'
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
  def assosi(minsupp = 2)
    # create 1-frequent-set
    c1 = Product.all.permutation(1).to_a
    l1 = c1.reject { |fi| trans_containing(fi) < minsupp}
    # find k-frequent-set, first elem is nil because k = 2
    l = [nil, l1]
    k = 2
    c = []
    while not(l[k-1].empty?)
      # find candidates
      b = l[k-1].flatten.to_set.to_a
      c = b.reduce([]) do |accu, extension|
        accu + l[k-1].reduce([]) do |accu2, canidate|
          if not(canidate.include?(extension)) then
            accu2 << (canidate + [extension])
          else
            accu2
          end
        end
      end
      # remove dubs
      c = c.collect {|e| e.to_set }.to_set.collect {|e| e.to_a }.to_a
      # select minsupps
      l[k] = c.reject { |canidate| trans_containing(canidate) < minsupp }
      k = k + 1
    end
    #first elem is nil; last elem is an empty list
    l.shift; l.pop
    low_fatten(l)
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
