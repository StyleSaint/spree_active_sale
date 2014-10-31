$(document).ready(function() {
  $("[data-timer]").each(function() {
    var cTime = $(this).attr('data-timer');
    var timeLayout = $(this).attr('data-layout');
    // endTime for event in db and should be with timezone, like 2014-10-30T05:04:00-0700:
    var endTime = new Date(cTime);

    $(this).countdown({
      until: endTime,
      compact: false,
      layout: timeLayout,
      labels0: ['Year', 'Month', 'Week', 'Day', 'Hour', 'Minute', 'Second'],
      onExpiry: function() {
        window.location.reload();
      }
    });
  });
});