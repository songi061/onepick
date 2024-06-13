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
<jsp:include page="layout/header.jsp"></jsp:include>
<div class="container">
  <h1>Q&A</h1>
  <a href="/qnaEdit?bno=${bno}"><button id="editBtn">수정</button></a>
  <button id="deleteBtn">삭제</button>
  
  <ul id="detail_wrap">
    <li id="detail_head">
        <p>제목</p><div id="title"></div>
        <ul id="detail_info">
            <li id="category"></li>
            <li id="username"></li>
            <li id="date"></li>
        </ul>
    </li>
    <li id="detail_content">
        <p>내용</p><div id="content"></div>
        <div id="response"></div>
    </li>
  </ul>
  <a href="/qnaList">
    <button>목록</button>
  </a>
</div>
<jsp:include page="layout/footer.jsp"></jsp:include>
</body>
<script>
    $(document).ready(function(){

        var bno = ${bno};
        console.log("bno 값:"+ bno);

        $.ajax({
            url: "http://localhost:9001/api/v1/qna/" + bno,
            method: "GET",
            success: function(qna){
                $('#title').text(qna.title);
                $('#category').text(qna.category);

                if(qna.user && qna.user.username){
                    $('#username').text(qna.user.username);
                }else if(qna.company && qna.company.username){
                    $('#username').text(qna.company.username);
                }

                // 작성일 처리
                var regdate = qna.regdate ? new Date(qna.regdate) : null;
                var moddate = qna.moddate ? new Date(qna.moddate) : null;

                var formattedDate = '';

                if (regdate) {
                    formattedDate = regdate.getFullYear() + '-' + ('0' + (regdate.getMonth() + 1)).slice(-2) + '-' + ('0' + regdate.getDate()).slice(-2);
                } else if (moddate) {
                    formattedDate = moddate.getFullYear() + '-' + ('0' + (moddate.getMonth() + 1)).slice(-2) + '-' + ('0' + moddate.getDate()).slice(-2);
                }
                
                $('#date').text(formattedDate);

                $('#content').text(qna.content);
                $('#response').text(qna.response);

                $("#editBtn").on("click", function(){
                    window.location.href ="/qnaEdit?bno=" + bno;
                });

                $("#deleteBtn").on("click", function(event){
                    confirmDelete(event, bno);
                });
            },
            error: function(error){
                console.log("에러 :", error);
                console.log("에러 상세 정보: ", error.responseText);
            }
        });

    });

    function confirmDelete(event,bno) {
        if (confirm("정말 삭제하시겠습니까?")) {
            deleteQna(bno);
        }
    }

    function deleteQna(bno){
        event.preventDefault();
        $.ajax({
            url: "http://localhost:9001/api/v1/qna/" + bno,
            method: "DELETE",
            success: function(response){
                alert("삭제되었습니다.");
                console.log(response);
                window.location.href = "/qnaList";
            },
            error: function(error){
                console.log("에러 :", error);
                console.log("에러 상세 정보: ", error.responseText);
            }
        });
    }
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>