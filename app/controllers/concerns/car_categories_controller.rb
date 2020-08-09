class CarCategoriesController < ApplicationController
    def index
        @car_categories = CarCategory.all
    end

    def show
        @car_category = CarCategory.find(params[:id]) # params é um hash
    end
end