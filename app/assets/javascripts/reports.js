$(function() {
  $('#district_9000').hide();
  $('#district_9100').hide();
  $('.district-label').hide();
  $('#entity_').on('change',function(){
    $('.district-label').show();
    $('#district_9000').hide();
    $('#district_9100').hide();
    $('#district_'+$(this).val()).show();
  });
});