class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @Subsidiary = Subsidiary.find(params[:id]) # params é um hash
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.create(subsidiary_params)
    redirect_to @subsidiary
    #rails já entende que redirecionar para esse objeto é 
    #fazer um show dele, e o rails já cria o path certo.
  end

  private
    def subsidiary_params
      params.require(:subsidiary).permit(:name, :cnpj, :address)
    end
end
  