require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'Must be signed in' do
    # Arrange

    #Act
    visit root_path
    click_on 'Categorias'

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'Must be signed in' do
    # Arrange

    #Act
    visit root_path
    click_on 'Categorias'

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'from index page' do
    #Arrange
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')
    user_login(user) # esse método feito a mão reduz código mas não o tempo, é melhor usar o login_as do devise

    #Act
    visit root_path
    click_on 'Categorias'

    #Assert
    expect(page).to have_link('Registrar uma nova categoria',
                              href: new_car_category_path)
  end

  scenario 'successfully' do
    #Arrange
    user = User.create!(name: 'Grégory', email: 'gregory@email.com', password: '123456')

    login_as(user, scope: :user) #esse é o método do devise com capybata, pode achar ele na wiki do github do devise
    # login_as não faz login, ele cria uma sessão de logado isso deixa muito mais rápido
    #obs  tem que usar login_as antes do root_path

    #act
    visit root_path
    click_on 'Categorias'

    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: 'Top'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Enviar'

    #assert
    expect(current_path).to eq car_category_path(CarCategory.last)
    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_link('Voltar')
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
