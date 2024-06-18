<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>1PICK!</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="/css/adminstyle.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>

<body class="d-flex flex-column h-100 min-h-100">
    <jsp:include page="../layout/adminHeader.jsp"></jsp:include>
    <div class="container">
        <div class="page_title">신고 게시글 관리</div>
        <table class="table">
            <thead>
                <tr id="tbl_header">
                    <th>번호</th>
                    <th>신고일</th>
                    <th>내용</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody id="reportTableBody">
                <!-- AJAX로 데이터가 삽입될 부분 -->
            </tbody>
        </table>
    </div>
    <jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script>

$(document).ready(function () {
    $.ajax({
        url: "http://localhost:9001/api/v1/reported-board",
        method: "GET",
        success: function (data) {
            var tbody = $("#reportTableBody");
            tbody.empty();
            $.each(data, function (index, board) {
                var row = $("<tr>").attr("data-reno", board.reno);
                row.append($("<td>").text(index + 1));
                row.append($("<td>").text(board.report_date));
                row.append($("<td>").text(board.ub.title));
                row.append($("<td>").text(board.user.username));
                
                var userTd = $("<td>");
                var userButton = $("<button class='delete-btn' data-username='" + user.username + "'>").text("회원삭제");

                userTd.append(userButton);
                row.append(userTd);

                tbody.append(row);
            });

            // delete 버튼 클릭 이벤트 핸들러 추가
            tbody.on("click", ".delete-btn", function () {
                var username = $(this).data("username");
                if (confirm(username + " 회원을 정말 삭제하시겠습니까?")) {
                    $.ajax({
                        url: "http://localhost:9001/api/v1/user/" + username,
                        method: "DELETE",
                        success: function (response) {
                            alert(username + " 회원이 삭제되었습니다.");
                            location.reload(); // 페이지 새로고침
                        },
                        error: function (error) {
                            console.log("삭제 실패:", error);
                            alert("삭제 중 오류가 발생했습니다.");
                        }
                    });
                }
            });
        },
        error: function (error) {
            console.log("에러 :", error);
            console.log("에러 상세 정보: ", error.responseText);
        }
    }); 
});

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</html>
