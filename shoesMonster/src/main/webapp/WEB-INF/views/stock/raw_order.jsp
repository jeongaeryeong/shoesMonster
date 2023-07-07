<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../include/header.jsp"%>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}
</style>
<!-- 폰트 -->

<script type="text/javascript">
	
	// 발주 팝업
	function roPopup() {
		window.open("roPopup","거래처 목록","width=800, height=700, left=300, top=150, location=no");
	}
	
	// 발주 현황 상세페이지
	function detailPopup(rawCode, raw_order_num) {
		window.open("detailPopup?rawCode=" + rawCode + "&raw_order_num=" + raw_order_num, "거래처 상세", "width=650, height=400, left=200, top=150");
	}
	
	// 총액
	function totalAmount() {
		
		var roCount = parseInt(document.getElementById("raw_order_count").value);
		var rawPriceInput = document.getElementById("raw_price").value;
		var rawPrice = parseFloat(rawPriceInput.replace(/,/g, ""));
		
		var totalAmount = roCount * rawPrice;
		
		var fmtAmount = totalAmount.toLocaleString() + "원";
		
		document.getElementById("total_amount").textContent = fmtAmount;
	}
	
	// 창고
	function warehouse() {
		window.open("whPopup","창고 목록","width=400, height=400, left=550, top=150, location=no");
	}
	
	// 체크
	function check() {
		if(document.getElementById("client_actname").value === "") {
			alert("발주 항목을 선택해주세요.");
			return false;
		} else if(document.getElementById("raw_order_count").value === "") {
			alert("발주 수량을 입력해주세요.");
			return false;
		} else if(document.getElementById("wh_code").value === "") {
			alert("입고 창고를 선택해주세요.");
			return false;
		}
	}
	
		
</script>

<!-- page content -->
<div class="right_col" role="main">




<script type="text/javascript">

function toggleDiv(divId) {
    var listDiv = document.getElementById("list");
    var registDiv = document.getElementById("regist");
    
    if(divId === "list"){
   	 listDiv.style.display = "block";
   	registDiv.style.display = "none";
  
   	
    } else if(divId === "regist"){
   
   	 listDiv.style.display = "none";
   	 registDiv.style.display = "block";
    	}
    
    }

	window.onload = function() {
		var listDiv = document.getElementById("list");
		var registDiv = document.getElementById("regist");
		 
		listDiv.style.display = "block";
		registDiv.style.display = "none";
				
	};

</script>
	
<%-- 	<c:if test="${empty emp_id }"> --%>
<%-- 		<c:redirect url="/smmain/smLogin" /> --%>
<%-- 	</c:if> --%>
	
	<h1 style="margin-left: 1%;"> 발주 관리 </h1>

    <div style="margin-left: 1%;">
    
    
    <!-- 버튼 제어 -->
    <form action="" name="ro">
	    <input type="button" value="발주 현황" class="btn btn-info" onclick="toggleDiv('list')" id="matList"></input>
	    <input type="button" value="발주 등록" class="btn btn-info" onclick="toggleDiv('regist')"id="matAdd"></input>
    </form>
    
  		<script>
		    var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
		
		    if (team === "영업팀" || team === "관리자") {
		        document.getElementById("matList").disabled = false;
		        document.getElementById("matAdd").disabled = false;
		    } else {
		        document.getElementById("matList").hidden = true;
		        document.getElementById("matAdd").hidden = true;
		    }
		</script>
	<!-- 버튼 제어 -->
	
	
    </div>

    <hr>

    <div id="list">
	    <form action="" method="get" style="margin: 0 0 1% 1%; ">
		    발주 번호 <input type="text" name="raw_order_num" placeholder="발주 번호를 입력하세요">
		   	품명 <input type="text" name="rawMaterial.raw_name" placeholder="품명을 입력하세요">
	<!-- 	   		품명 <input type="text" name="raw_name" placeholder="품명을 입력하세요"> -->
		   	거래처명 <input type="text" name="clients.client_actname" placeholder="거래처명을 입력하세요"> 
	<!-- 	   	발주 날짜 <input type="date" id="start_date" max=""> ~ <input type="date" id="end_date" max="2023-06-18"> -->
		   	<input type="submit" class="btn btn-info" value="검색"></input>
	    </form>
    
    <!-- ///////////////////////////////////////////////목록 템플릿  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ -->
    
    <div class="col-md-12 col-sm-12">
		<div class="x_panel">
			<div class="x_title">
				<h2> 발주 목록 </h2>
				<span style="float: right; margin-top: 1%;">총 ${count1 }건</span>
				<div class="clearfix"></div>
			</div>
			<div class="x_content" >
				
				<div>
					<form action="" method="post">
						<table class="table table-striped jambo_table bulk_action">
							<thead>
								<tr class="headings">
									<th></th>
									<th class="column-title">발주 번호</th>
									<th class="column-title">거래처명</th>
									<th class="column-title">품번</th>
									<th class="column-title">품명</th>
									<th class="column-title">색상</th>
									<th class="column-title">발주 수량</th>
									<th class="column-title">재고 수량</th>
									<th class="column-title">단가</th>
									<th class="column-title">총액</th>
									<th class="column-title">입고 창고</th>
									<th class="column-title">발주일</th>
									<th class="column-title">담당자</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${ro_List }">
									<tr class="even pointer">
										<td><a onclick="detailPopup('${vo.raw_code}', '${vo.raw_order_num }')" style="font-size:15px">&#128269;</a></td>
										<td class=" ">${vo.raw_order_num }</td>
										<td class=" ">${vo.clients.client_actname }</td>
										<td class=" ">${vo.raw_code }</td>
										<td class=" ">${vo.rawMaterial.raw_name }</td>
										<td class=" ">${vo.rawMaterial.raw_color }</td>
										<td class=" ">${vo.raw_order_count}</td>
										<td class=" " style="color: ${vo.stock.stock_count <= 20 ? 'red' : 'inherit'}">${vo.stock.stock_count != null ? vo.stock.stock_count : 0}</td>
										<td class=" "><fmt:formatNumber value=" ${vo.rawMaterial.raw_price}" />원</td>
										<td class=" "><fmt:formatNumber value=" ${vo.rawMaterial.raw_price*vo.raw_order_count}" />원</td>
										<td class=" ">${vo.rawMaterial.wh_code }</td>
										<td class=" ">${vo.raw_order_date}</td>
										<td class=" ">${vo.emp_id }</td>
										
									</tr>

								</c:forEach>
							</tbody>
						</table>
					</form>

				</div>
			</div>
		</div>
		<div>
   		<c:if test="${count1 > 10 }">
			<c:if test="${bp.prev}">

			    <a class="btn btn-secondary" href="/stock/raw_order?page=${bp.startPage - 1}&raw_order_num=${param.raw_order_num}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">이전</a>

			</c:if>
			
			<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
			    <a class="btn btn-secondary" href="/stock/raw_order?page=${idx}&raw_order_num=${param.raw_order_num}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">${idx}</a>
			</c:forEach>
			
			<c:if test="${bp.next && bp.endPage > 0}">

			    <a class="btn btn-secondary" href="/stock/raw_order?page=${bp.endPage + 1}&raw_order_num=${param.raw_order_num}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">다음</a>

			</c:if>
		</c:if>
		</div>

	</div>
    
	</div>
    
    <!-- //////////////////////////////////목록 템플릿  /////////////////////////////////////// -->
    
    
	
	<!-- ============================ 발주 현황 ============================ -->
	
	
	
	
	
	<!-- ============================ 발주 등록 ============================ -->

	<div id="regist">

		<form action="" method="post" onsubmit="return check()">
			<c:set var="today" value="<%=new Date()%>" />

			<table border="1">
			<tr>
				<th>입고 창고</th>
				<td onclick="roPopup();"><input type="text" name="wh_code" id="wh_code" readonly></td>
			</tr>
		</table>
			<br>
						<div class="table-responsive">
							<table id="table"
								class="table table-striped jambo_table bulk_action">
								<thead>
									<tr class="headings">
										<th class="column-title">발주일</th>
										<th class="column-title">거래처 코드</th>
										<th class="column-title">거래처명</th>
										<th class="column-title">품번</th>
										<th class="column-title">품명</th>
										<th class="column-title">색상</th>
										<th class="column-title">발주 수량</th>
										<th class="column-title">재고 수량</th>
										<th class="column-title">단가</th>
										<th class="column-title">총액</th>
										<th class="column-title">담당자</th>
										<!-- 발주번호처럼 '발주 신청' 버튼 눌렀을 때 저장하기 -->
									</tr>
								</thead>
								<tbody>

									<tr class="even pointer">
										<td class=" "><input type="text" name="raw_order_date"
											value="<fmt:formatDate value="${today }" pattern="yyyy-MM-dd"/>"
											readonly></td>
										<td class=" " onclick="roPopup();"><input type="text" 
											name="client_code" id="client_code" readonly></td>
										<td class=" " onclick="roPopup();"><input type="text" 
											name="client_actname" id="client_actname" required readonly></td>
										<td class=" " onclick="roPopup();"><input type="text" 
											name="raw_code" id="raw_code" readonly></td>
										<td class=" " onclick="roPopup();"><input type="text" 
											name="raw_name" id="raw_name" readonly></td>
										<td class=" " onclick="roPopup();"><input type="text" 
											name="raw_color" id="raw_color" readonly></td>
										<td class=" "><input type="number"  min="1"
											id="raw_order_count" name="raw_order_count"
											oninput="totalAmount()"></td>
										<!-- CSS할 때 증감버튼 없애기 -->
										<td class=" ">
											<input type="text" style="color: ${rvo.stock.stock_count <= 20 ? 'red' : 'inherit'}" name="stock_count" id="stock_count" readonly>
										</td>
										<td class=" "><input type="text"  name="raw_price"
											id="raw_price" readonly></td>
										<td id="total_amount" class=" "></td>
										<td class=" ">${sessionScope.id.emp_id }</td>

									</tr>


								</tbody>
							</table>
							<input type="submit" class="btn btn-info" value="발주 신청">
							</div>
							
							</form>
						</div>

	
	<!-- ============================ 발주 등록 ============================ -->
	

	<!-- ============================ 발주 등록 ============================ -->
	
<!-- ============================ 발주 등록 ============================ -->
	</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


