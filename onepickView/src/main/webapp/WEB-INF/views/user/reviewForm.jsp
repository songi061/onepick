<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
<link href="/css/resumeList.css" rel="stylesheet">
<link href="/css/reviewForm.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<div class="container">
		<div class="page_title">평점 등록</div>
		<hr>
		
		<div id="applyList"></div>
		
		
		
		<div class="interviewees_list">
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			    
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="exampleModalLabel">지원자 아무개님</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body" >
			        <img id="star1" class="stars" style="width:30px; display:inline-block;" src="/icon/star.png"><img id="star2" class="stars" style="width:30px; display:inline-block;" src="/icon/star.png"><img id="star3" class="stars" style="width:30px; display:inline-block;" src="/icon/star.png"><img id="star4" class="stars" style="width:30px; display:inline-block;" src="/icon/star.png"><img id="star5" class="stars" style="width:30px; display:inline-block;" src="/icon/star.png">
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" id="regBtn" data-bs-dismiss="modal">평점등록하기</button>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
		
		
	</div>
	
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
    const listContainer = document.querySelector('.interviewees_list');

    var companyName = "";

    // 지원내역 리스트 불러오기
    $.ajax({
        url: 'http://localhost:9001/api/v1/myapply',
        type: 'GET',
        dataType: 'json',
        headers: {
            'username': username  // HTTP 요청 헤더에 username 추가
        },
        success: function(data) {
            var applyList = $('#applyList');
            applyList.empty(); // 기존 내용을 비웁니다.
			
            //데이터가 있으면 리스트 출력
            if (data.length > 0) {
                // 받은 데이터 반복 처리
                $.each(data, function(index, apply) {
                	console.log("apply.ratingStatus 출력 : " + apply.ratingStatus);
                    if (apply.status === "면접완료" || apply.status === "합격" || apply.status === "불합격" && apply.ratingStatus === false) {
                        var div = $('<div class="apply"></div>');
                        var ul = $('<ul class="res"></ul>'); // ul 태그 생성

                        ul.append('<li><a href="/company/recruitDetail?jno=' + apply.jobAd.jno + '">채용공고 : ' + apply.jobAd.wantedTitle + '</a></li>');
                        ul.append('<li><a href="/user/resumeDetail?rno=' + apply.resume.rno + '">지원 이력서 보기</a></li>');
                        ul.append('<li>지원자명 : ' + apply.resume.user.name + '</li>'); 

                        var regdate = new Date(apply.regdate).toISOString().split('T')[0];
                        ul.append('<li>지원날짜 : ' + regdate + '</li>');
                        ul.append('<li>상태 : ' + apply.status + '</li>');
						
                        if (apply.ratingStatus == false) {
                            div.append('<a href="#" class="review" data-jno="' + apply.jobAd.jno + '">평점 등록하기</a>');
                        }else{
                        	div.append('평점 등록 완료');
                        }
                        
                        companyName = apply.jobAd.company.name;

                        div.append(ul);
                        applyList.append(div);
                    }
                });

            } else {
                // 지원 내역이 없는 경우 메시지 표시
                applyList.html('지원 내역이 없습니다.');
            }
            
            // 평점 등록 링크 클릭 이벤트 핸들러 설정
            $('#applyList').on('click', '.review', function(e) {
                e.preventDefault();
                var jno = $(this).data('jno');
                openRegModal(jno);
            });
            
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', status, error);
        }
    });

    // 평점 등록 기능
    function openRegModal(jno) {
        // 모달을 보여줍니다.
        $('#exampleModal').modal('show');

        let finalScore = 1;

        // 모달이 표시된 후에 실행될 작업 설정
        $('#exampleModal').on('shown.bs.modal', function() {
            // 모달 제목 설정
            document.querySelector("#exampleModalLabel").innerText = "기업명 : " + companyName;

            // 별모양 클릭 이벤트 핸들러 설정
            document.querySelectorAll(".stars").forEach(star => {
                star.addEventListener("click", function(e) {
                    // 새로 클릭시에 빈 별로 초기화해주기
                    document.querySelectorAll(".stars").forEach(star => {
                        star.src = "/icon/star.png";
                    });

                    // 별 클릭시 별모양 노란색으로 바꿔주기
                    let starId = Number(e.target.getAttribute("id").slice(4));
                    for (let i = 1; i <= starId; i++) {
                        document.querySelector("#star" + i).src = "/icon/star_full.png";
                    }
                    finalScore = starId;
                });
            });

            // 평점 등록 버튼 클릭 이벤트 핸들러 설정
            document.querySelector("#regBtn").addEventListener("click", function() {
                // ajax 요청으로 평점 등록
                console.log("평점 등록: jno=" + jno + ", score=" + finalScore);
                const data = {"rating": finalScore};
                $.ajax({
                    url: "http://localhost:9001/api/v1/review?jno=" + jno + "&score=" + finalScore,
                    type: "POST",
                    //contentType: "application/json",
                    //data: JSON.stringify(data),
                    headers: {
                        //'jwtToken': localStorage.getItem('jwtToken'),
                        'username': localStorage.getItem('username'),
                        //'role': localStorage.getItem('role')
                    },
                    success: function(response) {
                        console.log("평점 등록 성공:", response);
                        alert("평점을 등록하였습니다!");
                        // 성공적으로 등록되었으면 모달 닫기
                        $('#exampleModal').modal('hide');
                        window.location.reload();
                    },
                    error: function(xhr, status, error) {
                        console.error("평점 등록 실패:", status, error);
                        // 실패 시에도 모달 닫기
                        $('#exampleModal').modal('hide');
                        window.location.reload();
                    }
                });
            });
        });
    }
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="/js/userInterceptor.js"></script>
<script src="/js/CloseBrowserClearlocalStorage.js"></script>
</html>