require 'rails_helper'

feature 'admin register subsidiary' do
  scenario 'from index page' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar uma nova filial',
                              href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'

    expect(page).to have_link('Voltar', href: subsidiaries_path)

    fill_in 'Nome', with: 'Maria'
    fill_in 'CNPJ', with: '02.904.967/0001-23'
    fill_in 'Endereço', with: 'Rua xxxxxxxx xxxx'

    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Maria')
    expect(page).to have_content('02.904.967/0001-23')
    expect(page).to have_content('Rua xxxxxxxx xxxx')
    expect(page).to have_link('Voltar', href: subsidiaries_path)
  end
end
