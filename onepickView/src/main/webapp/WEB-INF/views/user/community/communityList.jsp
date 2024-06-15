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
	<div class="col-4">
	    <div id="list-example" class="list-group list-group-horizontal">
			<a class="list-group-item list-group-item-active" id="freeBoard" aria-current="true" href="#list-item-1">자유글</a>
	      	<a class="list-group-item list-group-item-action" id="job_hunting" href="#list-item-2">취업준비</a>
	      	<a class="list-group-item list-group-item-action" id="turnover" href="#list-item-3">이직</a>
	    </div>
	</div>
<div class="col-8">
	<div data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		<div id="data_freeBoard">
			<table id="freeBoard">
				<tr>
					<th>게시글 번호</th><th>제목</th><th>내용</th><th>글쓴이</th><th>조회수</th>
				</tr>
			</table>
		</div>
		<div id="data_job_hunting"><table id="job_hunting"></table></div>
		<div id="data_turnover"><table id="turnover"></table></div>
	</div>
</div>
<script>
	// 게시물 조회 - 자유글
	$(document).ready(function(){
		$('#freeBoard').click(function(){
			$.ajax({
				type: 'GET',
				url: 'http://localhost:9001/api/v1/user/community-board',
				data: { category: "freeBoard"},
				dataType: 'json',
				success: function(data){
					console.log(data);
					$('#data_job_hunting').empty();
					$('#data_turnover').empty();
					
					if (data !== null) {
						let str = '';
						for(var i=0; i<data.length; i++){
							str += '<tr id="'+data[i].ubno+'" class="clickable"><td>'+data[i].ubno +
								'</td> '+ '<td>'+data[i].title + '</td>'+
								'<td>'+data[i].content +'</td>'+
								'<td>'+data[i].user.username+'</td>'+
								'<td>'+data[i].views+'</td></tr>';
						}
						$('#data_freeBoard').html(str);
					}
				},
				error:function(error){
					alert(error);
				}
			});
		});
	});
	
	// 게시물 조회 - 취업준비
	$(document).ready(function(){
		$('#job_hunting').click(function(){
			$.ajax({
				type: 'GET',
				url: 'http://localhost:9001/api/v1/user/community-board',
				data: { category: "job_hunting"},
				dataType: 'json',
				success: function(data){
					console.log(data);
					$('#data_freeBoard').empty();
					$('#data_turnover').empty();
					
					if (data !== null) {
						let str = '';
						for(var i=0; i<data.length; i++){
							str += '<tr id="'+data[i].ubno+'" class="clickable"><td>'+data[i].ubno +
								'</td> '+ '<td>'+data[i].title + '</td>'+
								'<td>'+data[i].content +'</td>'+
								'<td>'+data[i].user.username+'</td>'+
								'<td>'+data[i].views+'</td></tr>';
						}
						$('#data_job_hunting').html(str);
					}
				},
				error:function(error){
					alert(error);
				}
			});
		});
	});
	
	// 게시물 조회 - 이직
	$(document).ready(function(){
		$('#turnover').click(function(){
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
						let str = '';
						for(var i=0; i<data.length; i++){
							str += '<tr id="'+data[i].ubno+'" class="clickable"><td>'+data[i].ubno +
								'</td> '+ '<td>'+data[i].title + '</td>'+
								'<td>'+data[i].content +'</td>'+
								'<td>'+data[i].user.username+'</td>'+
								'<td>'+data[i].views+'</td></tr>';
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
	
	// 정보가 표시되는 div를 button으로 해서 누르면 상세페이지로 이동하게 하기
	// -->행 클릭 시 상세 페이지로 이동

	
	$(document).on('click', '.clickable', function(){
		// let idList = document.querySelectorAll('.clickable').id;
		console.log(this.id);
		window.location.href = '/user/communityList/'+this.id;
	});	
	
	
</script>
</div>
<jsp:include page="..//../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>