<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
	<c:import url="./main/header.jsp">
    	<c:param name="pageTitle" value="사용자 리스트"/>
    </c:import>
    
    <body class="sb-nav-fixed">
        <%@include file="./main/navigation.jsp" %>
        <div id="layoutSidenav">
	        <div id="layoutSidenav_nav">
				<%@include file="./main/gnb.jsp" %>
			</div>
			
			<div id="layoutSidenav_content">
				<main class="contents">
					<h2 class="contents-title">사용자 리스트</h2>
					<div class="contents-box">
						<div class="card">
						    <div class="card-body">
							    <div class="search-form">
							    	<form action="" id="search_fm" name="search_fm" method="get" class="search-box" style="max-width:1000px">
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
							                    <th>티켓번호</th>
							                    <th>등록일</th>
							                </tr>
							            </thead>
							            <tbody>
								            <c:forEach var="resultList" items="${resultList}" varStatus="status">
								                <tr>
							                    	<td>${status.count}</td>
							                    	<td class="opt-tl"><a href="javascript:void(0);" onclick="user_mod('${resultList.idx}');" class="link">${resultList.name}</a></td>
							                    	<td>${resultList.mobile}</td>
							                    	<td>${resultList.cnt}</td>
							                    	<td>${resultList.ticket}</td>
							                    	<td>${resultList.reg_date}</td>
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
		</div>

		<script>

			function search(){
				$("#search_fm").attr("action", "/test_user_list.do");
				$("#search_fm").submit();
			}

			function user_mod(idx){
				location.href= "/test_user_register.do?idx="+ idx;
			}

		</script>
            
		<script src="../../../../../js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
		<script src="../../../../../js/scripts.js"></script>
		<script src="../../../../../js/Chart.min.js" crossorigin="anonymous"></script>
		<script src="../../../../../js/simple-datatables@latest.js" crossorigin="anonymous"></script>
		
    </body>
</html>