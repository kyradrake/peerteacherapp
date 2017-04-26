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
  document.getElementById("display all button").style.display = "none";
  document.getElementById("schedule changes view").style.display = "none";
  document.getElementById("classnum view").style.display = "none";
  document.getElementById("byname view").style.display = "none";
  
  // select available button, other buttons default color
  document.getElementById("available button").classList.remove("btn-link");
  document.getElementById("available button").classList.add("btn-link-active");
  
  document.getElementById("all button").classList.remove("btn-link-active");
  document.getElementById("all button").classList.add("btn-link");
  
  document.getElementById("schedule changes button").classList.remove("btn-link-active");
  document.getElementById("schedule changes button").classList.add("btn-link");
  
  return false;
}

function showAllDiv() {
  document.getElementById("all view").style.display = "block";

  document.getElementById("available view").style.display = "none";
  document.getElementById("display all button").style.display = "none";
  document.getElementById("schedule changes view").style.display = "none";
  document.getElementById("classnum view").style.display = "none";
  document.getElementById("byname view").style.display = "none";
  
  // select all button, other buttons default color
  document.getElementById("available button").classList.remove("btn-link-active");
  document.getElementById("available button").classList.add("btn-link");
  
  document.getElementById("all button").classList.remove("btn-link");
  document.getElementById("all button").classList.add("btn-link-active");
  
  document.getElementById("schedule changes button").classList.remove("btn-link-active");
  document.getElementById("schedule changes button").classList.add("btn-link");
  
  return false;
}

function showScheduleChangesDiv() {
  document.getElementById("schedule changes view").style.display = "block";

  document.getElementById("available view").style.display = "none";
  document.getElementById("all view").style.display = "none";
  document.getElementById("display all button").style.display = "none";
  document.getElementById("classnum view").style.display = "none";
  document.getElementById("byname view").style.display = "none";
  
  // select schedule changes button, other buttons default color
  document.getElementById("available button").classList.remove("btn-link-active");
  document.getElementById("available button").classList.add("btn-link");
  
  document.getElementById("all button").classList.remove("btn-link-active");
  document.getElementById("all button").classList.add("btn-link");
  
  document.getElementById("schedule changes button").classList.remove("btn-link");
  document.getElementById("schedule changes button").classList.add("btn-link-active");
  
  return false;
}

function showByName() {
  
  document.getElementById("byname view").style.display = "block";
  // http://stackoverflow.com/questions/1789945/how-to-check-whether-a-string-contains-a-substring-in-javascript
  var inputString = document.getElementById("name search bar dhananjay").value;
  console.log(inputString);
  document.getElementById("schedule changes view").style.display = "none";
  document.getElementById("all view").style.display = "none";
  document.getElementById("classnum view").style.display = "none";  
  document.getElementById("available view").style.display = "none";

  document.getElementById("display all button").style.display = "none";
  
  
  //button highliting 
  
   // select all button, other buttons default color
  document.getElementById("available button").classList.remove("btn-link-active");
  document.getElementById("available button").classList.add("btn-link");
  
  document.getElementById("all button").classList.remove("btn-link");
  document.getElementById("all button").classList.add("btn-link-active");
  
  document.getElementById("schedule changes button").classList.remove("btn-link-active");
  document.getElementById("schedule changes button").classList.add("btn-link");
   document.getElementById("display all button").style.display = "block";
  document.getElementById("display all button").textContent = "Currently displaying Search Results for  '" + inputString + "', click here to display all.";
  
  // var items = document.getElementsByTagName('div');
  var list = document.getElementsByClassName('col-lg-4 col-md-6 col-sm-12 col-xs-12 name');

  // go through all list
  for(var i = 0;i < list.length; i++) {
    // get each pt
      
    // check if any of the ids match classvar
    var lowerCaseID = list[i].id.toLowerCase();
    inputString = inputString.toLowerCase();
      
    // if(list[i].id.search(inputString) == -1){
    
    if(lowerCaseID.search(inputString) == -1){
      console.log("Didnt Match");
      list[i].style.display = 'none';
    } else {
       list[i].style.display = 'block';
        console.log("MATCH");
    }
    console.log("END USER");
  }
  
  return false;
}


function showclass(classvar) {
  document.getElementById("display all button").style.display = "block";
  document.getElementById("display all button").textContent = "Currently displaying CSCE " + classvar + " Peer Teachers, click here to display all.";
  
  document.getElementById("all view").style.display = "none";
  document.getElementById("available view").style.display = "none";
  document.getElementById("schedule changes view").style.display = "none";
    document.getElementById("byname view").style.display = "none";
  document.getElementById("classnum view").style.display = "block";
  
  // select all button, other buttons default color
  document.getElementById("available button").classList.remove("btn-link-active");
  document.getElementById("available button").classList.add("btn-link");
  
  document.getElementById("all button").classList.remove("btn-link");
  document.getElementById("all button").classList.add("btn-link-active");
  
  document.getElementById("schedule changes button").classList.remove("btn-link-active");
  document.getElementById("schedule changes button").classList.add("btn-link");
  
  var items = document.getElementsByTagName('div');
  var list = document.getElementsByClassName('col-lg-4 col-md-6 col-sm-12 col-xs-12 selective');

  // go through all list
  for(var i = 0;i < list.length; i++) {
    // get each pt
    var results = list[i].id.split(" ");

    for(var x = 0; x < results.length; x++) {
      console.log(results[x]);
      
      // check if any of the ids match classvar
      if(results[x] != classvar) {
        console.log("Didnt Match");
        list[i].style.display = 'none';
        // console.log(list[i].id);
      } else {
        list[i].style.display = 'block';
        console.log("MATCH");
        break;
      }
    }

    console.log("END USER");
  }
  
  return false;
}