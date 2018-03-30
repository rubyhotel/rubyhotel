# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@retrieveResults = (element) ->
  $.ajax({
    url: "/agg_search",
    data: {aggregator: element.value}
  })
    .done (json) ->
      switch element.value
        when "max", "min", "avg", "sum"
          table_rows = $('<tbody>')
          table_rows.append($('<tr>')
            .append($('<td />', {text: "#{row.cost}"}))
            .append($('<td />', {text: "#{row.numOfGuests}"}))) for row in json
          table_html = $('<table>')
            .append($('<thead>')
              .append($('<tr>')
                .append($('<th />', {text: 'Cost'}))
                  .append($('<th />', {text: 'Number of Guests'}))))
            .append(table_rows)
          $("#agg_table").html table_html
        when "count"
          table_html = $('<table>')
            .append($('<thead>')
              .append($('<tr>')
                .append($('<th />', {text: 'Count'}))))
            .append($('<tbody>')
              .append($('<tr>')
                .append($('<td />', {text: "#{json[0].count}"}))))
          $("#agg_table").html table_html
        else
          $("#agg_table").html ""

@retrieveAggGroupByResults = (element) ->
  $.ajax({
    url: "/agg_group_by_search",
    data: {aggregator: element.value}
  })
    .done (json) ->
      switch element.value
        when "max", "min"
          table_rows = $('<tbody>')
          table_rows.append($('<tr>')
            .append($('<td />', {text: "#{row.locationAddress}"}))
            .append($('<td />', {text: "#{row.avgHourlyRate}"}))) for row in json
          table_html = $('<table>')
            .append($('<thead>')
            .append($('<tr>')
            .append($('<th />', {text: 'Address'}))
            .append($('<th />', {text: 'Average Salary ($/hr)'}))))
            .append(table_rows)
          $("#agg_group_by_table").html table_html
        else
          $("#agg_group_by_table").html ""
