<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="./head.jsp" %>
<%
	pageContext.setAttribute("name", session.getAttribute("name"));
	pageContext.setAttribute("mobile", session.getAttribute("mobile"));
%>
<body>
	<div class="wrap">
        <div class="header after">
            <h1>
                <a href="/center_main.do">
                    <img src="../../../../../img/center_img/center-logo.webp" alt="">
                </a>
            </h1>
        </div>
        <div class="contents">
            <div class="myInfo">
            	<p class="myName"><span>${name}</span>님 안녕하세요!</p>
            	<p class="myPhone">${fn:substring(mobile,0,3)}-${fn:substring(mobile,3,7)}-${fn:substring(mobile,7,11)}</p>
            	<a href="/center_mypage.do">나의 인증현황 보러가기<i class="fa-regular fa-angle-right fa-sm" style="color: #fff;"></i></a>
            </div>
            <div class="bottomCont">
	            <div id="slider">
	            <!-- 
	                <a href="#" class="control_next"><i class="fa-regular fa-chevron-right" style="color: #fff;"></i></a>
	                <a href="#" class="control_prev"><i class="fa-regular fa-chevron-left" style="color: #fff;"></i></a>
	                 -->
	                <button class="control_next"><i class="fa-regular fa-chevron-right" style="color: #fff;"></i></button>
	                <button class="control_prev"><i class="fa-regular fa-chevron-left" style="color: #fff;"></i></button>
	                <ul>
	                    <li><img src="../../../../../img/center_img/주의사항_02.webp" alt=""></li>
	                    <li><img src="../../../../../img/center_img/주의사항_03.webp" alt=""></li>
	                    <li><img src="../../../../../img/center_img/주의사항_04.webp" alt=""></li>
	                    <li><img src="../../../../../img/center_img/주의사항_01.webp" alt=""></li>
	                </ul>  
	            </div>
	            <p class="noti2">주의사항을 전부 확인하셔야<br>영수증 업로드가 가능합니다!</p>
	            <div class="button-wrap up">
	                <a href="#lnk" onclick="next_step()" class="login up" style="">업로드하러 가기</a>
	            </div>
	            <button class="logout" onclick="logout()">로그아웃</button>
			</div>
        </div>
    </div>
</body>
<script>
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){
			location.href="/center_logout.do"
		}
	}
	var rdcnt = 0;

	// 이미지 슬라이드
	jQuery(document).ready(function ($) {
		
		document.querySelector(".login").removeAttribute('href');
		
	    var slideCount = $('#slider ul li').length;
	    var slideWidth = $('#slider ul li').width();
	    var slideHeight = $('#slider ul li').height();
	    var sliderUlWidth = slideCount * slideWidth;
		
	    $('#slider').css({ width: slideWidth, height: slideHeight });
	    $('#slider ul').css({ width: sliderUlWidth, marginLeft: "-150%" });
	    $('#slider ul li:last-child').prependTo('#slider ul');
	
	    function moveLeft() {
	        $('#slider ul').animate({
	            left: + slideWidth
	        }, 200, function () {
	            $('#slider ul li:last-child').prependTo('#slider ul');
	            $('#slider ul').css('left', '');
	        });
	    };
	
	    function moveRight() {
	        $('#slider ul').animate({
	            left: - slideWidth
	        }, 200, function () {
	            $('#slider ul li:first-child').appendTo('#slider ul');
	            $('#slider ul').css('left', '');
	            rdcnt++;
	            if(rdcnt >= 3){
	            	$('.login').addClass("active");
	            }   
	        });
	    };
	    
	    
	    $('button.control_prev').click(function () {
	        moveLeft();
	    });
	    $('button.control_next').click(function () {
	        moveRight();
	    });
	
	});    
	function next_step(){
    	if(rdcnt >= 3){
        	window.location.href="/center_upload.do";
        }
    	else{
    		alert("주의사항 내용을 전부 확인해주세요.")
    	}
    }

</script>