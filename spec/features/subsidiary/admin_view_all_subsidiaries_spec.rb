require 'rails_helper'
# cada teste é dividido em 3 partes
# os 3 A's, arrange, act e assert
# 3 A's, prepara, executa e valida (prepara os dados, executa com eles e valida eles)

feature 'admin view all subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'filial1', cnpj: '55.292.046/0001-13', address: 'rua xxxxxxxx')
    Subsidiary.create!(name: 'filial2', cnpj: '02.904.967/0001-23', address: 'ruaxxxxxxxx')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('filial1')
    expect(page).to have_content('filial2')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'filial1', cnpj: '55.292.046/0001-13', address: 'rua xxxxxxxx')
    Subsidiary.create!(name: 'filial2', cnpj: '02.904.967/0001-23', address: 'ruaxxxxxxxx')

    visit root_path
    click_on 'Filiais'
    click_on 'filial1'

    expect(page).to have_content('filial1')
    expect(page).to have_content('55.292.046/0001-13')
    expect(page).to have_content('rua xxxxxxxx')
    expect(page).not_to have_content('filial2')
  end

  scenario 'and no Filials categories are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma Filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'filial1', cnpj: '55.292.046/0001-13', address: 'rua xxxxxxxx')

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to filials page' do
    Subsidiary.create!(name: 'filial1', cnpj: '55.292.046/0001-13', address: 'rua xxxxxxxx')

    visit root_path
    click_on 'Filiais'
    click_on 'filial1'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end
