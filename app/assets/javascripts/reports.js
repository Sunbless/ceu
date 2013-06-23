$(function() {
  var initEntity = $('#entity_entity').val();
  $('#district_9000').hide();
  $('#district_9100').hide();
  $('.district-label').hide();
  if (initEntity){
    $('.district-label').show();
    $('#district_'+initEntity).show();
  }
  $('#entity_entity').on('change',function(){
    $('.district-label').show();
    $('#district_9000').hide();
    $('#district_9100').hide();
    $('#district_'+$(this).val()).show();
  });
});