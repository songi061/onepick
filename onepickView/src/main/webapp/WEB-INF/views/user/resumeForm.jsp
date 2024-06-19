<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/style.css" rel="stylesheet">
<link href="/css/resumeForm.css" rel="stylesheet">
<script src="/js/resume.js"></script>
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
			  <button class="btn dropdown-toggl text-onepick" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    이력서 관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/resumeList'">이력서 리스트</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/user/resumeForm'">이력서 작성</button></li>
			  </ul>
			</div>
			<button class="btn" type="button" onclick="location.href='/user/scrapList'">
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
<div class="container" id="box">
<h3 class="page_title">이력서 작성</h3>
<hr>
<form name="frm">
	  	
  	<label class="checkbox-container">공개 여부
    <input type="checkbox" id="disclo_check" name="disclo" value="public">
    <span class="checkmark"></span>
	</label><br><br>
  	
	이력서 제목<input type="text" name="title" placeholder="이력서 제목을 입력해주세요" class="textbox"><br>
	자기소개서 제목<input type="text" name="selfInfoTitle" placeholder="자기소개서 제목을 입력해주세요" class="textbox"><br>
	자기소개서 내용<br>
	<textarea name="selfInfoContent" placeholder="자기소개서 내용을 입력해주세요" class="longtext" ></textarea>
	<span style="color:#aaa;" id="counter">글자 수 (0 / 500)</span><br>
	
	<div>
	<label for="select1">희망근무지역1</label>
	<select name="region1" id="select1" class="selectbox"> 
		<option value="">시 선택</option>
	</select>	
	<select name="region1_1" id="select2" class="selectbox">
		<option value="">구 선택</option>
	</select>
	</div>
	
	<br>
	
	<div>
	<label for="select3">희망근무지역2</label>
	<select name="region2" id="select3" class="selectbox">
		<option value="">시 선택</option>
	</select>	
	<select name="region2_1" id="select4" class="selectbox">
		<option value="">구 선택</option>
	</select>
	</div>
	
	<br>
	
	<div>
	<label for="select_sector">관심업종</label>
	<select name="sector" id="select_sector" class="selectbox">
		<option value="">관심업종 선택</option>
	</select>
	
	<label for="select_job">관심직무</label>
	<select name="job" id="select_job" class="selectbox">
		<option value="">관심직무 선택</option>
	</select>
	</div>
	
	<br>
	포트폴리오 URL<input type="text" name="portfolioUrl" placeholder="내용을 입력하세요" class="textbox"><br><br>
	
	<div>
		<span class="subtitle">사회활동</span><br>
		<hr>
		시작일<input type="date" name="startDay" class="datebox">
		종료일<input type="date" name="endDay" class="datebox"><br>
		참여기관<input type="text" name="ex_org" placeholder="내용을 입력하세요" class="textbox"><br>
		활동내역<input type="text" name="ex_content" placeholder="내용을 입력해주세요" class="textbox"><br><br>
	</div>
	
	<div>
		<span class="subtitle">자격증</span><br>
		<hr>
		자격증명<input type="text" name="lname" placeholder="내용을 입력하세요" class="textbox"><br>
		발급기관<input type="text" name="org" placeholder="내용을 입력하세요" class="textbox"><br>
		취득일<input type="date" name="getDate" class="datebox"><br><br>
		<button onclick="getLicenseData(event)">추가</button>
	</div>
	
	<div>
		<span class="subtitle">학력사항</span><br>
		<hr>
		입학일자<input type="date" name="accDate" class="datebox">
		졸업일자<input type="date" name="gradDate" class="datebox"><br>
		학교명<input type="text" name="eduName" placeholder="내용을 입력하세요" class="textbox">
		전공학과<input type="text" name="major" placeholder="내용을 입력하세요" class="textbox"><br>
		학점<input type="text" name="score" placeholder="내용을 입력하세요" class="textbox">
		
		<label for="select_degree">상태</label>
		<select name="s_status" id="select_degree" class="selectbox">
			<option value="졸업">졸업</option>
			<option value="중퇴">중퇴</option>
			<option value="휴학">휴학</option>
			<option value="기타">기타</option>
		</select><br><br>
	</div>
	
	<div>

		<span class="subtitle">경력사항</span><br>
		<hr>
		입사일자<input type="date" name="startDate" class="datebox">
		퇴사일자<input type="date" name="endDate" class="datebox"><br>
		회사명<input type="text" name="companyName" placeholder="내용을 입력하세요" class="textbox">
		직급<input type="text" name="rank" placeholder="내용을 입력하세요" class="textbox"><br>
		
		
		
		<label for="select_sector2">업종</label>
		<select name="c_type" id="select_sector2" class="selectbox">
			<option value="">업종 선택</option>
		</select>
		
		<label for="select_job2">직무</label>
		<select name="position" id="select_job2" class="selectbox">
			<option value="">업종을 먼저 선택해주세요</option>
		</select><br>
		
		<label for="select_career">상태</label>
		<select name="career_status" id="select_career" class="selectbox">
			<option value="재직">재직중</option>
			<option value="퇴사">퇴사</option>
			<option value="기타">기타</option>
		</select><br>
		
		업무 내용<input type="text" name="work" placeholder="내용을 입력하세요" class="textbox"><br><br>

	</div>
	
	<div>
		<span class="subtitle">보유능력</span><br>
		<hr>
		<label for="select_skill">타입</label>
		<select name="skillName" id="select_skill" class="selectbox">
			<option value="">스킬 선택</option>
			<option value="java">java</option>
			<option value="python">python</option>
			<option value="javascript">javascript</option>
			<option value="c++">c++</option>
			<option value="Ruby">Ruby</option>
			<option value="SQL">SQL</option>
			<option value="R">R</option>
			<option value="C">C</option>
			<option value="ERP">ERP</option>
			<option value="HTML/CSS">HTML/CSS</option>
			<option value="React">React</option>
			<option value="Angular">Angular</option>
			<option value="Vue.js">Vue.js</option>
			<option value="Django">Django</option>
			<option value="네트워크 보안">네트워크 보안</option>
			<option value="Swift(IOS)">Swift(IOS)</option>
			<option value="Kotlin">Kotlin</option>
			<option value="Flutter">Flutter</option>
			<option value="Excel">Excel</option>
			<option value="외국어능통">외국어능통</option>
		</select><br>
		
		내용<input type="text" name="oa_content" placeholder="내용을 입력하세요" class="textbox">
	</div>
	
	<input type="button" value="등록하기" onclick="postData(event)" class="btn2">
</form>
</div>

<script>
	$('.longtext').keyup(function (e){
	    var content = $(this).val();
	    $('#counter').html("("+content.length+" / 500)");    //글자수 실시간 카운팅
	
	    if (content.length > 500){
	        alert("최대 500자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 500));
	        $('#counter').html("(500 / 500)");
	    }
	});
	
	
	let licenseArr=[];
	//let licenseDiv = document.querySelector("#license");
	
	   function getLicenseData(e) {
		    e.preventDefault();
		
		    // 부모 요소에서 입력 값을 가져오기
		    const parentElement = e.target.parentElement;
		
		    // 입력 요소 선택
		    const lname = parentElement.querySelector("input[name=lname]");
		    const org = parentElement.querySelector("input[name=org]");
		    const getDate = parentElement.querySelector("input[name=getDate]");
		
		    // 입력 값을 객체로 변환
		    let licenseObj = {
		        "lname": lname.value,
		        "org": org.value,
		        "getDate": getDate.value
		    };
		
		    // 콘솔에 객체 출력
		    console.log("licenseObj 출력 : ", licenseObj);
		
		    // 배열에 객체 추가
		    licenseArr.push(licenseObj);
		
		    // 콘솔에 배열 출력
		    console.log("licenseArr 출력 : ", licenseArr);
		
		    // 입력 폼 초기화
		    lname.value = "";
		    org.value = "";
		    getDate.value = "";
		}
	
	   
	   
	   
	   let resumeArr = [];
		
		   function getResumeData(e) {
			    e.preventDefault();

			
			    // 입력 요소 선택
			    const disclo = document.querySelector("input[name=disclo]");
			    const title = document.querySelector("input[name=title]");
			    const selfInfoTitle = document.querySelector("input[name=selfInfoTitle]");
			    const selfInfoContent = document.querySelector("input[name=selfInfoContent]");
			    const region1 = document.querySelector("select[name=region1]");
			    const region1_1 = document.querySelector("select[name=region1_1]");
			    const region2 = document.querySelector("select[name=region2]");
			    const region2_1 = document.querySelector("select[name=region2_1]");
			    const sector = document.querySelector("select[name=sector]");
			    const job = document.querySelector("select[name=job]");
			    const portfolioUrl = document.querySelector("input[name=portfolioUrl]")
			
			    // 입력 값을 객체로 변환
			    let resumeObj = {
			        "disclo": disclo.value,
			        "title": title.value,
			        "selfInfoTitle": selfInfoTitle.value,
			        "selfInfoContent": selfInfoContent.value,
			        "region1": region1.value,
			        "region1_1": region1_1.value,
			        "region2": region2.value,
			        "region2_1": region2_1.value,
			        "sector": sector.value,
			        "job": job.value,
			        "portfolioUrl": portfolioUrl.value,
			    };
			
			    // 콘솔에 객체 출력
			    console.log("resumeObj 출력 : ", resumeObj);
			
			    // 배열에 객체 추가
			    resumeArr.push(resumeObj);
			
			    // 콘솔에 배열 출력
			    console.log("resumeArr 출력 : ", resumeArr);
			
			    
			}
	


</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="/js/userInterceptor.js"></script>
<script src="/js/CloseBrowserClearlocalStorage.js"></script>
</html>