<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="layout/header.jsp"></jsp:include>
<div class="container">
	<div id="search-box">
		<input type="text" name="search" size="50">
	</div>
	<div id="search_result"></div>
</div>

<script>
// 검색 결과 불러오기
$(document).ready(function(){
	$('#turnover').change(function(){
		$.ajax({
			type: 'GET',
			url: 'http://localhost:9001/api/v1/user/community-board',
			data: { category: "turnover"},
			dataType: 'json',
			success: function(data){
				console.log(data);
				$('#data_freeBoard').empty();
				$('#data_job_hunting').empty();
				
				if (data !== null) {
					let str = '<tr><th>'+'번호'+'<th>'+'제목'+'<th>'+'내용'+'<th>'+'글쓴이'+'</th></tr>';
					for(var i=0; i<data.length; i++){
						str += '<tr id="'+data[i].ubno+'" class="clickable"><td>'+data[i].ubno +'</td> '+ '<td>'+data[i].title + '</td>'+'<td>'+data[i].content +'</td>'+'<td>'+data[i].user.username+'</td></tr>';
					}
					$('#data_turnover').html(str);
				}
			},
			error:function(error){
				alert(error);
			}
		});
	});
});
</script>
<jsp:include page="layout/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>