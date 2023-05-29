package com.yh.book.springboot.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

@RestController
@RequestMapping("/api")
public class WeatherApiController {

    @GetMapping("/weather")
    public String restApiGetWeather() throws Exception {
        /*
            @ 공공데이터 기상청 API LIST
            getUltraSrtNcst 초단기실황조회
            getUltraSrtFcst 초단기예보조회
            getVilageFcst 동네예보조회
            getFcstVersion 예보버전조회
        */
        String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
                + "?serviceKey=%2FMLDHFU3P5hUGUPGoUcc8BFqpgv4rf1dul8%2FTG3bs4sNFAnmpKVNkwSiiCdW%2FSNMSWI8WwESbtlz2L%2FoEwSXUA%3D%3D"
                + "&dataType=JSON"            // JSON, XML
                + "&numOfRows=100"             // 페이지 ROWS
                + "&pageNo=1"                 // 페이지 번호
                + "&base_date=" + getCurrentDate()    // 발표일자
                + "&base_time=" + getCurrentTime()    // 발표시각
                + "&nx=61"                    // 예보지점 X 좌표
                + "&ny=125";                  // 예보지점 Y 좌표

        HashMap<String, Object> resultMap = getDataFromJson(url, "UTF-8", "get", "");

        System.out.println("# RESULT : " + resultMap);

        JSONObject jsonObj = new JSONObject();

        jsonObj.put("result", resultMap);

        return jsonObj.toString();
    }

    // 현재 날짜 가져오기
    public String getCurrentDate() {
        Calendar calendar = Calendar.getInstance();
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        int minute = calendar.get(Calendar.MINUTE);

        if ((hour >= 0 && hour < 2) || (hour == 2 && minute < 20)) {
            // 00:00 ~ 02:19 사이에는 이전 날짜로 설정
            calendar.add(Calendar.DAY_OF_MONTH, -1);
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        return dateFormat.format(calendar.getTime());
    }

    // 현재 시간 가져오기
    public String getCurrentTime() {
        Calendar calendar = Calendar.getInstance();
        int hour = calendar.get(Calendar.HOUR_OF_DAY);

        if (hour >= 0 && hour < 3) {
            return "2300";
        } else if (hour >= 3 && hour < 6) {
            return "0200";
        } else if (hour >= 6 && hour < 9) {
            return "0500";
        } else if (hour >= 9 && hour < 15) {
            return "0800";
        } else if (hour >= 15 && hour < 18) {
            return "1400";
        } else if (hour >= 18 && hour < 21) {
            return "1700";
        } else if (hour >= 21 && hour < 24) {
            return "2000";
        } else {
            // 해당하는 구간이 없는 경우 기본값으로 "0200" 반환
            return "0200";
        }
    }

    // API 호출 및 결과 데이터 가져오기
    public HashMap<String, Object> getDataFromJson(String url, String encoding, String type, String jsonStr) throws Exception {
        boolean isPost = false;

        if ("post".equals(type)) {
            isPost = true;
        } else {
            url = "".equals(jsonStr) ? url : url + "?request=" + jsonStr;
        }

        return getStringFromURL(url, encoding, isPost, jsonStr, "application/json");
    }

    public HashMap<String, Object> getStringFromURL(String url, String encoding, boolean isPost, String parameter, String contentType) throws Exception {
        URL apiURL = new URL(url);

        HttpURLConnection conn = null;
        BufferedReader br = null;
        BufferedWriter bw = null;

        HashMap<String, Object> resultMap = new HashMap<String, Object>();

        try {
            conn = (HttpURLConnection) apiURL.openConnection();
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);
            conn.setDoOutput(true);

            if (isPost) {
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", contentType);
                conn.setRequestProperty("Accept", "*/*");
            } else {
                conn.setRequestMethod("GET");
            }

            conn.connect();

            if (isPost) {
                bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
                bw.write(parameter);
                bw.flush();
                bw = null;
            }

            br = new BufferedReader(new InputStreamReader(conn.getInputStream(), encoding));

            String line = null;

            StringBuffer result = new StringBuffer();

            while ((line=br.readLine()) != null) result.append(line);

            ObjectMapper mapper = new ObjectMapper();

            resultMap = mapper.readValue(result.toString(), HashMap.class);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(url + " interface failed" + e.toString());
        } finally {
            if (conn != null) conn.disconnect();
            if (br != null) br.close();
            if (bw != null) bw.close();
        }

        return resultMap;
    }
}