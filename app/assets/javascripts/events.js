$(document).ready(function() {
  select_first_tab();
});

function select_first_tab(){
  if($("#game_tabs").length > 0) {
    $('#game_tabs a:first').tab('show');
  }
}
