require 'rails_helper'

feature 'User Register a costumer' do
  scenario 'and must be signed in' do
    #Arrenge
    #Act
    visit root_path
    click_on 'Clientes'

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'succesfully' do
    #Arrange
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar um novo cliente'
    fill_in 'Nome', with: 'cliente1'
    fill_in 'CPF', with: '111.111.111-11'
    fill_in 'E-mail', with: 'cliente1@email.com'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Cliente cadastrado com sucesso!')
    expect(page).to have_content('cliente1')
    expect(page).to have_content('111.111.111-11')
    expect(page).to have_content('cliente1@email.com')
    expect(page).to have_link('Voltar')
  end

  scenario 'and no costumer registered' do
    #Arrange
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on 'Clientes'

    #Assert
    expect(page).to have_content('Nenhum cliente cadastrado')
    expect(page).to have_content('Voltar')
  end

  scenario 'and sign out' do
    #Arrange
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scope: :user)

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
