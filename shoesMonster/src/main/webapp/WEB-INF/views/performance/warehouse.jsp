<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h2>창고관리</h2>

	<form action="" method="get">
		
		<label>창고코드</label>
			<input type="text" name="wh_code"  placeholder="검색어를 입력해주세요">
		
		<label>품번</label>
			<input type="text" name="" placeholder="검색어를 입력해주세요">
		
		<br>
		
		<label>창고명</label>
		<input type="text" name="wh_name" placeholder="검색어를 입력해주세요">
				
		<label>지역</label>
			<select name="wh_addr" >
				<option selected value="3">전 체</option>
				<option value="1">부산</option>
				<option value="2">창원</option>
			</select>
		
		<label>사용여부</label>
			<select name="wh_use" >
				<option selected value="3">전 체</option>
				<option value="1">Y</option>
				<option value="2">N</option>
			</select>
			
		<input type="submit" value="검색">
	</form>
	
	<table border="1">
		<tr>
			<td></td>
			<td>창고코드</td>
			<td>창고명</td>
			<td>창고유형</td>
			<td>품번</td>
			<td>품명</td>
			<td>지역</td>
			<td>전화번호</td>
			<td>사용여부</td>
			<td>비고</td>
		</tr>
		
		<c:forEach var="ww" items="${whList }" varStatus="i">
			
			<c:if test="${ww.wh_dv == '원자재'}">
				<tr>	
					<td>${i.count }</td>
					<td>${ww.wh_code}</td>
					<td>${ww.wh_name}</td>
					<td>${ww.wh_dv}</td>
					<td>${ww.raw_code }</td>
					<td>${ww.raw.raw_name }</td>
					<td>${ww.wh_addr}</td>
					<td>${ww.wh_tel}</td>
					<td>${ww.wh_use}</td>
					<td>${ww.wh_note}</td>
				</tr>
			</c:if>
			
			<c:if test="${ww.wh_dv == '완제품'}">
				<tr>
					<td>${i.count }</td>
					<td>${ww.wh_code}</td>
					<td>${ww.wh_name}</td>
					<td>${ww.wh_dv}</td>
					<td>${ww.prod_code }</td>
					<td>${ww.prod.prod_name }</td>
					<td>${ww.wh_addr}</td>
					<td>${ww.wh_tel}</td>
					<td>${ww.wh_use}</td>
					<td>${ww.wh_note}</td>
				</tr>
			</c:if>
			
		</c:forEach>
	</table>
<%-- ${whList} --%>