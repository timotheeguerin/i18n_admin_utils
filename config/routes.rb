Rails.application.routes.draw do

  get '/translation' => 'i18n_admin_utils/translation#index', :as => :translation_home
  get 'translation/missing' => 'i18n_admin_utils/translation#show', :as => :translation_missing_show
  get 'translation/missing/list' => 'i18n_admin_utils/translation#missing_list', :as => :translation_missing_list
  post '/translation/edit' => 'i18n_admin_utils/translation#edit', :as => :translation_edit
end