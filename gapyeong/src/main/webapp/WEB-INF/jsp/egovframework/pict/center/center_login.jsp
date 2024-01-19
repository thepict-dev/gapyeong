<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="./head.jsp" %>
<body>
	<form action="#" id="loginForm" name="loginForm" method="post">
		<div class="wrap">
	        <div class="header">
	            <h1>
	                <a href="/center_main.do">
	                    <img src="/img/center_img/center-logo.webp" alt="">
	                </a>
	            </h1>
	        </div>
	        <div class="contents">
	            <h2><img src="/img/center_img/title.webp" alt=""></h2>
	            <p>예매자 정보를 입력해주세요.</p>
                <div class="info-box">
                    <input type="text" name="name" id="name" required="required" placeholder="인터파크 예매자 이름" onkeypress="if(event.keyCode == 13){fn_login();}" autocomplete="off">
                    <input type="text" name="mobile" id="mobile" required="required" maxlength="11" placeholder="인터파크 예매자 연락처" onkeypress="if(event.keyCode == 13){fn_login();}" autocomplete="off" onkeyup="characterCheck(this)" onkeydown="characterCheck(this)">
                    
                </div>
	            
	            <div class="button-wrap">
	                <button type="button" onclick="fn_login()" class="login">로그인</button>
	            </div>
	            <p class="noti">* 인터파크 예약자 정보와 동일하게 입력해주셔야 정상 인증됩니다.</p>
	        </div>
	    </div>
	    
	</form>
</body>
	<script>
		function characterCheck(obj){
			 var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
		        
	        //배열에서 하나씩 값을 비교
	        if( regExp.test(obj.value) ){
	           //값이 일치하면 문자를 삭제
	           obj.value = obj.value.substring( 0 , obj.value.length - 1 ); 
	        }
		}
		
		function fn_login() {
			if ($("#name").val() == "") {
				alert("예매자명을 입력하세요.");
				$("#name").focus();
				return false;
			}
			
			if ($("#mobile").val() == "") {
				alert("휴대전화번호를 입력하세요.");
				$("#mobile").focus();
				return false;
			}
			if($("#mobile").val().length != 11){
				alert("휴대전화번호 입력을 확인해주세요.");
				$("#mobile").focus();
				return false;
			}
			var name = $('#name').val();
			var mobile = $('#mobile').val()
			if(confirm("입력하신 정보는\n예매자명 : "+name + "\n휴대전화번호 : " + mobile)){
				document.loginForm.action = "/login_center.do";
				document.loginForm.submit();	
			}
			
			
			
		}
	</script>