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

  $(document).on 'click', '.translation_list .translation_item', () ->
    console.log('click')
    item = $(this)

    item.closest('.translation_list').find('.translation_item.active').each () ->
      $(this).removeClass('active')
    item.addClass('active')


#Rerun this command for reloading script for new element added with ajax for example
window.load_script_on = (container) ->
  container.find("[rel=tooltip]").tooltip({ container: 'body', animation: false, delay: 0});
  container.find("[rel=popover]").popover({ container: 'body', animation: false, delay: 0, trigger: 'hover'});
  container.find('[data-toggle="modal"]').modal('hide')
  window.load_rails_embed_code_editor() #Reload editors


