<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>1PICK!</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="/css/adminstyle.css" rel="stylesheet">
    <link href="/css/report.css" rel="stylesheet">
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
                    <th>구분</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>신고일</th>
                    <th>신고자</th>
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
        url: "http://localhost:9001/api/v1/admin/reported-board",
        method: "GET",
        success: function (data) {
            var tbody = $("#reportTableBody");
            tbody.empty();
            $.each(data, function (index, board) {
            	console.log(board);

                var row = $("<tr>").attr("data-reno", board.reno)
                                   .attr("data-ubno", board.ub ? board.ub.ubno : "")
                                   .attr("data-cbno", board.cb ? board.cb.cbno : "");
                row.append($("<td>").text(index + 1));

                // 회원/기업 구분 처리
                var userCategory = $("<td class='category'>");
                if (board.user && board.user.username) {
                    userCategory.text("개인");
                } else if (board.company && board.company.username) {
                    userCategory.text("기업");
                }
                row.append(userCategory);
                
                // 제목
                var title = $("<td>");
                if (board.user && board.user.username) {
                    title.text(board.ub.title);
                } else if (board.company && board.company.username) {
                    title.text(board.cb.title);
                }
                row.append(title);  

                // 작성자 처리
                var author = $("<td>");
                if (board.user && board.user.username) {
                    author.text(board.ub.user.username);
                } else if (board.company && board.company.username) {
                    author.text(board.cb.company.username);
                }
                row.append(author);   
                tbody.append(row);



                // 신고일
                var regdate = new Date(board.report_date);
                var formattedDate = regdate.getFullYear() + '-' + ('0' + (regdate.getMonth() + 1)).slice(-2) + '-' + ('0' + regdate.getDate()).slice(-2);

                row.append($("<td>").text(formattedDate));
                

                // 신고자 처리
                var reporter = $("<td class='reporter'>");
                if (board.user && board.user.username) {
                    reporter.text(board.user.username);
                } else if (board.company && board.company.username) {
                    reporter.text(board.company.username);
                }
                row.append(reporter);   
                tbody.append(row);

                // tr 클릭 이벤트 핸들러 추가
                $("#reportTableBody").on("click", "tr", function () {
                    var ubno = $(this).attr("data-ubno");
                    var cbno = $(this).attr("data-cbno");


                    if (ubno) {
                        window.location.href = "/user/communityDetail?ubno=" + ubno;
                    } else if (cbno) {
                        window.location.href = "/company/communityDetail?cbno=" + cbno;
                    }

                });

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
