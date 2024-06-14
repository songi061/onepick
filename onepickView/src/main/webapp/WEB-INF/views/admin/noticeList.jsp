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
  <h1>공지사항</h1>
    <table class="table">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일자</th>
            </tr>
        </thead>
        <tbody id="noticeTableBody">
            <!-- AJAX로 데이터가 삽입될 부분 -->
        </tbody>
    </table>
    <a href="/admin/noticeForm"><button>글쓰기</button></a>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script>
$(document).ready(function(){
    $.ajax({
        url: "http://localhost:9001/api/v1/notice",
        method: "GET",
        success: function(data){ // 요청이 성공적으로 완료됐을 경우 호출될 콜백함수 -- 서버로부터 받은 응답 데이터를 인자로 받는다
            var tbody = $("#noticeTableBody");
            tbody.empty(); // tbody의 기존 내용을 모두 지움 -- 테이블을 업데이트할 때 이전의 데이터를 제거하고 새 데이터를 추가할 수 있음
            $.each(data, function(index, notice){ // 서버로부터 받은 G&A리스트를
                // index: 현재 반복의 인덱스 , qna: 현재 요소
                var row = $("<tr>").attr("data-nno", notice.nno); // 각 행에 data-bno 속성을 추가
                row.append($("<td>").text(notice.nno));
                row.append($("<td>").text(notice.title));

                // 작성일 처리
                var regdate = notice.regdate ? new Date(notice.regdate) : null;
                var moddate = notice.moddate ? new Date(notice.moddate) : null;

                var formattedDate = '';

                if (regdate) {
                    formattedDate = regdate.getFullYear() + '-' + ('0' + (regdate.getMonth() + 1)).slice(-2) + '-' + ('0' + regdate.getDate()).slice(-2);
                } else if (moddate) {
                    formattedDate = moddate.getFullYear() + '-' + ('0' + (moddate.getMonth() + 1)).slice(-2) + '-' + ('0' + moddate.getDate()).slice(-2);
                }

                row.append($("<td>").text(formattedDate));


                tbody.append(row); // 설정한 모든 row 요소들을 tbody에 삽입
            });

            // tr 클릭 이벤트 핸들러 추가
            $("#noticeTableBody").on("click", "tr", function(){
                var nno = $(this).data("nno"); // 클릭한 tr의 data-nno 값을 가져옴
                window.location.href = "/admin/noticeDetail?nno=" + nno; // noticeDetail 페이지로 리다이렉트
            });

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