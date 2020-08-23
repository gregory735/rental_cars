require "rails_helper"

feature "Admin schedule rental" do
  scenario "Must be signed in" do
    # Arrange

    #Act
    visit root_path
    click_on "Locações"

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content("Para continuar, faça login ou registre-se.")
  end

  scenario "successfully" do
    CarCategory.create!(name: "Top", car_insurance: 100, daily_rate: 100,
                        third_party_insurance: 100)
    Customer.create!(name: "cliente1", cpf: "512.129.580-47",
                     email: "test@client.com")
    user = User.create!(name: "tester", email: "tester@email.com",
                        password: "123456")
    login_as(user, scoop: :user)

    visit root_path
    click_on "Locações"
    click_on "Agendar uma nova locação"
    fill_in "Data de início", with: "21/08/2030"
    fill_in "Data de término", with: "23/08/2030"
    select "cliente1 - 512.129.580-47", from: "Cliente"
    select "Top", from: "Categoria de carro"
    click_on "Agendar"

    expect(page).to have_content("21/08/2030")
    expect(page).to have_content("23/08/2030")
    expect(page).to have_content("cliente1")
    expect(page).to have_content("512.129.580-47")
    expect(page).to have_content("test@client.com")
    expect(page).to have_content("Top")
    expect(page).to have_content("R$ 600,00")
    expect(page).to have_content("Agendamento realizado com sucesso!")
  end

  scenario "must fill in all fields" do
    #Arrange
    CarCategory.create!(name: "Top", car_insurance: 100, daily_rate: 100,
                        third_party_insurance: 100)
    Customer.create!(name: "cliente1", cpf: "512.129.580-47",
                     email: "test@client.com")
    user = User.create!(name: "tester", email: "tester@email.com",
                        password: "123456")
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on "Locações"
    click_on "Agendar uma nova locação"
    click_on "Agendar"

    #Assert
    expect(page).to have_content("não pode ficar em branco", count: 2)
  end

  scenario "must be logged in to schedule rental" do
    visit new_rental_path

    expect(current_path).to eq new_user_session_path
  end

end
