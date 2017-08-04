$(document).ready(function() {
  add_new_phone_submit_listener();
  add_phone_input_listener();
});

function add_phone_input_listener(){
  $("#user_phone").keyup(function(e) {
    phone_input_changed(e);
  });
}

function phone_input_changed(e){
  phone = $(e.target).val();
  if(phone && phone.length >= 10){
    $('#submit_btn_phone').prop('disabled', false);
  }else{
    $('#submit_btn_phone').prop('disabled', true);
  }
}

function add_new_phone_submit_listener(){
  $("#submit_btn_phone").click(function() {
    submit_form_new_phone();
  });
}

function submit_form_new_phone(){
  var $form = $("#new_phone_form");
  url = $form.attr('action');
  method = "put";
  data_to_send = $form.serialize();
  $.ajax({
    url: url,
    type: method,
    dataType: "json",
    data: data_to_send,
    complete : function(resultat){
      console.log(resultat);
      status = resultat.status;
      if(status == "200"){
        $('#new_phone_modal').modal('hide');
        location.reload();
      } else {
        show_notif_failure();
      }
    }
  });
}
