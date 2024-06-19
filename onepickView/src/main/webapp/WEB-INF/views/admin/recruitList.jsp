<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="/css/adminstyle.css" rel="stylesheet">
<link href="/css/adminList.css" rel="stylesheet">
<script src="/js/adminInterceptor.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
</head>

<body class="d-flex flex-column h-100 min-h-100">
	<jsp:include page="../layout/adminHeader.jsp"></jsp:include>
	<div class="container">
		<div class="page_title">채용공고 관리</div>
		<div class="float-end input-group main_seaerch_box mt-md-5">
			<input type="text" class="form-control" placeholder="공고 검색"
				name="searchInput" aria-label="제목 검색"
				aria-describedby="jobAdSearchBtn">
			<button class="btn btn-outline-secondary" type="button"
				id="SearchBtn">검색</button>
		</div>
		<div id="allJobAdList" class="row mb-5"></div>
		<table class="table">
			<thead>
				<tr id="tbl_header">
					<th>번호</th>
					<th>아이디</th>
					<th>기업명</th>
					<th>공고명</th>
					<th>등록일</th>
					<th>마감일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody id="jabAdTableBody">
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
            url: "http://localhost:9001/api/v1/admin/recruit",
            method: "GET",
            success: function (data) {
                displayUsers(data);
                
                
                $(".delete-btn").on("click", function(event){
                    var jno = $(this).data("jno");
                    confirmDelete(event, jno);
                });

                // tr 클릭 이벤트 핸들러 추가
                $("#jabAdTableBody").on("click", "tr", function(){
                    var jno = $(this).data("jno");
                    window.location.href = "/company/recruitDetail?jno=" + jno;
                });
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
            url: "http://localhost:9001/api/v1/admin/recruit-search/" + keyword,
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
    function displayUsers(jobAds) {
        var tbody = $("#jabAdTableBody");
        tbody.empty();
    
        if (jobAds.length === 0) {
            // 검색 결과가 없는 경우 메시지 출력
            $("#allJobAdList").html("<div class='col-12'><div class='border w-100 p-4 text-center text-secondary rounded'>검색 결과가 없습니다.<br>검색어를 다시 확인해주세요.</div></div>");
        } else {
            // 검색 결과를 테이블에 추가
            $.each(jobAds, function (index, jobAd) {
                var row = $("<tr>").attr("data-jno", jobAd.jno);
                row.append($("<td>").text(jobAd.jno));
                row.append($("<td>").text(jobAd.company.username));
                row.append($("<td>").text(jobAd.company.name));
                row.append($("<td>").text(jobAd.wantedTitle));
    
                var regdate = jobAd.regdate ? new Date(jobAd.regdate) : null;
                var moddate = jobAd.moddate ? new Date(jobAd.moddate) : null;
                var formattedDate = '';
    
                if (regdate) {
                    formattedDate = regdate.getFullYear() + '-' + ('0' + (regdate.getMonth() + 1)).slice(-2) + '-' + ('0' + regdate.getDate()).slice(-2);
                } else if (moddate) {
                    formattedDate = moddate.getFullYear() + '-' + ('0' + (moddate.getMonth() + 1)).slice(-2) + '-' + ('0' + moddate.getDate()).slice(-2);
                }
    
                row.append($("<td>").text(formattedDate));
                row.append($("<td>").text(jobAd.receiptCloseDt));
    
                var jobAdTd = $("<td>");
                var jobAdButton = $("<button class='delete-btn' data-jno='" + jobAd.jno + "'>").text("공고삭제");
    
                jobAdTd.append(jobAdButton);
                row.append(jobAdTd);
    
                tbody.append(row);
            });
        }
    }
    
    function confirmDelete(event, jno) {
        if (confirm("정말 삭제하시겠습니까?")) {
            deleteRecruit(jno);
        }
    }
    
    function deleteRecruit(jno){
        event.preventDefault();
        console.log(jno);
        $.ajax({
            url: "http://localhost:9001/api/v1/admin/recruit/" + jno,
            method: "DELETE",
            success: function(response){
                alert("삭제되었습니다.");
                console.log(response);
                window.location.href = "/admin/recruitList";
            },
            error: function(error){
                console.log("에러 :", error);
                console.log("에러 상세 정보: ", error.responseText);
            }
        });
    }
    </script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

</html>
