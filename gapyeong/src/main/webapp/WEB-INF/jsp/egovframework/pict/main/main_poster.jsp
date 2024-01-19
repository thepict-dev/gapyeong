<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
	<c:import url="../main/header_main.jsp">
    	<c:param name="pageTitle" value="영수증콘서트"/>
    </c:import>
    <body>

    	<div class="wrapper">
   			<%@include file="./navigation_main.jsp" %>
	        <main class="container">
	        	<div style="margin-top: 20px; text-align:center">
	        		<img src="/images/pict/poster.jpg"/>
	        	</div>
       		</main>
		</div>
    </body>
</html>
