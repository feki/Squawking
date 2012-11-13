jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

jQuery -> 
  for link in $(".navbar a")
    do (link) ->
      if (window.location.pathname == link.pathname)
        $(link).parent().toggleClass("active")
