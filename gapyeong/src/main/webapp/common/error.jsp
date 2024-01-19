<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/sample.css'/>" />
<title>Basic Sample</title>
</head>
<link rel="stylesheet" href="../../../../../css/egovframework/pict/reset.css">
<link rel="stylesheet" href="../../../../../css/egovframework/pict/layout.css">
<link rel="stylesheet" href="../../../../../css/egovframework/pict/contents.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css">
<body>
    <img src="../../../../../images/pict/404.png" alt="페이지를 찾을수 없습니다.">
    <div style="margin-left:60px">
    	<button type="button" onclick="button1_click();" class="btn-basic btn-primary">이전으로 돌아가기</button>
    </div>
</body>

<script>
	function button1_click(){
		window.history.back();
	}
</script>
</html>