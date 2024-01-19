<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
	<c:import url="./main/header.jsp">
    	<c:param name="pageTitle" value="영수증 리스트"/>
    </c:import>
    
    <body class="sb-nav-fixed">
        <%@include file="./main/navigation.jsp" %>
        <div id="layoutSidenav">
	        <div id="layoutSidenav_nav">
				<%@include file="./main/gnb.jsp" %>
			</div>
			
			<div id="layoutSidenav_content">
				<main class="contents">
					<h2 class="contents-title">영수증 리스트</h2>
					<div class="contents-box">
						<div class="card">
						    <div class="card-body">
						    	<div>
						    		<c:if test="${pictVO.search_text eq '' && pictVO.search_mobile eq ''}">
						    			사용자를 검색해주세요.
						    		</c:if>
						    		<c:if test="${pictVO.search_text ne '' || pictVO.search_mobile ne ''}">
							    		필요 금액 : <span><fmt:formatNumber value="${cnt * 40000}" pattern="#,###" />원</span><br>
						    			인증영수증 금액 : <span id="total"><fmt:formatNumber value="${total}" pattern="#,###" />원</span>
							    		<br>
							    		추가결제 금액:
							    		<c:if test="${cnt eq null || cnt eq undefined || cnt eq 0}">
							    			<span>예매 티켓 없음</span>
							    		</c:if>
							    		<c:if test="${cnt ne null && cnt ne undefined && cnt > 0 && total ne null && total ne undefined}">
							    			<span>
							    				<c:if test="${cnt * 40000 - total <= 0}">
							    					0원
							    				</c:if>
							    				<c:if test="${cnt * 40000 - total > 0}">
							    					<c:set var="prc" value="${cnt * 40000 - total }"/>
													<c:if test="${prc % 10000 eq 0}">
														<fmt:formatNumber value="${prc}" pattern="#,###" />원
													</c:if>
							    					<c:if test="${prc % 10000 ne 0}">
							    						<fmt:formatNumber value="${prc - (prc % 10000) + 10000}" pattern="#,###" />원
							    					</c:if>
							    					
						    					</c:if>
						    				</span>
							    		</c:if>
						    		</c:if>
					    		</div>
							    <div class="search-form">
							    	<form action="" id="search_fm" name="search_fm" method="get" class="search-box" style="max-width:1200px">
							    	<!-- 
							    		<button type="button" onclick="btn_excel();" class="btn-basic btn-sm btn-default point" style="display:flex; align-items:center; margin-right:20px; margin-top:5px; justify-content: center; width:180px">엑셀다운로드</button>
							    		 -->
							    		 <div style="display: flex; justify-content: space-between;">
								    		 <input type="hidden" id="use_at" name="use_at" value="${pictVO.use_at}" />
								    		 <label class="radio-inline radio-styled" style="display: flex; align-items: center;">
												<input type="radio" name="use_at_name" value="" ${(pictVO.use_at eq '') ? "checked" : ""} ><span style="padding: 0 10px; white-space: nowrap;">전체</span>
											 </label>
								    		<label class="radio-inline radio-styled" style="display: flex; align-items: center;">
												<input type="radio" name="use_at_name" value="1" ${pictVO.use_at eq '1' ? "checked" : ""}><span style="padding: 0 10px; white-space: nowrap;">완료</span>
											</label>
								    		 <label class="radio-inline radio-styled" style="display: flex; align-items: center;">
												<input type="radio" name="use_at_name" value="0" ${pictVO.use_at eq '0' ? "checked" : ""} ><span style="padding: 0 10px; white-space: nowrap;">미승인</span>
											</label>
											
											<label class="radio-inline radio-styled" style="display: flex; align-items: center;">
												<input type="radio" name="use_at_name" value="2" ${pictVO.use_at eq '2' ? "checked" : ""}><span style="padding: 0 10px; white-space: nowrap;">부적격</span>
											</label>
										</div>
							    		<button type="button" onclick="btn_confirm();" class="btn-basic btn-sm btn-default point" style="display:flex; align-items:center; margin-right:20px; margin-top:5px; justify-content: center; width:160px">완료</button>
							    		<button type="button" onclick="btn_noconfirm();" class="btn-basic btn-sm btn-default point" style="display:flex; align-items:center; margin-right:20px; margin-top:5px; justify-content: center; width:160px">미승인</button>
							    		<button type="button" onclick="btn_refuse();" class="btn-basic btn-sm btn-default point" style="display:flex; align-items:center; margin-right:20px; margin-top:5px; justify-content: center; width:160px">부적격</button>
								    	<input type="text" id="search_text" name="search_text" value="${pictVO.search_text}" class="input" placeholder="이름을 검색하세요." autocomplete="off" onkeypress="if(event.keyCode == 13){search();}">
								    	<input type="text" id="search_mobile" name="search_mobile" value="${pictVO.search_mobile}" class="input" placeholder="휴대전화를 검색하세요." autocomplete="off" onkeypress="if(event.keyCode == 13){search();}">
								    	<button type="button" onclick="search();" class="btn"><i class="fa-solid fa-magnifying-glass"></i></button>
							    	</form>
							    </div>
						    	<div class="tbl-basic tbl-hover">
							        <table style="text-align : left">
							        	<colgroup>
							        		<col style="width:5%;">
							        		<col style="width:5%;">
							        		<col style="width:10%;">
							        		<col style="width:8%;">
							        		<col style="width:12%;">
							        		<col style="width:10%;">
							        		<col style="width:12%;">
							        		<col style="width:10%;">
							        		<col style="width:10%;">
							        		<col style="width:8%;">
							        		<col style="width:10%;">
							        	</colgroup>
							            <thead>
							                <tr class="thead">
							                    <th><input type="checkbox" class="check" title="전체선택" onchange="allCheck(this);" data-check="addApplList"></th>
							                    <th>이름</th>
							                    <th>연락처</th>
							                    <th>티켓매수</th>
							                    <th>가맹점</th>
							                    <th>사업자등록번호</th>
							                    <th>가맹점주소</th>
							                    <th>승인번호</th>
							                    <th>승인날짜</th>
							                    <th>금액</th>
							                    <th>영수증이미지</th>
							                </tr>
							            </thead>
							            <tbody>
								            <c:forEach var="resultList" items="${resultList}" varStatus="status">
								                <tr style="background: 
								                	<c:choose>
								                		<c:when test="${resultList.use_at eq '1'}">#d3fffb</c:when>
								                		<c:when test="${resultList.use_at eq '2'}">#c1c1c1</c:when>
								                		<c:otherwise>#ffd3d3</c:otherwise>
								                	
								                	</c:choose>
								                	">
							                    	<td><input type="checkbox" class="check js-check" name="applCheck" data-check="addApplList" data-id="${resultList.idx}"></td>
							                    	<td class="opt-tl"><a href="javascript:void(0);" onclick="user_mod('${resultList.user_idx}');" class="link">${resultList.name}</a></td>
							                    	<td>${resultList.mobile}</td>
							                    	<td>${resultList.cnt}</td>
							                    	<td class="opt-tl"><a href="javascript:void(0);" onclick="board_mod('${resultList.idx}');" class="link">${resultList.title}</a></td>
							                    	<td>${resultList.biz_num}</td>
							                    	
							                    	<td>${resultList.address}</td>
							                    	<td>${resultList.confirm_num}</td>
							                    	<td>${resultList.date}</td>
							                    	<td><fmt:formatNumber value="${resultList.price}" pattern="#,###" /></td>
							                    	<td>
							                    		<button type="button" onclick="detail('${resultList.img_url}')" class="btn-basic btn-fill btn-sm">영수증</button>
									            	</td>
								                </tr>
							                </c:forEach>
							            </tbody>
						            </table>
				            	</div>
				            </div>
			            </div>
		            </div>
		            <div id="popup_img_div" style="display: none">
			            <img src="" id="popup_img" style="position:fixed; top:15%; left:30%" onclick="popup_img()"/>
		            </div>
				</main>
			</div>
		</div>
		<form action="" id="register" name="register" method="post" enctype="multipart/form-data">
			
			<input type='hidden' name="flag" id="flag" value='' />
			<input type='hidden' name="check_list" id="check_list" value='' />
			<input type='hidden' name="search_num_form" id="search_num_form" value='' />
			<input type='hidden' name="search_text_form" id="search_text_form" value='' />
		</form>
		<script>
			//var radio_name = $('input[name=use_at]').val();
			$('input[type=radio][name="use_at_name"]').change(function() {
				
				$('#use_at').val($(this).val());
				$("#search_fm").attr("action", "/test_list.do");
				$("#search_fm").submit();
		    });
			function search(){
				$("#search_fm").attr("action", "/test_list.do");
				$("#search_fm").submit();
			}
			function detail(file_url){
				$('#popup_img_div').show()
				var img = "http://www.billconcert.com"+file_url
				
				$("#popup_img").attr("src", img).width(500).height(800);
			}
			function popup_img(){
				$('#popup_img_div').hide()
				$("#popup_img").attr("src", "");
			}
			function board_mod(idx){
				
				location.href= "/test_register.do?idx="+ idx + "&search_num_form="+$('#search_mobile').val()+"&search_text_form="+$('#search_text').val() +"&use_at_name="+$('#use_at').val();
				
			}
			function user_mod(idx){
				location.href= "/test_user_register.do?idx="+ idx;
			}
			function btn_excel(){
				if(confirm("리스트를 엑셀파일로 내려받으시겠습니까?")){
					
					//$("#search_fm").attr("action", "/user/excel_down.do");
					//$("#search_fm").submit();
					
				}
			}
			function btn_confirm(){
				var check_list = [];
				$("input[name='applCheck']:checked").each(function (e){
					check_list.push($(this).data("id"));
				});
				if(check_list.length == 0) {
					alert("사용자를 선택해주세요.");
					return false;
				}
				$("#check_list").val(check_list.toString());
				if(confirm("완료 처리 하시겠습니까?")){
					$('#search_num_form').val($('#search_mobile').val())
					$('#search_text_form').val($('#search_text').val())
					$('#flag').val("confirm")
					$("#register").attr("action", "/test_confirm.do");
					$("#register").submit();
				}
			}
			function btn_noconfirm(){
				var check_list = [];
				$("input[name='applCheck']:checked").each(function (e){
					check_list.push($(this).data("id"));
				});
				if(check_list.length == 0) {
					alert("사용자를 선택해주세요.");
					return false;
				}
				$("#check_list").val(check_list.toString());
				if(confirm("미승인 처리 하시겠습니까?")){
					$('#search_num_form').val($('#search_mobile').val())
					$('#search_text_form').val($('#search_text').val())
					$('#flag').val("nonconfirm")
					$("#register").attr("action", "/test_confirm.do");
					$("#register").submit();
				}
			}
			function btn_refuse(){
				var check_list = [];
				$("input[name='applCheck']:checked").each(function (e){
					check_list.push($(this).data("id"));
				});
				if(check_list.length == 0) {
					alert("사용자를 선택해주세요.");
					return false;
				}
				$("#check_list").val(check_list.toString());
				if(confirm("부적격 처리 하시겠습니까?")){
					$('#search_num_form').val($('#search_mobile').val())
					$('#search_text_form').val($('#search_text').val())
					$('#flag').val("refuse")
					$("#register").attr("action", "/test_confirm.do");
					$("#register").submit();
				}
			}
			
			function allCheck(target) {
				var $id = $(target).data('check');
				var $check = $('.js-check[data-check="'+$id+'"]');
				if($(target).prop('checked'))
					$check.prop('checked', true);
				else
					$check.prop('checked', false);
				
				var check_list = [];
				$("input[name='applCheck']:checked").each(function (e){
					check_list.push($(this).data("id"));
				});
				
			}
		</script>
            
		<script src="../../../../../js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
		<script src="../../../../../js/scripts.js"></script>
		<script src="../../../../../js/Chart.min.js" crossorigin="anonymous"></script>
		<script src="../../../../../js/simple-datatables@latest.js" crossorigin="anonymous"></script>
		
    </body>
</html>