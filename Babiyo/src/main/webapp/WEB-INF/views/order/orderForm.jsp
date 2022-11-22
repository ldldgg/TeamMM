<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문화면</title>

<link rel="stylesheet" type="text/css" href="/babiyo/resources/css/common.css"/>
<script type="text/javascript" src="/babiyo/resources/js/jquery-3.6.1.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">

#title{
	text-align: center;
	padding-top: 30px;
	margin: 0px 0px 30px 0px;
}

#receiverDiv {
	position: relative;
	margin-left: 50px;
	box-sizing: border-box;
	width: 550px;
	height: 500px;
	padding: 30px;
	border: 1px solid black;
	border-radius: 20px;
	float: left;
}
#receiverTitle{
	position: absolute;
	top: -14px; 
	left: 40px;
	font-size:20px; 
	font-weight: bold;
	background-color: white;
	padding: 0px 5px;
}

.receiverInfo {
	display: inline-block;
	width: 200px;
}

.receiverInput {
	width: 270px;
}

.receiverInfoDiv {
	margin-top: 20px;
}

#post{
	width: 80px;
}

#requestInfo {
	float: left;
}

#requestText {
	resize: none;
	margin-left: 6px;
	height: 200px;
}

#paymentInfoDiv {
	margin: 0px 0px 0px 650px;
	width: 500px;
	min-height: 500px;
}


#mealkitListDiv{
	height: 280px;

} 

#mealkitUl{
	list-style: none;
	padding: 0px;
}


#mealkitListP,#balanceName,#totalAmountName{
	font-weight: bold;
}

#balanceMoney, #totalAmountMoney{
	float: right
}

.mealkitName{
	display: inline-block;
	width: 300px;
}
.mealkitQuantity{
	display: inline-block;
	float: right;
	text-align: right;
}
.mealkitPrice{
	margin-left: 20px;
	text-align: right;
	width: 100px;
	float: right;
}



#orderBtn, #backBtn{
	width:240px;
	height:40px;
}

#backBtn{
	margin-left: 12px;
}

</style>
<script type="text/javascript">

$(document).ready(function(){
	
	var totalAmount = 0;
	
	$('.price').each(function(i, element) {
		totalAmount += Number($(element).val()) * Number($('.quantity').eq(i).val());
	});
	
	var htmlStr = totalAmount.toLocaleString('ko-KR') + '원';
	
	$('#totalAmount').val(totalAmount);
	$('#totalAmountMoney').html(htmlStr);
	
	
	
	$('#orderBtn').click(function(){
		
		var str = '';
		
		if(!$('#receiverName').val()){
			str = '받으시는 분 성함을 입력해주세요';
			$('#receiverName').focus();
		}else if(!$('#receiverPhone').val()){
			str = '받으시는 분 연락처를 입력해주세요';
			$('#receiverPhone').focus();		
		}else if(!$('#post').val()){
			str = '우편번호를 입력해주세요';
			$('#post').focus();
		}else if(!$('#addressDetail').val()){
			str = '상제주소를 입력해주세요';
			$('#addressDetail').focus();
		}else{
			return $('#receiverForm').submit();
		}
		
		alert(str);
		
	});
	
	$('#backBtn').click(function(){
		location.href = document.referrer;
	});
	
});


function postFind() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
            }
            
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('post').value = data.zonecode;
            document.getElementById("address").value = addr + extraAddr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("addressDetail").focus();
        }
    }).open();
}


</script>

</head>

<body>

<div id="rootDiv">

	<jsp:include page="/WEB-INF/views/Header.jsp" />

	<div id="middleDiv">
	
		<div id='centerTitle'></div>
		
		<div id="receiverDiv">
			
			<span id="receiverTitle">받는사람 정보</span>

			<form action="./orderCtr.do" method="post" id="receiverForm">
				<div class="receiverInfoDiv">
					<span class="receiverInfo">받으시는 분 성함</span>
					<input type="text" name="receiverName" id="receiverName" class="receiverInput"
						 value="${_memberDto_.name}">
				</div>
				<div class="receiverInfoDiv">
					<span class="receiverInfo">받으시는 분 연락처</span>
					<input type="text" name="receiverPhone" id="receiverPhone" class="receiverInput" 
						value="${_memberDto_.phone}">
				</div>
				<div class="receiverInfoDiv">
					<span class="receiverInfo">우편번호</span> 
					<input type="text" name="post" id="post" class="receiverInput" readonly="readonly">
					<input type="button" onclick="postFind()" value="우편번호 찾기">
				</div>
				<div class="receiverInfoDiv">
					<span class="receiverInfo">배송지 입력</span> 
					<input type="text" name="address" id="address" class="receiverInput" readonly="readonly">
				</div>
				<div class="receiverInfoDiv">
					<span class="receiverInfo">상세주소</span>
					<input type="text" name="addressDetail" id="addressDetail" class="receiverInput">
				</div>
				<div class="receiverInfoDiv">
					<span id="requestInfo" class="receiverInfo">배송 시 요청사항</span>
					<textarea name="request" id="requestText" class="receiverInput"></textarea>
				</div>
				
				<div>
					<c:forEach items="${orderDetailList}" var="mealkit" varStatus="status">
						<input type="hidden" name="orderDetailList[${status.index}].productNo" value="${mealkit.productNo}">
						<input type="hidden" class="quantity" name="orderDetailList[${status.index}].quantity" value="${mealkit.quantity}">
						<input type="hidden" class="price" name="orderDetailList[${status.index}].price" value="${mealkit.price}">
					</c:forEach>
					<input type="hidden" id="totalAmount" name="totalAmount" value="">
					<input type="hidden" id="memberId" name="memberId" value="${_memberDto_.id}">
					<input type="hidden" name="preview" value="${orderDetailList[0].productName}">
					<input type="hidden" name="productQuantity" value="${fn:length(orderDetailList)}">
					<c:forEach items="${cartDto.cartList}" var="cart" varStatus="status">
						<input type="hidden" name="cartList[${status.index}].no" value="${cart.no}">
					</c:forEach>
				</div>
				
				
				
			</form>

		</div>
		<div id="paymentInfoDiv">
			<div id="mealkitListDiv">
				<p id="mealkitListP">품목</p>
				<ul id="mealkitUl">
					<c:forEach items="${orderDetailList}" var="mealkit">
						<li>
							<span class="mealkitName">${mealkit.productName}</span>
							<span class="mealkitPrice">
							<fmt:formatNumber pattern="#,###">${mealkit.price * mealkit.quantity}</fmt:formatNumber>원
							</span>
							<span class="mealkitQuantity">${mealkit.quantity}개</span>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div>
				<p>
					<span id="balanceName">보유금액</span>
					<span id="balanceMoney"><fmt:formatNumber pattern="#,###">${_memberDto_.cash}</fmt:formatNumber>원</span>
				</p>
				<p>
					<span id="totalAmountName">총 결제금액</span> <span id="totalAmountMoney"></span>
				</p>
			</div>

			<p>위 내용을 확인하였으며 결제에 동의합니다</p>
			<hr>
			<input id="orderBtn" type="button" value="결제하기">
			<input id="backBtn" type="button" value="뒤로가기">
			
		</div> <!-- paymentDiv 끝 -->

		<div id="underPadding"></div>
	
	</div> <!-- middleDiv 끝 -->
	
	<jsp:include page="/WEB-INF/views/Footer.jsp" />

</div>

</body>
</html>