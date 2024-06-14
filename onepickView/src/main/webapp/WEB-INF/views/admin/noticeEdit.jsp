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
            <p>제목</p><input type="text" name="title" id="title">
        </div>
            <p>내용</p><input type="text" name="content" id="content">
        </div>
        <input type="submit" onclick="submitForm(event)" value="수정">
        <input type="hidden" name="nno" id="nno" value="${nno}">
    </form>
  <a href="/admin/noticeList">
    <button>목록으로</button>
  </a>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script>
    $(document).ready(function(){
        var nno = ${nno};
        console.log("nno 값:"+ nno);
        $.ajax({
            url: "http://localhost:9001/api/v1/notice/" + nno,
            method: "GET",
            success: function(notice){
                $("#title").val(notice.title);
                $("#content").val(notice.content);
                $("#nno").val(notice.nno);

                console.log("제목:"+ notice.title);
                console.log("내용:"+ notice.content);
                console.log("글번호:"+ notice.nno);

            },
            error: function(error){
                console.log("에러 :", error);
                console.log("에러 상세 정보: ", error.responseText);
            }
        });
    });


	
    function submitForm(event){
    	event.preventDefault();
        alert("등록 완료되었습니다.");

        var form = document.forms['frm'];
        var formData = $(form).serialize();

        $.ajax({
            type: 'PUT',
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