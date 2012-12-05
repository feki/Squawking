# creating reaction ajax events
jQuery ->
  $("#create_reaction_form")
    .bind("ajax:beforeSend", (evt, xhr, settings) ->
      $submitButton = $(this).find('input[name="commit"]');

      # Update the text of the submit button to let the user know stuff is happening.
      # But first, store the original text of the submit button, so it can be restored when the request is finished.
      $submitButton.data( 'origText', $(this).text() );
      $submitButton.text( "Submitting..." );
      $('div.validation-error').remove();
    )
    .bind("ajax:success", (evt, data, status, xhr) ->
      $form = $(this);

      # Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
      $form.find('textarea').val("");

      # Insert response partial into page below the form.
      $('#reactions').append(xhr.responseText);

    )
    .bind('ajax:complete', (evt, xhr, status) ->
      $submitButton = $(this).find('input[name="commit"]');

      # Restore the original submit button text
      $submitButton.text( $(this).data('origText') );
    )
    .bind("ajax:error", (evt, xhr, status, error) ->
      try
        # Populate errorText with the comment errors
        errors = $.parseJSON(xhr.responseText);
      catch err
        # If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
        errors = {message: "Please reload the page and try again"};
      
      # Build an unordered list from the list of errors
      errorText = "There were errors with the submission: \n<ul>";

      for error in Object.keys(errors)
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      
      errorText += "</ul>";

      errorText = "<div class='validation-error alert alert-error'>
        <button type='button' class='close' data-dismiss='alert'>×</button>
        #{errorText}</div>"

      # Insert error list
      $('#new-reaction').prepend(errorText);
    )

# Ajax listeners for deleting reaction.
jQuery ->
  $('a[data-action="delete-reaction"]')
    .live("ajax:beforeSend", (evt, xhr, settings) ->
      # link to delete action
      $a = $(this);

      # save the original text
      $a.data( 'origText', $(this).text() );

      # set up new link text
      $a.text( "Deleting..." );

      # clean up error messages
      $a.parent().find('div.delete-error').remove();
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      $a = $(this);
      # remove reaction from DOM tree
      $a.parent().remove();
    )
    .live('ajax:complete', (evt, xhr, status) ->
      # set up link text to original text
      $(this).text( $(this).data('origText') );
    )
    .live("ajax:error", (evt, xhr, status, error) ->
      try
        # try parse errors
        errors = $.parseJSON(xhr.responseText);
      catch err
        errors = {message: "Please reload the page and try again"}
      
      errorText = "There were errors with the submission: \n<ul>";

      for error in Object.keys(errors)
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      
      errorText += "</ul>";

      errorText = "<div class='delete-error alert alert-error'>
        <button type='button' class='close' data-dismiss='alert'>×</button>
        #{errorText}</div>"

      $(this).parent().prepend(errorText);
    )
