class CarCategoriesController < ApplicationController
  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_category = CarCategory.find(params[:id]) # params é um hash
  end

  def new
    @car_category = CarCategory.new
  end

  #o rails só identifica os erros quando vocÊ tenta fazer alguma coisa com eles ex usar o save
  # se o problema cai no else nesse código, ele não gera erros pq nao acontece o save ou alguma mudança no bd
  #para resolver isso tirar o redirect do else e usar o render :new
  def create
    @car_category = CarCategory.new(car_category_params) # se for usar create aqui, tem que usar persisted? no lugar de save em baixo.
    if @car_category.save
      redirect_to @car_category
    else
      #redirect_to new_car_category_path
      render :new
      #redirect manda para o new ser executado, o render
      #vocÊ ta no create mas está renderizando o new
    end
    #rails já entende que redirecionar para esse objeto é fazer um show dele, e o rails já cria o path certo.
    #redirect_to car_category_path(@car_category)
  end

  def edit
    @car_category = CarCategory.find(params[:id])
  end

  def update
    @car_category = CarCategory.find(params[:id])
    if @car_category.update(car_category_params)
      redirect_to @car_category
    else
      render :edit
    end
  end

  private

  def car_category_params
    params.require(:car_category)
      .permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end
end
