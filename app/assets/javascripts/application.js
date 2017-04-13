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
  
   document.getElementById("tochange").innerHTML = "Displaying Available Peer Teachers";
  // hide all view div and schedule changes view div
  document.getElementById("all view").style.display = "none";
  document.getElementById("schedule changes view").style.display = "none";
  document.getElementById("classnum view").style.display = "none";
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
     document.getElementById("tochange").innerHTML = "Displaying All Peer Teachers";

  document.getElementById("available view").style.display = "none";
  document.getElementById("schedule changes view").style.display = "none";
  document.getElementById("classnum view").style.display = "none";
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
     document.getElementById("tochange").innerHTML = "Displaying Peer Teacher Schedule Changes";

  document.getElementById("available view").style.display = "none";
  document.getElementById("all view").style.display = "none";
  document.getElementById("classnum view").style.display = "none";
  // select schedule changes button, other buttons default color
  document.getElementById("available button").classList.remove("btn-link-active");
  document.getElementById("available button").classList.add("btn-link");
  
  document.getElementById("all button").classList.remove("btn-link-active");
  document.getElementById("all button").classList.add("btn-link");
  
  document.getElementById("schedule changes button").classList.remove("btn-link");
  document.getElementById("schedule changes button").classList.add("btn-link-active");
  
  return false;
}


function showclass(classvar)
{
 // alert(classvar);
 

  document.getElementById("tochange").innerHTML = "Displaying Peer Teachers for CSCE " +classvar;
  
  document.getElementById("all view").style.display = "none";
  document.getElementById("available view").style.display = "none";
  document.getElementById("schedule changes view").style.display = "none";
  
  document.getElementById("classnum view").style.display = "block";
  
  var items = document.getElementsByTagName('div');
  var list = document.getElementsByClassName('col-lg-4 col-md-6 col-sm-12 col-xs-12 selective');
  //var listid = document.getElementById('selective');
  

  //go through all list
  for(var i=0;i<list.length;i++)  
  {
    // Gets each pt, need to check if any of the ids match classvar
    
      var results = list[i].id.split(" ");
      //console.log(results.length);
      //correct
      // console.log(results.length);
      //potential bug displays 3 for 2 classes
      for(var x =0;x<results.length;x++)
      {
        
        console.log(results[x]);
  
         if(results[x] != classvar)
             {
               console.log("Didnt Match");
        list[i].style.display = 'none';
       // console.log(list[i].id);
              }
              else
              {
                 list[i].style.display = 'block';
                console.log("MATCH");
                break;
              }
      }
     

    console.log("END USER");
  }
  
  // for element in test find its id and then if id = classvar  display, otherwise hide the block?
 
  /*
  
  for(var i = items.length;i--;)
  {
    
    var iter = list[i].getElementById(classvar);
   // alert(items[i].id)
    if(iter == classvar)
    {
     // items[i].style.display = 'block';
     alert("Found element that matches classvar");
    }
    else
    {
      alert("No Match Found");
     //items[i].style.display = 'none';
    }
    
  }
  
  
  */
  return false;
  
}
