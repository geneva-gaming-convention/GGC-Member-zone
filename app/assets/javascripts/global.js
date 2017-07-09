$(document).ready(function() {
  disable_listener();
  init_tooltips();
});

function disable_listener(){
  $( ".disable_on_clic" ).click(function() {
    var button = $(this);
    button.prop('disabled', true);
    setTimeout( function () {
      button.closest("form").submit();
    }, 100);
  });
}

function init_tooltips(){
  if($('[data-toggle="tooltip"]').length ){
    $('[data-toggle="tooltip"]').tooltip();
  }
}
