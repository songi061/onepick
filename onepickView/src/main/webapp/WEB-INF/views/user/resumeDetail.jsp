<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container">

<h1>이력서 상세페이지</h1>
<hr>


<div id="demo"></div>

</div>

<script>
$(document).ready(function() {
	
	var rno = <%= request.getAttribute("rno") %>;
    // AJAX 요청 보내기
	$.ajax({
	    url: 'http://localhost:9001/api/v1/resume/' + rno,
	    type: 'GET',
	    dataType: 'json',
	    /* headers: {
	        'Authorization': 'Bearer ' + token,
	        'writer': token_writer,
	        'role': token_role
	    }, */
	    success: function(data) {
	        console.log(data);
	        var resume = $('#demo');
	        resume.empty();
	        
	        var ul = $('<ul class="res"></ul>'); 
	        
	        if(data.disclo == "public"){
	        	 ul.append('<li>공개 이력서</li>');
	        }else{
	        	ul.append('<li>비공개 이력서</li>');
	        }
	        
	        ul.append('<li>'+ data.title +'</li>');
	        
	        ul.append('<li>기본정보</li>');
	        ul.append('<li>이름 : '+ data.user.name +'</li>');
	        ul.append('<li>E : '+ data.user.email +'</li>');
	        ul.append('<li>T : '+ data.user.tel +'</li>');
	        ul.append('<li>A : '+ data.user.addr +'</li>');
	        ul.append('<li>성별 : '+ data.user.gender +'</li>');
	        ul.append('<li>생년월일 : '+ data.user.birthDate +'</li>');
	        
	        ul.append('<li>'+ data.user.birthDate +'</li>');
	        
	        ul.append('<li>'+ data.selfInfoTitle +'</li>');
	        ul.append('<li>'+ data.selfInfoContent +'</li>');
	        
	        resume.append(ul);
	    },
	    error: function(xhr, status, error) {
	        console.error('AJAX 요청 실패:', status, error);
	    }
	});
});
</script>

<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>