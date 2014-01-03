# This is literate coffeescript

Some kind of description.

    $(document).ready ->
      $("button").click (event) ->
        title = $(this).html()
        alert "You clicked the #{title} button."

More markdown content afterwards.
