<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<b>Messages:</b>
<br>
<br>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>


<div id="messages"></div>

<script type="text/javascript">
<!--
	function showReply(i) {
		stopTimer();
		$("#form" + i).toggle();
	}

	function success() {
		alert("success");
	}

	function error() {
		alert("error");
	}

	function sendMessage(i, name, email) {

		var text = $("#textbox"+ i).val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		$.ajax({
			"type" : 'POST',
			"url" : '<c:url value="/sendmessage" />',
			"data" : JSON.stringify({"text": text, "name": name, "email": email}),
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
				},
			"success" : success,
			"error" : error,
			contentType : "application/json",
			dataType : "json"
		});
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
			textArea.setAttribute("class", "replyarea");
			textArea.setAttribute("id", "textbox" + i);

			var replyButton = document.createElement("input");
			replyButton.setAttribute("class", "replybutton");
			replyButton.setAttribute("value", "Reply");
			replyButton.setAttribute("type", "button");
			replyButton.onclick = function(j, name, email) {
				return function() {
					sendMessage(j, name, email);
				}
			}(i, message.name, message.email);

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
		startTimer();
	}

	function startTimer() {
		timer = window.setInterval(updatePage, 5000);
	}

	function stopTimer() {
		window.clearInterval(timer);
	}

	function updatePage() {
		$.getJSON("<c:url value="/getmessages" />", updateMessageLink);
		$.getJSON("<c:url value="/getmessages" />", updateMessageNumber);
	}
//-->
</script>