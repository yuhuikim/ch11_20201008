<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- jstl -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 반응형 웹 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- bootstrap, jquery -->
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<link href="${path}/resources/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${path}/resources/js/jquery.js"></script>
<script type="text/javascript"
	src="${path}/resources/js/bootstrap.min.js"></script>
<!-- css 디자인 c + s + ?주 석 -->
<style>
caption {
	font-size: 30px;
}

.err {
	color: red;
	font-weight: bold;
}
</style>