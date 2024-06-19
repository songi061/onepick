<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
<link href="/css/resumeList.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="sub_header border-bottom">
	<div class="container">
		<div class="d-flex py-2">
			<button class="btn" type="button" onclick="location.href='/user/myHome'">
			   MyHome
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggl" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    이력서 관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/resumeList'">이력서 리스트</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/resumeForm'">이력서 작성</button></li>
			  </ul>
			</div>
			<button class="btn text-onepick" type="button" onclick="location.href='/user/scrapList'">
			   스크랩관리
			</button>
			<button class="btn" type="button" onclick="location.href='/user/interestList'">
			   구독관리
			</button>
			<button class="btn" type="button" onclick="location.href='/user/applyList'">
			   지원내역관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    평점관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/reviewList'">평점 조회</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/reviewForm'">평점 등록</button></li>
			  </ul>
			</div>
			<button class="btn" type="button" onclick="location.href='/user/myQnaList'">
			   QnA관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    커뮤니티관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/myBoardList'">내가 쓴 글 리스트</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/myCommentList'">내가 쓴 댓글 목록</button></li>
			  </ul>
			</div>
		</div>
	</div>
</div>

<div class="container" id="ctn">
    <p class="page_title">🚩 스크랩한 공고 리스트</p>
    <hr>
    <div id="scrapList"></div>
</div>

<script>
$(document).ready(function() {
    // AJAX 요청 보내기
	$.ajax({
        url: 'http://localhost:9001/api/v1/job-scrap',
        type: 'GET',
        dataType: 'json',
        headers: {
            'username': username  // HTTP 요청 헤더에 username 추가
        }, 
        success: function(data) {
            var scrapList = $('#scrapList');
            scrapList.empty(); // 기존 내용을 비웁니다.
   
            // 받은 데이터 반복 처리
            $.each(data, function(index, scrap) {
                var div = $('<div class="scrap_div"></div>');

                div.append('<a href="#" class="delete-link" data-scno="' + scrap.scno + '">스크랩 취소</a>');

                var ul = $('<ul class="res"></ul>'); // ul 태그 생성
                
                ul.append('<li><a href="/company/recruitDetail?jno=' + scrap.jobAd.jno + '">' + scrap.jobAd.wantedTitle + '</a></li>');

                var due = new Date(scrap.jobAd.receiptCloseDt).toISOString().split('T')[0];
                ul.append('<li>공고 마감 날짜 : ' + due + '</li>');

                div.append(ul); 
                scrapList.append(div);
                
                
                $('.delete-link').on('click', function(e) {
                    e.preventDefault(); // 기본 동작 방지

                    var scno = $(this).data('scno'); // 삭제할 이력서 번호 가져오기
                    deleteScrap(scno); // 삭제 함수 호출
                });
                
                
            });
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', status, error);
        }
    });
    
    
	function deleteScrap(scno) {
        $.ajax({
            url: 'http://localhost:9001/api/v1/job-scrap/' + scno,
            type: 'DELETE',
            success: function(response) {
                // 삭제 성공 시 동작 (예: 페이지 새로고침)
                console.log('스크랩 목록 삭제 : ', response);
                alert(response);
                window.location.reload(); // 예시로 페이지를 새로고침하는 방식
            },
            error: function(xhr, status, error) {
                console.error('스크랩 삭제 실패:', status, error);
                console.log(scno);
            }
        });
    }
    
    
    
});    
</script>

<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="/js/userInterceptor.js"></script>
<script src="/js/CloseBrowserClearlocalStorage.js"></script>
</html>