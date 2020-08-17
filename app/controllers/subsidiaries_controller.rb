class SubsidiariesController < ApplicationController
  before_action :set_subsidiary, only: [:show, :edit, :update]

  def index
    @subsidiaries = Subsidiary.all
  end

  def show; end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.create(subsidiary_params)
    if @subsidiary.save
      redirect_to @subsidiary
      #rails já entende que redirecionar para esse objeto é
      #fazer um show dele, e o rails já cria o path certo.
    else
      render :new
    end
  end

  def edit; end

  def update
    if @subsidiary.update(subsidiary_params)
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  def set_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
end
