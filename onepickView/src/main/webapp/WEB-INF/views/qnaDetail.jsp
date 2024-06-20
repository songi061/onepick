<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet">
<link href="css/qnaDetail.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="layout/header.jsp"></jsp:include>
<div class="container">
  <div class="page_title">Q&A</div>
  <div id="qnaBtn_wrap">
    <a href="/qnaEdit?bno=${bno}" id="qnaBtn_a"><button id="editBtn" class="qnaBtn">수정</button></a>
    <button id="deleteBtn" class="qnaBtn">삭제</button>
  </div>

  <ul id="detail_wrap">
    <li id="detail_head">
        <div id="title">제목</div>
        <ul id="detail_info">
            <li id="category">카테고리</li>
            <li id="username">user</li>
            <li id="date">2024-06-17</li>
        </ul>
    </li>
    <li id="detail_content">
        <div id="content">내용입니다</div>
        <div id="response"></div>
    </li>
  </ul>
    <button id="qnaListButton">목록</button>
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

                if (qna.response) {
                $('#editBtn').hide(); // response에 내용이 있을 경우 수정 버튼 숨기기
                } else {
                    $("#editBtn").on("click", function(){
                        window.location.href ="/qnaEdit?bno=" + bno;
                    });
                }
                
                if(!qna.response){
                	$('#response').hide();
                }

                $("#deleteBtn").on("click", function(event){
                    confirmDelete(event, bno);
                });
                
                // 버튼 클릭 이벤트 핸들러 추가
                $('#qnaListButton').on('click', function(event) {
                    event.preventDefault(); // 기본 동작 방지

                    const storedUsername = localStorage.getItem("username"); // 로컬 스토리지에서 username 가져오기
                    
                    if (qna.user && qna.user.username === storedUsername) {
                        window.location.href = "/user/myQnaList";
                    } else if (qna.company && qna.company.username === storedUsername) {
                        window.location.href = "/company/myQnaList";
                    } else if (storedUsername === "admin") {
                        window.location.href = "/admin/qnaList";
                    } else {
                        alert("해당 사용자 또는 기업의 QnA 리스트가 없습니다.");
                    }
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
            success: function(qna){
                alert("삭제되었습니다.");
                
                if (localStorage.getItem("role") === 'ROLE_USER') {
                    window.location.href = "/user/myQnaList";
                } else if (localStorage.getItem("role") === 'ROLE_COMPANY') {
                    window.location.href = "/company/myQnaList";
                } else if (localStorage.getItem("role") === 'ROLE_ADMIN') {
                    window.location.href = "/admin/qnaList";
                }
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