<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="ko">
	<script>
			function gogo(user_id){
	            $.ajax({
	               url : "/print_ajax.do"
	               , type : "GET"
	               , data : {"user_id" : user_id}
	               , contentType : "application/json"
	               , dataType : "json"
	               , success : function(data, status, xhr) {
						let cList = data.list;
						let html = '';
						for(let i=0; i<cList.length; i++){
							 var price = 0;
							 if(cList[i].price != '' && cList[i].price != undefined) price = cList[i].price
							 html += 
								'<div class="print-list">' +
								'<p class="recipt-tit">영수증콘서트 인증 영수증</p>'+
								'<ul class="recipt-texts">'+
										'<li><p class="text-title">승인번호</p><p>'+ cList[i].name +'</p></li>'+
										'<li><p class="text-title">승인날짜</p><p>'+ cList[i].date +'</p></li>'+
										'<li><p class="text-title">가맹점이름</p><p>'+ cList[i].name +'</p></li>'+
										'<li><p class="text-title">사업자등록번호</p><p>'+ cList[i].biz_num +'</p></li>'+
										'<li><p class="text-title">가맹점주소</p><p>'+ cList[i].address +'</p></li>'+
									'</ul>'+
									'<ul class="totalPrice">'+
										'<li>사용금액</li>'+
										'<li><span>'+ price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") +'</span>원</li>'+
									'</ul>'+
								'</div>'
									
						}
	                  
						$('#divtest_'+user_id).html(html)
	                  
					}
					, error : function(xhr, status, error) {
	   
					}
				});
			}
		</script>
	<c:import url="./main/header.jsp">
    	<c:param name="pageTitle" value="영수증 리스트"/>
    </c:import>
    <body style="min-width : unset; overflow-y: scroll" id="pdfDiv">
    	<c:forEach var="resultList" items="${resultList}" varStatus="status">
			<div class="print-wrap" id="print_div">
	            <div class="print-title">
	                <p>영수증리스트</p>
	            </div>

		        <div class="print-inner">
		            <button></button>
		            <div class="print-top">
		                <ul>
		                    <li class="top-head">성명</li>
		                    <li>${resultList.name}</li>
		                    <li class="top-head b-rt">휴대폰번호</li>
		                    <li>${resultList.mobile}</li>
		                </ul>
		                <ul>
		                    <li class="top-head">인증건수</li>
		                    <li>${resultList.cnt}건</li>
		                    <li class="top-head b-rt">총 인증금액</li>
		                    <li><fmt:formatNumber value="${resultList.price}" pattern="#,###" />원</li>
		                </ul>
		            </div>
		            <div class="lists-wrpper">
			            <div class="print-lists" id="divtest_${resultList.user_id}">
			                <%-- 그려질영역 --%>
			                <script>
			                gogo('${resultList.user_id}');
							</script>
							
			            </div>
		            </div>
		    	</div>
	    	</div>
    	</c:forEach>
   	</body>
</html>