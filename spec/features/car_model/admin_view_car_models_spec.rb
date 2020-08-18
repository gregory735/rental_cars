require 'rails_helper'

feature 'Admin view car model' do
  scenario 'and view list' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 200,
                                       third_party_insurance: 280.55)
    CarModel.create!(name: 'Civic', year: 2009, manufacturer: 'Honda',
                     motorization: '2.0', car_category: car_category, fuel_type: 'Gasolina')
    CarModel.create!(name: 'Jeep', year: 2018, manufacturer: 'Renegade',
                     motorization: '2.0', car_category: car_category, fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Honda')
    expect(page).to have_content('Civic')
    expect(page).to have_content('2009')
    expect(page).to have_content('Jeep')
    expect(page).to have_content('Renegade')
    expect(page).to have_content('2018')
    expect(page).to have_content('Top', count: 2) #expressão regular,ex. /A/ faz que ache um A sozinho, entraria no lugar de 'TOP'
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and view details' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 200,
                                       third_party_insurance: 280.55)
    CarModel.create!(name: 'Civic', year: 2009, manufacturer: 'Honda',
                     motorization: '2.0', car_category: car_category, fuel_type: 'Gasolina')
    CarModel.create!(name: 'Jeep', year: 2018, manufacturer: 'Renegade',
                     motorization: '2.0', car_category: car_category, fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Civic - 2009'

    expect(page).to have_content('Civic')
    expect(page).to have_content('2009')
    expect(page).to have_content('Honda')
    expect(page).to have_content('2.0')
    expect(page).to have_content(car_category.name) #pode ser usado assim também
    expect(page).to have_content('Gasolina')
    expect(page).not_to have_content('jeep')
    expect(page).not_to have_content('Renegade')
    expect(page).to have_link('Voltar', href: car_models_path)
  end

  scenario 'and nothing registered' do
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Nenhum modelo de carro registrado')
    expect(page).to have_link('Voltar', href: root_path)
  end
end
