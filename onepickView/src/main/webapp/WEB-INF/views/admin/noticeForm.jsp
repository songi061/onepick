<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
    <form name="frm">
        <div>
            <p>제목</p><input type="text" name="title">
        </div>
            <p>내용</p><input type="text" name="content">
        </div>
        <input type="submit" onclick="submitForm(event)" value="등록">
    </form>
  <a href="/admin/noticeList">
    <button>목록으로</button>
  </a>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script>
    function submitForm(event){
    	event.preventDefault();
        alert("등록 완료되었습니다.");

        var form = document.forms['frm'];

        var formData = $(form).serialize();

        $.ajax({
            type: 'POST',
            url: 'http://localhost:9001/api/v1/notice',
            data: formData,
            success: function(response){
                console.log(response);
                window.location.href = "/admin/noticeList";
            },
            error: function(error){
            	 console.log("에러 :", error);
                 console.log("에러 상세 정보: ", error.responseText);
            }
        })
    }
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>