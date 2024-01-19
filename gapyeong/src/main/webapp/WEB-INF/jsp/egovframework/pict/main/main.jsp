<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
	<c:import url="../main/header_main.jsp">
    	<c:param name="pageTitle" value="영수증콘서트"/>
    </c:import>
    <body>

    	<div class="wrapper">
   			<%@include file="./navigation_main.jsp" %>
	        <main class="container">
        		<section class="main-visual">
        			<div class="main-visual-container">
        				<div class="main-visual-box">
       						<div class="main-visual-slide swiper js-slide-visual">
       							<div class="swiper-wrapper">
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.4 YB</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-yb.png">
										    <img src="../../../../../images/pict/main-visual-yb.png" alt="">
										</picture>
      								</div>
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.4 백지영</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-baek.webp">
										    <img src="../../../../../images/pict/main-visual-baek.webp" alt="">
										</picture>
      								</div>
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.4 김범수</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-kimbum.webp">
										    <img src="../../../../../images/pict/main-visual-kimbum.webp" alt="">
										</picture>
      								</div>
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.4 다나카</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-danaka.webp">
										    <img src="../../../../../images/pict/main-visual-danaka.webp" alt="">
										</picture>
      								</div>
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.4 케이시</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-kassy.webp">
										    <img src="../../../../../images/pict/main-visual-kassy.webp" alt="">
										</picture>
      								</div>
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.5 김윤아</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-kimyouna.png">
										    <img src="../../../../../images/pict/main-visual-kimyouna.png" alt="">
										</picture>
      								</div>
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.5 박정현</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-park.webp">
										    <img src="../../../../../images/pict/main-visual-park.webp" alt="">
										</picture>
      								</div>
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.5 거미</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-kumi.webp">
										    <img src="../../../../../images/pict/main-visual-kumi.webp" alt="">
										</picture>
      								</div>
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.5 멜로망스</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-mel.webp">
										    <img src="../../../../../images/pict/main-visual-mel.webp" alt="">
										</picture>
      								</div>
       								<div class="swiper-slide">
       									<div class="main-visual-text">2023.8.5 경서</div>
       									<picture>
										    <source media="(max-width: 768px)" srcset="../../../../../images/pict/main-visual-kyeongseo.webp">
										    <img src="../../../../../images/pict/main-visual-kyeongseo.webp" alt="">
										</picture>
      								</div>
       							</div>
       							<div class="swiper-scrollbar"></div>
       							<div class="swiper-pagination"></div>
       						</div>
        				</div>
        				<%-- <section class="main-notice">
       						<div class="main-notice-list">
      							<div class="main-notice-title">NEWS</div>
      							<div class="main-notice-item">
      								<c:forEach var="resultList" items="${resultList}" varStatus="status">
      									<a href="/news.do">${resultList.title}</a>
      								</c:forEach>
								</div>
      							<a href="/news.do" class="main-notice-more" title="더보기"><i class="fa-solid fa-plus"></i></a>
       						</div>
        				</section> --%>
        			</div>
        		</section>
        		<section class="main-intro main-circle">
        			<h2 class="main-title" data-aos="fade-down" data-aos-duration="800">영수증이 티켓이 되다!</h2>
        			<div class="main-intro-box">
        				<div class="main-intro-item" data-aos="fade-right" data-aos-duration="800">
        					<div class="main-intro-desc">
								<img src="../../../../../images/pict/main-intro-img.png" alt="">
        					</div>
<!--         					<a href="/event.do" class="main-intro-more">자세히보기&nbsp;&nbsp;&nbsp;+</a> -->
        				</div>
        				<div class="main-intro-item" data-aos="fade-left" data-aos-duration="800">
        					<h2 class="main-intro-title">
        						<span class="desc">같이 사고. 가치를 살리는</span>
        						국내 최초 지역 상생 뮤직 페스티벌! <strong class="strong">영수증콘서트</strong>
        					</h2>
        					<div class="main-intro-desc">
								제 19회 제천국제음악영화제와 함께하는 영수증 콘서트! <br>
								지역 소상공인을 살리는 상생 콘서트<br>
								4만원 이상 제천시에서 사용한 영수증이 바로 티켓!<br><br>
								공연 관람만으로 지역에 나눔을 실천 할 수 있는<br>
								'영수증 콘서트 with 제천국제음악영화제' 많은 참여 바랍니다.<br><br>
							</div>
        				</div>	
        			</div>
        		</section>
        		<!-- 
        		<section class="main-video main-circle promote" data-aos="fade-up" data-aos-duration="800">
        			<div class="main-video-box">
        				<h2 class="main-title">
        					<span class="desc">지역에서 사용한 영수증이 콘서트 티켓이 되다-</span>
        					홍보영상
        				</h2>
        				<div class="main-video-item">
        					<video controls autoplay muted class="main-promote-video">
							    <source src="../../../../../images/pict/promotion-video.mp4" type="video/mp4">
							</video>
        				</div>
        			</div>
        		</section>
        		 -->
        		<!-- <section class="main-video welcome" data-aos="fade-up" data-aos-duration="800">
        			<div class="main-video-box">
        				<h2 class="main-title">
        					<span class="desc">지역에서 사용한 영수증이 콘서트 티켓이 되다-</span>
        					웰컴영상
        				</h2>
        				<div class="main-video-item">
        					<div class="main-welcome-slide swiper js-slide-welcome">
       							<div class="swiper-wrapper">
       								<div class="swiper-slide">
			        					<video controls class="main-welcome-video">
										    <source src="../../../../../images/pict/promotion-video.mp4" type="video/mp4">
										</video>
      								</div>
      								<div class="swiper-slide">
			        					<video controls class="main-welcome-video">
										    <source src="../../../../../images/pict/promotion-video.mp4" type="video/mp4">
										</video>
      								</div>
       							</div>
       							<div class="main-welcome-btn">
       								<div class="main-welcome-prev"></div>
	       							<div class="swiper-pagination"></div>
	       							<div class="main-welcome-next"></div>
       							</div>
       						</div>
        				</div>
        			</div>
        		</section> -->
        		<section class="main-map" data-aos="fade-up" data-aos-duration="800">
        			<div class="main-map-box">
        				<h2 class="main-title">
        					<span class="desc">지역에서 사용한 영수증이 콘서트 티켓이 되다-</span>
        					공연장 소개
        				</h2>
        			</div>
        			<div class="main-map-item">
						<div class="main-map-frame">
				        	<div id="map" style="width:100%; height:100%;"></div>
							<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0d776bb34a08483e971b1a5e18e0b065&libraries=services"></script>
							<script>
								var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							    mapOption = { 
							        center: new kakao.maps.LatLng('37.17605086221292', '128.1961410960461'), // 지도의 중심좌표
							        level: 3 // 지도의 확대 레벨
							    };
					
								var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
						
								// 마커가 표시될 위치입니다 
								var markerPosition  = new kakao.maps.LatLng('37.17605086221292', '128.1961410960461'); 
								// 마커를 생성합니다
								var marker = new kakao.maps.Marker({
								    position: markerPosition
								});
						
								// 마커가 지도 위에 표시되도록 설정합니다
								marker.setMap(map);
							
								var iwContent = '<div style="line-height:20px; width:180px; text-align:center">' + '세명대학교 세명체육관 <br>야외 특설무대' +'</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				
								// 인포윈도우를 생성합니다
								var infowindow = new kakao.maps.InfoWindow({
								    content : iwContent
								});
								kakao.maps.event.addListener(marker, 'mouseover', function() {
								  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
								    infowindow.open(map, marker);
								});
							
							</script>
				        </div>
        			</div>
        		</section>
	        </main>
	        <%@include file="./footer.jsp" %>
        </div>
        
		
        <script>
        	// visual slide
			var mainVisual = new Swiper(".js-slide-visual", {
				scrollbar: {
					el: ".swiper-scrollbar",
					hide: false,
				},
				pagination: {
					el: ".swiper-pagination",
					type: "fraction"
				},
			});
        	
        	// welcome slide
			var mainVisual = new Swiper(".js-slide-welcome", {
				pagination: {
					el: ".swiper-pagination",
					type: "fraction"
				},
				navigation: {
		          nextEl: ".main-welcome-next",
		          prevEl: ".main-welcome-prev",
		        },
		        loop: true,
			});
        </script>
    </body>
</html>
