# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree .
#= require bootstrap

$(document).ready () ->
  window.load_script_on($(this))

  $('.loadonready').each () ->
    container = $(this)
    url = container.data('url')
    container.html($('#loading_icon').html())
    $.get(url).success (data) ->
      container.html(data)
      window.load_script_on(container)

  $(document).on 'click', 'form input.nosubmit, form button.nosubmit', (e) ->
    e.preventDefault();

  $(document).on 'keyup', 'input[data-update], textarea[data-update]', () ->
    input = $(this)
    form = input.closest('form')
    form.find('input[name="' + input.data('update') + '"], textarea[name="' + input.data('update') + '"]').val(input.val())

  $(document).on 'click', '.toogle-container', () ->
    container = $($(this).data('container'))
    if container.is(':visible')
      container.hide()
    else
      container.show()


  $(document).on 'click', '.translation_edit_container .locale-tab', () ->
    tab = $(this)
    active_tab = tab.parent().find('.locale-tab.active')
    translation_edit_container = tab.closest('.translation_edit_container')
    form = translation_edit_container.find('form.translation_form')
    locale_input = form.find('input[name="locale"]')
    text_input = form.find('textarea[name="value"]')
    active_tab.data('translation', text_input.val())
    text_input.val(tab.data('translation'))
    locale_input.val(tab.data('locale'))
    active_tab.removeClass('active')
    tab.addClass('active')

  $(document).on 'translation-saved', '.translation_edit_container form.translation_form button', () ->
    button = $(this)
    form = button.closest('form.translation_form')
    #Update the tab
    locale = form.find('input[name="locale"]')
    container = button.closest('.translation_edit_container')
    active_tab = container.find('.locale-tab[data-locale="' + locale.val() + '"]')
    active_tab.removeClass('btn-danger').addClass('btn-success')

    #Update the left menu
    list = button.closest('.translation_container').find('.translation_list')
    key = form.find('input[name="key"]')
    element = list.find('.translation_item[data-key="' + key.val() + '"]')
    $.get(element.data('reload-url'), {
      translation: element.data('translation')
    }

    ).success (data) ->
      element.html($(data).html())

  $(document).on 'click', '.translation_filter .show-completed', () ->
    button = $(this)
    button.toggleClass('active')
    filter(button.closest('.translation_filter'))

  $(document).on 'keyup', 'input.translation_search', () ->
    filter($(this).closest('.translation_filter'))

  $(document).on 'click', '.translation_list .translation_item', () ->
    item = $(this)
    list = item.closest('.translation_list')
    list.find('.translation_item.active').each () ->
      $(this).removeClass('active')
    item.addClass('active')
    container = item.closest('.translation_container').find(list.data('container'))
    container.html($('#loading_icon').html())
    $.get(list.data('url'), {
      translation: item.data('translation')
    }).success (data) ->
      container.html(data)
      window.load_script_on(container)


#Rerun this command for reloading script for new element added with ajax for example
window.load_script_on = (container) ->
  container.find("[rel=tooltip]").tooltip({ container: 'body', animation: false, delay: 0});
  container.find("[rel=popover]").popover({ container: 'body', animation: false, delay: 0, trigger: 'hover'});
  container.find('[data-toggle="modal"]').modal('hide')
  container.find('textarea.autosize').autosize()
  window.load_rails_embed_code_editor() #Reload editors


show_translation_element = (elements) ->
  elements.each () ->
    element = $(this)
    if not element.is ':visible'
      element.slideDown(200)

hide_translation_element = (elements) ->
  elements.each () ->
    element = $(this)
    if  element.is ':visible'
      element.slideUp(200)


filter = (filter_container) ->
  input = filter_container.find('input.translation_search')
  show_completed_button = filter_container.find('.btn.show-completed')
  val = input.val()

  container = input.closest '.translation_container'
  elements = container.find('.translation_list .translation_item')
  query = ''
  query += '[data-key*="' + val + '"]'  if val.length > 0
  query += '[data-completed=false]' unless show_completed_button.hasClass('active')

  if query.length >0
    show_translation_element(elements.filter(query))
    hide_translation_element(elements.not(query))
  else
    show_translation_element(elements)