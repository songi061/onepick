<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>1PICK!</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="/css/style.css" rel="stylesheet">
    <link href="/css/communityList.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
    <jsp:include page="..//../layout/header.jsp"></jsp:include>
    <div class="container">
        <div class="page_title">기업 커뮤니티</div>

        <div id="list-example" class="list-group list-group-horizontal text-center" style="max-width:100%">
            <a class="list-group-item list-group-item-action" id="freeBoard" aria-current="true" href="#list-item-1">자유글</a>
            <a class="list-group-item list-group-item-action" id="information" href="#list-item-2">정보공유</a>
            <a class="list-group-item list-group-item-action" id="dispatch" href="#list-item-3">파견</a>
            <a class="list-group-item list-group-item-action" id="seminar" href="#list-item-4">세미나</a>
        </div>

        <div data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
            <div id="data_content">
                <!-- 테이블 내용이 여기에 동적으로 추가됩니다 -->
            </div>
        </div>

        <div class="go_regist"><button class="btn btn-onepick" id="go_regist">글쓰기</button></div>
    </div>
    <script>
        // 기본 페이지 - 자유글
        $(document).ready(function () {
            loadBoard('freeBoard');
        });

        function loadBoard(category) {
            $.ajax({
                type: 'GET',
                url: 'http://localhost:9001/api/v1/company/community-board',
                data: { category: category },
                dataType: 'json',
                success: function (data) {
                    let tableContent = '<table class="table">';
                    tableContent += '<thead><tr><th>번호</th><th id="title">제목</th><th>작성자</th><th>조회 수</th></tr></thead>';
                    tableContent += '<tbody>';

                    if (data !== null) {
                        for (var i = 0; i < data.length; i++) {
                            tableContent += '<tr id="' + data[i].cbno + '" class="clickable"><td>' + (i+1) +
                                '</td><td>' + data[i].title + '</td>' +
                                '<td>' + data[i].company.username + '</td>' +
                                '<td>' + data[i].views + '</td></tr>';
                        }
                    }

                    tableContent += '</tbody></table>';
                    $('#data_content').html(tableContent);
                },
                error: function (error) {
                    alert(error);
                }
            });
        }

        // 게시물 조회 - 자유글
        $('#freeBoard').click(function () {
            loadBoard('freeBoard');
        });

        // 게시물 조회 - 정보공유
        $('#information').click(function () {
            loadBoard('information');
        });

        // 게시물 조회 - 파견
        $('#dispatch').click(function () {
            loadBoard('dispatch');
        });

        // 게시물 조회 - 세미나
        $('#seminar').click(function () {
            loadBoard('seminar');
        });

        // 행 클릭 시 상세 페이지로 이동
        $(document).on('click', '.clickable', function () {
            console.log(this.id);
            window.location.href = '/company/communityDetail?cbno=' + this.id;
        });

        // 게시글 등록 페이지로 가는 버튼
        $(document).on('click', '#go_regist', function () {
            window.location.href = '/company/communityForm';
        });
    </script>
    <jsp:include page="..//../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</html>
