require 'rails_helper'

feature 'admin edit a filial' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Filial1', cnpj: '02.904.967/0001-23', address: 'rua santana da paraiba')

    visit root_path
    click_on 'Filiais'
    click_on 'Filial1'
    click_on 'Editar'
    fill_in 'Nome', with: 'Filial Nova'
    fill_in 'CNPJ', with: '55.292.046/0001-13'
    fill_in 'Endereço', with: 'rua santana nova'
    click_on 'Enviar'

    expect(page).to have_content('Filial Nova')
    expect(page).not_to have_content('02.904.967/0001-23')
    expect(page).to have_content('rua santana nova')
  end

  scenario 'attributes cannot be blank' do
    Subsidiary.create!(name: 'Filial1', cnpj: '02.904.967/0001-23', address: 'rua santana da paraiba')

    visit root_path
    click_on 'Filiais'
    click_on 'Filial1'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end
