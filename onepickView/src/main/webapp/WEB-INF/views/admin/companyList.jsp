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
        <div class="page_title">기업 회원관리</div>
        <div class="float-end input-group main_seaerch_box mt-md-5">
            <input type="text" class="form-control" placeholder="회원 검색" name="searchInput" aria-label="제목 검색" aria-describedby="jobAdSearchBtn">
            <button class="btn btn-outline-secondary" type="button" id="SearchBtn">검색</button>
        </div>
        <div id="allCompanyList" class="row mb-5">
        <table class="table">
            <thead>
                <tr id="tbl_header">
                    <th>번호</th>
                    <th>아이디</th>
                    <th>기업명</th>
                    <th>가입일</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody id="companyTableBody">
                <!-- AJAX로 데이터가 삽입될 부분 -->
            </tbody>
        </table>
    </div>
    <jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script>
   $(document).ready(function () {
    // 초기 사용자 목록 불러오기
    loadAllUsers();

    // 사용자 검색 버튼 클릭 이벤트
        $("#SearchBtn").click(function () {
        var keyword = $("input[name='searchInput']").val().trim();
            if (keyword.length > 0) {
                var encodedKeyword = encodeURIComponent(keyword); // 키워드 인코딩
                searchUsers(encodedKeyword);
            } else {
                // 검색어가 없을 경우 전체 사용자 목록을 다시 불러옴
                loadAllUsers();
            }
        });

});

// 전체 사용자 목록 불러오기
function loadAllUsers() {
    $.ajax({
        url: "http://localhost:9001/api/v1/admin/company",
        method: "GET",
        success: function (data) {
            displayUsers(data);
        },
        error: function (error) {
            console.log("에러 :", error);
            console.log("에러 상세 정보: ", error.responseText);
        }
    });
}

// 사용자 검색 함수
function searchUsers(keyword) {
    $.ajax({
        url: "http://localhost:9001/api/v1/admin/company-search/" + keyword,
        method: "GET",
        success: function (data) {
            displayUsers(data);
        },
        error: function (error) {
            console.log("검색 에러 :", error);
            console.log("검색 에러 상세 정보: ", error.responseText);
        }
    });
}

// 사용자 목록을 화면에 출력하는 함수
function displayUsers(companies) {
    var tbody = $("#companyTableBody");
    tbody.empty();

    if (users.length === 0) {
        // 검색 결과가 없는 경우 메시지 출력
        $("#allCompanyList").html("<div class='col-12'><div class='border w-100 p-4 text-center text-secondary rounded'>검색 결과가 없습니다.<br>검색어를 다시 확인해주세요.</div></div>");
    } else {
        // 검색 결과를 테이블에 추가
        $.each(companies, function (index, company) {
            var row = $("<tr>").attr("data-username", company.username);
            row.append($("<td>").text(index + 1));
            row.append($("<td>").text(company.username));
            row.append($("<td>").text(company.name));

            var regdate = company.regdate ? new Date(company.regdate) : null;
            var moddate = company.moddate ? new Date(company.moddate) : null;
            var formattedDate = '';

            if (regdate) {
                formattedDate = regdate.getFullYear() + '-' + ('0' + (regdate.getMonth() + 1)).slice(-2) + '-' + ('0' + regdate.getDate()).slice(-2);
            } else if (moddate) {
                formattedDate = moddate.getFullYear() + '-' + ('0' + (moddate.getMonth() + 1)).slice(-2) + '-' + ('0' + moddate.getDate()).slice(-2);
            }

            row.append($("<td>").text(formattedDate));

            var companyTd = $("<td>");
            var companyButton = $("<button class='delete-btn' data-username='" + company.username + "'>").text("회원삭제");

            companyTd.append(companyButton);
            row.append(companyTd);

            tbody.append(row);
        });
    }
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</html>
