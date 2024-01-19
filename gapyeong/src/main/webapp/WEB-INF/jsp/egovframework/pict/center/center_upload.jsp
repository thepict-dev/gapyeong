<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="./head.jsp" %>
<%
	pageContext.setAttribute("idx", session.getAttribute("idx"));
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
            <div class="bottomCont upload">
            	<div class="formWrap">
		            <form action="" id="register1" name="register1" method="post" enctype="multipart/form-data" class="upload-form">
		            	<input type="hidden" id="idx" name="idx" value="${idx}"/>
		            	<input type="hidden" id="name" name="name" value="${name}"/>
		            	<input type="hidden" id="mobile" name="mobile" value="${mobile}"/>
		                <div class="images">
		                    <img src="../../../../../img/center_img/back.webp" alt="" class="image-box">
		                    <label for="attach_file1" class="upload-btn">
		                        <input type="file" id="attach_file1" name="attach_file" accept="image/*">
		                    </label>
		                </div>
	                </form>
	                <form action="" id="register2" name="register2" method="post" enctype="multipart/form-data" class="upload-form">
	                	<input type="hidden" id="idx" name="idx" value="${idx}"/>
	                	<input type="hidden" id="name" name="name" value="${name}"/>
		            	<input type="hidden" id="mobile" name="mobile" value="${mobile}"/>
		                <div class="images">
		                    <img src="../../../../../img/center_img/back.webp" alt="" class="image-box">
		                    <label for="attach_file2" class="upload-btn">
		                        <input type="file" id="attach_file2" name="attach_file" accept="image/*">
		                    </label>
		                </div>
	                </form>
	                <form action="" id="register3" name="register3" method="post" enctype="multipart/form-data" class="upload-form">
	                	<input type="hidden" id="idx" name="idx" value="${idx}"/>
	                	<input type="hidden" id="name" name="name" value="${name}"/>
		            	<input type="hidden" id="mobile" name="mobile" value="${mobile}"/>
		                <div class="images">
		                    <img src="../../../../../img/center_img/back.webp" alt="" class="image-box">
		                    <label for="attach_file3" class="upload-btn">
		                        <input type="file" id="attach_file3" name="attach_file" accept="image/*">
		                    </label>
		                </div>
	                </form>
	                <form action="" id="register4" name="register4" method="post" enctype="multipart/form-data" class="upload-form">
	                	<input type="hidden" id="idx" name="idx" value="${idx}"/>
	                	<input type="hidden" id="name" name="name" value="${name}"/>
		            	<input type="hidden" id="mobile" name="mobile" value="${mobile}"/>
		                <div class="images">
		                    <img src="../../../../../img/center_img/back.webp" alt="" class="image-box">
		                    <label for="attach_file4" class="upload-btn">
		                        <input type="file" id="attach_file4" name="attach_file" accept="image/*">
		                    </label>
		                </div>
	                </form>
	            </div>
	            <p class="uploadDesc">한번에 최대 4장까지 업로드할 수 있어요!</p>
	            
	            <div class="button-wrap up">
	                <a href="/center_upload.do" class="login up" style="background-color: #308f3a;">영수증 추가등록하기</a>
	            </div>
	            <p class="uploadDesc conDesc">'영수증 확인 중' 문구가 2~3일 지속될 시<br>카카오톡 채널을 통해 문의하여 주세요.</p>
	            <a class="talk" href="http://pf.kakao.com/_FxeaST/chat">
	            	<img src="../../../../../img/center_img/kakao-icon.png" alt="">
	            	카카오톡 문의
	           	</a>
	            <button class="logout" onclick="logout()">로그아웃</button>
			</div>
        </div>
    </div>
    <div class="loading-wrap" id="loading">
	    <div class="loading-container">
		    <div class="loading"></div>
		    <div id="loading-text">업로드 중···</div>
		</div>
	</div>
	<div class="succece" id="succece">
	    <div class="donePopup">
		    <i class="fa-regular fa-circle-check fa-2x" style="color: #308f3a;"></i>
		    <p>업로드가 완료되었습니다.</p>
		    <button>확인</button>
		</div>
	</div>
	<div class="fail" id="fail">
	    <div class="donePopup">
		    <i class="fa-regular fa-circle-exclamation fa-2x" style="color: #308f3a;"></i>
		    <p>업로드가 실패했습니다.<br>관리자에게 문의해주세요.</p>
		    <button>확인</button>
		</div>
	</div>
</body>
<script>
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){
			location.href="/center_logout.do"
		}
	}

	$('.fail button').click(function(){
		$('.fail').css('display', 'none');
	});
	$('.succece button').click(function(){
		$('.succece').css('display', 'none');
	});

	$("#attach_file1").change(function(){
		if(confirm("해당 영수증 파일을 업로드 하시겠습니까?")){
			$('#loading').css("display", "block");
			var form = $('#register1')[0]
			var formData = new FormData(form);
			
			$.ajax({
				url : "/test2.do"
				, type : "POST"
				, enctype:'multipart/form-data'
				, data : formData
				, contentType : false
		        , processData : false
		        , success:function(data){
		        	console.log(data)
		        	if(data == 'Y'){
		        		$('#loading').css("display", "none");
		        		$('#succece').css("display", "block")
		        	}
		        	else if(data == 'confirm_num'){
		        		$('#loading').css("display", "none");
		        		alert("승인번호 중복데이터 입니다.");
		        		return false
		        	}
		        	else{
		        		$('#loading').css("display", "none");
		        		$('#fail').css("display", "block")
		        	}
		        }
		        , error:function(e){
		        	if(e == 'N'){
		        		$('#loading').css("display", "none");
		        		$('#fail').css("display", "block")
		        	}
		        }
			})
		}
	});
	$("#attach_file2").change(function(){
		if(confirm("해당 영수증 파일을 업로드 하시겠습니까?")){
			$('#loading').css("display", "block");
			var form = $('#register2')[0]
			var formData = new FormData(form);
			
			$.ajax({
				url : "/test2.do"
				, type : "POST"
				, enctype:'multipart/form-data'
				, data : formData
				, contentType : false
		        , processData : false
		        , success:function(data){
		        	console.log(data)
		        	if(data == 'Y'){
		        		$('#loading').css("display", "none");
		        		$('#succece').css("display", "block")
		        	}
		        	else if(data == 'confirm_num'){
		        		$('#loading').css("display", "none");
		        		alert("승인번호 중복데이터 입니다.");
		        		return false
		        	}
		        	else{
		        		$('#loading').css("display", "none");
		        		$('#fail').css("display", "block")
		        	}
		        }
		        , error:function(e){
		        	if(e == 'N'){
		        		$('#loading').css("display", "none");
		        		$('#fail').css("display", "block")
		        	}
		        }
			})
		}
	});
	$("#attach_file3").change(function(){
		if(confirm("해당 영수증 파일을 업로드 하시겠습니까?")){
			$('#loading').css("display", "block");
			var form = $('#register3')[0]
			var formData = new FormData(form);
			
			$.ajax({
				url : "/test2.do"
				, type : "POST"
				, enctype:'multipart/form-data'
				, data : formData
				, contentType : false
		        , processData : false
		        , success:function(data){
		        	console.log(data)
		        	if(data == 'Y'){
		        		$('#loading').css("display", "none");
		        		$('#succece').css("display", "block")
		        	}
		        	else if(data == 'confirm_num'){
		        		$('#loading').css("display", "none");
		        		alert("승인번호 중복데이터 입니다.");
		        		return false
		        	}
		        	else{
		        		$('#loading').css("display", "none");
		        		$('#fail').css("display", "block")
		        	}
		        }
		        , error:function(e){
		        	if(e == 'N'){
		        		$('#loading').css("display", "none");
		        		$('#fail').css("display", "block")
		        	}
		        }
			})
		}
	});
	$("#attach_file4").change(function(){
		if(confirm("해당 영수증 파일을 업로드 하시겠습니까?")){
			$('#loading').css("display", "block");
			var form = $('#register4')[0]
			var formData = new FormData(form);
			
			$.ajax({
				url : "/test2.do"
				, type : "POST"
				, enctype:'multipart/form-data'
				, data : formData
				, contentType : false
		        , processData : false
		        , success:function(data){
		        	console.log(data)
		        	if(data == 'Y'){
		        		$('#loading').css("display", "none");
		        		$('#succece').css("display", "block")
		        	}
		        	else if(data == 'confirm_num'){
		        		$('#loading').css("display", "none");
		        		alert("승인번호 중복데이터 입니다.");
		        		return false
		        	}
		        	else{
		        		$('#loading').css("display", "none");
		        		$('#fail').css("display", "block")
		        	}
		        }
		        , error:function(e){
		        	if(e == 'N'){
		        		$('#loading').css("display", "none");
		        		$('#fail').css("display", "block")
		        	}
		        }
			})
		}
	});
	//파일 이미지 미리보기
	const fileDOM1 = document.querySelector('#attach_file1');
	const fileDOM2 = document.querySelector('#attach_file2');
	const fileDOM3 = document.querySelector('#attach_file3');
	const fileDOM4 = document.querySelector('#attach_file4');
	let previews = document.querySelectorAll('.image-box');
	
	fileDOM1.addEventListener('change', () => {
	    const reader = new FileReader();
	    reader.onload = ({ target }) => {
	        previews[0].src = target.result;
	    };
	    reader.readAsDataURL(fileDOM1.files[0]);
	});
	fileDOM2.addEventListener('change', () => {
	    const reader = new FileReader();
	    reader.onload = ({ target }) => {
	        previews[1].src = target.result;
	    };
	    reader.readAsDataURL(fileDOM2.files[0]);
	});
	fileDOM3.addEventListener('change', () => {
	    const reader = new FileReader();
	    reader.onload = ({ target }) => {
	        previews[2].src = target.result;
	    };
	    reader.readAsDataURL(fileDOM3.files[0]);
	});
	fileDOM4.addEventListener('change', () => {
	    const reader = new FileReader();
	    reader.onload = ({ target }) => {
	        previews[3].src = target.result;
	    };
	    reader.readAsDataURL(fileDOM4.files[0]);
	});
	
</script>