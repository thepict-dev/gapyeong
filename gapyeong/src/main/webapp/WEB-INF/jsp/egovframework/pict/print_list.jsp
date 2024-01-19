<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
	<c:import url="./main/header.jsp">
    	<c:param name="pageTitle" value="인쇄 리스트"/>
    </c:import>
    
    <body class="sb-nav-fixed">
        <%@include file="./main/navigation.jsp" %>
        <div id="layoutSidenav">
	        <div id="layoutSidenav_nav">
				<%@include file="./main/gnb.jsp" %>
			</div>
			
			<div id="layoutSidenav_content">
				<main class="contents">
					<h2 class="contents-title">인쇄 리스트</h2>
					<div class="contents-box">
						<div class="card">
						    <div class="card-body">
							    <div class="search-form">
							    	<form action="" id="search_fm" name="search_fm" method="get" class="search-box" style="max-width:1000px">
							    		<button onClick="printArea()">전체출력</button>
							    		<div style="display: flex; align-items: center; width: 78px;">
								    		<input type="checkbox" id="search_print" name="search_print" value="1" style="margin-right: 10px;" <c:if test="${pictVO.search_print eq '1'}">checked </c:if>>
							    			<label for="search_print" style="width:200px">미출력</label>
							    		</div>
							    		<input type="text" id="search_num" name="search_text" value="${pictVO.search_text}" class="input" placeholder="이름을 검색하세요." autocomplete="off" onkeypress="if(event.keyCode == 13){search();}">
								    	<input type="text" id="search_text" name="search_mobile" value="${pictVO.search_mobile}" class="input" placeholder="휴대전화를 검색하세요." autocomplete="off" onkeypress="if(event.keyCode == 13){search();}" >
								    	<button type="button" onclick="search();" class="btn"><i class="fa-solid fa-magnifying-glass"></i></button>
							    	</form>
							    </div>
						    	<div class="tbl-basic tbl-hover">
							        <table style="text-align : left">
							        	<colgroup>
							        		<col style="width:10%;">
							        		<col style="width:10%;">
							        		<col style="width:15%;">
							        		<col style="width:10%;">
							        		<col style="width:15%;">
							        		<col style="width:15%;">
							        	</colgroup>
							            <thead>
							                <tr class="thead">
							                    <th>순서</th>
							                    <th>이름</th>
							                    <th>연락처</th>
							                    <th>티켓매수</th>
							                    <th>영수증 출력여부</th>
							                    <th>영수증 출력</th>
							                </tr>
							            </thead>
							            <tbody>
								            <c:forEach var="resultList" items="${resultList}" varStatus="status">
								                <tr>
							                    	<td>${status.count}</td>
							                    	<td class="opt-tl"><a href="javascript:void(0);" onclick="user_mod('${resultList.idx}');" class="link">${resultList.name}</a></td>
							                    	<td>${resultList.mobile}</td>
							                    	<td>${resultList.cnt}</td>
							                    	<td>
							                    		<c:if test="${resultList.print eq '1'}"><span style="color : blue">출력</span></c:if>
							                    		<c:if test="${resultList.print ne '1'}"><span style="color : red">미출력</span></c:if>
													</td>
							                    	<td><button type="button" onclick="print('${resultList.idx}')" class="btn-basic btn-fill btn-sm">출력</button></td>
								                </tr>
							                </c:forEach>
							            </tbody>
						            </table>
				            	</div>
				            </div>
			            </div>
		            </div>
				</main>
			</div>
			<form action="" id="register" name="register" method="post" enctype="multipart/form-data">
				<input type="hidden" name="idx" id="idx" value="" />
			</form>
		</div>

		<script>
			
		
			$("#search_print").change(function(){
				$("#search_fm").attr("action", "/print_list.do");
				$("#search_fm").submit();
			})
		
			function search(){
				$("#search_fm").attr("action", "/print_list.do");
				$("#search_fm").submit();
			}

			function user_mod(idx){
				location.href= "/test_user_register.do?idx="+ idx;
			}
			function print(idx){
				var popUrl = "print_recipt.do?idx="+idx;
				var title ="영수증 인쇄"
		        var popOption = "top=10, left=10, width=900, height=1200, status=no, menubar=no, toolbar=no, resizable=no";
		        
		        window.open(popUrl, title, popOption);
		        
			}
			function printArea(){
				var popUrl = "print_recipt.do"
				var title ="영수증 인쇄"
		        var popOption = "top=10, left=10, width=900, height=1200, status=no, menubar=no, toolbar=no, resizable=no";
		        
		        window.open(popUrl, title, popOption);
			}
			

		</script>
            
		<script src="../../../../../js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
		<script src="../../../../../js/scripts.js"></script>
		<script src="../../../../../js/Chart.min.js" crossorigin="anonymous"></script>
		<script src="../../../../../js/simple-datatables@latest.js" crossorigin="anonymous"></script>
		
    </body>
</html>