$(document).ready(function() {
  disable_listener();
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
