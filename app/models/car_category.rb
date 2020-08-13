class CarCategory < ApplicationRecord
    validates :name, :daily_rate, :car_insurance, 
                :third_party_insurance, presence: true #{ message: 'não pode ficar em branco' } <- pode escolher a mensagem no lugar do true
    validates :name, uniqueness: { case_sensitive: false }
end

