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

#myHomeContainer {
    max-width: 1000px;
    margin: 40px auto;
    background-color: #ffffff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.user-info {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.user-img {
    margin-right: 40px;
    margin-left: 20px;
}

#userImg {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
}

.user-details {
    list-style: none;
    padding: 0;
    margin: 0;
    flex: 1; /* Flexbox를 사용하여 남은 공간 차지 */
}

.user-details li {
    margin-bottom: 5px;
    font-size: 1.1em;
}

.user-details a {
    color: #007bff;
    text-decoration: none;
}

.user-details a:hover {
    text-decoration: underline;
}

.user-details-container {
    display: flex;
    align-items: center;
    width: 100%;
}

.res {
    border: 1px solid lightgrey;
    box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.2);
    border-radius: 10px;
    padding: 15px;
    margin-bottom: 20px;
    list-style-type: none;
}

.res li {
    margin-bottom: 8px;
    font-size: 1em;
}

.res li a {
    color: #007bff;
    text-decoration: none;
}

.res li a:hover {
    text-decoration: underline;
}

.myHomelink {
    color: #007bff;
    text-decoration: none;
}

.myHomelink:hover {
    text-decoration: underline;
}

.def {
    color: #ff4500;
    font-weight: bold;
}

.def_div {
    margin-bottom: 10px;
}

.resume-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.quickMenu {
    text-align: center;
    margin-top: 20px;
}

.quickMenu a {
    display: inline-block;
    margin: 10px 20px;
    padding: 20px 30px; /* Padding을 추가하여 버튼처럼 보이게 함 */
    color: black;
    text-decoration: none;
    font-size: 1.3em;
    background-color: #f8f9fa; /* 배경색 추가 */
    border: 1px solid #ced4da; /* 테두리 추가 */
    border-radius: 5px; /* 둥근 모서리 추가 */
    transition: background-color 0.3s, color 0.3s; /* 전환 효과 추가 */
}

.quickMenu a:hover {
    text-decoration: none;
    background-color: #007bff; /* 호버 시 배경색 변경 */
    color: white; /* 호버 시 글자색 변경 */
    border-color: #007bff; /* 호버 시 테두리 색 변경 */
}

.homeinfo{
	margin-top : 30px;
	margin-bottom : 80px;
}

</style>
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container" id="myHomeContainer">
    <h2>My Home</h2>
    <hr>
    
    <div class="homeinfo">
    	<h5>회원 정보</h5>
    	<hr>
    	<div id="userInfo"></div>
    </div>
    
    <div class="homeinfo">
        <div class="resume-header">
            <h5>이력서 리스트 (최대 3개)</h5>
            <a href="/user/resumeList" class="myHomelink">더보기</a>
        </div>
    	<hr>
    	<div id="resumeList"></div>
    </div>
    
    <div class="quickMenu">
    	<a href="/user/resumeForm">이력서 작성하기</a>
    	<a href="/user/scrapList">스크랩한 공고</a>
    	<a href="/user/applyList">지원 내역</a>
    	<a href="/user/myQnaList">QNA 관리</a>
    </div>
    
</div>

<script>
$(document).ready(function() {
    // AJAX 요청 보내기
	$.ajax({
        url: 'http://localhost:9001/api/v1/resume',
        type: 'GET',
        dataType: 'json',
        headers: {
            'username': username  // HTTP 요청 헤더에 username 추가
        }, 
        success: function(data) {
        	console.log(data);
        	
        	var userInfo = $('#userInfo');
        	    	
            var firstResume = data[0];
      
            var user = firstResume.user;

            var userDiv = $('<div class="user-info"></div>');

            var imgDiv = $('<div class="user-img"></div>');
            
            imgDiv.append('<img src="/img/no_img.jpg" id="userImg">');
            
            var infoDiv = $('<div class="user-details"></div>');
            infoDiv.append('<a href="/user/userEdit" class="myHomelink">내정보 수정</a>');
            infoDiv.append('<li>이름 :  ' + user.name + ' 님 </li>');
            infoDiv.append('<li>성별 :  ' + user.gender + '</li>');
            infoDiv.append('<li>지역 :  ' + user.addr + '</li>');

            //var editLink = $('<a href="/user/userEdit" class="myHomelink">내정보 수정</a>');
          
            
            var userDetailsContainer = $('<div class="user-details-container"></div>');
            userDetailsContainer.append(infoDiv);
           // userDetailsContainer.append(editLink);

            userDiv.append(imgDiv);
            userDiv.append(userDetailsContainer);

            userInfo.append(userDiv);
             
        	
        	
            var resumeList = $('#resumeList');
            resumeList.empty(); // 기존 내용을 비웁니다.
            
            if (data.length === 0) {
                resumeList.append('<p>이력서가 없습니다</p>');
            } else {

	            var count = 0;
	            $.each(data, function(index, resume) {
	                if (count >= 3) {
	                    return false; // 반복을 중지
	                }
	                count++;
	
	                var ul = $('<ul class="res"></ul>'); // ul 태그 생성
	                var div = $('<div class="def_div"></div>');
	
	                if (resume.def == "Y") {
	                    div.append('<span class="def">대표 이력서✍</span>');
	                }
	
	                ul.append(div);
	                ul.append('<li><a href="/user/resumeDetail?rno=' + resume.rno + '">' + resume.title + '</a></li>');
	
	                if (resume.moddate == null) {
	                    var regdate = new Date(resume.regdate).toISOString().split('T')[0];
	                    ul.append('<li>최종수정날짜 : ' + regdate + '</li>');
	                } else {
	                    var moddate = new Date(resume.moddate).toISOString().split('T')[0];
	                    ul.append('<li>최종수정날짜 : ' + moddate + '</li>');
	                }
	
	                resumeList.append(ul);
	            });
            }
           
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', status, error);
        }
    });

});

     
</script>


<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>