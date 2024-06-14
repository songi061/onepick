<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet">
<link href="css/noticeDetail.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="layout/header.jsp"></jsp:include>
<div class="container">
  <div id="page_title">공지사항</div>
  <div id="detail_wrap">
    <ul id="detail_head">
        <li id="notice">공지</li>
        <li id="title"></li>
        <li id="date"></li>
    </ul>
    <ul id="detail_content">
        <div id="content"></div>
    </ul>
  </div>
  <a href="/noticeList" id="listBtn_wrap">
    <button id="list">목록</button>
  </a>
</div>
<jsp:include page="layout/footer.jsp"></jsp:include>
</body>
<script>
    $(document).ready(function(){

        var nno = ${nno};
        console.log("nno 값:"+ nno);

        $.ajax({
            url: "http://localhost:9001/api/v1/notice/" + nno,
            method: "GET",
            success: function(notice){
                $('#title').text(notice.title);
                // 작성일 처리
                var regdate = notice.regdate ? new Date(notice.regdate) : null;
                var moddate = notice.moddate ? new Date(notice.moddate) : null;

                var formattedDate = '';

                if (regdate) {
                    formattedDate = regdate.getFullYear() + '-' + ('0' + (regdate.getMonth() + 1)).slice(-2) + '-' + ('0' + regdate.getDate()).slice(-2);
                } else if (moddate) {
                    formattedDate = moddate.getFullYear() + '-' + ('0' + (moddate.getMonth() + 1)).slice(-2) + '-' + ('0' + moddate.getDate()).slice(-2);
                }
            
                $('#date').text(formattedDate);

                $('#content').text(notice.content);
        
            },
            error: function(error){
                console.log("에러 :", error);
                console.log("에러 상세 정보: ", error.responseText);
            }
        });

    });

</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>