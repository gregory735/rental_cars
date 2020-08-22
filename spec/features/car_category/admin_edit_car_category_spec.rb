require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'Must be signed in' do
    # Arrange

    #Act
    visit root_path
    click_on 'Categorias'

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'successfully' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Editar'
    fill_in 'Nome', with: 'Flex'
    fill_in 'Diária', with: '80'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Enviar'

    expect(page).to have_content('Flex')
    expect(page).not_to have_content('Top')
    expect(page).to have_content('R$ 80,00')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('R$ 10,00')
  end

  scenario 'attributes cannot be blank' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro do carro', with: ''
    fill_in 'Seguro para terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end

  scenario 'name must be unique' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Flex'
    click_on 'Editar'
    fill_in 'Nome', with: 'Top'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
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
