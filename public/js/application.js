$(document).ready(function() {

// jQuery for dynamic form fields
  var startingNo = 1;
  var $node = "";
  for(varCount=0;varCount<=startingNo;varCount++){
    var displayCount = varCount+1;
    $node += '<p><label for="var'+displayCount+'">Option '+displayCount+': </label><input type="text" name="question[var'+displayCount+']" id="var'+displayCount+'" class="needs_clear"><span class="removeVar">Remove Option</span></p>';
  }
  $('#createQuestion').prepend($node);

  $('#createQuestion').on('click', '.removeVar', function(){
    $(this).parent().remove();
  });

  $('#addVar').on('click', function(){
    varCount++;
    $node = '<p><label for="var'+varCount+'">Option '+varCount+': </label><input type="text" name="question[var'+varCount+']" id="var'+varCount+'" class="needs_clear"><span class="removeVar">Remove Option</span></p>';
    $(this).parent().before($node);
  });

// Puts question and survey title field at the top of the page, above the options
  $('#createQuestion').prepend("<div><label>Question: </label><input type='text' name='question_title' class='question_title needs_clear'></div>");
  if (window.location.pathname == "/surveys/new") {
    $('#createQuestion').prepend("<div id='survey_title_input'><label>Survey Title: </label><input type='text' name='survey_title' ></div>");
  };

// Ajax for create question

  $('#createQuestion').on('submit', function(event){
    event.preventDefault();
    var data = $("#createQuestion").serialize(),
        url = '/survey',
        title = $('input[name="survey_title"]').val();
    $("#createQuestion input[type=text]").val("");
    $.post(url, data, function(serverResponse, status, jqXHR) {
      $("#main").append(serverResponse);
      $('#survey_title_input').fadeOut();
      $("#title_land_zone").text(title);
    });

  });

// Ajax for delete question

  $('#main').on('submit', '.delete', function(event){
    event.preventDefault();
    var url = event.target.id,
        par = $(event.target).parent()

    $.get(url, function(serverResponse, status, jqXHR) {
      par.fadeOut();
    });
  });

// Ajax for get edit question

  $('#main').on('submit', '.edit', function(event){
    event.preventDefault();
    var url = event.target.id,
        par = $(event.target).parent()

    $.get(url, function(serverResponse, status, jqXHR) {
      par.html(serverResponse)
    });
  });

// Ajax for post edit question

  $('#main').on('submit', '.submit_edit', function(event){
    event.preventDefault();
    var url = event.target.id,
        par = $(event.target).parent(),
        data = $(".submit_edit").serialize()

    $.post(url, data, function(serverResponse, status, jqXHR) {
      par.html(serverResponse)
    });
  });

// Ajax for get edit survey title

  $('#main').on('submit', '.edit_title', function(event){
    event.preventDefault();
    var url = event.target.id,
        par = $(event.target).parent()

    $.get(url, function(serverResponse, status, jqXHR) {
      par.html(serverResponse)
    });
  });

  $('#main').on('submit', '.submit_edit_title', function(event){
    event.preventDefault();
    var url = event.target.id,
        par = $(event.target).parent(),
        data = $(".submit_edit_title").serialize()

    $.post(url, data, function(serverResponse, status, jqXHR) {
      par.html(serverResponse)
    });
  });
  
  $(function() {
   $("#bars li .bar").each( function( key, bar ) {
     var percentage = $(this).data('percentage');

     $(this).animate({
       'height' : percentage + '%'
     }, 1000);
 });

});


});
