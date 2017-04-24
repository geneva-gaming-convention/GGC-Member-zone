$(document).ready(function() {
  select_first_tab();
  tab_listener();
  set_tab_from_hash();
});

function select_first_tab(){
  if($("#game_tabs").length > 0) {
    $('#game_tabs a:first').tab('show');
  }
}

function tab_listener(){
  $('#game_tabs a').click(function (e) {
    tab_url = $(this).tab().attr("href");
    set_url_hash(tab_url);
  })
}

function set_tab_from_hash(){
  hash = get_url_hash();
  console.log($(hash).length);
  if(hash != null) {
    proper_hash_name = hash.replace(/[^a-zA-Z ]/g, "");
    console.log('#game_tabs #tab_btn_'+proper_hash_name);
    $('#game_tabs #tab_btn_'+proper_hash_name).tab('show');
  }
}

function get_url_hash(){
  if(window.location.hash) {
    return window.location.hash;
  }else{
    return null;
  }
}

function set_url_hash(data){
  window.location.hash = data;
}
