<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"	   uri="http://java.sun.com/jsp/jstl/functions"%>



<%
	String url = request.getRequestURL().toString();
	pageContext.setAttribute("url", url);
	
%>
<c:set var="test_bill" value="${fn:indexOf(url, 'test.jsp')}"/>
<c:set var="test_list" value="${fn:indexOf(url, 'test_list')}"/>
<c:set var="print_list" value="${fn:indexOf(url, 'print_list')}"/>
<c:set var="test_register" value="${fn:indexOf(url, 'test_register')}"/>

<c:set var="test_user_list" value="${fn:indexOf(url, 'test_user_list')}"/>
<c:set var="test_user_register" value="${fn:indexOf(url, 'test_user_register')}"/>

<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
    <div class="sb-sidenav-menu">
        <div class="nav">
        	
        	<%
				pageContext.setAttribute("sessionid", session.getAttribute("id"));
			%>
			          
			
            <a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts1" aria-expanded="true" aria-controls="collapseLayouts1">
				행사관리
            </a>
            <c:if test="${sessionid eq 'admin' || sessionid eq 'finecom'}">
	            <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                <nav class="sb-sidenav-menu-nested nav">
	                    <a class="nav-link" href="/test.do" style="<c:if test="${test_bill ne -1}">font-weight:700; color:#000</c:if>">영수증 등록</a>
	                </nav>
	            </div>
	            <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                <nav class="sb-sidenav-menu-nested nav">
	                    <a class="nav-link" href="/test_user_register.do" style="<c:if test="${test_user_register ne -1}">font-weight:700; color:#000</c:if>">사용자 등록</a>
	                </nav>
	            </div>
	            <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                <nav class="sb-sidenav-menu-nested nav">
	                    <a class="nav-link" href="/test_user_list.do" style="<c:if test="${test_user_list ne -1}">font-weight:700; color:#000</c:if>">사용자 리스트</a>
	                </nav>
	            </div>
	            <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
					<nav class="sb-sidenav-menu-nested nav">
	                    <a class="nav-link" href="/test_list.do" style="<c:if test="${test_list ne -1 || test_register ne -1}">font-weight:700; color:#000</c:if>">영수증 리스트</a>
	                </nav>
	            </div>
	            <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
					<nav class="sb-sidenav-menu-nested nav">
	                    <a class="nav-link" href="/print_list.do" style="<c:if test="${print_list ne -1}">font-weight:700; color:#000</c:if>">영수증 출력</a>
	                </nav>
	            </div>
            </c:if>
            <c:if test="${sessionid eq 'user'}">
	            <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                <nav class="sb-sidenav-menu-nested nav">
	                    <a class="nav-link" href="/test.do" style="<c:if test="${test_bill ne -1}">font-weight:700; color:#000</c:if>">영수증 등록</a>
	                </nav>
	            </div>
            </c:if>
	            
	          
		</div>
	</div>
</nav>
<script>
	function tttt() {
		alert("준비중입니다.")
	}
</script>

<script src="../../../../../js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="../../../../../js/scripts.js"></script>
<script src="../../../../../js/Chart.min.js" crossorigin="anonymous"></script>
<script src="../../../../../js/simple-datatables@latest.js" crossorigin="anonymous"></script>