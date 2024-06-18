<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<div class="page_title"><h3>기업 커뮤니티</h3></div>
    <form class="communityEditForm" id="communityEditForm">
        <div class="col-12">
            제목<input type="text" name="title" class="form-control" id="inputTitle">
        </div>
        <div class="col-md-6">
        	내용<textarea class="form-control" id="inputContent" name="content"></textarea>
        </div>
        <div class="col-md-4">
	        <label for="inputState" class="form-label">카테고리</label>
	        <select id="category" class="form-select">
	        	<option selected>카테고리를 선택하세요</option>
	            <option value="freeBoard">자유글</option>
		        <option value="information">정보공유</option>
		        <option value="dispatch">파견</option>
		        <option value="seminar">세미나</option>
	        </select>
        </div>
        <div class="col-12">
        	<button type="submit" id="btn-boardRegist">수정하기</button>
        </div>
    </form>
</div>
<script>
const cbno = ${cbno};
console.log("yyyyyyyyyyyyyyyyyy"+cbno)
let input_title = document.getElementById('inputTitle');
let input_content = document.getElementById('inputContent');
const selected = document.getElementById('category');

// 게시글 디테일 불러오기
$(document).ready(function(){
	$.ajax({
		type: 'GET',
		url: 'http://localhost:9001/api/v1/company/community-board/'+cbno,
		dataType: 'json',
		success: function(data){
 			console.log(data);
			$(data).empty();
			writer = data.company.username;
			console.log(data.company.username)
			if (data !== null) {
				input_title.value = data.title;
				input_content.value = data.content;
				
			    for (let i = 0; i < $('#category')[0].options.length; i++) {
                	if ($('#category')[0].options[i].value == data.category) {
                		$('#category')[0].options[i].selected = true;
                		break;
               		}
				}
			}
		},
		error:function(error){
			alert(error);
		}
	});
});

// 수정한 게시글 등록하기
$(document).ready(function(){
	$('#communityEditForm').submit(function(event){
		event.preventDefault();
		var title = $('input[name=title]').val();
		var content = $('textarea[name=content]').val();
		var category = $('#category').val();
		console.log("xxxxxxx cbno =" + cbno)
		console.log("수정한 title:"+title)
		console.log("수정한 content:"+content)
		console.log("수정한 category:"+category)
		//console.log("수정한 username:"+username)
		
		$.ajax({
		    type: 'PUT',
			url: 'http://localhost:9001/api/v1/company/community-board',
			headers: {
				"jwtToken" : localStorage.getItem("jwtToken"),
			    "username" : localStorage.getItem("username"),
			    "role" : localStorage.getItem("role")
			},
			data: JSON.stringify({
				cbno: cbno,
                title: title,
                content: content,
                category: category
			}),
			contentType: 'application/json; charset=utf-8',
			dataType:'text',
			success: function(data){
				if(data == "수정완료"){
					console.log("fffffffffffffffffffffffffffff");
					alert("수정완료");
					
					
					location.href="/company/communityList?cbno="+cbno;
				}
				
			},
			error: function(xhr, status, error) {
				// 요청이 실패한 경우 처리할 코드
				console.error(xhr.status)
			}
		});
	});
});
</script>
<jsp:include page="..//../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>