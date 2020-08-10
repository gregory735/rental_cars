class SubsidiariesController < ApplicationController

    def index
        @subsidiaries = Subsidiary.all
    end

    def show
        @Subsidiary = Subsidiary.find(params[:id]) # params é um hash
    end

end