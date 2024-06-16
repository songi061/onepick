<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<style>
#ctn {
    max-width: 800px;
    margin: 30px auto;
    background-color: #ffffff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    
}

.res {
    border: 1px solid lightgrey;
    box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.2);
    border-radius: 15px;
    padding: 15px;
    margin-bottom: 20px;
}

.def_div {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.def_div input[type="checkbox"] {
    margin-right: 10px;
}

.def {
    font-size: 1.1em;
    font-weight: bold;
   /*  color: #2E9AFE; */
}

.delete-link {
    color: #dc3545;
    text-decoration: none;
    margin-left: 10px;
}

.delete-link:hover {
    text-decoration: underline;
}

#def_btn {
    background-color: #2E9AFE;
    color: white;
    border: none;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin-bottom: 20px;
    cursor: pointer;
    border-radius: 12px;
    transition-duration: 0.4s;
    font-weight: bold;
  
}

#def_btn:hover {
    background-color: #87CEEB;
    color: #2E2E2E;
}

.res {
    list-style-type: none;
    padding: 20px;
}

.res li {
    margin-bottom: 8px;
}

.res li a {
    color: #007bff;
    text-decoration: none;
}

.res li a:hover {
    text-decoration: underline;
}


.checkbox-container {
    display: inline-block;
    position: relative;
    padding-left: 35px; 
    margin-bottom: 12px;
    cursor: pointer;
    font-size: 18px; 
    user-select: none; 
}


.checkbox-container input {
    position: absolute;
    opacity: 0;
    cursor: pointer;
}


.checkmark {
    position: absolute;
    top: 0;
    left: 0;
    height: 25px;
    width: 25px; 
    border: 1px solid #ccc; 
    border-radius: 4px; 
}


.checkmark:after {
    content: "";
    position: absolute;
    display: none;
}


.checkbox-container input:checked ~ .checkmark:after {
    display: block;
}


.checkbox-container .checkmark:after {
    left: 9px; /* 체크 아이콘의 위치 */
    top: 5px; /* 체크 아이콘의 위치 */
    width: 6px; /* 체크 아이콘의 너비 */
    height: 12px; /* 체크 아이콘의 높이 */
    border: solid green;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg); /* 체크 아이콘 회전 */
}


.checkbox-container .checkbox-label {
    margin-left: 40px; /* 체크박스 레이블의 왼쪽 여백 */
}


</style>
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
        success: function(data) {
            var resumeList = $('#resumeList');
            resumeList.empty(); // 기존 내용을 비웁니다.
            resumeList.append('<button id="def_btn">대표이력서 설정</button>');

            // 받은 데이터 반복 처리
            $.each(data, function(index, resume) {
                var ul = $('<ul class="res"></ul>'); // ul 태그 생성
                var div = $('<div class="def_div"></div>');

                div.append('<label class="checkbox-container"><input type="checkbox" id="def_check" name="def"><span class="checkmark"></span></label>');
                

                

                if (resume.def == "Y") {
                    div.append('<span class="def"><대표 이력서></span>');
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
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', status, error);
        }
    });
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
     
     
     
     
     
     
     
 </script>









<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>