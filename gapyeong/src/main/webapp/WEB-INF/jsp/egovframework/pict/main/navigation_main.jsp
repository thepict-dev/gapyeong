<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<header class="header"> 
	<div class="header-container">
		<h1 class="header-logo"><a href="/"><img src="../../../../../images/pict/jc-logo.png" alt="2022 대한민국상생 영수증콘서트 in 강원"></a></h1>
<!--		<button type="button" class="header-btn" title="메뉴열기" onclick="gnbMenu('open')"><i class="fa-solid fa-bars"></i></button>-->
		<div class="header-gnb">
			<nav class="header-menu">
				<ul class="header-list">
					<li class="header-item">
						<a href="http://pf.kakao.com/_FxeaST" title="새창이동" class="sns-lnk header" target="_blank">
							<div class="img"><img src="../../../../../images/pict/kakao.png" alt=""></div>
							<div class="text">카카오톡채널</div>
						</a>
					</li>
					<li class="header-item">
						<a href="https://tv.naver.com/alllivetv" title="새창이동" class="sns-lnk header none" target="_blank">
							<div class="img"><img src="../../../../../images/pict/naver.png" alt=""></div>
							<div class="text">네이버TV</div>
						</a>
					</li>
			 		<li class="header-item">
				 		<a href="https://tickets.interpark.com/goods/23008502" title="새창이동" class="sns-lnk header" target="_blank">
							<div class="img"><img src="../../../../../images/pict/interpark.png" alt=""></div>
							<div class="text">인터파크</div>
						</a>
					</li>
					<li class="header-item">
						<a href="https://www.facebook.com/p/%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD-%EC%83%81%EC%83%9D-%EC%98%81%EC%88%98%EC%A6%9D%EC%BD%98%EC%84%9C%ED%8A%B8-100083206185109/" title="새창이동" class="sns-lnk header none" target="_blank">
							<div class="img"><img src="../../../../../images/pict/facebook.png" alt=""></div>
							<div class="text">페이스북</div>
						</a>
					</li>
					<li class="header-item">
						<a href="https://www.instagram.com/billconcert_official/" title="새창이동" class="sns-lnk header none" target="_blank">
							<div class="img"><img src="../../../../../images/pict/insta.png" alt=""></div>
							<div class="text">인스타그램</div>
						</a>
					</li>
					<li class="header-item">
						<a href="https://www.youtube.com/@user-hd1vt6ns3o" title="새창이동" class="sns-lnk header none" target="_blank">
							<div class="img"><img src="../../../../../images/pict/youtube.png" alt=""></div>
							<div class="text">유튜브</div>
						</a>
					</li>
				</ul>
			</nav>
			<button type="button" class="header-close" title="메뉴닫기" onclick="gnbMenu('close')"><i class="fa-solid fa-xmark"></i></button>
		</div>
	</div>
</header>
<a href="https://tickets.interpark.com/goods/23008502" class="main-banner" title="새창이동" target="_blank">
	<picture>
	    <source media="(max-width: 768px)" srcset="../../../../../images/pict/jc-main-banner.jpg">
	    <img src="../../../../../images/pict/jc-main-banner.jpg" alt="대한민국 상생 영수증 콘서트 2022.6.18-6.19 강릉아이스아레나">
	</picture>
	<div class="main-banner-box">
		<span class="main-banner-btn" title="새창이동">티켓예매 +</span>
	</div>
</a>