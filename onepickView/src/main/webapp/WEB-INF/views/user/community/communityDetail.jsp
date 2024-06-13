<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="..//../layout/header.jsp"></jsp:include>
<div class="container">
<h3>구직자 커뮤니티</h3>
<div id="board_detail">
	<table id="data_board_detail">
	</table>
</div>
<div id="reply_regist">
	<input type="text" name="content">
	<input type="submit" value="등록">
</div>
<div id="reply_detail">
	<table id="data_reply_detail">
	</table>
</div>

<script>
$(document).ready(function(){
	const ubno = ${ubno};
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/user/community-board/'+ubno,
		//data: { ubno: "job_hunting"},
		dataType: 'json',
		success: function(data){
			console.log(data);
			$(data).empty();
			
			if (data !== null) {
				let str = '';
				str += '<tr><td>'+data.category +'</td></tr> '+ '<tr><td>'+data.title + '</td></tr>'+'<tr><td>'+data.views +
				'</td></tr>'+'<tr><td>'+data.user.username+'</td></tr>'+'<tr><td>'+data.regdate + '</td></tr>'+
				'<tr><td>'+data.view+'</td></tr>';
				$('#data_board_detail').html(str);
			}
		},
		error:function(error){
			alert(error);
		}
	});
});

$(document).ready(function(){
	const ubno = ${ubno};
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/user/community-comment?ubno='+ubno,
		data: { ubno: ubno},
		dataType: 'json',
		success: function(data){
			console.log(data);
			$(data).empty();
			
			if (data !== null) {
				let str = '';
				str += '<tr><td>'+data.reply_content+'</td></tr>'+'<tr><td>'+data.reply_username+'</td></tr>'+'<tr><td>'+data.reply_report+'</td></tr>'+'<tr><td>'+data.regdate+'</td></tr>';
				$('#data_reply_detail').html(str);
			}
		},
		error:function(error){
			alert(error);
		}
	});
});


</script>
</div>
<jsp:include page="..//../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>