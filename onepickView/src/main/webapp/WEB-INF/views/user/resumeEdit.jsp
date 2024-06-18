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

</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container" id="box">
<h3>이력서 작성</h3>
<hr>
<form name="frm">
	  	
  	<label class="checkbox-container">공개 여부
    <input type="checkbox" id="disclo_check" name="disclo" value="public">
    <span class="checkmark"></span>
	</label><br><br>
  	
	이력서 제목<input type="text" name="title" id="title" placeholder="이력서 제목을 입력해주세요" class="textbox"><br>
	자기소개서 제목<input type="text" name="selfInfoTitle" id="selfInfoTitle" placeholder="자기소개서 제목을 입력해주세요" class="textbox"><br>
	자기소개서 내용<br>
	<textarea name="selfInfoContent" class="longtext" id="selfInfoContent" placeholder="자기소개서 내용을 입력해주세요" ></textarea>
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
	포트폴리오 URL<input type="text" name="portfolioUrl" id="portfolioUrl" placeholder="내용을 입력하세요" class="textbox"><br><br>
	
	<div>
		<span class="subtitle">사회활동</span><br>
		<hr>
		시작일<input type="date" name="startDay" id="startDay" class="datebox">
		종료일<input type="date" name="endDay" id="endDay" class="datebox"><br>
		참여기관<input type="text" name="ex_org" id="ex_org" placeholder="내용을 입력하세요" class="textbox"><br>
		활동내역<input type="text" name="ex_content" id="ex_content" placeholder="내용을 입력해주세요" class="textbox"><br><br>
	</div>
	
	<div>
		<span class="subtitle">자격증</span><br>
		<hr>
		자격증명<input type="text" name="lname" id="lname" placeholder="내용을 입력하세요" class="textbox"><br>
		발급기관<input type="text" name="org" id="org" placeholder="내용을 입력하세요" class="textbox"><br>
		취득일<input type="date" name="getDate" id="getDate" class="datebox"><br><br>
	</div>
	
	<div>
		<span class="subtitle">학력사항</span><br>
		<hr>
		입학일자<input type="date" name="accDate" id="accDate" class="datebox">
		졸업일자<input type="date" name="gradDate" id="gradDate" class="datebox"><br>
		학교명<input type="text" name="eduName" id="eduName" placeholder="내용을 입력하세요" class="textbox">
		전공학과<input type="text" name="major" id="major" placeholder="내용을 입력하세요" class="textbox"><br>
		학점<input type="text" name="score" id="score" placeholder="내용을 입력하세요" class="textbox">
		
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
		입사일자<input type="date" name="startDate" id="startDate" class="datebox">
		퇴사일자<input type="date" name="endDate" id="endDate" class="datebox"><br>
		회사명<input type="text" name="companyName" id="companyName" placeholder="내용을 입력하세요" class="textbox">
		직급<input type="text" name="rank" id="rank" placeholder="내용을 입력하세요" class="textbox"><br>
		
		
		
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
		
		업무 내용<input type="text" name="work" id="work" placeholder="내용을 입력하세요" class="textbox"><br><br>

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
		
		내용<input type="text" name="oa_content" id="oa_content" placeholder="내용을 입력하세요" class="textbox">
	</div>
	
	<input type="button" value="수정하기" onclick="putData(event)" class="btn2">
</form>
</div>



<script>
$(document).ready(function() {
    // 글자수 실시간 카운팅
    $('.longtext').keyup(function (e){
        var content = $(this).val();
        $('#counter').html("("+content.length+" / 500)");

        if (content.length > 500){
            alert("최대 500자까지 입력 가능합니다.");
            $(this).val(content.substring(0, 500));
            $('#counter').html("(500 / 500)");
        }
    });

    var rno = <%= request.getParameter("rno") %>;

    // AJAX 요청 보내기
    $.ajax({
        url: 'http://localhost:9001/api/v1/resume/' + rno,
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            //console.log('Resume data:', data);
            var resume = data.resume;

            // 각 input 요소에 값 설정
            $('#disclo_check').prop('checked', resume.disclo === 'public');
            $('#title').val(resume.title);
            $('#selfInfoTitle').val(resume.selfInfoTitle);
            $('#selfInfoContent').val(resume.selfInfoContent);
            $('#portfolioUrl').val(resume.portfolioUrl);

            // 데이터를 로드한 후 select 요소를 업데이트
            updateSelectElements(resume);
            updateJobSectorElements(resume);
            updateJobSectorElements2(data);

            var experiences = data.experiences[0]; // 예시로 첫 번째 경험을 사용
            $('#startDay').val(experiences.startDay);
            $('#endDay').val(experiences.endDay);
            $('#ex_org').val(experiences.ex_org);
            $('#ex_content').val(experiences.ex_content);

            var licenses = data.licenses[0]; // 예시로 첫 번째 자격증을 사용
            $('#lname').val(licenses.lname);
            $('#org').val(licenses.org);
            $('#getDate').val(licenses.getDate);

            var school = data.schools[0]; // 예시로 첫 번째 학력을 사용
            $('#accDate').val(school.accDate);
            $('#gradDate').val(school.gradDate);
            $('#eduName').val(school.eduName);
            $('#major').val(school.major);
            $('#score').val(school.score);
            $('#select_degree').val(school.s_status);

            var career = data.careers[0]; // 예시로 첫 번째 경력을 사용
            $('#startDate').val(career.startDate);
            $('#endDate').val(career.endDate);
            $('#companyName').val(career.companyName);
            $('#rank').val(career.rank);
            //$('#select_sector2').val(career.c_type);
            //$('#select_job2').val(career.position);
            $('#select_career').val(career.career_status);
            $('#work').val(career.work);

            var skill = data.oaList[0]; // 예시로 첫 번째 스킬을 사용
            $('#select_skill').val(skill.skillName);
            $('#oa_content').val(skill.oa_content);
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', status, error);
        }
    });

    function updateSelectElements(resume) {
        const xhttp1 = new XMLHttpRequest();
        xhttp1.onload = function() {
            const select1 = document.getElementById("select1");
            const select2 = document.getElementById("select2");
            const select3 = document.getElementById("select3");
            const select4 = document.getElementById("select4");

            let data = JSON.parse(this.responseText);
            //console.log('Administrative data:', data);

            // select1과 select3에 데이터 키를 추가
            data.forEach((item) => {
                const key = Object.keys(item)[0];

                // select1과 select3에 옵션 추가
                const option1 = document.createElement("option");
                option1.value = key;
                option1.text = key;
                select1.appendChild(option1);

                const option3 = document.createElement("option");
                option3.value = key;
                option3.text = key;
                select3.appendChild(option3);
            });

            // select1의 선택된 값에 따라 select2 업데이트 함수
            function updateSelect1() {
                const selectedKey = select1.value;
                select2.innerHTML = '<option value="">구를 선택하세요!</option>';

                if (selectedKey) {
                    const selectedItem = data.find(item => Object.keys(item)[0] === selectedKey);
                    if (selectedItem) {
                        const values = selectedItem[selectedKey];
                        values.forEach(value => {
                            const option = document.createElement("option");
                            option.value = value;
                            option.text = value;
                            select2.appendChild(option);
                        });
                    }
                }
            }

            // select3의 선택된 값에 따라 select4 업데이트 함수
            function updateSelect2() {
                const selectedKey = select3.value;
                select4.innerHTML = '<option value="">구를 선택하세요!</option>';

                if (selectedKey) {
                    const selectedItem = data.find(item => Object.keys(item)[0] === selectedKey);
                    if (selectedItem) {
                        const values = selectedItem[selectedKey];
                        values.forEach(value => {
                            const option = document.createElement("option");
                            option.value = value;
                            option.text = value;
                            select4.appendChild(option);
                        });
                    }
                }
            }

            // select1과 select3의 change 이벤트에 함수 연결
            select1.addEventListener('change', updateSelect1);
            select3.addEventListener('change', updateSelect2);

            // 데이터 로드 후 resume 객체에서 초기 값 설정
            select1.value = resume.region1;
            select3.value = resume.region2;
            updateSelect1();
            updateSelect2();

            // select2와 select4의 값 설정
            setTimeout(() => {
                select2.value = resume.region1_1;
                select4.value = resume.region2_1;
            }, 100); // 약간의 딜레이를 두어 옵션이 로드될 시간을 확보
        };

        xhttp1.open("GET", "/json/korea-administrative-district.json", true);
        xhttp1.send();
    }

    function updateJobSectorElements(resume) {
        // 관심업종
        const xhttp2 = new XMLHttpRequest();
        xhttp2.onload = function() {
            const selectSector = document.getElementById("select_sector");
            
            const data = JSON.parse(this.responseText);
            

            data.forEach(item => {
                const sectorName = item["상위직무"];
                const option = document.createElement("option");
                option.value = item["상위직무"];
                option.text = sectorName;
                selectSector.appendChild(option);
            });

            // 초기값 설정
            selectSector.value = resume.sector;
        };
        xhttp2.open("GET", "/json/job_category.json", true);
        xhttp2.send();

        // 관심직무
        const xhttp3 = new XMLHttpRequest();
        xhttp3.onload = function() {
            const selectSector = document.getElementById("select_sector");
            const selectJob = document.getElementById("select_job");
            
            const data = JSON.parse(this.responseText);
            

            // 관심업종 선택 변경 시 관심직무 업데이트
            function updateSelectJob() {
                const selectedSectorCode = selectSector.value;

                // 관심직무 옵션 초기화
                selectJob.innerHTML = '<option value="">관심직무 선택</option>';

                data.forEach(item => {
                    if (item["직무명"] == selectedSectorCode) {
                        const option = document.createElement("option");
                        option.text = item["직무 키워드명"];
                        option.value = item["직무 키워드명"];
                        selectJob.appendChild(option);
                    }
                });
            }

            selectSector.addEventListener('change', updateSelectJob);

            // 초기값 설정
            setTimeout(() => {
                updateSelectJob();
                selectJob.value = resume.job;
            }, 100); // 약간의 딜레이를 두어 옵션이 로드될 시간을 확보
        
        };
        xhttp3.open("GET", "/json/job.json", true);
        xhttp3.send();
    }
        
    
    
    function updateJobSectorElements2(resume) {
        // 업종
        const xhttp4 = new XMLHttpRequest();
        xhttp4.onload = function() {
            const selectSector2 = document.getElementById("select_sector2");
            
            const data = JSON.parse(this.responseText);

            data.forEach(item => {
                const sectorName = item["상위직무"];
                const option = document.createElement("option");
                option.value = item["상위직무"];
                option.text = sectorName;
                selectSector2.appendChild(option);
            });

            // 초기값 설정
            if (resume.careers && resume.careers.length > 0) {
                selectSector2.value = resume.careers[0].c_type;
            }
        };
        xhttp4.open("GET", "/json/job_category.json", true);
        xhttp4.send();

        // 직무
        const xhttp5 = new XMLHttpRequest();
        xhttp5.onload = function() {
            const selectSector2 = document.getElementById("select_sector2");
            const selectJob2 = document.getElementById("select_job2");
            
            const data = JSON.parse(this.responseText);

            // 직무 옵션 초기화
            if(selectSector2.value == null){
            	selectJob2.innerHTML = '<option value="">직무 선택</option>';
            }
         	// 업종 선택에 따른 직무 업데이트 실행
            updateSelectJob2();
         	
         	
            // 업종 선택 변경 시 직무 업데이트 함수 정의
            function updateSelectJob2() {
                const selectedSectorCode = selectSector2.value;

                selectJob2.innerHTML = '<option value="">직무 선택</option>';

                data.forEach(item => {
                    if (item["직무명"] == selectedSectorCode) {
                        const option = document.createElement("option");
                        option.text = item["직무 키워드명"];
                        option.value = item["직무 키워드명"];
                        selectJob2.appendChild(option);
                    }
                });
            }

            selectSector2.addEventListener('change', updateSelectJob2);

            // 초기값 설정

            selectJob2.value = resume.careers[0].position;
            console.log('포지션 출력 : '+resume.careers[0].position);

            
        };
        xhttp5.open("GET", "/json/job.json", true);
        xhttp5.send();
    }
});


function putData(e){
	var rno = <%= request.getParameter("rno") %>;
	
	e.preventDefault();
	var form = document.forms['frm'];
	var formData = new FormData(form);

	$.ajax({
		type: "PUT",
		url: 'http://localhost:9001/api/v1/resume/' + rno,
		data : formData,
		dataType : "text",
		contentType: false,  // 반드시 false로 설정
	    processData: false,  // 반드시 false로 설정
		success : function(data){
			alert("수정완료!");
			window.location.href = "/user/resumeList";
		},
		error : function(){
			console.log("에러 발생");
		}
	
	});
}


</script>
<script src="/js/resume_EditForm.js"></script>

<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>