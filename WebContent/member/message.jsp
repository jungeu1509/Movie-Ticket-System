<!-- /**
* [프로젝트]롯데e커머스_자바전문가과정
* [시스템명]영화예매시스템
* [팀 명]CUTEam
* -----------------------------------------------------------
* 수정일자 수정자 수정내용
* 2022.07.11 이충현 신규생성
* -----------------------------------------------------------
*/-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    String msg = request.getParameter("msg");
    String param = request.getParameter("param");
%>

<%
    if (param.equals("regi")) {
        if (msg.equals("OK")) {
%>
<script type="text/javascript">
    alert("회원가입되었습니다");
    location.href = "<%=request.getContextPath()%>/member?param=login";
</script>
<%
} else {
%>
<script type="text/javascript">
    alert("가입되지 않았습니다. 다시 작성해 주십시오");
    location.href = "<%=request.getContextPath()%>/member?param=regi";
</script>
<%
    }
} else if (param.equals("login")) {
    if (msg.equals("OK")) {
%>
<script type="text/javascript">
    alert("로그인 되었습니다.");
    location.href = "<%=request.getContextPath()%>/main";
</script>
<%
} else {
%>
<script type="text/javascript">
    alert("로그인 실패!");
    location.href = "<%=request.getContextPath()%>/member?param=login";
</script>
<%
        }
    }

%>
