function barChart(){
  var subjectNames = [];
  var subjectGrades = [];
  var averageGrades = [];

  for(var i = 0; i < gon.subjects.length; i++){
    subjectNames.push(gon.subjects[i].name);
    if (gon.subjects[i].value === 0) {
      subjectGrades.push(gon.subjects[i].grade);
    } else {
      subjectGrades.push((100 * gon.subjects[i].grade)/gon.subjects[i].value);
    }
    averageGrades.push(60);
  }

  var data = {
    labels : subjectNames,
    datasets : [
      {
        fillColor:"#89C4F4",
        data : subjectGrades
      }
    ]
  }

  var ctx = document.getElementById("canvas").getContext("2d");
  var horizontalBarChart = new Chart(ctx).HorizontalBar(data);

  var options = {
    //barValueSpacing : 10,
    responsive : true,
    //maintainAspectRatio: true
  };

  new Chart(ctx).HorizontalBar(data, options);

}
jQuery(document).on("ready page:change", function() { barChart();});
