<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
<!--
	var timer;
	function updateMessageLink(data) {
		$("#numberMessages").text(data.number);
	}

	function onLoad() {
		updatePage();
		startTimer();
		if (timer == null)
			alert("what?");
	}
	
	function startTimer() {
		timer = window.setInterval(updatePage, 5000);
	}
	
	function updatePage() {
		$.getJSON("<c:url value="/getmessages" />", updateMessageLink);
	}
	$(document).ready(onLoad);
//-->
</script>
<a class="title" href="<c:url value='/'/>">OFFERS</a>

<sec:authorize access="!isAuthenticated()">
	<a href='<c:url var="loginUrl" value="/login" />'></a>

	<form class="login" action="${loginUrl}" method="get">
		<input type="submit" value="Login" />
	</form>

</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<a href='<c:url var="logoutUrl" value="/logout" />'></a>

	<form class="login" action="${logoutUrl}" method="post">

		<input type="submit" value="Log out" /> <input type="hidden"
			name="${_csrf.parameterName}" value="${_csrf.token}" />

	</form>
</sec:authorize>

<c:choose>
	<c:when test="${hasOffer}">
		<a class="bar1" href="${pageContext.request.contextPath}/createoffer">Edit
			or delete offer.</a>
	</c:when>
	<c:otherwise>
		<a class="bar1" href="${pageContext.request.contextPath}/createoffer">Add
			a new offer.</a>
	</c:otherwise>
</c:choose>
&nbsp;
<sec:authorize access="hasAuthority('ROLE_ADMIN')">
	<a class="bar3" href="${pageContext.request.contextPath}/admin">Admin
		Page</a>
</sec:authorize>
&nbsp;
<sec:authorize access="isAuthenticated()">
	<a class="bar2" href="<c:url value='/messages' />">Messages(<span
		id="numberMessages">0</span>)
	</a>
</sec:authorize>