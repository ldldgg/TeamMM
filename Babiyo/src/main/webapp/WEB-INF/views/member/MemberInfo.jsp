<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>밀캐시</title>
<style type="text/css">
	#infoBox {
		text-align: center;
		width: 300px;
	}
	


</style>
<link rel="stylesheet" type="text/css" href="/babiyo/resources/css/common.css"/>
<script type="text/javascript" src="/babiyo/resources/js/jquery-3.6.1.js"></script>


<script type="text/javascript">

function moveChargeFnc() {
	location.href ='../cash/chargeCash.do';
}



</script>


</head>
<body>

<div id="rootDiv">

	<jsp:include page="/WEB-INF/views/Header.jsp" />

	<div id="middleDiv">
	
		<jsp:include page="/WEB-INF/views/CommonMiddleDiv.jsp" />
		
		<div id="middleMainDiv">
			<div id="sideTitle"></div>
			<div id="middleDiv">
				<!--여기서 작성 -->
				<div id='infoBox'>
					<p>${_memberDto_.id}님의 보유 밀캐시</p>
					<p>${_memberDto_.cash}원</p>
					
					<span>
					<input type="button" id="charge" value="충전" onclick='moveChargeFnc()'>
					<input type="button" value="충전 내역">	
					<input type="button" value="사용 내역">
					</span>
				</div>
				
			
				<div id="underPadding"></div>
				
			</div>
		
		
		
			<div id="underPadding"></div>
			
		</div> <!--middelMain 끝 -->
	
	</div> <!--middleDiv 끝 -->

	<jsp:include page="/WEB-INF/views/Footer.jsp" />

</div> <!-- rootDiv 끝 -->


</body>
</html>