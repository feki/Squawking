# # creating reaction ajax events
# jQuery ->
#   $("#create_reaction_form")
#     .live("ajax:beforeSend", (evt, xhr, settings) ->
#       $submitButton = $(this).find('input[name="commit"]');
#       $submitButton.data("origText", $(this).attr("value"));
#       $submitButton.attr("value", "Submitting...");
#       $('div.validation-error').remove();
#       # Update the text of the submit button to let the user know stuff is happening.
#       # But first, store the original text of the submit button, so it can be restored when the request is finished.
# #      $submitButton.data("origText", $(this).attr("value"));
# #      $submitButton.attr("value", "Submitting...");
# #      $('div.validation-error').remove();
#     )
#     .live("ajax:success", (evt, data, status, xhr) ->
# #      $form = $(this);

#       $(new_reaction_form_dialog).dialog("close");

#       # Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
# #      $form.find('textarea').val("");

#       # Insert response partial into page below the form.
#       $('#reactions').append(xhr.responseText);

#     )
#     .live('ajax:complete', (evt, xhr, status) ->
# #      $submitButton = $(this).find('input[name="commit"]');
# #
# #      # Restore the original submit button text
# #      $submitButton.text( $(this).data('origText') );

#       $submitButton = $(this).find('input[name="commit"]')
#       # Restore the original submit button text
#         .attr("value", $(this).data('origText'));
#     )
#     .live("ajax:error", (evt, xhr, status, error) ->
#       $submitButton = $(this).find('input[name="commit"]')
#       # Restore the original submit button text
#         .attr("value", $(this).data('origText'));

#       try
#         # Populate errorText with the comment errors
#         errors = $.parseJSON(xhr.responseText);
#       catch err
#         # If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
#         errors = {message: "Please reload the page and try again"};
      
#       # Build an unordered list from the list of errors
#       errorText = "There were errors with the submission: \n<ul>";

#       for error in Object.keys(errors)
#         errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      
#       errorText += "</ul>";

#       errorText = "<div class='validation-error alert alert-error'>
#         <button type='button' class='close' data-dismiss='alert'>×</button>
#         #{errorText}</div>"

#       # Insert error list
#       $('#create_reaction_form').prepend(errorText);
#     )

# Ajax listeners for deleting answer.
jQuery ->
  $('a[data-action="delete-answer"]')
    .live("ajax:beforeSend", (evt, xhr, settings) ->
      # link to delete action
      $a = $(this);

      # save the original text
      $a.data( 'origText', $(this).text() );

      # set up new link text
      $a.text( "Deleting..." );

      # clean up error messages
      $a.closest('.content_bubble').find('div.delete-error').remove();
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      $a = $(this);
      # remove answer from DOM tree
      $a.closest('.content_bubble').remove();
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

      $(this).closest('.content_bubble').prepend(errorText);
    )

  # editing answer ajax events
  jQuery ->
    $("#edit_answer_form")
      .live("ajax:beforeSend", (evt, xhr, settings) ->
        $submitButton = $(this).find('input[name="commit"]');
        $submitButton.data("origText", $(this).attr("value"));
        $submitButton.attr("value", "Submitting...");
        $('div.validation-error').remove();
      )
      .live("ajax:success", (evt, data, status, xhr) ->
        $(answer_div).replaceWith(xhr.responseText);
        $(answer_form_dialog).dialog("close");
#        article_loation = $("#back_to_article").attr("href");
#        window.location.replace(article_loation)
      )
      .live('ajax:complete', (evt, xhr, status) ->
        $submitButton = $(this).find('input[name="commit"]');
        # Restore the original submit button text
        $submitButton.attr("value", $(this).data('origText'));
      )
      .live("ajax:error", (evt, xhr, status, error) ->
        $submitButton = $(this).find('input[name="commit"]');
        # Restore the original submit button text
        $submitButton.attr("value", "Save");

        try
          errors = $.parseJSON(xhr.responseText);
        catch err
          errors = {message: "Please reload the page and try again"};

        errorText = "There were errors with the submission: \n<ul>";

        for error in Object.keys(errors)
          errorText += "<li>" + error + ': ' + errors[error] + "</li> ";

        errorText += "</ul>";

        errorText = "<div class='validation-error alert alert-error'>
          <button type='button' class='close' data-dismiss='alert'>×</button>
          #{errorText}</div>"

        $('#edit_answer_form').prepend(errorText);
      )
