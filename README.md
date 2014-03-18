i18n_admin_utils
================

Utils to help manage translation with a rails app


In devlopmment...


#Planned features
* On the page(Rendered on the browser) click on a translation missing to display a popover with a form to set the translation

**IN PROGRESS**
* Retreive all the translation used inside your application and check they have been translated.
* Check all the text you have entered in your application withour using t()


#Installation
Get the gem in your gemfile 
```ruby
gem `i18n_admin_utils`, :github => 'timcolonel/i18n_admin_utils'

```

Initialize
```bash
rails g i18n_admin_utils:install
```

#Configuration
The config is in 'config/initializer/i18n_admin_utils.rb'


#How to use
### Live editing
Click on a missing translation on the page to display a popover to translate the key.

![](https://f.cloud.github.com/assets/1031227/2431014/d6503c64-ad14-11e3-9fcf-f5339e1af69b.PNG)


### List of all untranslated key in app 
Search the entire project for the use of the t('') method. All the untranslated key without a translation will be displayed
Current view ***Styling in progress ***
![Preview](https://f.cloud.github.com/assets/1031227/2444217/48365ab4-ae4d-11e3-80f2-cb080831da24.PNG)

### List the content not using the translation method
Search views for usage of text without using the translation method. This allow you to check your app fully support internationalisation.


***TODO***
