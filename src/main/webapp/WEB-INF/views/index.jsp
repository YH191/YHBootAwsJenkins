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
document.addEventListener('DOMContentLoaded', function() {
    /* 달력 */
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        events: '${pageContext.request.contextPath}/resources/data/events.json',
        locale: 'ko', // 언어를 한글로 설정
        eventMouseEnter: function (mouseEnterInfo) {
            // 마우스가 이벤트 위로 올라갔을 때 실행되는 콜백 함수
            // 이벤트 내용을 표시하는 작업을 수행합니다.
            var event = mouseEnterInfo.event;
            var tooltipContent = event.title; // 이벤트의 제목을 tooltip 내용으로 설정합니다.

            // tooltip을 생성하고 표시합니다.
            $(mouseEnterInfo.el).tooltip({
                title: tooltipContent,
                placement: 'top',
                trigger: 'hover',
                container: 'body'
            });
        }
    });
    calendar.render();

    /* 날씨 */
    function weather() {
        // 로딩 표시 추가
        var chartContainer = document.getElementById('chart-container');
        var loadingOption = {
            text: '로딩 중...',  // 로딩 메시지
            color: '#c23531',    // 로딩 표시의 색상
            textColor: '#000',   // 로딩 표시의 텍스트 색상
            maskColor: 'rgba(255, 255, 255, 0.8)',  // 로딩 표시의 배경색 및 투명도
        };
        var chart = echarts.init(chartContainer);
        chart.showLoading(loadingOption);

        // ajax 데이터 받아오기 실패 시 사용할 변수
        var retryCount = 0;
        var maxRetryCount = 3;

        function requestWeatherData() {
            jQuery.ajax({
                url: "/api/weather",
                type: "get",
                timeout: 30000,
                contentType: "application/json",
                dataType: "json",
                success: function(data, status, xhr) {
                    let dataHeader = data.result.response.header.resultCode;

                    if (dataHeader == "00") {
                        // 성공적으로 데이터를 받아온 경우
                        var chartData = data.result.response.body.items.item;
                        // console.log(chartData);

                        var formattedDate = new Date();
                        var year = formattedDate.getFullYear();
                        var month = formattedDate.getMonth() + 1;
                        var day = formattedDate.getDate();

                        if (month < 10) {
                          month = "0" + month;
                        }
                        if (day < 10) {
                          day = "0" + day;
                        }

                        var currentDate = year + month + day;
                        var currentHour = new Date().getHours().toString().padStart(2, '0') + "00";

                        var filteredData = chartData.filter(function(item) {
                            return item.fcstDate === currentDate && item.fcstTime === currentHour;
                        });

                        if (filteredData.length > 0) {
                            var timeData = [];
                            var tmpData = [];
                            var popData = [];
                            var rehData = [];

                            for (var i = 0; i < filteredData.length; i++) {
                                var item = filteredData[i];
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

                            var options = {
                                xAxis: {
                                    type: 'category',
                                    data: ['기온', '강수확률', '습도'],
                                },
                                yAxis: {
                                    type: 'value',
                                    axisLabel: {
                                        formatter: function(value, index) {
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
                                series: [{
                                    name: '데이터',
                                    data: [{
                                        value: parseFloat(tmpData[0]),
                                        unit: '℃'
                                    }, {
                                        value: parseFloat(popData[0]),
                                        unit: '%'
                                    }, {
                                        value: parseFloat(rehData[0]),
                                        unit: '%'
                                    }],
                                    type: 'bar',
                                    label: {
                                        show: true,
                                        position: 'top',
                                        formatter: function(params) {
                                            return params.value + params.data.unit;
                                        },
                                    },
                                }],
                            };

                            // 데이터 표시 후 로딩 표시 제거
                            chart.setOption(options);
                            chart.hideLoading();
                        } else {
                            // 데이터 요청은 성공했지만 데이터가 없거나 오류가 있는 경우
                            console.log("No data available for the current hour.");

                            // chart-container에 실패 메시지 표시
                            jQuery('#chart-container').html('데이터를 불러오는데 실패했습니다.');

                            // 로딩 표시 제거
                            chart.hideLoading();
                        }
                    } else {
                        // 데이터 요청은 성공했지만 데이터가 없거나 오류가 있는 경우
                        console.log("No data available for the current hour.");

                        // chart-container에 실패 메시지 표시
                        jQuery('#chart-container').html('데이터를 불러오는데 실패했습니다.');

                        // 로딩 표시 제거
                        chart.hideLoading();
                    }
                },
                error: function(xhr, status, error) {
                    // 데이터 요청에 실패한 경우
                    console.log("Request failed: " + error);

                    if (retryCount < maxRetryCount) {
                        // 재시도 가능한 횟수를 초과하지 않았으면 재시도
                        retryCount++;
                        console.log("Retrying request (" + retryCount + " of " + maxRetryCount + ")...");
                        requestWeatherData();
                    } else {
                        // 재시도 횟수를 초과한 경우 실패 메시지 표시
                        console.log("Max retry count exceeded. Failed to retrieve data.");

                        // chart-container에 실패 메시지 표시
                        jQuery('#chart-container').html('데이터를 불러오는데 실패했습니다.');

                        // 로딩 표시 제거
                        chart.hideLoading();
                    }
                }
            });
        }

        requestWeatherData();
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
