require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and cnpj must be unique' do
    Subsidiary.create!(name: 'filial1', cnpj: '55.292.046/0001-13', address: 'rua santana nº 3')

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'filial2'
    fill_in 'CNPJ', with: '55.292.046/0001-13'
    fill_in 'Endereço', with: 'Rua maruja nº 655'
    click_on 'Enviar'

    expect(page).to have_content('Cnpj já está em uso')
  end

  scenario 'and attributes cannot be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'and cnpj has 18 caracters' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'filial2'
    fill_in 'CNPJ', with: '55.292.046'
    fill_in 'Endereço', with: 'Rua maruja nº 655'
    click_on 'Enviar'

    expect(page).to have_content('Cnpj com número de digitos insuficientes')
  end

  scenario 'and cnpj must be valid' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'filial2'
    fill_in 'CNPJ', with: '21423574'
    fill_in 'Endereço', with: 'Rua maruja nº 655'
    click_on 'Enviar'

    expect(page).to have_content('Cnpj deve ser válido')
  end
end
