<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	height: 450px;
	border: 2px solid green;
	table-layout: fixed;
	overflow: hidden;
}

#chatMessage {
	height: 400px;
	overflow: scroll;
}
</style>
<script type="text/javascript">
	var websocket; // 웹 소캣 변수, 전역변수로 사용하기 위해서 !!
	$(function() {
		//enterBtn 버튼을 누르면 connect를 실행시키라는 것이다.
		$('#enterBtn').click(function() {
			connect();
		});
		$('#exitBtn').click(function() {
			disconnect();
		});
		$('#sendBtn').click(function() { // 전송버튼
			send();
		});
		$('#message').keypress(function() { // enter키 처리
			//          인터넷 익스플로러면? IE key값 : IE 아닌 key값
			var keycode = event.keyCode ? event.keyCode : event.which;
			if (keycode == 13) { // enter키를 13이라고 함
				send();
			}
			event.stopPropargation(); // 이벤트를 전달하지 말라는 뜻
		});
	});
	function connect() {
		websocket = new WebSocket("ws://172.30.1.15:8888/ch11/chat-ws.do");
		websocket.onopen = onOpen;
		websocket.onmessage = onMessage;
		websocket.onclose = onClose;
	}
	function onOpen() {
		var nickname = $('#nickname').val();
		appendMessage(nickname + "님이 입장하였습니다.");
	}
	function onMessage(event) {
		var msg = event.data; //메세지는 event의 data로 들어온다.
		appendMessage(msg);
	}
	function onClose() {
		var nickname = $('#nickname').val();
		appendMessage(nickname + "님이 퇴장하였습니다.");
	}
	function appendMessage(msg) {
		$('#chatMessage').append(msg + '<br>');
		// scrollBar를 아래로 내리란 의미
		var objDiv = document.getElementById("chatMessage");
		objDiv.scrollTop = objDiv.scrollHeight;
	}
	function disconnect() {
		websocket.close();
	}
	function send() {
		var nickname = $('#nickname').val(); // 별명
		var msg = $('#message').val(); // 메세지
		websocket.send(nickname + "=>" + msg); // 별명과 메세지를 묶어서 보낸다.
		$('#message').val(""); // 입력한 메세지 삭제
	}
</script>

</head>
<body>
	<div class="container">
		<table class="table table-hover">
			<tr>
				<td>별명</td>
				<td><input type="text" id="nickname"> <input
					type="button" id="enterBtn" value="입장" class="btn btn-sm btn-info">
					<input type="button" id="exitBtn" value="퇴장"
					class="btn btn-sm btn-warning"></td>
			</tr>
			<tr>
				<td>메세지</td>
				<td><input type="text" id="message"> <input
					type="button" id="sendBtn" value="전송"
					class="btn btn-success btn-sm"></td>
			</tr>
			<tr>
				<td>대화영역</td>
				<td><div id="chatMessage"></div></td>
			</tr>
		</table>
	</div>
</body>
</html>