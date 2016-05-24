<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<b>Messages:</b>
<br>
<br>

<div id="messages"></div>

<script type="text/javascript">
<!--
	function showReply(i) {
		$("#form" + i).toggle();
	}
	function updateMessageLink(data) {

		$("div#messages").html("");
		for (var i = 0; i < data.messages.length; i++) {
			var message = data.messages[i];

			var messageDiv = document.createElement("div");
			messageDiv.setAttribute("class", "message");

			var subjectSpan = document.createElement("span");
			subjectSpan.setAttribute("class", "subject");
			subjectSpan.appendChild(document.createTextNode(message.subject));

			var contentSpan = document.createElement("span");
			contentSpan.setAttribute("class", "contentbody");
			contentSpan.appendChild(document.createTextNode(message.content));

			var nameSpan = document.createElement("span");
			nameSpan.setAttribute("class", "namebody");
			nameSpan.appendChild(document.createTextNode(message.name + " ("));

			var link = document.createElement("a");
			link.setAttribute("class", "replylink");
			link.setAttribute("href", "#");
			link.setAttribute("onclick", "showReply(" + i + ")");
			link.appendChild(document.createTextNode(message.email));
			nameSpan.appendChild(link);

			nameSpan.appendChild(document.createTextNode(")"));

			var replyForm = document.createElement("form");
			replyForm.setAttribute("class", "replyform");
			replyForm.setAttribute("id", "form" + i);

			var textArea = document.createElement("textarea");
			textArea.setAttribute("class", "replyname");

			var replyButton = document.createElement("input");
			replyButton.setAttribute("class", "replybutton");
			replyButton.setAttribute("value", "Reply");
			replyButton.setAttribute("type", "button");

			replyForm.appendChild(textArea);
			replyForm.appendChild(replyButton);

			messageDiv.appendChild(subjectSpan);
			messageDiv.appendChild(contentSpan);
			messageDiv.appendChild(nameSpan);
			messageDiv.appendChild(replyForm);

			$("div#messages").append(messageDiv);
		}
	}

	function updateMessageNumber(data) {
		$("#numberMessages").text(data.number);
	}

	function onLoad() {
		updatePage();
		window.setInterval(updatePage, 10000);
	}

	function updatePage() {
		$.getJSON("<c:url value="/getmessages" />", updateMessageLink);
		$.getJSON("<c:url value="/getmessages" />", updateMessageNumber);
	}
	$(document).ready(onLoad);
//-->
</script>