require 'rails_helper'

feature 'admin register subsidiary' do
  scenario 'and must be signed in' do
    #Arrenge
    #Act
    visit root_path
    click_on 'Filiais'

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'from index page' do
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar uma nova filial',
                              href: new_subsidiary_path)
  end
  scenario 'successfully' do
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'Maria'
    fill_in 'CNPJ', with: '02.904.967/0001-23'
    fill_in 'Endereço', with: 'Rua xxxxxxxx xxxx'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Maria')
    expect(page).to have_content('02.904.967/0001-23')
    expect(page).to have_content('Rua xxxxxxxx xxxx')
    expect(page).to have_link('Voltar', href: subsidiaries_path)
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
