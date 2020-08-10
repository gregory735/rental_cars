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

    def create
        @car_category = CarCategory.create(car_category_params)
        redirect_to @car_category
        #rails já entende que redirecionar para esse objeto é fazer um show dele, e o rails já cria o path certo.
        #redirect_to car_category_path(@car_category)
    end

    private 
        def car_category_params
            params.require(:car_category)       
                .permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
        end
end