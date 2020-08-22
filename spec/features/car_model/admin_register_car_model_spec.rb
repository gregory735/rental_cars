require 'rails_helper'

feature 'Admin register car model' do
  scenario 'Must be signed in' do
    # Arrange

    #Act
    visit root_path
    click_on 'Modelos de carro'

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'successfully' do
    CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 200,
                        third_party_insurance: 280.55)
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar um modelo de carro'
    fill_in 'Nome', with: 'Civic'
    fill_in 'Ano', with: '2009'
    fill_in 'Fabricante', with: 'Honda'
    fill_in 'Motorização', with: '2.0'
    select 'Top', from: 'Categoria de carro'
    fill_in 'Tipo de combustível', with: 'Gasolina'
    click_on 'Enviar'

    expect(page).to have_content('Civic')
    expect(page).to have_content('Honda')
    expect(page).to have_content('2009')
    expect(page).to have_content('2.0')
    expect(page).to have_content('Top')
    expect(page).to have_content('Gasolina')
  end

  scenario 'must fill in all fields' do
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scoop: :user)

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar um modelo de carro'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Fabricante não pode ficar em branco')
    expect(page).to have_content('Motorização não pode ficar em branco')
    expect(page).to have_content('Categoria de carro é obrigatório(a)')
    expect(page).to have_content('Tipo de combustível não pode ficar em branco')
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
