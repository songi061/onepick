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
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container" id="ctn">
    <h3 class="page_title">💙 관심기업 리스트</h3>
    <hr>
    <div id="interestList"></div>
</div>

<script>
$(document).ready(function() {
    // AJAX 요청 보내기
	$.ajax({
        url: 'http://localhost:9001/api/v1/interested-companyList',
        type: 'GET',
        dataType: 'json',
        headers: {
            'username': username  // HTTP 요청 헤더에 username 추가
        }, 
        success: function(data) {
            var interestList = $('#interestList');
            interestList.empty(); // 기존 내용을 비웁니다.
   
            // 받은 데이터 반복 처리
            $.each(data, function(index, interCom) {
                var div = $('<div class="interCom"></div>');

                div.append('<a href="#" class="delete-link" data-interno="' + interCom.interno + '">관심 해제</a>');

                var ul = $('<ul class="res"></ul>'); // ul 태그 생성
                
                ul.append('<li><a href="/company/companyDetail?username=' + interCom.company.username + '">' + interCom.company.name + '</a></li>');


                ul.append('<li>'+ interCom.company.size + ' / ' +  interCom.company.sector + '</li>');

                div.append(ul); 
                interestList.append(div);
                
                
                $('.delete-link').on('click', function(e) {
                    e.preventDefault(); // 기본 동작 방지

                    var interno = $(this).data('interno'); 
                    deleteInterCom(interno); // 삭제 함수 호출
                });
                
                
            });
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', status, error);
        }
    });
    
    
	function deleteInterCom(interno) {
        $.ajax({
            url: 'http://localhost:9001/api/v1/interested-company/' + interno,
            type: 'DELETE',
            success: function(response) {
                // 삭제 성공 시 동작 (예: 페이지 새로고침)
                console.log('관심기업 삭제 : ', response);
                alert(response);
                window.location.reload(); // 예시로 페이지를 새로고침하는 방식
            },
            error: function(xhr, status, error) {
                console.error('관심기업 삭제 실패:', status, error);
                console.log("interno 출력 : "+interno);
            }
        });
    }
});  	
</script>

<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>