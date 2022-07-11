<%@ page import="dto.ReservationDto" %>
<%@ page import="dto.MemberDto" %>
<%@ page import="dao.MovieDao" %>
<%@ page import="dto.MovieDto" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-07-11
  Time: 오후 4:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String id = null;
    Object obj = session.getAttribute("login");
    MemberDto mem = null;
    if (obj != null) {
        mem = (MemberDto) obj;
        id = mem.getId();
    }

    if (id == null)
        id = "";
    else
        System.out.println("***id 확인: " + id + "***");

    MovieDao movieDao = MovieDao.getInstance();
    List<MovieDto> movies = movieDao.getMovies();

%>

<%
    // 1, 'hyewon', 1, 1, '2022-07-10 19:20:00', 2, '서울/월드타워', '토르-러브 앤 썬더', 119, NOW(), 0
    Long reservationId = 1L;
    String memberName = "hyewon";
    Long memberId = 1L;
    Long screenId = 1L;
    Long movieId = 1L;
    int rated = 15;
    String screenTime = "2022-07-10 19:20";
    String screenLocation = "서울/월드타워";
    String movieTitle = "토르-러브 앤 썬더";
    int runtime = 119;
    String reserveTime = "2022-07-11 16:30";
    String seats = "I9I10";

    String imageUrl = "https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202207/18748_103_1.jpg";

    int hour = 19;
    int minute = 20;

    int pHour = runtime / 60;
    int pMinute = (runtime / 60) % 60;

    hour += pHour;
    minute += pMinute;

    if(minute >= 60) {
        hour++;
        minute %= 60;
    }

    String endTime = hour + ":" + minute;

%>
<html>
<head>
    <title>예매 내역 확인</title>

    <!-- css -->
    <link rel="stylesheet" href="assets/css/reset.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/swiper.css">
    <link rel="stylesheet" href="assets/css/style_moviedetail.css">
    <link rel="stylesheet" href="assets/css/style_reservationDetail.css">

    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>

<header id="header">
    <div class="container">
        <div class="row">
            <div class="header clearfix">
                <h1>
                    <a href="main"> <em><img src="assets/img/cute-logo.png" alt="LOTTE"></em> </a>
                </h1>
                <nav id="mNav">
                    <h2 class="ir_so">전체메뉴</h2>
                    <a href="#" class="ham"><span></span></a>
                </nav>
                <nav class="nav">
                    <ul class="clearfix">
                        <li><a href="movie?param=list">영화</a></li>
                        <li><a href="#">영화관</a></li>
                        <li><a href="#">특별관</a></li>
                        <%
                            if (id != "") {
                        %>
                        <li><a href="mypage?param=mypage">마이페이지</a></li>
                        <li><a href="member?param=logout">로그아웃</a></li>
                        <%
                        } else {
                        %>
                        <li><a href="member?param=regi">회원가입</a></li>
                        <li><a href="member?param=login">로그인</a></li>
                        <%
                            }
                        %>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</header>
<!-- //header -->


<div align="center" class="poster_info" style="margin-top: 50px; margin-bottom: 50px;">

    <table class="table">

        <tr>
            <div class="reservation-title">
                <strong>예매가 확정되었습니다!</strong>
            </div>
        </tr>

        <tr>
            <div style="width: 300px; height: 400px; margin: 50px">
                <img src="<%= imageUrl%>" class="movie-image">
            </div>
        </tr>

        <tr>
            <div class="tit_info align-center" style="margin-top: -50px;">
                <span::before class="ic_grade gr_<%= rated%>">만<%= rated%>이상관람가 </span::before>&nbsp;
                <strong style="font-size: 30px; margin-top: 10px;"><%= movieTitle%></strong>
            </div>
            <div style="height:10px;">&nbsp;</div>
        </tr>

        <tr>
            <div class="detail_info1">
                <span class="movie-detail-span"><%= screenLocation%></span>&nbsp;&nbsp;
                <strong class="txt_ic_score ty2">
                    <strong><%= screenTime.split(" ")[1]%> ~ </strong>
                    <strong><%= endTime%></strong>
                    <span class="time_info"><strong>(<%= runtime%></strong>분)</span>&nbsp;&nbsp;&nbsp
                </strong>
            </div>
            <div style="height:10px;">&nbsp;</div>
        </tr>

        <tr>
            <div class="sub_info1">
                <strong>
                    <strong><%= seats %></strong>&nbsp;&nbsp;&nbsp;
                </strong>
            </div>
            <div style="height:10px;">&nbsp;</div>
        </tr>

        <tr>
            <div class="sub_info1">
                <ul>
                    <li >
                        극장 이용 시 마스크 착용은 필수 입니다.
                        <br>( 미착용 시 입장 제한)
                        <br>
                        입장 지연에 따른 관람 불편을 최소화 하기 위해 본 영화는 10분 후 상영이 시작됩니다.
                    </li>
                    <li>
                        영화 상영시작시간 15분 전까지 취소가 가능하며 캡쳐화면은 입장이 제한될 수 있습니다.
                    </li>
                </ul>


            </div>
            <div style="height:10px;">&nbsp;</div>
        </tr>

    </table>

    <button type="button" name="mainButton" onclick="goToMain(<%= memberId%>)">확인</button>
</div>


<script type="text/javascript">
  function goToMain(memberId) {
    location.href = "<%=request.getContextPath() %>/main?id=" + memberId;
  }
</script>

<footer id="footer">
    <div id="footer_sns">
        <div class="container">
            <div class="footer_sns">
                <ul>
                    <li class="icon s1"><a href="#"><span class="ir_pm">트위터</span></a></li>
                    <li class="icon s2"><a href="#"><span class="ir_pm">페이스북</span></a></li>
                    <li class="icon s3"><a href="#"><span class="ir_pm">인스타그램</span></a></li>
                    <li class="icon s4"><a href="#"><span class="ir_pm">구글 플레이</span></a></li>
                    <li class="icon s5"><a href="#"><span class="ir_pm">아이폰 앱스토어</span></a></li>
                </ul>
                <div class="tel">
                    <a href="#">ARS <em>0101-0101</em></a>
                </div>
            </div>
        </div>
    </div>
    <div id="footer_infor">
        <div class="container">
            <div class="row">
                <div class="footer_infor">
                    <h2 style="margin-bottom: 20px;">
                        <img src="assets/img/logo-footer.png" alt="lotte">
                    </h2>
                    <address>
                        <p>
                            서울 서초구 서초대로74길 33, 비트교육센터 3층<br> <span class="bar2">정은우</span>
                            이충현 안채영 권나연 장혜원 이성은<br> <span class="bar2">롯데e커머스</span>
                            CUTEam
                        </p>
                        <p>Copyright 2022 by Lotte CUTEam All right reserved</p>
                    </address>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- //footer -->

</body>
</html>