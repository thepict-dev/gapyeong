<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<!DOCTYPE html>
<html lang="ko">
	<c:import url="./main/header.jsp">
    	<c:param name="pageTitle" value="테스트"/>
    </c:import>
    
    
    
    <body class="sb-nav-fixed" style="min-width : unset;">
        <%@include file="./main/navigation.jsp" %>
        <form action="" id="register" name="register" method="post" enctype="multipart/form-data">
	        <div id="layoutSidenav">
		        <div id="layoutSidenav_nav" class="<c:if test='${type eq  "mobile"}'>active</c:if>">
					<button class="closeButton"><i class="fa-solid fa-chevron-left" style="color: #000000;"></i></button>
					<%@include file="./main/gnb.jsp" %>
				</div>
				<div id="layoutSidenav_content">
					<main class="contents <c:if test='${type eq  "mobile"}'>active</c:if>">
						<button class="openButton"><i class="fa-solid fa-chevron-right" style="color: #000000;"></i></button>
						<h2 class="contents-title">영수증 업로드</h2>
						<div class="contents-box">
							<div class="card">
							    <div class="card-body">
							    
								    <div class="write-item">
										<label for="title" class="title">사용자 검색</label>
										<div class="input-box" style="max-width: 601px;">
											<select class="companySelect" name="user_id" id="user_id" style="width: 100%; border: 1px solid #dddfe1;">
												<option value="" class="selectPlace" style="color: rgba(255, 255, 255, 0.5);">사용자를 선택하세요</option>
												<c:forEach var="resultList" items="${resultList}" varStatus="status">
													<option value="${resultList.idx}">${resultList.name}(${resultList.mobile})</option>
												</c:forEach>
											</select>
										</div>
									</div>
									
							    	<div class="write-item" id="file_div">
										<label for="title" class="title">영수증 이미지</label>
										<div class="input-box">
											<input style="margin-bottom:15px; border: 1px solid #aaa; border-radius: 3px;" type="file" id="attach_file" name="attach_file" class="input opt-max-width-600">
											<div class="select_img1">
						            			<img src="" style="width:200px; margin-bottom:15px; display: none" id="src_1"/>
					            			</div>
										</div>
									</div>
								 	<!-- 
									<div class="write-item" id="file_div">
										<label for="title" class="title">엑셀</label>
										<div class="input-box">
											<input style="margin-bottom:15px" type="file" id="attach_excel" name="attach_excel" class="input opt-max-width-600">
											
										</div>
									</div>
									 -->
					            </div>
					            <div style="float : right; margin-right: 20%">
						            <button type="button" id="button1" onclick="btn_cl();" style="width: 100px; height: 42px; margin: 30px; border: 1px solid #1f51a2; border-radius:10px; color: #1f51a2; font-size: 14px;">영수증업로드</button>
						        	<!-- 
						            <button type="button" id="button1" onclick="btn_cl2();">엑셀업로드</button>
						             -->
					            </div>
				            </div>
				            
			            </div>
			             
					</main>
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
			<input type="hidden" name="img" id="img" value=""/>
			<input type="hidden" name="flag" id="flag" value="N"/>
		</form>

		<script src="../../../../../js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
		<script src="../../../../../js/scripts.js"></script>
		<script src="../../../../../js/Chart.min.js" crossorigin="anonymous"></script>
		<script src="../../../../../js/simple-datatables@latest.js" crossorigin="anonymous"></script>
		
		<script>
			$('.companySelect').select2().on('select2:open', function(e){
			    $('.select2-search__field').attr('placeholder', '검색어를 입력하세요');
			})
			
			function btn_cl(){
				if($('#flag').val() != 'Y'){
					alert("이미지를 첨부해주세요.")
					 return false;
				}
				if(confirm("해당 영수증 파일을 업로드 하시겠습니까?")){
					$('#loading').css("display", "block");
					var form = $('#register')[0]
					var formData = new FormData(form);
					
					$.ajax({
						url : "/test3.do"
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
			}
			function btn_cl2(){
				$("#register").attr("action", "/test_excel.do");
				$("#register").submit();
			}
			
			
			$('#attach_file').change(function() {
				if(this.files && this.files[0]){
					if(this.files[0].type == '' || this.files[0].type.split('/')[0] != 'image'){
						alert ('이미지 파일만 첨부할 수 있습니다.');
						$('#attach_file').val("")
						return false
					}
					var reader = new FileReader;
					var blob_file = ""
					reader.onload = function(data){
						$('#src_1').show()
						$(".select_img1 img").attr("src", data.target.result).width(200);
						blob_file = data.target.result
					}
					
					$('#flag').val('Y');
					reader.readAsDataURL(this.files[0]);
					
				}
				else{
					$(".select_img1 img").attr("src", "");
				}
			});
			
			$('.closeButton').click(function(){
				$('.sb-nav-fixed #layoutSidenav #layoutSidenav_nav').addClass('active');
				event.preventDefault();
			});
			$('.openButton').click(function(){
				$('.sb-nav-fixed #layoutSidenav #layoutSidenav_nav').removeClass('active');
				event.preventDefault();
			});
			$('.closeButton').click(function(){
				$('.contents').addClass('active');
				event.preventDefault();
			});
			$('.openButton').click(function(){
				$('.contents').removeClass('active');
				event.preventDefault();
			});
		</script>
    </body>
</html>