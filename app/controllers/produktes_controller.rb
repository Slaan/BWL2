class ProduktesController < ApplicationController
  before_action :set_produkte, only: [:show, :edit, :update, :destroy]

  # GET /produktes
  # GET /produktes.json
  def index
    @produktes = Produkte.search(params[:search])
  end

  # GET /produktes/1
  # GET /produktes/1.json
  def show
  end

  # GET /produktes/new
  def new
    @produkte = Produkte.new
  end

  # GET /produktes/1/edit
  def edit
  end

  # POST /produktes
  # POST /produktes.json
  def create
    @produkte = Produkte.new(produkte_params)

    respond_to do |format|
      if @produkte.save
        format.html { redirect_to @produkte, notice: 'Produkte was successfully created.' }
        format.json { render :show, status: :created, location: @produkte }
      else
        format.html { render :new }
        format.json { render json: @produkte.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produktes/1
  # PATCH/PUT /produktes/1.json
  def update
    respond_to do |format|
      if @produkte.update(produkte_params)
        format.html { redirect_to @produkte, notice: 'Produkte was successfully updated.' }
        format.json { render :show, status: :ok, location: @produkte }
      else
        format.html { render :edit }
        format.json { render json: @produkte.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produktes/1
  # DELETE /produktes/1.json
  def destroy
    @produkte.destroy
    respond_to do |format|
      format.html { redirect_to produktes_url, notice: 'Produkte was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produkte
      @produkte = Produkte.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produkte_params
      params.require(:produkte).permit(:name, :beschreibung, :preis, :stueckzahl, :datumvon, :datumbis)
    end
end
