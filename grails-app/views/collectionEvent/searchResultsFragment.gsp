<g:if test="${collectionEvents}">
  <div id="search-results">
    <g:each in="${collectionEvents}" var="event" status="i">
      <g:set var="rowclass" value="${i % 2 == 0 ? 'even' : 'odd'}"/>
      <table class="${rowclass} collection-event-result" collection_event_id="${i}" lat="${event.latitude}" lng="${event.longitude}" locality="${event.locality}">
        <tr>
          <td class="event-date">${event.eventDate}</td>
          <td class="event-collector">${event.collector}</td>
          <td class="event-political-region">
            ${event.state}
            <g:if test="${event.state && event.country}">
              <span>, </span>
            </g:if>
            ${event.country}
          </td>
          <td class="result-select-button">
            <button class="select_event_button" eventId="${event.id}" title="Use all of the information from this collection event">Select&nbsp;event</button>
          </td>
        </tr>
        <tr>
          <td colspan="2" class="event-locality">${event.locality}</td>
          <td class="event-latlong">[${event.latitude}, ${event.longitude}]</td>
          <td class="result-select-button">
            <button class="select_location_button" eventId="${event.id}" title="Use just the locality information from this collection event">Select&nbsp;location</button>
          </td>
        </tr>

      </table>
    </g:each>
  </div>
</g:if>
<g:else>
  <span>There are no matching collection events.</span>
</g:else>

<script type="text/javascript">

  $(".select_event_button").click(function(e) {
    e.preventDefault();
    bindToCollectionEvent($(this).attr("eventId"))
    $.fancybox.close();
  });

  $(".select_location_button").click(function(e) {
    e.preventDefault();
    bindToCollectionEventLocality($(this).attr("eventId"))
    $.fancybox.close();
  });

  event_map.removeMarkers();

  $(".collection-event-result").each(function(e) {

    var elementId = $(this).attr('collection_event_id')

     if (event_map) {
        try {
            event_map.addMarker({
              lat: $(this).attr('lat'),
              lng: $(this).attr('lng'),
              title: $(this).attr('locality'),
              collection_event_id: elementId,
              animation: google.maps.Animation.DROP,
              mouseover: function(e, y) {

                $('table[collection_event_id="' + elementId + '"]').css("background", "orange");

                var container = $('#search_results');
                var scrollTo = $('table[collection_event_id="' + elementId + '"]');
                container.scrollTop(
                    scrollTo.offset().top - container.offset().top + container.scrollTop() - 20
                );

              },
              mouseout: function(e, y) {
                $('table[collection_event_id="' + elementId + '"]').css("background", "");

              }
            });

            event_map.fitZoom();
        } catch (ex) {

       }
     }
  });

  $('.collection-event-result').mouseenter(function(e) {
    var eventId = $(this).attr('collection_event_id');
    if (eventId) {
      $(this).css("background", "orange");
      setMarkerAnimation(eventId, google.maps.Animation.BOUNCE);
    }
  });

  $('.collection-event-result').mouseleave(function(e) {
    var eventId = $(this).attr('collection_event_id');
    if (eventId) {
      $(this).css('background', '');
      setMarkerAnimation(eventId, null);
    }
  });

  function setMarkerAnimation(eventId, animation) {
      // Find the marker...
      for (index in event_map.markers) {
        var marker = event_map.markers[index];
        if (marker.collection_event_id == eventId) {
          marker.setAnimation(animation);
          break;
        }
      }
  }


</script>

<style type="text/css">

  .select_event_button, .select_location_button {
    width: 100%;
  }

  .even {
    background: #F0F0E8
  }

  .result-select-button {
    width: 100px;
  }

  .event-date {
    width: 80px;
    font-weight: bold;
  }

  .event-locality {

  }

  .event-latlong {
    text-align: right !important;
  }

  #search-results td {
    text-align: left;
    padding: 5px;
  }

  .event-collector {
    font-weight: bold;
  }

  .event-political-region {
    text-align: right !important;
  }

</style>