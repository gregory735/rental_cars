require "rails_helper"

feature "admin register subsidiary" do
  scenario "from index page" do
    visit root_path
    click_on "Filiais"

    expect(page).to have_link("Registrar uma nova filial",
                              href: new_subsidiary_path)
  end

  scenario "successfully" do
    visit root_path
    click_on "Filiais"
    click_on "Registrar uma nova filial"

    fill_in "Nome", with: "Maria"
    fill_in "CNPJ", with: "00-000.000/0001-51"
    fill_in "Endereço", with: "Rua xxxxxxxx xxxx"

    click_on "Enviar"

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content("Maria")
    expect(page).to have_content("00-000.000/0001-51")
    expect(page).to have_content("Rua xxxxxxxx xxxx")
    expect(page).to have_link("Voltar")
  end
end
