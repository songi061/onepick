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
#def{
	font-size : 1em;
	font-weight : bold;
	color : #2E9AFE;
}

.res{
	border : 1px solid lightgrey;
	box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.2);
	border-radius: 15px;
	width : 500px;
	padding : 20px;
}

.res li{
	list-style-type: none;

}

#def_btn {
     background-color: #2E9AFE; /* 연한 파란색 배경 */
     color: white; /* 하얀색 글자 */
     border: none; /* 테두리 없음 */
     padding: 10px 20px; /* 여백 */
     text-align: center; /* 텍스트 가운데 정렬 */
     text-decoration: none; /* 밑줄 제거 */
     display: inline-block; /* 인라인 블록 요소 */
     font-size: 16px; /* 폰트 크기 */
     margin: 4px 2px; /* 마진 */
     cursor: pointer; /* 마우스 커서 포인터 */
     border-radius: 12px; /* 둥근 끝 */
     transition-duration: 0.4s; /* 호버 시 전환 시간 */
     font-weight : bold;
 }

 #def_btn:hover {
     background-color: #87CEEB; /* 호버 시 더 진한 파란색 */
     color : #2E2E2E;
     font-weight : bold;
 }
 
 .def_div{
 	display : flex;
 	flex-direction : row;
 	justify-content: space-between;
 }
 
</style>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container">

<h1>이력서 리스트</h1>
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
						
                     div.append('<input type="checkbox" id="def_chk" name="def" />');
                     
                     
                     if(resume.def == "Y"){
                    	 div.append('<li id="def">대표 이력서</li>');
                     }
                     
                     div.append('<li><a href="#" class="delete-link" data-rno="' + resume.rno + '">삭제</a></li>');
                     
                     
                     ul.append(div);
                     // li 태그 추가
  					 ul.append('<li><a href="/user/resumeDetail?rno=' + resume.rno + '">' + resume.title + '</a></li>');
         
                     if(resume.moddate == null){
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
                 alert("이력서 삭제 완료~!");
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