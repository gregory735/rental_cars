def user_login(user)
  #Act
  visit root_path
  click_on 'Entrar'
  fill_in 'E-mail', with: user.email
  fill_in 'Senha', with: user.password
  click_on 'Entrar'
end
