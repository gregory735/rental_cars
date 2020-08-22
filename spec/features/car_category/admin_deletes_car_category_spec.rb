require 'rails_helper'

feature 'Admin deletes manufacturer' do
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
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and keep anothers' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).not_to have_content('Top')
    expect(page).to have_content('Flex')
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
