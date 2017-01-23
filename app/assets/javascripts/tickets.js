$(function(){
  $('#ticket_status').on('change',function(){
    var status = $(this).val();
    if(status == ""){
      elements_to_hide($('.cancelled_wrapper,.completed_wrapper'));
      clear_elements($('#ticket_cancelled_other_description,#ticket_comments'));
    }
    else if(status == "cancelled"){
      elements_to_hide($('.completed_wrapper'));
      elements_to_show($('.cancelled_wrapper,#ticket_cancelled_reason,.cancelled_other_desc'));
      clear_elements($('#ticket_cancelled_other_description,#ticket_comments'));
    }
    else if(status == 'completed'){
      elements_to_hide($('.cancelled_wrapper'));
      elements_to_show($('.completed_wrapper,#ticket_comments'));
      clear_elements($('#ticket_cancelled_other_description,#ticket_comments'));
    }
  });

  $('#ticket_cancelled_reason').on('change',function(){
    ($(this).val() == "others") ? remove_hide('.cancelled_other_desc') : apply_hide('.cancelled_other_desc');
    clear_elements($('#ticket_cancelled_other_description'));
  });
});

function elements_to_show(items){
  items.each(function(){
    if($(this).length) remove_hide(this);
  });
}

function elements_to_hide(items){
  items.each(function(){
    if($(this).length) apply_hide(this);
  });
}

function apply_hide(element){
  $(element).addClass('hide').removeClass('show');
}

function remove_hide(element){
  $(element).addClass('show').removeClass('hide');
}

function clear_elements(items){
  items.each(function(){
    if($(this).length) $(this).val("");
  });
}
