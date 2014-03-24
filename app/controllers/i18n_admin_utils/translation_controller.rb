module I18nAdminUtils
  class TranslationController < ApplicationController
    def index
    end

    def edit
      if params[:key].nil?
        i18n_redirect('No key specified')
      else
        key = params[:key]
        locale = params[:locale]
        translation = params[:value]
        if locale.nil?
          if key.include? '.'
            split = key.split('.', 2)
            locale = split[0]
            key = split[1]
          else
            i18n_redirect('No locale specified', false)
            return
          end
        end
        I18nAdminUtils::Backend::Manager.save_translation(locale, key, translation)
        i18n_redirect('Translation edited with success')
      end
    end

    #Return a list of all the missing translation
    def missing_list
      translation = I18nAdminUtils::SearchTranslation.search
      puts translation
      render :partial => 'missing_list', :layouts => false, :locals=> {:translation => translation}
    end

    def i18n_redirect(message, success = true)
      if request.xhr?
        render :json => {:success => success, :message => message}
      else
        if success
          redirect_to :back, :notice => message
        else
          redirect_to :back, :alert => message
        end
      end
    end
  end
end