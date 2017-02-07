$(document).ready(function() {
  select_radio_div();
});

function select_radio_div(){
  $(".div-radio").click(function(){
    div = $(this)
    radio_input = div.find("input");
    input_name = radio_input.attr("name");
    reset_radio_input(input_name);
    radio_input.attr('checked',true);
    div.addClass("btn-primary active");
  })
}

function reset_radio_input(input_name){
  console.log(input_name);
  input_fields = $('input[name="'+input_name+'"]');
  input_fields.each(function(){
    $(this).attr('checked', false);
    $(this).parent().removeClass("btn-primary active");
  })
}
