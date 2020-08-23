require "rails_helper"

feature "Admin view all schedule rentals" do
  scenario "Must be signed in" do
    # Arrange

    #Act
    visit root_path

    #Assert
    expect(page).not_to have_content("Locações")
  end

  scenario "successfully" do
    car_category = CarCategory.create!(name: "Top", car_insurance: 100, daily_rate: 100,
                                       third_party_insurance: 100)
    customer = Customer.create!(name: "customer1", cpf: "512.129.580-47",
                                email: "test@customer.com")
    user = User.create!(name: "tester", email: "tester@email.com",
                        password: "123456")
    rental = Rental.create!(start_date: "22/08/2030", end_date: "24/08/2030",
                            car_category: car_category, customer: customer, user: user)
    rental2 = Rental.create!(start_date: "28/08/2030", end_date: "30/08/2030",
                             car_category: car_category, customer: customer, user: user)
    login_as(user, scoop: :user)

    visit root_path
    click_on "Locações"

    expect(page).to have_content(rental.customer.name)
    expect(page).to have_content(rental.start_date)
    expect(page).to have_content(rental.end_date)
    expect(page).to have_content(rental.car_category.name)
    expect(page).to have_content(rental2.start_date)
    expect(page).to have_content(rental2.end_date)
    expect(page).to have_content(rental2.customer.name)
    expect(page).to have_content(rental2.car_category.name)
  end
  
  scenario "no rental schedule" do
    #Arrange
    user = User.create!(name: "tester", email: "tester@email.com",
                        password: "123456")
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on "Locações"

    #Assert
    expect(page).to have_content("Nenhuma locação agendada!")
  end
end
