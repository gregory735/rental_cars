require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'token' do
    it 'generate on create' do
      #Arrange
      car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100,
                                         third_party_insurance: 100)
      customer = Customer.create!(name: 'cliente1', cpf: '310.208.020-06',
                                  email: 'test1@client.com')
      user = User.create!(name: 'tester', email: 'tester1@email.com',
                          password: '123456')
      rental = Rental.new(start_date: Date.current, end_date: 1.day.from_now,
                          car_category: car_category, customer: customer, user: user)

      #Act
      rental.save!

      #Assert
      expect(rental.token).to be_present
      expect(rental.token.size).to eq(6)
      expect(rental.token).to match(/^[A-Z0-9]+$/)
    end

    it 'must be unique' do
      car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100,
                                         third_party_insurance: 100)
      customer = Customer.create!(name: 'cliente1', cpf: '310.208.020-06',
                                  email: 'test1@client.com')
      user = User.create!(name: 'tester', email: 'tester1@email.com',
                          password: '123456')
      rental1 = Rental.new(start_date: Date.current, end_date: 1.day.from_now,
                           car_category: car_category, customer: customer, user: user)

      rental1.save!

      p '=========='
      p rental1.token
      p '=========='
    end
  end
end
