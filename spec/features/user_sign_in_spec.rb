require 'rails_helper'

feature 'User sign in' do
  scenario 'from home page' do
    #Arrange
    #Act
    visit root_path
    #Assert
    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do
    #Arrange
    User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')

    #Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'gregory@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    #Assert
    expect(page).to have_content('Grégory')
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_link('Sair')
    expect(page).not_to have_content('Entrar')
  end

  scenario 'and sign out' do
    #Arrange
    user = User.create!(name: 'Greg', email: 'greg@email.com', password: '123456')

    #Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on 'Sair'

    #Assert
    expect(page).not_to have_content('Greg')
    expect(page).to have_content('Logout efetuado com sucesso')
    expect(page).to have_content('Entrar')
    expect(page).not_to have_content('Sair')
  end
end
