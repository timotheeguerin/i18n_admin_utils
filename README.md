i18n_admin_utils 
================
[![Gem Version](https://badge.fury.io/rb/i18n_admin_utils.png)](http://badge.fury.io/rb/i18n_admin_utils) [![Build Status](https://travis-ci.org/timcolonel/i18n_admin_utils.png?branch=master)](https://travis-ci.org/timcolonel/i18n_admin_utils)  [![Code Climate](https://codeclimate.com/github/timcolonel/i18n_admin_utils.png)](https://codeclimate.com/github/timcolonel/i18n_admin_utils)


Utils to help manage translation with a rails app



#### [Changelog](https://github.com/timcolonel/i18n_admin_utils/wiki/Change-log)

**In devlopment...**

Please report bugs and features proposition https://github.com/timcolonel/i18n_admin_utils/issues


#Planned features

Main:

Description | Status
--- | ---
On the page(Rendered on the browser) click on a translation missing to display a popover with a form to set the translation | **Functional**, Working on customization
Retreive all the translation used inside your application and check they have been translated.| **Functional**
Check all the text you have entered in your application withour using t() | **TODO**

Other:
* Make account control(Each user can show the list on language he is charged of tranlating)

#Installation
Get the gem in your gemfile 
```ruby
gem `i18n_admin_utils`

```

Initialize
```bash
rails g i18n_admin_utils:install
```

Include javascript in `application.html.erb`
```erb
<%= javascript_include_tag 'i18n_admin_utils/translation_helper' if Rails.env.development? %>
```
#Configuration
The config is in 'config/initializer/i18n_admin_utils.rb'


#How to use
### Live editing
Click on a missing translation on the page to display a popover to translate the key.
![](https://f.cloud.github.com/assets/1031227/2431014/d6503c64-ad14-11e3-9fcf-f5339e1af69b.PNG)

To spot those translation you can add the class `.translation_missing` to your css, e.g.
```css
.translation_missing {
  color: red
}
```

### List of all keys used in app 
Search the entire project for the use of the t('') method. Then check for all given local for missing translations. You can see where this key is being used(And also live editing the file([Rails embed editor](https://github.com/timcolonel/rails_embed_editor) if you need to change the key).

![capture](https://cloud.githubusercontent.com/assets/1031227/2759141/c0958548-c99b-11e3-973a-374ed107e8b5.PNG)


Go to `/translation` (Loading might be long if your app is large). You should have a list of key to translate(Don't foregt to setup the locales your application use in the config file). The plugin reload the translation after updating one(You can disable it in the config). So reloading this page should update the translation

I will add some filter for getting the translation in a specific language and search by key.

### List the content not using the translation method
Search views for usage of text without using the translation method. This allow you to check your app fully support internationalisation.


***TODO***
