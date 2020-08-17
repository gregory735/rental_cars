class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: true #{ message: 'não pode ficar em branco' } <- pode escolher a mensagem no lugar do true
  validates :cnpj, uniqueness: true
  validates :cnpj, length: { is: 18, message: 'Cnpj com número de digitos insuficientes' }
  validate :cnpj_must_be_valid

  def cnpj_must_be_valid
    if cnpj.present? && !CNPJ.valid?(cnpj, strict: true)
      errors.add(:cnpj, 'Cnpj deve ser válido')
    end
  end
end
