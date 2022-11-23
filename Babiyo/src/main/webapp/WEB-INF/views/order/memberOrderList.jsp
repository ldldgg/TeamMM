<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 주문목록</title>

<link rel="stylesheet" type="text/css" href="/babiyo/resources/css/common.css"/>
<script type="text/javascript" src="/babiyo/resources/js/jquery-3.6.1.js"></script>

<style type="text/css">
table{
	border-collapse: collapse;
}

#orderList{
	min-height: 400px;
}

#orderListTable{
	margin: auto;
}
#firstRow{
	background-color: #E0E0E0;
}

#orderDateTh{
	width: 120px;
	height: 30px;
}
#orderNoTh{
	width: 100px;
}
#productNameTh{
	width: 500px;
}
#totalAmountTh{
	width: 100px;
}
#orderStateTh{
	width: 50px;
}
#btnTh{
	width: 80px;
}

.orderDateTd, .orderNoTd, .orderStateTd, .btnTd{
	text-align: center;
}

.totalAmountTd{
	padding-right: 5px;
	text-align: right;
}

.productNameTd{
	padding-left: 10px;
}

td{
	height: 30px;
	border-bottom: 1px solid gray;
}

#detailLink{
	color: black;
	text-decoration: none;
}

#searchOption{
	margin: 5px 50px;
}



</style>

<script type="text/javascript">

$(function(){
	$('#stateSelect').val($('#stateCode').val());
});

function cancelFnc(orderNo){
	
	if(confirm('정말로 주문을 취소하시겠습니가?')){
		location.href = '../cancel.do?orderNo=' + orderNo + '&backPage=list';
	}
}

function stateSelectFnc(){
	
	$('#stateForm').submit();
	
}

</script>

</head>
<body>
<div id="rootDiv">

	<jsp:include page="/WEB-INF/views/Header.jsp" />

	<div id="middleDiv">
	
		<jsp:include page="/WEB-INF/views/CommonMiddleDiv.jsp" />
		
		<div id="middleMainDiv">
			
			<div id='sideTitle'></div>
		
			<div id="searchOption">
				<form id="stateForm" method="get">
					<span>상태</span>
					<select id="stateSelect" name="stateCode" onchange="stateSelectFnc();">
					<option value="0">전체</option>
					<c:forEach items="${stateList}" var="state">
					<option value="${state.CODE}">${state.NAME}</option>
					</c:forEach>
					</select>
				</form>
			</div>
		
			<div id="orderList">
				<table id="orderListTable">
					<tr id="firstRow">
						<th id="orderDateTh">주문일자</th><th id="orderNoTh">주문번호</th>
						<th id="productNameTh">상품명</th><th id="totalAmountTh">결제금액</th>
						<th id="orderStateTh">상태</th><th id="btnTh"></th>
					</tr>
					
					<c:choose>
					<c:when test="true">
					<c:forEach items="${orderList}" var="order">
					<tr>
						<td class="orderDateTd"><fmt:formatDate value="${order.orderDate}"/></td>
						<td class="orderNoTd">${order.no}</td>
						<td class="productNameTd"><a id="detailLink" href="../order/detail.do?orderNo=${order.no}">
							${order.preview}
							<c:choose>
								<c:when test="${order.productQuantity gt 1}">
								 외 ${order.productQuantity-1}건
								</c:when>
							</c:choose>
							</a>
						</td>
						<td class="totalAmountTd"><fmt:formatNumber pattern="#,###" value="${order.totalAmount}"/>원</td>
						<td class="orderStateTd">${order.stateName}</td>
						
						<td class="btnTd">
						<c:choose>
							<c:when test="${order.stateCode eq 1}">
							<input type="button" value="취소" onclick="cancelFnc(${order.no});">
							</c:when>
							<c:when test="${order.stateCode eq 2}">
							<input type="button" value="리뷰쓰기">
							</c:when>
						</c:choose>
						</td>
					</tr>
					</c:forEach>
					</c:when>
					<c:otherwise>
					<tr>
						<td colspan="6">조회할 주문이 없습니다</td>
					</tr>
					</c:otherwise>
					</c:choose>
					
				</table>
				
			</div>
			
			<jsp:include page="/WEB-INF/views/Paging.jsp"/>
		
			<form method="get" id="pagingForm">
				<input type="hidden" id="curPage" name="curPage" value="${paging.curPage}">
				<input type="hidden" id="stateCode" name="stateCode" value="${searchOption.stateCode}">
			</form>
			
			<div id="underPadding"></div>
			
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/Footer.jsp" />

</div>

</body>
</html>