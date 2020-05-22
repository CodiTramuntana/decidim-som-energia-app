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
//= require rails-ujs
//= require_tree .
//= require decidim
//= require cas_client

$(function(){
  bindCasClientRoutes();
});

function bindCasClientRoutes(){
  var locale = $(document.documentElement).attr("lang") || "es";

  $(document).on("click","a[href*='/users/sign_in'], a[href*='/users/sign_up']", function(e){
    e.preventDefault();
    window.location.href = '/users/cas/sign_in?locale='+locale;
  });
  $("a[href*='/users/sign_out']").attr('href', '/users/cas/sign_out?locale='+locale);
}
