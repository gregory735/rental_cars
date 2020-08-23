class Customer < ApplicationRecord
  validates :cpf, :email, :name, presence: true
  validates :email, uniqueness: { case_sensitive: false, message: 'E-mail inválido, já registrado no sistema anteriormente!' }
  validates :cpf, uniqueness: { case_sensitive: false, message: 'CPF inválido, já registrado no sistema anteriormente!' }
  validate :cpf_must_be_valid

  private

  def cpf_must_be_valid
    return if cpf.blank?
    return if CPF.valid?(cpf)

    errors.add(:cpf, 'CPF inválido')
  end
end
