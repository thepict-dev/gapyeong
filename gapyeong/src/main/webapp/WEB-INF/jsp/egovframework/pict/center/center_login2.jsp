<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="./head.jsp" %>
<body>
	<form action="#" id="loginForm" name="loginForm" method="post">
		<input type="hidden" name="idx" id="idx" value="${pictVO.idx}"/>
		<input type="hidden" name="name" id="name" value="${pictVO.name}"/>
		<input type="hidden" name="mobile" id="mobile" value="${pictVO.mobile}"/>
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
	            <p>제천시민 이신가요?</p>
	            
	            <select id="address_ty" name="address_ty" class="select my-select">
	                <option value="1" class="option">아니오</option>
	                <option value="2" class="option">네</option>
	            </select>
	            
	            <div class="info-box" id="addr_input" style="display:none">
					<input type="text" name="address" id="address" required="required" placeholder="주소지" autocomplete="off" readonly>
				</div>
	            
	            <div class="button-wrap">
	                <button type="button" onclick="fn_login()" class="login">확인</button>
	            </div>
	            <p class="noti">* 인터파크 예약자 정보와 동일하게 입력해주셔야 정상 인증됩니다.</p>
	        </div>
	    </div>
    </form>
</body>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		window.onload = function(){
		    document.getElementById("address").addEventListener("click", function(){ //주소입력칸을 클릭하면
		        //카카오 지도 발생
		        new daum.Postcode({
		            oncomplete: function(data) { //선택시 입력값 세팅
		                document.getElementById("address").value = data.address; // 주소 넣기
		                //document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
		            }
		        }).open();
		    });
		}
	</script>
	<script>
		$("#address_ty").change(function(){
		    var val = $('#address_ty').val()
		    if(val == '2'){
		    	$('#addr_input').css("display", "block")
		    }
		    else{
		    	$('#addr_input').css("display", "none")
		    }
		});
		function fn_login() {
			var ty = $('#address_ty').val()
			var address = $('#address').val();
			
			if(ty == '' || ty == undefined){
				alert("주소지를 선택해주세요.")
				$('#address_ty').focus()
				return false;
			}
			if(ty == '2' && (address == undefined || address == '')){
				alert("주소지를 선택해주세요.")
				$('#address').focus()
				return false;
			}
			
			document.loginForm.action = "/login_address.do";
			document.loginForm.submit();
			
		}
	</script>