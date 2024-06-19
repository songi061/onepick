<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>1PICK!</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="/css/adminstyle.css" rel="stylesheet">
    <link href="/css/adminList.css" rel="stylesheet">
    <script src="/js/adminInterceptor.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>

<body class="d-flex flex-column h-100 min-h-100">
    <jsp:include page="../layout/adminHeader.jsp"></jsp:include>
    <div class="container">
        <div class="page_title">개인 회원관리</div>
        <div class="float-end input-group main_seaerch_box mt-md-5">
            <input type="text" class="form-control" placeholder="회원 검색" name="searchInput" aria-label="제목 검색" aria-describedby="jobAdSearchBtn">
            <button class="btn btn-outline-secondary" type="button" id="SearchBtn">검색</button>
        </div>
        <div id="allUserList" class="row mb-5">
        </div>
        <table class="table">
            <thead>
                <tr id="tbl_header">
                    <th>번호</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>가입일</th>
                    <th>활동 관리</th>
                </tr>
            </thead>
            <tbody id="userTableBody">
                <!-- AJAX로 데이터가 삽입될 부분 -->
            </tbody>
        </table>
    </div>
    <jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script>
    $(document).ready(function () {
        loadAllUsers();
    
        $("#SearchBtn").click(function () {
            var keyword = $("input[name='searchInput']").val().trim();
            if (keyword.length > 0) {
                var encodedKeyword = encodeURIComponent(keyword);
                searchUsers(encodedKeyword);
            } else {
                loadAllUsers();
            }
        });
    
        function loadAllUsers() {
            $.ajax({
                url: "http://localhost:9001/api/v1/admin/user",
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
    
        function searchUsers(keyword) {
            $.ajax({
                url: "http://localhost:9001/api/v1/admin/user-search/" + keyword,
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
    
        function displayUsers(users) {
            var tbody = $("#userTableBody");
            tbody.empty();
    
            if (users.length === 0) {
                $("#allUserList").html("<div class='col-12'><div class='border w-100 p-4 text-center text-secondary rounded'>검색 결과가 없습니다.<br>검색어를 다시 확인해주세요.</div></div>");
            } else {
                $.each(users, function (index, user) {
                    var row = $("<tr>").attr("data-username", user.username);
                    row.append($("<td>").text(index + 1));
                    row.append($("<td>").text(user.username));
                    row.append($("<td>").text(user.name));
    
                    var regdate = user.regdate ? new Date(user.regdate) : null;
                    var moddate = user.moddate ? new Date(user.moddate) : null;
                    var formattedDate = '';
    
                    if (regdate) {
                        formattedDate = regdate.getFullYear() + '-' + ('0' + (regdate.getMonth() + 1)).slice(-2) + '-' + ('0' + regdate.getDate()).slice(-2);
                    } else if (moddate) {
                        formattedDate = moddate.getFullYear() + '-' + ('0' + (moddate.getMonth() + 1)).slice(-2) + '-' + ('0' + moddate.getDate()).slice(-2);
                    }
    
                    row.append($("<td>").text(formattedDate));
    
                    var userStatus = $("<td>");
                    if (user.active) {
                        userStatus.html('<p class="ing">활동중</p>');
                    } else {
                        userStatus.html('<p class="stop">활동중지</p>');
                    }
                    row.append(userStatus);
    
                    tbody.append(row);
                });
    
                // tr 클릭 이벤트 핸들러 추가
                $("#userTableBody").on("click", "tr", function () {
                    var username = $(this).data("username");
                    if (confirm("해당 회원의 활동 상태를 변경하시겠습니까?")) {
                        var currentActiveStatus = $(this).find("p").hasClass("ing");
                        toggleUserActive(username, !currentActiveStatus);
                    }
                });
            }
        }
    
        function toggleUserActive(username, active) {
            $.ajax({
                url: "http://localhost:9001/api/v1/admin/user/" + username + "/active?active=" + active,
                method: "PUT",
                success: function () {
                	alert("변경 되었습니다.");
                    loadAllUsers();
                },
                error: function (error) {
                    console.log("상태 변경 에러 :", error);
                    console.log("상태 변경 에러 상세 정보: ", error.responseText);
                }
            });
        }
    });
    </script>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</html>
