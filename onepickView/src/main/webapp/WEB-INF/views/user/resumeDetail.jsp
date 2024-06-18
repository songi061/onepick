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
.title{
	font-size : 1.4em;
	font-weight : bold;
}

.subtitle{
	font-size : 1.1em;
	font-weight : bold;
}
.pub{
	color : #42d056; 
	font-weight : bold;
}

.info{
	border : 2px solid lightgrey;
	padding : 20px;
	padding-bottom : 30px;
	margin-bottom : 30px;
	margin-top : 10px;
	border-radius: 20px;
	color : #424242;
}
#resumeForm{
	border : 2px solid darkgrey;
	padding : 30px;
	margin : 60px;
	border-radius: 10px;

}
.right {
       float: right;
       color : #848484;
   }
   
#editBtn{
    width: 100%;
    height: 40px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 60px;
    
}

#editBtn:hover {
    background-color: #0056b3;
    color: white;
}    

    
</style>

</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container">
	
<div id="resumeForm">
	<div   id="scrapBtn" onclick="scrapResume()">
		<img class="ms-auto" style="width:25px; height:25px;" src="/icon/save.png">
	</div>
<div id="resume"></div>
<hr>
<p class="subtitle">사회활동</p>
<div class="info" id="experiences"></div>
<hr>
<p class="subtitle">경력사항</p>
<div class="info" id="careers"></div>
<hr>
<p class="subtitle">학력사항</p>
<div class="info" id="schools"></div>
<hr>
<p class="subtitle">자격증</p>
<div class="info" id="licenses"></div>
<hr>
<p class="subtitle">보유능력</p>
<div class="info" id="oaList"></div>


<input type="button" id="editBtn" value="수정" style="display: none;" onclick="edit(<%= request.getAttribute("rno") %>)">


</div>


</div>

<script>
let rno = null;
let scrapped = null;

$(document).ready(function() {
	
	rno = <%= request.getAttribute("rno") %>;
	
    // AJAX 요청 보내기
	$.ajax({
	    url: 'http://localhost:9001/api/v1/resume/' + rno,
	    type: 'GET',
	    dataType: 'json',
	    /* headers: {
	        'Authorization': 'Bearer ' + token,
	        'writer': token_writer,
	        'role': token_role
	    }, */
	    success: function(data) {
	    	
	        console.log(data);
	        
	     // Resume 정보
            var resumeDiv = $('#resume');
            resumeDiv.empty();
            var resumeUl = $('<ul class="resume"></ul>');
            var resume = data.resume;

            if (resume.disclo == "public") {
                resumeUl.append('<li class="pub">공개 이력서</li>');
            } else {
                resumeUl.append('<li class="pub">비공개 이력서</li>');
            }
            resumeUl.append('<li class="title">' + resume.title + '</li><hr>');
            resumeUl.append('<li class="subtitle" style="color : #2E9AFE;">기본정보</li>');
            resumeUl.append('<li class="subtitle">💚 이름 :  ' + resume.user.name + '</li>');
            resumeUl.append('<li class="subtitle">💚 이메일 :  ' + resume.user.email + '</li>');
            resumeUl.append('<li class="subtitle">💚 전화번호 :  ' + resume.user.tel + '</li>');
            resumeUl.append('<li class="subtitle">💚 주소 :  ' + resume.user.addr + '</li>');
            resumeUl.append('<li class="subtitle">💚 성별 :  ' + resume.user.gender + '</li>');
            resumeUl.append('<li class="subtitle">💚 생년월일 :  ' + resume.user.birthDate + '</li><br><br>');
            resumeUl.append('<li class="subtitle">자기소개서 제목</li>');
            resumeUl.append('<li>' + resume.selfInfoTitle + '</li><br>');
            resumeUl.append('<li class="subtitle">자기소개서 내용</li>');
            resumeUl.append('<li>' + resume.selfInfoContent + '</li><br><hr>');
            resumeUl.append('<li class="subtitle">희망근무지역</li>');
            resumeUl.append('<li>1순위 : ' + resume.region1 + ' ' + resume.region1_1 + ' / 2순위 : ' + resume.region2 + ' ' + resume.region2_1 + '</li><br>');
            resumeUl.append('<li class="subtitle">관심업종/직무</li>');
            resumeUl.append('<li>' + resume.sector + ' / ' + resume.job + '</li><br>');
            resumeUl.append('<li class="subtitle">포트폴리오 URL</li>');
            resumeUl.append('<li>' + resume.portfolioUrl + '</li>');

            resumeDiv.append(resumeUl);

            
            // Experience(사회활동) 정보
            var experiencesDiv = $('#experiences');
            experiencesDiv.empty();
            var experiencesUl = $('<ul class="experiences"></ul>');
            var experiences = data.experiences;

            experiences.forEach(function(experience) {
            	
                experiencesUl.append('<li>' + experience.ex_content + '</li>');
                experiencesUl.append('<li>' + experience.ex_org + '</li>');
                experiencesUl.append('<li class="right">활동 기간 : '+ experience.startDay + ' ~ ' + experience.endDay + '</li>');
            });
            experiencesDiv.append(experiencesUl);

            
            // Career(경력사항) 정보
            var careersDiv = $('#careers');
            careersDiv.empty();
            var careersUl = $('<ul class="careers"></ul>');
            var careers = data.careers;

            careers.forEach(function(career) {
            	careersUl.append('<li>' + career.companyName + '</li>');
            	careersUl.append('<li>' + career.c_type + '/' +career.position + '/'  + career.work + '</li>');
            	careersUl.append('<li>' + career.rank + '/' +career.career_status + '</li>');
            	careersUl.append('<li class="right">근무 기간 : '+ career.startDate + ' ~ ' + career.endDate + '</li>');
            });
            careersDiv.append(careersUl);
			
            
         	// School (학력) 정보
            var schoolsDiv = $('#schools');
            schoolsDiv.empty();
            var schoolsUl = $('<ul class="schools"></ul>');
            var schools = data.schools;

            schools.forEach(function(school) {
            	schoolsUl.append('<li>' + school.eduName +'/' + school.major + '</li>');
            	schoolsUl.append('<li>' + school.s_status + '(학점 : ' +school.score + ')</li>');
        
            	schoolsUl.append('<li class="right">학업 기간 : '+ school.accDate + ' ~ ' + school.gradDate + '</li>');
            });
            schoolsDiv.append(schoolsUl);
            
            
            // License(자격증) 정보
            var licensesDiv = $('#licenses');
            licensesDiv.empty();
            var licensesUl = $('<ul class="licenses"></ul>');
            var licenses = data.licenses;

            licenses.forEach(function(license) {
                licensesUl.append('<li>' + license.lname + '</li>');
            	licensesUl.append('<li>발급 기관 : ' + license.org + '</li>');
           		licensesUl.append('<li>취득일 : ' + license.getDate + '</li>');
            
            });
            licensesDiv.append(licensesUl);
            
            
            // OA (스킬) 정보
            var oaDiv = $('#oaList');
            oaDiv.empty();
            var oaUl = $('<ul class="oa"></ul>');
            var oaList = data.oaList;

            oaList.forEach(function(oa) {
                oaUl.append('<li>&nbsp&nbsp' + oa.skillName + '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'+ oa.oa_content + '</li>');
            });
            oaDiv.append(oaUl);
			
            
            
            
         	// Role에 따라 버튼 보이기 처리
            var role = localStorage.getItem('role');
            var editBtn = $('#editBtn');
            var scrapBtn = $('#scrapBtn');
            
            if (role === 'ROLE_USER') {
                editBtn.show();  // 수정 버튼 보이기
            } else if (role === 'ROLE_COMPANY') {
                editBtn.hide();  // 수정 버튼 숨기기
                scrapBtn.show(); //기업이 구직자 스크랩하기
            }
            
            //var resumeForm = $('#resumeForm');
            //resumeForm.append('<input type="button" id="editBtn" value="수정" onclick="edit(' + resume.rno + ')">');
	    
            //스크랩 여부 띄워주기
            checkScrapStatus();
	    	
	    },
	    error: function(xhr, status, error) {
	        console.error('AJAX 요청 실패:', status, error);
	    }
	});
});

function edit(rno) {
	window.location.href = '/user/resumeEdit?rno=' + rno;
}



//이력서 스크랩상태체크
async function checkScrapStatus() {
  try {
    const response = await fetch('http://localhost:9001/api/v1/scrapped-resume?rno=' + rno, {
      method: 'GET',
      headers: {
        'jwtToken': localStorage.getItem('jwtToken'),
        'username': localStorage.getItem('username'),
        'role': localStorage.getItem('role'),
        'Content-Type': 'application/json'
      }
    });

    if (response.ok) {
      const result = await response.text();
      if (result === "existed") {
        document.querySelector("#scrapBtn img").src = "/icon/save_full.png";
        scrapped = true;
      } else if (result === "not existed") {
        document.querySelector("#scrapBtn img").src = "/icon/save.png";
        scrapped = false;
      } else {
        console.error('예상치 못한 응답:', result);
      }
    } else {
      console.error('네트워크 응답이 정상적이지 않습니다:', response.statusText);
    }
  } catch (error) {
    console.error('구독 상태 확인 중 오류가 발생했습니다:', error);
  }
}

//공고찜하기 버튼 클릭이벤트
function scrapResume() {
	if(localStorage.getItem("role") == "ROLE_COMPANY"){
		if(scrapped == true){
			if (confirm("정말 해당 이력서를 스크랩 리스트에서 삭제하시겠습니까?")) {
				//구독취소하기
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function () {
					if (this.responseText == "done") {
						//비어있는 버튼으로 바꿔주기
						document.querySelector("#scrapBtn img").src = "/icon/save.png";
						 scrapped = false;
					} 
				}
				xhttp.open("delete", 'http://localhost:9001/api/v1/scrapped-resume?rno=' + rno, true);
				xhttp.setRequestHeader("username", localStorage.getItem("username"));
				xhttp.send();
			}
		}else if(scrapped == false){
			//구독하기
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function () {
				if (this.responseText == "done") {
					alert("성공적으로 해당 이력서를 스크랩 했습니다!")
					//버튼 색칠한거로 바꿔주기
					document.querySelector("#scrapBtn img").src = "/icon/save_full.png";
					 scrapped = true;
				} 
			}
			xhttp.open("POST", 'http://localhost:9001/api/v1/scrapped-resume?rno=' + rno, true);
			xhttp.setRequestHeader("username", localStorage.getItem("username"));
			xhttp.send();
		}
	}else{
		alert("이력서 스크랩은 기업 사용자만 사용 가능한 기능입니다.")
	}
	
} 

	

</script>

<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>