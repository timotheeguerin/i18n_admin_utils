Rails.application.routes.draw do

  get '/translation' => 'i18n_admin_utils/translation#index', :as => :translation_home
  get 'translation/show' => 'i18n_admin_utils/translation#show', :as => :translation_missing_show
  get 'translation/list' => 'i18n_admin_utils/translation#missing_list', :as => :translation_missing_list
  get 'translation/list/element' => 'i18n_admin_utils/translation#list_element', :as => :translation_list_element
  post '/translation/edit' => 'i18n_admin_utils/translation#edit', :as => :translation_edit
end