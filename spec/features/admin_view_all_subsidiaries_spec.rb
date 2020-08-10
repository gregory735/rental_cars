require 'rails_helper'


feature 'admin view all subsidiaries' do
    scenario 'successfully' do
        Subsidiary.create!(name: 'filial1', cnpj: '55.555.555/0001-51', address: 'rua xxxxxxxx')
        Subsidiary.create!(name: 'filial2', cnpj: '55555555000151', address: 'ruaxxxxxxxx')

        visit root_path
        click_on 'Filiais'
    
        expect(page).to have_content('filial1')
        expect(page).to have_content('filial2')
    end

    scenario 'and view details' do
        Subsidiary.create!(name: 'filial1', cnpj: '55.555.555/0001-51', address: 'rua xxxxxxxx')
        Subsidiary.create!(name: 'filial2', cnpj: '55555555000151', address: 'ruaxxxxxxxx')    
        
        visit root_path
        click_on 'Filiais'
        click_on 'filial1'

        expect(page).to have_content('filial1')
        expect(page).to have_content('55.555.555/0001-51')
        expect(page).to have_content('rua xxxxxxxx')
        expect(page).not_to have_content('filial2')

    end

    scenario 'and no Filials categories are created' do
        visit root_path
        click_on 'Filiais'

        expect(page).to have_content('Nenhuma Filial cadastrada')
    end

    scenario 'and return to home page' do
        Subsidiary.create!(name: 'filial1', cnpj: '55.555.555/0001-51', address: 'rua xxxxxxxx')

        visit root_path
        click_on 'Filiais'
        click_on 'Voltar'

        expect(current_path).to eq root_path
    end
    
    scenario 'and return to filials page' do
        Subsidiary.create!(name: 'filial1', cnpj: '55.555.555/0001-51', address: 'rua xxxxxxxx')

        visit root_path
        click_on 'Filiais'
        click_on 'filial1'
        click_on 'Voltar'

        expect(current_path).to eq subsidiaries_path

    end


end