I18nAdminUtils::Engine.routes.draw do

  get '/translation' => 'i18n_admin_utils/translation#index', :as => :tramslation_home
  get 'translation/missing/list' => 'i18n_admin_utils/translation#missing_list', :as => :translation_missing_list
  post '/translation/edit' => 'i18n_admin_utils/translation#edit', :as => :tramslation_edit
end