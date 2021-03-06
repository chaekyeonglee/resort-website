<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<%
    // 마지막 방문일을 저장하고 있는 쿠키를 저장할 객체
    Cookie lastVisit = null;
   
    // 화면에 출력할 메시지를 저장할 문자열 변수
    String msg = "";
   
    // 마지막 방문일을 저장하고 있는 쿠키가 존재하는지를 판별할 변수
    boolean isCookie = false;
   
    // 현재 시간을 저장
    String currentTime = "" + System.currentTimeMillis();
   
    // 쿠키를 얻는다.
    Cookie[] cookies = request.getCookies();
   
    // 마지막 방문 일을 정하고 있는 쿠키를 검색(쿠키 값이 없으면 에러가 날 수 있기때문에 조치를 취함)
    if (cookies != null) {
       
        for (int i = 0; i < cookies.length; i++) {
           	// 쿠키의 마지막 값이 저장되면 그것을 사용할 것 이다.(마지막 방문일)
        	lastVisit = cookies[i];
           	
            // 쿠키값의 마지막이라면 멈춘다
            if (lastVisit.getName().equals("lastdateCookie")) {
               
            	isCookie = true;
                break;
            }
        }
    }
   
    // 처음 방문일 경우 새 쿠키 생성
    if (!isCookie) {    
       
        msg = "첫 방문을 감사드립니다~!";
   
        // 쿠키 객체를 생성하여 마지막 방문일에 넣어준다.
        lastVisit = new Cookie("lastdateCookie", currentTime);
       
        // 쿠키 속성값을 설정
        lastVisit.setMaxAge(365*24*60*60);    // 365일
        // 쿠키의 유효한 디렉토리 설정
        //lastVisit.setPath("/");
       
        // 쿠키를 추가
        response.addCookie(lastVisit);
    }
   
    else {    // 이미 방문한 적이 있는 클라이언트라면
       	
    	// 마지막 방문일(lastVist)값을 알아내어 long값으로 저장
        long value = new Long(lastVisit.getValue()).longValue();
   		
        // 방문시간을 출력할 수 있도록 msg 변수에 저장
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일HH시mm분ss초");
    	msg = sdf.format(value);
     
        // 쿠키에 새 값을 추가
        lastVisit.setValue(currentTime);
       
        // 쿠키를 추가
        response.addCookie(lastVisit);
    }
%>
<!DOCTYPE html>
<html>
	<head>
		<title> 방문시간 조회 </title>
	</head>
	<body>
		<h2><%= msg %></h2>
	</body>
</html>