<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
      height: 400px; /* 예시로 400px로 설정합니다. 필요에 따라 조정 가능합니다. */
    }

    #calendar a {
      color: black;
    }

    #calendar .fc-day-sun a {
      color: red;
    }

    #chart-container {
      width: 100%;
      height: 100%; /* ECharts 그래프 영역을 right-container에 맞게 설정합니다. */
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
      var calendarEl = document.getElementById('calendar');
      var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        events: '${pageContext.request.contextPath}/resources/data/events.json',
      });
      calendar.render();

      var chartContainer = document.getElementById('chart-container');
      var chart = echarts.init(chartContainer);

      var options = {
        xAxis: {
          type: 'category',
          data: ['월', '화', '수', '목', '금', '토', '일'],
        },
        yAxis: {
          type: 'value',
        },
        series: [
          {
            data: [120, 200, 150, 80, 70, 110, 130],
            type: 'line',
            symbol: 'triangle',
            symbolSize: 20,
            lineStyle: {
              color: '#5470C6',
              width: 4,
              type: 'dashed',
            },
            itemStyle: {
              borderWidth: 3,
              borderColor: '#EE6666',
              color: 'yellow',
            },
          },
        ],
      };

      chart.setOption(options);

    /*날씨*/
    function weather() {
        jQuery.ajax({
            url : "/api/weather",
            type : "get",
            timeout: 30000,
            contentType: "application/json",
            dataType : "json",
            success : function(data, status, xhr) {

                let dataHeader = data.result.response.header.resultCode;

                if (dataHeader == "00") {
                   console.log("success == >");
                   console.log(data);
                } else {
                   console.log("fail == >");
                   console.log(data);
                }
            },
            error: function (xhr, status, error) {
                console.log("error == >");
                console.log(error);
            }
        });
    }

weather();

    });
  </script>
  <%@ include file="layout/footer.jspf" %>
</html>
