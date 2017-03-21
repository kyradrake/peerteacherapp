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

function showTime(sHour, sMin, eHour, eMin) {
  var string =  " ";
  
  // get start time 
  if(sHour > 12) {                         // check if start time is pm
    var startHour = (sHour-12);
    var startMinute;
    if(sMin == 0) {
      startMinute = "00";
    }
    else {
      startMinute = sMin;
    }
    var startTime = startHour + ":" + startMinute + "pm";
    string += startTime;
  }
  else {                                        // start time is am
    var startHour = sHour;
    var startMinute;
    if(sMin == 0) {
      startMinute = "00";
    }
    else {
      startMinute = sMin;
    }
    var startTime = startHour + ":" + startMinute + "am";
    string += startTime
  }
  
  string += " - ";
  
  // get end time 
  if(eHour > 12) {                         // check if end time is pm
    var endHour = (eHour-12);
    var endMinute;
    if(eMin == 0) {
      endMinute = "00";
    }
    else {
      endMinute = eMin;
    }
    var eTime = startHour + ":" + startMinute + "pm";
    string += startTime;
  }
  else {                                        // start time is am
    var startHour = sHour;
    var startMinute;
    if(sMin == 0) {
      startMinute = "00";
    }
    else {
      startMinute = sMin;
    }
    var startTime = startHour + ":" + startMinute + "am";
    string += startTime
  }
}