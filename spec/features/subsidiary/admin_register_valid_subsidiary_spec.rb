require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and must be signed in' do
    #Arrange
    #Act
    visit root_path
    click_on 'Filiais'

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'and cnpj must be unique' do
    Subsidiary.create!(name: 'filial1', cnpj: '55.292.046/0001-13', address: 'rua santana nº 3')
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

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
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

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
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

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
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'filial2'
    fill_in 'CNPJ', with: '21423574'
    fill_in 'Endereço', with: 'Rua maruja nº 655'
    click_on 'Enviar'

    expect(page).to have_content('Cnpj deve ser válido')
  end

  scenario 'and must sign out' do
    #Arrange
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on 'Sair'

    #Assert
    expect(page).not_to have_content(user.name)
    expect(page).not_to have_content('Sair')
    expect(page).to have_content('Logout efetuado com sucesso')
    expect(page).to have_content('Entrar')
  end
end
