$(function() {
  $('.datepicker').datepicker({ dateFormat: 'yy-mm-dd',changeMonth: true, changeYear: true, yearRange: '1900:+0' });
  $('#case_date_of_birth').on('change',function(data){
    var curDate = new Date();
    var dateOfBirth = new Date(this.value);
    var raz = curDate.getFullYear() - dateOfBirth.getFullYear();
    $('#case_age').val(raz);
  });
});