class CarCategory < ApplicationRecord
  has_many :car_models

  validates :name, :daily_rate, :car_insurance,
            :third_party_insurance, presence: true #{ message: 'não pode ficar em branco' } <- pode escolher a mensagem no lugar do true
  validates :name, uniqueness: { case_sensitive: false }

  def daily_price
    daily_price + car_insurance + third_party_insurance
  end
end
