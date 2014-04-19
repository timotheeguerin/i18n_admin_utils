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


  $(document).on 'keyup', 'input.translation_search', () ->
    input = $(this)
    val = input.val()


    container = input.closest '.translation_container'
    elements = container.find('.translation_list .translation_item')
    if val.length == 0
      show_translation_element(elements)
    else
      query = '[data-locale*="' + val + '"],[data-key*="' + val + '"], [data-filename*="' + val + '"]'
      show_translation_element(elements.filter(query))
      hide_translation_element(elements.not(query))

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