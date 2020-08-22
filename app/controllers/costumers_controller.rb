class CostumersController < ApplicationController
  before_action  :authenticate_user!, only: [ :index ]
  
  def index
    @costumers = Costumer.all
  end

  def show
    @costumer = Costumer.find(params[:id])
  end

  def new
    @costumer = Costumer.new
  end

  def create
    @costumer = Costumer.new(costumer_params)
    if @costumer.save
      redirect_to @costumer, notice: 'Cliente cadastrado com sucesso!'
    else
      render :new
    end
  end

  private

  def costumer_params
    params.require(:costumer)
      .permit(:name, :cpf, :email)
  end
end