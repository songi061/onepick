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
    <h3>이력서 리스트</h3>
    <hr>
    <div id="resumeList"></div>
</div>

<script>
$(document).ready(function() {
    // AJAX 요청 보내기
	$.ajax({
        url: 'http://localhost:9001/api/v1/resume',
        type: 'GET',
        dataType: 'json',
        /* headers: {
            'Authorization': 'Bearer ' + token,
            'writer': token_writer,
            'role': token_role
          }, */
          
        headers: {
            'username': username  // HTTP 요청 헤더에 username 추가
        }, 
        success: function(data) {
            var resumeList = $('#resumeList');
            resumeList.empty(); // 기존 내용을 비웁니다.
            resumeList.append('<button id="def_btn">대표이력서 설정</button>');

            // 받은 데이터 반복 처리
            $.each(data, function(index, resume) {
                var ul = $('<ul class="res"></ul>'); // ul 태그 생성
                var div = $('<div class="def_div"></div>');

                div.append('<label class="checkbox-container"><input type="checkbox" class="def_check" name="def" data-rno="' + resume.rno + '"><span class="checkmark"></span></label>');

                if (resume.def == "Y") {
                    div.append('<span class="def">대표 이력서✍</span>');
                }

                div.append('<a href="#" class="delete-link" data-rno="' + resume.rno + '">삭제</a>');

                ul.append(div);
                ul.append('<li><a href="/user/resumeDetail?rno=' + resume.rno + '">' + resume.title + '</a></li>');

                if (resume.moddate == null) {
                    var regdate = new Date(resume.regdate).toISOString().split('T')[0];
                    ul.append('<li>최종수정날짜 : ' + regdate + '</li>');
                } else {
                    var moddate = new Date(resume.moddate).toISOString().split('T')[0];
                    ul.append('<li>최종수정날짜 : ' + moddate + '</li>');
                }

                resumeList.append(ul); // ul 태그를 resumeList에 추가

                // 삭제 링크 클릭 이벤트 처리
                $('.delete-link').on('click', function(e) {
                    e.preventDefault(); // 기본 동작 방지

                    var rno = $(this).data('rno'); // 삭제할 이력서 번호 가져오기
                    deleteResume(rno); // 삭제 함수 호출
                });
            });

            // 대표이력서 설정 버튼 클릭 이벤트 처리
            $('#def_btn').on('click', function() {
                var selectedCheckbox = $('input[name="def"]:checked'); // 선택된 체크박스 가져오기

                if (selectedCheckbox.length === 0) {
                    alert('선택된 이력서가 없습니다.');
                    return;
                }
                
                if (selectedCheckbox.length > 1) {
                    alert('대표이력서를 선택할 체크박스를 하나만 선택하세요!!');
                    return;
                }

                var rno = selectedCheckbox.data('rno'); // 선택된 체크박스의 이력서 번호 가져오기

                // AJAX 요청을 통해 서버에 대표 이력서 설정 요청 보내기
                $.ajax({
                    url: 'http://localhost:9001/api/v1/resume/setDef/' + rno,
                    type: 'PUT', // 대표 이력서 설정을 나타내는 PUT 요청 보냄
                    success: function(response) {
                        console.log('대표 이력서 설정 성공:', response);
                        alert('대표 이력서로 설정되었습니다.');
                        window.location.reload(); // 페이지 새로고침
                    },
                    error: function(xhr, status, error) {
                        console.error('대표 이력서 설정 실패:', status, error);
                        alert('대표 이력서 설정 중 오류가 발생했습니다.');
                    }
                });
            });
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', status, error);
        }
    });
    
    
	function deleteResume(rno) {
        $.ajax({
            url: 'http://localhost:9001/api/v1/resume/' + rno,
            type: 'DELETE',
            success: function(response) {
                // 삭제 성공 시 동작 (예: 페이지 새로고침)
                console.log('이력서 삭제 성공:', response);
                console.log(rno);
                alert("이력서 삭제 완료!!");
                window.location.reload(); // 예시로 페이지를 새로고침하는 방식
            },
            error: function(xhr, status, error) {
                console.error('이력서 삭제 실패:', status, error);
                console.log(rno);
            }
        });
    }
    
});

 
 </script>



<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>