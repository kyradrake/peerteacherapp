//= require active_admin/base
//= require bootstrap-sprockets

$(document).ready(function() {
  // Add meta view port
  $('head').append('<meta name="viewport" content="width=device-width, initial-scale=1">');
  $('head').append('<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">');

  // Dropdown menus
  $(window).resize(function(){
    if ($(window).width() <= 768) {
      $('#tabs').addClass('collapse');
    } else {
      $('#tabs').removeClass('collapse');
    }
  });

  html_responsive = ' \
    <ul class="header-item tabs mobile"> \
      <li> \
        <button class="navbar-toggle button_mobile_burger" type="button" data-toggle="collapse" href="#tabs" aria-expanded="true" aria-controls="tabs"> \
          <span class="sr-only">Toggle navigation</span> \
          <span class="icon-bar"></span> \
          <span class="icon-bar"></span> \
          <span class="icon-bar"></span> \
        </button> \
      </li> \
    </ul> \
  '

  $(html_responsive).insertAfter('#site_title');
});