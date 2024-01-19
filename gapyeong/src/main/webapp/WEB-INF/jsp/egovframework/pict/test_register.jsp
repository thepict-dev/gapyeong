<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>

<!DOCTYPE html>
<html lang="ko">
<c:import url="./main/header.jsp">
	<c:param name="pageTitle" value="영수증 등록" />
</c:import>
<body class="sb-nav-fixed">
	<form action="" id="register" name="register" method="post" enctype="multipart/form-data">
		<%@include file="./main/navigation.jsp"%>
		<div id="layoutSidenav">
			<div id="layoutSidenav_nav">
				<%@include file="./main/gnb.jsp"%>
			</div>
			<div id="layoutSidenav_content">
				<main class="contents">
					<h2 class="contents-title">영수증 등록</h2>
					<div class="contents-box" style="position:relative">
						<div class="card">
							<div class="card-body">
								<div class="write-box">
									<div class="write-item">
										<label for="title" class="title">가맹점</label>
										<div class="input-box">
											<input type="text" id="name" name="name" value="${pictVO.name}" class="input opt-max-width-500">
										</div>
									</div>
								</div>
								<div class="write-box">
									<div class="write-item">
										<label for="title" class="title">사업자등록번호</label>
										<div class="input-box">
											<input type="text" id="biz_num" name="biz_num" value="${pictVO.biz_num}" class="input opt-max-width-500">
										</div>
									</div>
								</div>
								<div class="write-box">
									<div class="write-item">
										<label for="title" class="title">가맹점주소지</label>
										<div class="input-box">
											<input type="text" id="address" name="address" value="${pictVO.address}" class="input opt-max-width-500">
										</div>
									</div>
								</div>
								<div class="write-box">
									<div class="write-item">
										<label for="title" class="title">승인번호</label>
										<div class="input-box">
											<input type="text" id="confirm_num" name="confirm_num" value="${pictVO.confirm_num}" class="input opt-max-width-500">
										</div>
									</div>
								</div>
								<div class="write-box">
									<div class="write-item">
										<label for="title" class="title">결제일</label>
										<div class="input-box">
											<input type="text" id="date" name="date" value="${pictVO.date}" class="input opt-max-width-500">
										</div>
									</div>
								</div>
								<div class="write-box">
									<div class="write-item">
										<label for="title" class="title">금액</label>
										<div class="input-box">
											<input type="text" id="price" name="price" value="${pictVO.price}" class="input opt-max-width-500">
										</div>
									</div>
								</div>
								
								<div class="write-item">
									<label for="title" class="title">승인여부</label>
									<select id="use_at" name="use_at" class="input opt-max-width-300">
										<option value="">승인여부</option>
										<option value="0" <c:if test="${pictVO.use_at eq '0'}"> selected</c:if> >미승인</option>
										<option value="1" <c:if test="${pictVO.use_at eq '1'}"> selected</c:if> >승인</option>
										<option value="2" <c:if test="${pictVO.use_at eq '2'}"> selected</c:if> >거절</option>
									</select>
								</div>
									
								<div class="btn-box">
									<c:if test="${pictVO.saveType eq 'insert'}">
										<button type="button" onclick="button1_click();" class="btn-basic btn-primary btn-sm">등록</button>
									</c:if>
									<c:if test="${pictVO.saveType ne 'insert'}">
										<button type="button" onclick="button1_click();" class="btn-basic btn-primary btn-sm">수정</button>
									</c:if>
						        	<button type="button" onclick="javascript:popup_list();" class="btn-basic btn-common btn-sm">목록보기</button>    
					            </div>
					            <c:if test="${pictVO.img_url ne '' && pictVO.img_url ne undefined}">
						            <div style="position:absolute; top:20px; right:20%">
						            	<img src="http://www.chuncheonkoreaopen.org${pictVO.img_url}" style="width:450px"/>
						            </div>
					            </c:if>
							</div>
						</div>
						
		            </div>
		            
				</main>
			</div>
		</div>
		<input type='hidden' name="saveType" id="saveType" value='${pictVO.saveType}' /> 
		<input type='hidden' name="idx" id="idx" value='${pictVO.idx}' /> 
		<input type='hidden' name="use_at" id="use_at" value='${pictVO.use_at}' />
		<input type='hidden' name="type" id="type" value='' />
		<input type='hidden' name="del_img_url" id="del_img_url" value='' />
		
		<input type='hidden' name="search_num_form" id="search_num_form" value='${pictVO.search_num_form }' />
		<input type='hidden' name="search_text_form" id="search_text_form" value='${pictVO.search_text_form }' />
		<input type='hidden' name="use_at_name" id="use_at_name" value='${pictVO.use_at_name }' />
	</form>
	
	<script>
		function popup_list() {
			location.href = "/test_list.do";
		}
		function button1_click() {
			var title = $('#name').val();
			
			if (title == "" || title == undefined) {
				window.alert("가맹점을 입력해주세요.");
				$('#title').focus();
				return false;
			}
			
			var text = "등록하시겠습니까?";
			if (saveType == 'update') {
				text = "수정하시겠습니까?"
			}

			if (confirm(text)) {
				$("#register").attr("action", "/test_save.do");
				$("#register").submit();
			}
		}
	</script>
	<script src="../../../../../js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="../../../../../js/scripts.js"></script>
	<script src="../../../../../js/Chart.min.js" crossorigin="anonymous"></script>
	<script src="../../../../../js/simple-datatables@latest.js" crossorigin="anonymous"></script>

</body>
</html>