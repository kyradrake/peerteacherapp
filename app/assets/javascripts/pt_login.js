function showChangeDiv() {
  document.getElementById("schedule change view").style.display = "block";
  document.getElementById("pt view").style.display = "none";
  return false;
}

function showPTDiv() {
  document.getElementById("pt view").style.display = "block";
  document.getElementById("schedule change view").style.display = "none";
  return false;
}

function showCancelForm() {
  document.getElementById("cancel form").style.display = "block";
  document.getElementById("schedule form").style.display = "none";
  return false;
}

function showScheduleForm() {
  document.getElementById("schedule form").style.display = "block";
  document.getElementById("cancel form").style.display = "none";
  return false;
}

