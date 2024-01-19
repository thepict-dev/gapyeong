<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<form name="messageForm" id="messageForm" method="post" action="${retUrl}">
	<input type="hidden" name="name" id="name" value="${pictVO.name}"/>
	<input type="hidden" name="mobile" id="mobile" value="${pictVO.mobile}"/>
	<input type="hidden" name="idx" id="idx" value="${pictVO.idx}"/>
</form>

<script type="text/javascript">
	<c:if test="${retType eq ':alert'}">
		<c:if test="${message ne '' && message ne undfined}">
			alert("${fn:replace(message, '<br>', '\\n')}");
		</c:if>
	</c:if>

	<c:if test="${retType eq ':submit'}">
		<c:if test="${message ne '' && message ne undfined}">
			alert("${fn:replace(message, '<br>', '\\n')}");
		</c:if>
		document.messageForm.submit();
	</c:if>
	
	<c:if test="${retType eq ':location'}">
		<c:if test="${message ne '' && message ne undfined}">
			alert("${fn:replace(message, '<br>', '\\n')}");
		</c:if>
		location.href="${retUrl}";
	</c:if>
	
	<c:if test="${retType eq ':exit'}">
		alert("${fn:replace(message, '<br>', '\\n')}");
		self.close()
	</c:if>
</script>