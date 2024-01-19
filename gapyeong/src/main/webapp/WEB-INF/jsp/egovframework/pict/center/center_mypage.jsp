<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="./head.jsp" %>
<body>
	<div class="wrap">
        <div class="header">
            <h1>
                <a href="/center_main.do">
                    <img src="../../../../../img/center_img/center-logo.webp" alt="">
                </a>
            </h1>
        </div>
        <div class="contents my">
            <h2><img src="../../../../../img/center_img/title.webp" alt=""></h2>
            <div class="myText text1">인증 영수증(인증완료/업로드)<p>${vo.cnt}<span>/${vo.total_cnt}</span></p></div>
            <div class="myText text2">인증 금액<p>
            	<fmt:formatNumber value="${vo.price}" pattern="#,###" />
            	</p></div>
            <div class="button-wrap up my">
                <a href="/center_upload.do" class="login up" style="background-color: #308f3a;">영수증 추가 등록하기</a>
            </div>
            <div class="reciptList">
            	<c:forEach var="resultList" items="${resultList}" varStatus="status">
	                <div class="recipt" onclick="bind('${resultList.idx}')">
	                    <!-- <img src="http://www.billconcert.com${resultList.img_url}" alt="영수증이미지"> -->
						<img src="/images/pict/bill_thumb.png" alt="영수증이미지" style="opacity : 0.5">
	                    
	                    <c:choose>
		               		<c:when test="${resultList.use_at eq '1'}"><p class="accept"><img src="../../../../../img/center_img/accept.png" alt=""></p></c:when>
		               		<c:when test="${resultList.use_at eq '2'}"><p class="decline"><img src="../../../../../img/center_img/decline.png" alt=""></p></c:when>
		               		<c:otherwise><p>영수증 확인 중</p></c:otherwise>
		               	
		               	</c:choose>
	                </div>
	                <div class="modal modal_${resultList.idx}">
				        <button><i class="fa-thin fa-x fa-xl" style="color: #fff;"></i></button>
				        <div class="modalImg">
				            <p>영수증콘서트 인증 영수증</p>
				            <ul class="reciptInfo">
				                <li>
				                    <p>승인번호</p>
				                    <p>${resultList.confirm_num}</p>
				                </li>
				                <li>
				                    <p>승인날짜</p>
				                    <p>${resultList.date}</p>
				                </li>
				                <li>
				                    <p>가맹점이름</p>
				                    <p style="line-height: 1.4;">${resultList.name}</p>
				                </li>
				                <li>
				                    <p>사업자등록번호</p>
				                    <p>${resultList.biz_num}</p>
				                </li>
				                <li>
				                    <p>가맹점주소</p>
				                    <p style="line-height: 1.4;">${resultList.address }</p>
				                </li>
				            </ul>
				            <div class="totalPrice">
				                <p class="totalTit">사용금액</p>
				                <p class="Totalamount"><fmt:formatNumber value="${resultList.price}" pattern="#,###" /><span>원</span></p>
				            </div>
				        </div>
				    </div>
                </c:forEach>
            </div>
        	<p class="uploadDesc conDesc">'영수증 확인 중' 문구가 2~3일 지속될 시<br>카카오톡 채널을 통해 문의하여 주세요.</p>
        	<p class="uploadDesc conDesc">AI 자동승인 이후에도 재검토 과정에서 거절될 수 있습니다.</p>
        	
            <a class="talk" href="http://pf.kakao.com/_FxeaST/chat">
            	<img src="../../../../../img/center_img/kakao-icon.png" alt="">
            	카카오톡 문의
           	</a>
            <button class="logout my" onclick="logout()">로그아웃</button>
        </div>
    </div>
    
</body>

<script>
	function bind(idxtt){
		console.log(idxtt)
		$(".modal.modal_"+idxtt).show();
	}
	 $(".modal button").click(function(){
        $(".modal").hide();
    });
	  $(".modal").click(function (e) {
		  $(".modal").hide();
    });

	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){
			location.href="/center_logout.do"
		}
	}
</script>