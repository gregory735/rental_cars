require 'rails_helper'

feature 'Admin view car categories' do
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
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Top')
    expect(page).to have_content('Flex')
  end

  scenario 'and view details' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'

    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 105,50')
    expect(page).to have_content('R$ 58,50')
    expect(page).to have_content('R$ 10,50')
    expect(page).not_to have_content('Flex')
  end

  scenario 'and no car categories are created' do
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and return to home page' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to manufacturers page' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end

  scenario 'and view car models' do
    top = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                              third_party_insurance: 10.5)
    CarModel.create!(name: 'Civic', year: 2020, manufacturer: 'Honda',
                     motorization: '2.0', car_category: top, fuel_type: 'Flex')
    CarModel.create!(name: 'Jeep', year: 2020, manufacturer: 'Renegade',
                     motorization: '2.0', car_category: top, fuel_type: 'Flex')
    user = User.create!(name: 'greg', email: 'greg@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on top.name

    expect(page).to have_content('Top')
    expect(page).to have_link('Jeep')
    expect(page).to have_content('2020')
    expect(page).to have_link('Civic')
    expect(page).to have_content('2020')
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
