// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function showAvailableDiv() {
  // show available view div
  document.getElementById("available view").style.display = "block";
  
  // hide all view div and schedule changes view div
  document.getElementById("all view").style.display = "none";
  document.getElementById("schedule changes view").style.display = "none";
  // make available button black
  document.getElementById("available button").style.backgroundColor = "0D0D0D";
  return false;
}

function showAllDiv() {
  document.getElementById("all view").style.display = "block";
  
  document.getElementById("available view").style.display = "none";
  document.getElementById("schedule changes view").style.display = "none";
  
  return false;
}

function showScheduleChangesDiv() {
  document.getElementById("schedule changes view").style.display = "block";
  
  document.getElementById("available view").style.display = "none";
  document.getElementById("all view").style.display = "none";
  return false;
}