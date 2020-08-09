# config/initializers/locale.rb
 
# Where the I18n library should search for translation files
#I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
# essa a cima linha do código serve para mudar a pasta aonde tem os arquivos das linguas do i18n
 
# Permitted locales available for the application

#nome padrão é pt, mudar para pt-br colocar aspas duplas, as aspas duplas é porque o symbol com o traço deixaria invalido
I18n.available_locales = [:"pt-BR"]
 
# Set default locale to something other than :en
I18n.default_locale = :"pt-BR"