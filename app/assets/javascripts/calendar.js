function fullCalendar(){
  $('#calendar').fullCalendar({
    defaultView: "agendaWeek",
    //theme: true,
    height: "auto",
    //themeButtonIcons: false,
    header: {
      left: 'prev,today,next',
      center: 'title',
      right: 'month,agendaWeek'//,agendaDay'
    },
    dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
    monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
    monthNames: ['Janeiro', 'Fevereiro', 'Marco', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
    allDaySlot: false,
    slotDuration: "01:00:00",
    axisFormat: 'HH:mm',
    timeFormat: 'HH:mm',
    titleFormat: 'MMMM YYYY',
    minTime: gon.calendar_hours[0],
    maxTime: gon.calendar_hours[1],
    scrollTime: "00:00:00",
    views: {
      week: {
        columnFormat: 'ddd D'
      }
    },
    buttonText: {
      today: 'hoje',
      month: 'mes',
      week: 'semana',
      day: 'dia'
    },
    events: '/fullcalendar_events.json',
    eventColor: '#1484E6'

  });
}
jQuery(document).on("ready page:change", function() { fullCalendar(); });
