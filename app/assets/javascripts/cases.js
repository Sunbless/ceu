$(function() {
  $('.datepicker').datepicker({ dateFormat: 'yy-mm-dd',changeMonth: true, changeYear: true, yearRange: '1900:+0' });
  $('#case_date_of_birth').on('change',function(data){
    var curDate = new Date();
    var dateOfBirth = new Date(this.value);
    var raz = curDate.getFullYear() - dateOfBirth.getFullYear();
    $('#case_age').val(raz);
  });
  
  // var full_phi_list = $('#tmp_phi');
  // $('#case_district_id').on('change',function(){
  //   fullClone = full_phi_list.clone();
  //   var children = $(fullClone).children('[data-district="'+$(this).val()+'"]');
  //   if (children.length == 0){
  //     children = $(fullClone).children();
  //   }
  //   $('#phi_id option').remove();
  //   $('#phi_id').append(children);
  // });

  $('.openModal').on('click',function(){
    var modalName = $(this).attr('data-modal');
    $(modalName).modal('show');
  });

  $('.addNewDoctor').on('click',function(){
    $('#newFakeUser .error').remove();
    var firstname = $('#dfirstname').val();
    var surname = $('#dsurname').val();
    var email = $('#demail').val() ? $('#demail').val() : false;
    if (firstname && surname){
      var data = { user: {name: firstname, surname: surname, email: email, user_type: 1 }};
      $.ajax({
        type: "POST",
        url: '/users',
        data: JSON.stringify(data),
        dataType: "json",
        contentType: "application/json",
        processData: false,
      }).done(function(response){
        var user_id = response.id;
        var name = "Dr. " + response.name + " " + response.surname;
        $('#case_user_id').append("<option value=\"" + user_id + "\">"+name+"</option>");
        $('#case_user_id').val(user_id);
        $('#newFakeUser').modal('hide');
      }).error(function(error){
        $('#newFakeUser .modal-body').prepend('<p class="error text-error">Greška: neispravni ili već postojeći podaci!</p>');
      });
    } else {
      $('#newFakeUser .modal-body').prepend('<p class="error text-error">Morate popuniti ime i prezime doktora!</p>');
    }
    
  });

  $('.addNewAgent').on('click',function(){
    $('#newAgent .error').remove();
    var agent = $('#aname').val();
    if (agent){
      var data = { agent: {agent: agent} };
      $.ajax({
        type: "POST",
        url: '/agents',
        data: JSON.stringify(data),
        dataType: "json",
        contentType: "application/json",
        processData: false,
      }).done(function(response){
        $('#case_agent_id').append("<option value=\"" + response.id + "\">"+response.agent+"</option>");
        $('#case_agent_id').val(response.id);
        $('#newAgent').modal('hide');
      }).error(function(error){
        $('#newFakeUser .modal-body').prepend('<p class="error text-error">Greška pri kreiranju nove dijagnoze!</p>');
      });
    } else {
      $('#newFakeUser .modal-body').prepend('<p class="error text-error">Morate popuniti naziv dijagnoze!</p>');
    }
  });

  $('.addNewLaboratory').on('click',function(){
    $('#newLaboratory .error').remove();
    var name = $('#lname').val();
    var municipality_id = $('#lmunicipality_').val();
    if (name && municipality_id){
      var data = { laboratory: {name: name, municipality_id: municipality_id} };
      $.ajax({
        type: "POST",
        url: '/laboratories',
        data: JSON.stringify(data),
        dataType: "json",
        contentType: "application/json",
        processData: false,
      }).done(function(response){
        $('#case_laboratory_id').append("<option value=\"" + response.id + "\">"+response.name+"</option>");
        $('#case_laboratory_id').val(response.id);
        $('#newLaboratory').modal('hide');
      }).error(function(error){
        $('#newLaboratory .modal-body').prepend('<p class="error text-error">Greška pri kreiranju nove laboratorije!</p>');
      });
    } else {
      $('#newLaboratory .modal-body').prepend('<p class="error text-error">Morate popuniti naziv i lokaciju laboratorije!</p>');
    }
  });

$('.addNewHes').on('click',function(){
    $('#newHes .error').remove();
    var name = $('#hname').val();
    var code = $('#hcode').val();
    var center_id = $('#center_id_').val();
    var chief_id = $('#chief_id_').val();
    var nurse_id = $('#nurse_id_').val();
    if (name && center_id){
      var data = { he: {name: name, code: code, center_id: center_id, chief_id: chief_id, nurse_id: nurse_id} };
      $.ajax({
        type: "POST",
        url: '/hes',
        data: JSON.stringify(data),
        dataType: "json",
        contentType: "application/json",
        processData: false,
      }).done(function(response){
        $('#case_he_id').append("<option value=\"" + response.id + "\">"+response.name+"</option>");
        $('#case_he_id').val(response.id);
        $('#newHes').modal('hide');
      }).error(function(error){
        $('#newHes .modal-body').prepend('<p class="error text-error">Greška pri kreiranju novog odjela/HES!</p>');
      });
    } else {
      $('#newHes .modal-body').prepend('<p class="error text-error">Morate popuniti naziv i instituciju!</p>');
    }
  });
});