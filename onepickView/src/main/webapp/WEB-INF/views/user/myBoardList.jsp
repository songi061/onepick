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
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	<div class="sidebar">
	    <ul>
	        <li><a href="#">내가 쓴 글 목록</a></li>
	        <li><a href="#">내가 쓴 댓글 목록</a></li>
	    </ul>
	</div>
	<div class="myBoard" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		<table id="input_result">
			<!--  
			<tr>
				<th>카테고리</th>
				<th>게시글 번호</th>
				<th>제목</th>
				<th>내용</th>
			</tr>	
			-->	
			
		</table>
	</div>

<script>
// 내가 쓴 게시물 조회
$(document).ready(function(){
	
	var username_ = userStorage.getItem("username");
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/user/community-myboard?username='+username_,
		// data: { category: "freeBoard"},
		dataType: 'json',
		success: function(data){
			console.log(data);
			
			if (data !== null) {
				//let str = '<tr><th>'+'번호'+'<th>'+'제목'+'<th>'+'내용'+'<th>'+'글쓴이'+'</th></tr>';
				for(var i=0; i<data.length; i++){
					str += '<tr id="'+data[i].ubno+'" class="clickable"><td>'+data[i].category +
					'</td> '+ '<td>'+data[i].ubno + '</td>'+'<td>'+data[i].title +
					'</td>'+'<td>'+data[i].content+'</td></tr>';
				}
				$('#input_result').html(str);
			}
		},
		error:function(error){
			alert(error);
		}
	});
});



</script>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>