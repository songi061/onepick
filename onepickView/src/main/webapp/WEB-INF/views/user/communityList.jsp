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
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	  <div class="col-4">
	    <div id="list-example" class="list-group list-group-horizontal">
	      <a class="list-group-item list-group-item-active" id="freeBoard" aria-current="true" href="#list-item-1">자유글</a>
	      <a class="list-group-item list-group-item-action" id="job_hunting" href="#list-item-2">취업준비</a>
	      <a class="list-group-item list-group-item-action" id="turnover" href="#list-item-3">이직</a>
	    </div>
	  </div>
	</div>
	<div class="col-8">
	    <div data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
	      <div id="data_freeBoard">
	      	<table>
	      	</table>	
	      </div>
	      <div id="data_job_hunting">
	      	<table>
			</table>    
	      </div>
	      <div id="data_turnover">
	      	<table>
			</table>
	      </div>
	    </div>
	  </div>
</div>
<script>
	// 게시물 조회 - 자유글
	$(document).ready(function(){
		$('#freeBoard').click(function(){
			
			$.ajax({
				type: 'GET',
				url: '/api/v1/user/community-board',
				dataType: 'json',
				success: function(data){
					console.log(data);
					$(data).empty();
					
					if (data !== null && typeof data === 'List') { // 객체인지 확인
	                    const str = '<ul><li>'+'번호 : '+data.bno +' '+ '제목 : '+data.title + ' '+'내용 : '+data.content +' '+'글쓴이 : '+data.writer.username+'</li></ul>';
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
				url: '/board/getList/',
				dataType: 'json',
				success: function(data){
					console.log(data);
					$(data).empty();
					
					if (data !== null && typeof data === 'object') { // 객체인지 확인
	                    const str = '<ul><li>'+'번호 : '+data.bno +' '+ '제목 : '+data.title + ' '+'내용 : '+data.content +' '+'글쓴이 : '+data.writer.username+'</li></ul>';
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
				url: '/board/getList/',
				dataType: 'json',
				success: function(data){
					console.log(data);
					$(data).empty();
					
					if (data !== null && typeof data === 'object') { // 객체인지 확인
	                    const str = '<ul><li>'+'번호 : '+data.bno +' '+ '제목 : '+data.title + ' '+'내용 : '+data.content +' '+'글쓴이 : '+data.writer.username+'</li></ul>';
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
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>