require 'rails_helper'

feature 'Admin searches rental' do
  scenario 'and find exact match' do
    #Arrange
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100,
                                       third_party_insurance: 100)
    customer = Customer.create!(name: 'cliente1', cpf: '310.208.020-06',
                                email: 'test1@client.com')
    user = User.create!(name: 'tester', email: 'tester1@email.com',
                        password: '123456')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                            car_category: car_category, customer: customer, user: user)
    rental2 = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                             car_category: car_category, customer: customer, user: user)
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'

    #Assert
    expect(page).to have_content(rental.token)
    expect(page).not_to have_content(rental2.token)
    expect(page).to have_content(rental.customer.name)
    expect(page).to have_content(rental.customer.email)
    expect(page).to have_content(rental.customer.cpf)
    expect(page).to have_content(rental.car_category.name)
  end

  scenario 'finds by partial token' do
    #Arrange
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100,
                                       third_party_insurance: 100)
    customer = Customer.create!(name: 'cliente1', cpf: '310.208.020-06',
                                email: 'test1@client.com')
    user = User.create!(name: 'tester', email: 'tester1@email.com',
                        password: '123456')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                            car_category: car_category, customer: customer, user: user)
    rental.update(token: 'ABC123')
    another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                                    car_category: car_category, customer: customer, user: user)
    another_rental.update(token: 'ABC567')
    rental_not_to_be_found = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                                            customer: customer,
                                            car_category: car_category,
                                            user: user)
    rental_not_to_be_found.update(token: '485866')
    login_as(user, scoop: :user)

    #Act
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: 'ABC'
    click_on 'Buscar'

    expect(page).to have_content(rental.token)
    expect(page).to have_content(another_rental.token)
    expect(page).not_to have_content(rental_not_to_be_found.token)
  end
end
