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
<link href="/css/recruitForm.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="/js/CloseBrowserClearlocalStorage.js"></script>
<script src="/js/companyInterceptor.js"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="sub_header border-bottom">
	<div class="container">
		<div class="d-flex py-2">
			<button class="btn" type="button" onclick="location.href='/company/myHome'">
			   MyHome
			</button>
			<button class="btn" type="button" onclick="location.href='/company/scrapList'">
			   스크랩관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle  text-onepick" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    채용공고관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/recruitList'">채용공고 조회</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/recruitForm'">채용공고 등록</button></li>
			  </ul>
			</div>
			<button class="btn" type="button" onclick="location.href='/company/applyList'">
			   지원내역관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    평점관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/reviewList'">평점 조회</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/reviewForm'">평점 등록</button></li>
			  </ul>
			</div>
			<button class="btn" type="button" onclick="location.href='/company/myQnaList'">
			   QnA관리
			</button>
			<div class="dropdown">
			  <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    커뮤니티관리
			  </button>
			  <ul class="dropdown-menu">
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/myBoardList'">내가 쓴 글 리스트</button></li>
			    <li><button class="dropdown-item" type="button" onclick="location.href='/company/myCommentList'">내가 쓴 댓글 목록</button></li>
			  </ul>
			</div>
		</div>
	</div>
</div>
	<div class="container">
		<div class="page_title">채용공고등록</div>
		<div class="recruit_form">
		
			<form>
				<div class="section_title">채용공고 제목 *</div>
				<input type="text" name="wantedTitle" placeholder="채용공고 제목을 입력하세요">
				<div class="section_title">모집 업종 *</div>
				<select name="sector1"><option value="">업종 상위 카테고리 선택</option></select>	<select name="sector2"><option value="">업종 하위 카테고리 선택</option></select>
				<div class="section_title">모집 직무 *</div>
				<select name="position1"><option value="">직무 상위 카테고리 선택</option></select> <select name="position2"><option value="">직무 하위 카테고리 선택</option></select>
				<div class="section_title">상세 직무내용 *</div>
				<textarea name="jobCont"></textarea>
				<div class="section_title">필요스킬 *</div>
				<select name="skillName" style="display:none;">
					 <option value="">스킬 선택</option>
					 <option value="재무제표관리">재무제표관리</option>
					 <option value="고객관계관리">고객관계관리</option>
					 <option value="기본데이터분석기술">기본데이터분석기술</option>
					 <option value="커뮤니케이션기술">커뮤니케이션기술</option>
					 <option value="리더십">리더십</option>
					 <option value="팀워크">팀워크</option>
					 <option value="문제해결">문제해결</option>
					 <option value="디자인">Photoshop</option>
					 <option value="커뮤니케이션기술">AdobeXD</option>
					 <option value="커뮤니케이션기술">Jira</option>
			         <option value="Figma">Figma</option>
			         <option value="HTML">HTML</option>
			         <option value="프리미어">프리미어</option>
			         <option value="illustrator">illustrator</option>
			         <option value="마케팅역량">마케팅역량</option>
			         <option value="홍보광고">홍보광고</option>
			         <option value="세일즈리더십">세일즈리더십</option>
			         <option value="번역">번역</option>
			         <option value="영상제작">영상제작</option>
			         <option value="모바일애플리케이션개발">모바일애플리케이션개발</option>
			         <option value="디자인">UX디자인</option>
			         <option value="인공지능">인공지능</option>
			         <option value="사람관리">사람관리</option>
			         <option value="분석적사고력">분석적사고력</option>
			         <option value="음향제작">음향제작</option>
			         <option value="회계">회계</option>
			         <option value="금융상품개발">금융상품개발</option>
			         <option value="금융영업">금융영업</option>
			         <option value="신용분석">신용분석</option>
			         <option value="총무">총무</option>
			         <option value="품질관리">품질관리</option>
			         <option value="무역유통관리">무역유통관리</option>
			         <option value="일반사무">일반사무</option>
			         <option value="경영기획">경영기획</option>
			         <option value="건강관리">건강관리</option>
			         <option value="배관공사">배관공사</option>
			         <option value="하드웨어">하드웨어</option>
			         <option value="외국어능통">외국어능통</option>
			         <option value="식음료">식음료</option>
			         <option value="자동차정비">자동차정비</option>
			         <option value="간호">간호</option>
			         <option value="의료">의료</option>
			         <option value="전기">전기</option>
			         <option value="python">python</option>
			         <option value="javascript">javascript</option>
			         <option value="Ruby">Ruby</option>
			         <option value="SQL">SQL</option>
			         <option value="R">R</option>
			         <option value="C">C</option>
			         <option value="ERP">ERP</option>
			         <option value="클라우드컴퓨팅">클라우드컴퓨팅</option>
			         <option value="React">React</option>
			         <option value="Angular">Angular</option>
			         <option value="Vue.js">Vue.js</option>
			         <option value="Django">Django</option>
			         <option value="네트워크 보안">네트워크 보안</option>
			         <option value="Swift(IOS)">Swift(IOS)</option>
			         <option value="Kotlin">Kotlin</option>
			         <option value="Flutter">Flutter</option>
			         <option value="Excel">Excel</option>
				</select> 
				<div onclick="showSkillOption()" class="showOptionbtn"> ➕ 필요스킬추가하기 </div>
				<div style="display:none;" onclick="addSkill()" class="add-skill-btn"> ➕ 필요스킬추가하기 </div>
				<div class='skillContainer'></div>
				<div class="btn btn-onepick" style="display:none;" id="saveBtn" onclick="saveSkills(event)">저장</div>
				<div class="section_title">접수마감일 *</div>
				<input type="date" name="receiptCloseDt">
				<div class="section_title">경험</div>
				<select name="experience">
					<option value="">경력 선택 </option>
					<option value="경력무관">경력무관</option>
					<option value="신입">신입</option>
					<option value="1~5년">1~5년</option>
					<option value="6~10년">6~10년</option>
					<option value="11년 이상">11년 이상</option>
				</select>
				<div class="section_title">고용형태 *</div>
				<select name="empTpNm"><option value="">고용형태 선택</option></select>
				<div class="section_title">모집인원 *</div>
				<input type="text" name="collectPsncnt" value="1"> 명
				<div class="section_title">임금조건 *</div>
				<select name="salTpNm"><option value="">임금조건 선택</option></select>
				<div class="section_title">근무지역 *</div>
				<select name="region1"><option value="">지역 상위 카테고리 선택</option></select>	<select name="region2"><option value="">직무 하위 카테고리 선택</option></select>
				<div class="section_title">근무시간 *</div>
				<input type="text" name="wkdWkhCnt">
				<div class="section_title">퇴직금</div>
				<input type="text" name="retirepay">
				<div class="section_title">기타복리후생</div>
				<input type="text" name="etcWelfare">
				<div class="section_title">공고이미지 첨부파일</div>
				<input type="file" name="attachFileUrl">
				<div class="section_title">병역특례채용희망 *</div>
				<input type="radio" name="mltsvcExcHope" value="y"> 특례채용희망
				<input type="radio" name="mltsvcExcHope" value="n"> 해당없음
				<div class="section_title">담당자이름 *</div>
				<input type="text" name="empName">
				<div class="section_title">담당자이메일 *</div>
				<input type="text" name="empEmail">
				<div class="section_title">담당자연락처 *</div>
				<input type="text" name="empTel">
				<input class="btn btn-onepick" type="submit" value="공고등록" onclick="return regJobAd(event)">
				
			</form>
		</div>
		
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const sector1El = document.querySelector("select[name=sector1]");
const sector2El = document.querySelector("select[name=sector2]");
const position1El = document.querySelector("select[name=position1]");
const position2El = document.querySelector("select[name=position2]");
const region1El = document.querySelector("select[name=region1]");
const region2El = document.querySelector("select[name=region2]");
const salaryEl = document.querySelector("select[name=salTpNm]");
const workTypeEl = document.querySelector("select[name=empTpNm]");
const skillNameEl = document.querySelector("select[name=skillName]");
const skillContainer = document.querySelector(".skillContainer")
const showOptionbtn = document.querySelector(".showOptionbtn");
const addSkillBtn = document.querySelector(".add-skill-btn");
const wantedTitleEl = document.querySelector("input[name=wantedTitle]")
const jobContEl = document.querySelector("select[name=jobCont]")
const receiptCloseDtEl = document.querySelector("input[name=receiptCloseDt]")
const collectPsncntEl = document.querySelector("input[name=collectPsncnt]")
const wkdWkhCntEl = document.querySelector("input[name=wkdWkhCnt]")
const empNameEl = document.querySelector("input[name=empName]")
const empEmailEl = document.querySelector("input[name=empEmail]")
const empTelEl = document.querySelector("input[name=empTel]")





let selectedSector1 = null;
let selectedSector1El = null;
let selectedPosition1 = null;
let selectedPosition1El = null;
let selectedRegion1 = null;
let selectedRegion1El = null;
let selectedSalary = null;
let selectedWorkType = null;
let skillExisted = false;
let arrItems = [];

function showSkillOption(){
//기존버튼 숨기고 추가버튼과 스킬옵션 보이게하기
	showOptionbtn.style.display = "none";
	addSkillBtn.style.display = "block";
	skillNameEl.style.display = "block";
}

//필요스킬 추가버튼 누를때마다 밑에 더해주기
function addSkill(){
	//클릭시에 선택된 option의 text값을 빼서 밑에 넣어줌
	const skillNameEl = document.querySelector("select[name=skillName]");
			
	//만약 스킬이 선택이 안되었거나, 되었더라도 이미 추가되어있는 스킬이라면 추가 안되도록 처리
	if(skillNameEl.value !=""){
		if(!skillContainer.querySelector("#"+ skillNameEl.value)){
			let skillItems = document.createElement("span");
			skillItems.classList = "skill_items"
			skillItems.setAttribute("id", skillNameEl.value);
			skillItems.style.margin="5px";
			skillItems.innerHTML=skillNameEl.value + "<span onclick='deleteSkill(event)'>❌</span>";
			skillContainer.appendChild(skillItems);
			document.querySelector("#saveBtn").style.display="block";
		}
		
	}
	
}

function deleteSkill(e){
	e.target.parentElement.remove();
	document.querySelector("#saveBtn").style.display="block";
}

//스킬 저장 버튼 
function saveSkills(e){
	//다시 클릭했을 경우를 위해서 초기화 시켜주기
	arrItems=[];
	//버튼 클릭하자마자 버튼 안보이게 하기
	e.target.style.display="none";
	const childNodes = document.querySelectorAll(".skill_items");
	
	//기존버튼 보이게하고 추가버튼과 스킬옵션 숨기기
	showOptionbtn.style.display = "block";
	addSkillBtn.style.display = "none";
	skillNameEl.style.display = "none";
	
	childNodes.forEach(skill=>{
		//여기서 skill List만들어준 후 저장하기
         arrItems.push(skill.getAttribute("id"));
    });
    console.log(arrItems); // 생성된 배열 출력
   	
}



//제출버튼 클릭시 서버로 데이터 보내주기

function regJobAd(event){
	event.preventDefault();
	
	if(!wantedTitleEl.value || !sector1El.value || !sector2El.value 
		|| !region1El.value || !region2El.value || !position1El.value 
		|| !position2El.value || !workTypeEl.value  || !salaryEl.value 
		|| !skillNameEl.value || !receiptCloseDtEl.value 
		|| !collectPsncntEl.value || !wkdWkhCntEl.value
		|| !empNameEl.value || !empEmailEl.value || !empTelEl.value ){
		alert("필수 입력값이 모두 입력되지 않았습니다. 다시 시도해주세요")
		return false;
	}

	let form = document.querySelector("form");
	let formData = new FormData(form);
	
  
  	 fetch("http://localhost:9001/api/v1/recruit/", {
		    method: "POST",
		    headers: {
		    	'jwtToken': localStorage.getItem("jwtToken"),
		    	'username': localStorage.getItem("username"),
		    	'role':localStorage.getItem("role")
		      },
		    body: formData, 
		  }).then(response => {
		        // 응답이 JSON인지 텍스트인지에 따라 처리
		        const contentType = response.headers.get("content-type");
		        if (contentType && contentType.indexOf("application/json") !== -1) {
		            return response.json();
		        } else {
		            return response.text();
		        }})
			.then(result => {
				console.log(result)
				//공고등록 성공시 skill등록해주기><
			   addSkills(result);
			})
			.catch(error => {
			    console.log('Error:', error);
			});
	
}
//스킬들 스킬테이블에 넣어주기
function addSkills(jno){
	 fetch("http://localhost:9001/api/v1/recruit/skill/"+jno, {
				    method: "POST",
				    headers: {
				    	"Content-Type": "application/json",
				    	'jwtToken': localStorage.getItem("jwtToken"),
				    	'username': localStorage.getItem("username"),
				    	'role':localStorage.getItem("role")
				      },
				    body: JSON.stringify(arrItems), 
				  }).then(response => {
				        // 응답이 JSON인지 텍스트인지에 따라 처리
				        const contentType = response.headers.get("content-type");
				        if (contentType && contentType.indexOf("application/json") !== -1) {
				            return response.json();
				        } else {
				            return response.text();
				        }})
					.then(result => {
					    //공고와 skill모두 등록 성공시 공고리스트로이동
					    location.href="/company/recruitList"
					})
					.catch(error => {
					    console.log('Error:', error);
					});
}

//업종
    fetch('/json/sector_category.json')
        .then(response => response.json())
        .then(data => {
            let i = 0;
            // 업종 상위 카테고리 뿌려주기
            while (i < data.length) {
                const sectorCateCode = data[i].코드;
                const sectorCategory = data[i]["산업/업종명"];
                if (sectorCategory != null) {
                	let optionItems = document.createElement('option');
                	optionItems.classList = "sectorCategories"; 
                	optionItems.setAttribute("value", sectorCategory); 
                	optionItems.setAttribute("id", "sectorCategory" + sectorCateCode); 
                	optionItems.innerHTML =	sectorCategory;
                	sector1El.appendChild(optionItems);
                }
                i++;
            }
    
            //상위카테고리가 변할때마다 값 추적
            sector1El.addEventListener('change', function() {
            	sector2El.innerHTML="";
                // 선택된 option의 value 가져오기
                selectedSector1 = sector1El.value;
                // 선택된 option의 id 가져오기
                const selectedOption = sector1El.options[sector1El.selectedIndex];
                selectedSector1El = selectedOption.id;
                console.log(document.getElementById(selectedSector1El))
                document.getElementById(selectedSector1El).selected = "selected";

                // 사용자가 선택한 상위카테고리 클릭시 해당 카테고리 내 상세 직무 카테고리 뿌려주기
                if(selectedSector1){
                    fetch('/json/sector.json')
                    .then(response => response.json())
                    .then(data => {
//                     	console.log(data);
                        let j = 0;
                        while (j < data.length) {
                            const sectorCode = data[j]["코드"];
                            const sectorTitle = data[j]["산업/업종명"];
                            if (Number(selectedSector1El.slice(14)) == data[j]["상위코드"]) {
                                let optionItems = document.createElement('option');
                            	optionItems.setAttribute("value", sectorTitle); 
                            	optionItems.setAttribute("id", "sectorTitle" + sectorCode); 
                            	optionItems.innerHTML =	sectorTitle;
                            	sector2El.appendChild(optionItems)
                            }
                            j++;
                        }
                    });
                }
            })
        })
       
//직무
    fetch('/json/job_category.json')
        .then(response => response.json())
        .then(data => {
            let i = 0;
            // 직무 상위 카테고리 뿌려주기
            while (i < data.length) {
            	 const cateCode = data[i].코드;
                 const jobCategory = data[i].상위직무;
                if (jobCategory != null) {
                	let optionItems = document.createElement('option');
                	optionItems.classList = "jobCategories"; 
                	optionItems.setAttribute("value", jobCategory); 
                	optionItems.setAttribute("id", "jobCategory" + cateCode); 
                	optionItems.innerHTML =	jobCategory;
                	position1El.appendChild(optionItems)
                }
                i++;
            }
    
            //상위카테고리가 변할때마다 값 추적
            position1El.addEventListener('change', function() {
            	position2El.innerHTML="";
                // 선택된 option의 value 가져오기
                selectedPosition1 = position1El.value;
                // 선택된 option의 id 가져오기
                const selectedOption = position1El.options[position1El.selectedIndex];
                selectedPosition1El = selectedOption.id;
                // 사용자가 선택한 상위카테고리 클릭시 해당 카테고리 내 상세 직무 카테고리 뿌려주기
                if(selectedPosition1){
                    fetch('/json/job.json')
                    .then(response => response.json())
                    .then(data => {
//                     	console.log(data)
                        let j = 0;
                        while (j < data.length) {
                        	const jobCode = data[j]["직무 코드"];
                            const positionTitle = data[j]["직무 키워드명"];
                            if (Number(selectedPosition1El.slice(11)) === data[j]["직무 상위 코드"]) {
                                let optionItems = document.createElement('option');
                            	optionItems.setAttribute("value", positionTitle); 
                            	optionItems.setAttribute("id", "positionTitle" + jobCode); 
                            	optionItems.innerHTML =	positionTitle;
                            	position2El.appendChild(optionItems)
                            }
                            j++;
                        }
                    });
                }
            })
        })
	
//지역
    fetch('/json/korea-administrative-district.json')
        .then(response => response.json())
        .then(data => {
            let i = 0;
            // 지역 상위 카테고리 뿌려주기
            while (i < data.length) {
            	  const city = Object.keys(data[i]);
                if (city != null) {
                	let optionItems = document.createElement('option');
                	optionItems.classList = "cities"; 
                	optionItems.setAttribute("value", city); 
                	optionItems.setAttribute("id", "city" + i); 
                	optionItems.innerHTML =	city;
                	region1El.appendChild(optionItems)
                }
                i++;
            }
    
            //상위카테고리가 변할때마다 값 추적
            region1El.addEventListener('change', function() {
            	region2El.innerHTML="";
                // 선택된 option의 value 가져오기
                selectedRegion1 = region1El.value;
                // 선택된 option의 id 가져오기
                const selectedOption = region1El.options[region1El.selectedIndex];
                selectedRegion1El = selectedOption.id;
                // 사용자가 선택한 상위카테고리 클릭시 해당 카테고리 내 상세 지역 카테고리 뿌려주기
                if(selectedRegion1){
                	   const ccode = Number(selectedRegion1El.slice(4));
                       const gu = Object.values(data[ccode])[0];
                    	
                        let j = 0;
                        while (j < gu.length) {
                            const guName = gu[j];
                            let optionItems = document.createElement('option');
                           	optionItems.setAttribute("value", guName); 
                           	optionItems.setAttribute("id", "gu" + j); 
                           	optionItems.innerHTML =	guName;
                           	region2El.appendChild(optionItems)
                            j++;
                        }
               
                }
            })
        })
//임금조건
  fetch('/json/salary.json')
        .then(response => response.json())
        .then(data => {
            let i = 0;
            // 임금 조건뿌려주기
            while (i < data.length) {
            	const salary = data[i].학력
                if (salary != null) {
                	let optionItems = document.createElement('option');
                	optionItems.classList = "salaries"; 
                	optionItems.setAttribute("value", salary); 
                	optionItems.setAttribute("id", "salary" + i); 
                	optionItems.innerHTML =	salary;
                	salaryEl.appendChild(optionItems)
                }
                i++;
            }
            salaryEl.addEventListener('change', function() {
                // 선택된 option의 value 가져오기
                selectedSalary = salaryEl.value;
            })
        })
//고용형태
  fetch('/json/workType.json')
        .then(response => response.json())
        .then(data => {
//         	console.log(data)
            let i = 0;
            // 고용형태 조건뿌려주기
            while (i < data.length) {
            	const workType = data[i].근무형태
                if (workType != null) {
                	let optionItems = document.createElement('option');
                	optionItems.classList = "workTypes"; 
                	optionItems.setAttribute("value", workType); 
                	optionItems.setAttribute("id", "workType" + i); 
                	optionItems.innerHTML =	workType;
                	workTypeEl.appendChild(optionItems)
                }
                i++;
            }
            workTypeEl.addEventListener('change', function() {
                // 선택된 option의 value 가져오기
                selectedWorkType = workTypeEl.value;
                console.log(selectedWorkType)
            })
        })



</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>