require 'rails_helper'

feature 'Admin register a valid customer' do
  scenario 'Must be signed in' do
    # Arrange

    #Act
    visit root_path
    click_on 'Clientes'

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'and the cpf must be unique' do
    #Arrange
    Customer.create!(name: 'customer1', cpf: '964.362.025-52',
                     email: 'customer1@email.com')
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar um novo cliente'
    fill_in 'Nome', with: 'customer1.1'
    fill_in 'CPF', with: '964.362.025-52'
    fill_in 'E-mail', with: 'customer1@email.com'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('CPF inválido, já registrado no sistema anteriormente!')
    expect(page).to have_content('E-mail inválido, já registrado no sistema anteriormente!')
    expect(page).not_to have_content('Cliente cadastrado com sucesso!')
  end

  scenario 'and the cpf must be valid' do
    #Arrange
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar um novo cliente'
    fill_in 'Nome', with: 'customer1.1'
    fill_in 'CPF', with: '111.111'
    fill_in 'E-mail', with: 'customer1@email.com'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('CPF inválido')
    expect(page).not_to have_content('Cliente cadastrado com sucesso!')
  end

  scenario 'and attributes cannot be blank' do
    #Arrange
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar um novo cliente'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end
