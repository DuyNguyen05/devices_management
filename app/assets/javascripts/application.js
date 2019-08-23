// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage

$(document).ready(function(){
  $("#search-devices input").keyup(function() {
    $.get($("#search-devices").attr("action"),
  $("#search-devices").serialize(), null, "script");
    return false;
  });
});

$(document).ready(function(){
  $("#match_name_email input").keyup(function() {
      $.get($("match_name_email").attr("action"), $("#match_name_email").serialize(), null, "script");
      return false;
  });
});
