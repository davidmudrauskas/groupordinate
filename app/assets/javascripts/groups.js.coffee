# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $(document).ready ->
    $("#calendar").fullCalendar({
      events: window.location.pathname + '.json'  
    })

    $(".new-shift").on "click", ->
      $(".new-shift").hide()
      $(".form-wrapper").show()

    $(".fc-day").on "click", ->
      $(".new-shift").hide()
      $(".form-wrapper").show()
      
      date = $(this).attr("data-date")
      exploded_date = date.split("-")
      year = exploded_date[0]
      month = exploded_date[1].replace(/^0/, "")
      day = exploded_date[2].replace(/^0/, "")

      $("#shift_start_at_1i").val(year)
      $("#shift_start_at_2i").val(month)
      $("#shift_start_at_3i").val(day)

      $("#shift_end_at_1i").val(year)
      $("#shift_end_at_2i").val(month)
      $("#shift_end_at_3i").val(day)
    
    # TODO: callback to renderEvent on form submission

    $(".group-tab").on "click", ->
      this.attr('class', 'newClass');