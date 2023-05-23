<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<%@ include file="layout/header.jspf" %>
<script src="${pageContext.request.contextPath}/resources/js/fullcalendar.global.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/echarts.min.js"></script>
<style>
#left-container {
  float: left;
  width: 44%;
  height: 400px;
}
#right-container {
  float: left;
  width: 54%;
  height: 400px;
}

#calendar a {
  color: black;
}

#calendar .fc-day-sun a {
  color: red;
}

#chart-container {
  width: 100%;
  height: 100%;
}
</style>

<body>
  <div id="left-container">
    <div id="calendar"></div>
  </div>
  <div id="right-container">
    <div id="chart-container"></div>
    <div id="weather-info"></div>
  </div>
</body>

<script>
document.addEventListener('DOMContentLoaded', function () {
  /* 달력 */
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    events: '${pageContext.request.contextPath}/resources/data/events.json',
  });
  calendar.render();

  /* 날씨 */
  function weather() {
      jQuery.ajax({
          url: "/api/weather",
          type: "get",
          timeout: 30000,
          contentType: "application/json",
          dataType: "json",
          success: function(data, status, xhr) {
              let dataHeader = data.result.response.header.resultCode;

              if (dataHeader == "00") {
                  console.log("success == >");
                  console.log(data);

                  // 차트 데이터 추출
                  var chartData = data.result.response.body.items.item;

                  // 필요한 데이터 추출
                  var timeData = [];
                  var tmpData = [];
                  var popData = [];
                  var rehData = [];

                  for (var i = 0; i < chartData.length; i++) {
                      var item = chartData[i];
                      if (item.fcstDate === "20230523") {
                          timeData.push(item.fcstTime);
                          if (item.category === "TMP") {
                              tmpData.push(item.fcstValue);
                          }
                          if (item.category === "POP") {
                              popData.push(item.fcstValue);
                          }
                          if (item.category === "REH") {
                              rehData.push(item.fcstValue);
                          }
                      }
                  }

                  // 차트 설정
                  var chartContainer = document.getElementById('chart-container');
                  var chart = echarts.init(chartContainer);

                  var options = {
                      title: {
                          text: '5월 23일',
                      },
                      xAxis: {
                          type: 'category',
                          data: ['기온', '강수확률', '습도'],
                      },
                      yAxis: {
                          type: 'value',
                      },
                      tooltip: {
                          trigger: 'axis', // 툴팁을 축에 따라 표시
                      },
                      series: [
                          {
                              name: '데이터',
                              data: [tmpData[0], popData[0], rehData[0]],
                              type: 'bar',
                              label: {
                                  show: true, // 라벨 표시
                                  position: 'top', // 라벨 위치: 막대 위쪽
                                  formatter: '{c}', // 라벨 형식: 데이터 값만 표시
                              },
                          },
                      ],
                  };

                  chart.setOption(options);
              } else {
                  console.log("fail == >");
                  console.log(data);
              }
          },
      });
  }

  weather();
});
</script>
<%@ include file="layout/footer.jspf" %>
</html>
