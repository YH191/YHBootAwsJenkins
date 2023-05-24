<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<%@ include file="layout/header.jspf" %>
<script src="${pageContext.request.contextPath}/resources/js/fullcalendar.global.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/echarts.min.js"></script>


<body>
<div id="main-content-wrapper">
  <div id="left-container">
    <div id="calendar"></div>
  </div>
  <div id="right-container">
    <div id="chart-container"></div>
    <div id="weather-info"></div>
  </div>
<div>
</body>

<script>
document.addEventListener('DOMContentLoaded', function () {
  /* 달력 */
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    events: '${pageContext.request.contextPath}/resources/data/events.json',
    locale: 'ko', // 언어를 한글로 설정
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
              <%--
                  console.log("success == >");
                  console.log(data);
              --%>

                  // 차트 데이터 추출
                  var chartData = data.result.response.body.items.item;
                  console.log(chartData)

                  // 필요한 데이터 추출
                  var timeData = [];
                  var tmpData = [];
                  var popData = [];
                  var rehData = [];
                  var currentDate = new Date().toISOString().slice(0, 10).replace(/-/g, "");

                  for (var i = 0; i < chartData.length; i++) {
                      var item = chartData[i];
                      if (item.fcstDate === currentDate) {
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
                    xAxis: {
                      type: 'category',
                      data: ['기온', '강수확률', '습도'],
                    },
                    yAxis: {
                      type: 'value',
                      axisLabel: {
                        formatter: function (value, index) {
                          if (index === 0) {
                            return value + '℃';
                          } else if (index === 1) {
                            return value + '%';
                          } else {
                            return value;
                          }
                        },
                      },
                    },
                    series: [
                      {
                        name: '데이터',
                        data: [
                          { value: parseFloat(tmpData[0]), unit: '℃' },
                          { value: parseFloat(popData[0]), unit: '%' },
                          { value: parseFloat(rehData[0]), unit: '%' },
                        ],
                        type: 'bar',
                        label: {
                          show: true,
                          position: 'top',
                          formatter: function (params) {
                            return params.value + params.data.unit;
                          },
                        },
                      },
                    ],
                  };

                  chart.setOption(options);
              } else {
              <%--
                  console.log("fail == >");
                  console.log(data);
              --%>
              }
          },
      });
  }

  weather();

    // 차트 컨테이너 엘리먼트를 가져옵니다.
    var chartContainer = document.getElementById('chart-container');

    // 차트 높이를 동적으로 계산하여 설정하는 함수
    function setChartHeight() {
      // 현재 화면의 높이를 가져옵니다.
      var screenHeight = window.innerHeight;

      // 초기 크기로 설정할 높이를 지정합니다.
      var initialHeight = 420;

      // 차트 컨테이너의 높이를 계산합니다.
      var chartHeight = Math.min(screenHeight - 20, initialHeight); // 필요한 여백을 고려하여 계산합니다.

      // 차트 컨테이너의 높이를 설정합니다.
      chartContainer.style.height = chartHeight + 'px';
    }

    // 초기 로드 시 차트 높이 설정
    setChartHeight();

    // 창 크기 변경 시 차트 높이 재조정
    window.addEventListener('resize', function() {
      setChartHeight();
    });

});
</script>
<%@ include file="layout/footer.jspf" %>
</html>
