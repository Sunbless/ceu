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

  // var sumRegion = $('#region').val();
  $('#region').on('change', function (){
    if ($(this).val() === 'MoCA'){
      $('#sumreport').children('[data-type="w"]').attr('disabled',true);
    } else {
      $('#sumreport').children('[data-type="w"]').attr('disabled',false);
    }
  });

  $('#sumreport').on('change', function () {
    if ($(this).find(':selected').attr('data-type') === 'w'){
      $('.periodvalue').text('Sedmica:');
      //Grrr js nema nativnog nacina da se uzme broj sedmice..
      $('#periodvalue').val($('#periodvalueW').val());
    } else {
      $('.periodvalue').text('Mjesec:');
      var d = new Date();
      var n = d.getMonth();
      $('#periodvalue').val(n);
    }
  });
});