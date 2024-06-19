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
<!-- <link href="/js/recruitEdit.js"> -->
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
		<div class="page_title">채용공고수정폼</div>
		<div class="recruit_detail"></div>
		<div class="recruit_form">
			<form>
				<div class="section_title">채용공고 제목</div>
				<input type="text" name="wantedTitle" placeholder="채용공고 제목을 입력하세요">
				<div class="section_title">모집 업종</div>
				<select style="display:none;" name="sector1"><option value="">업종 상위 카테고리 선택</option></select>	<select style="display:none;" name="sector2"><option value="">업종 하위 카테고리 선택</option></select>
				<span class="sector1"></span>  <span class="sector2"></span>  <button class="btn btn-onepick btnEdit" id="sectorBtn">수정하기</button>
				<div class="section_title">모집 직무</div>
				<select style="display:none;" name="position1"><option value="">직무 상위 카테고리 선택</option></select> <select style="display:none;" name="position2"><option value="">직무 하위 카테고리 선택</option></select>
				<span class="position1"></span>  <span class="position2"></span> <button class="btn btn-onepick btnEdit" id="positionBtn">수정하기</button>
				<div class="section_title">상세 직무내용</div>
				<textarea name="jobCont"></textarea>
				<div class="section_title">필요스킬</div>
				<select name="skillName" style="display:none;">
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
				</select>
				<div onclick="showSkillOption()" class="showOptionbtn"> ➕ 필요스킬추가하기 </div>
				<div style="display:none;" onclick="addSkill()" class="add-skill-btn"> ➕ 필요스킬추가하기 </div>
				<div class='skillContainer'></div>
				<div class="btn btn-onepick" style="display:none;" id="saveBtn" onclick="saveSkills(event)">저장</div>
				<div class="section_title">접수마감일</div>
				<input type="date" name="receiptCloseDt">
				<div class="section_title">경험</div>
				<select name="experience">
					<option value="">경력 선택</option>
					<option value="경력무관">경력무관</option>
					<option value="신입">신입</option>
					<option value="1~5년">1~5년</option>
					<option value="6~10년">6~10년</option>
					<option value="11년 이상">11년 이상</option>
				</select>
				<div class="section_title">고용형태</div>
				<select name="empTpNm"><option value="">고용형태 선택</option></select>
				<div class="section_title">모집인원</div>
				<input type="text" name="collectPsncnt" value="1"> 명
				<div class="section_title">임금조건</div>
				<select name="salTpNm"><option value="">임금조건 선택</option></select>
				<div class="section_title">근무지역</div>
				<select style="display:none;" name="region1"><option value="">지역 상위 카테고리 선택</option></select>	<select style="display:none;" name="region2"><option value="">직무 하위 카테고리 선택</option></select>
				<span class="region1"></span>  <span class="region2"></span>  <button class="btn btn-onepick btnEdit" id="regionBtn">수정하기</button>
				<div class="section_title">근무시간</div>
				<input type="text" name="wkdWkhCnt">
				<div class="section_title">퇴직금</div>
				<input type="text" name="retirepay">
				<div class="section_title">기타복리후생</div>
				<input type="text" name="etcWelfare">
				<div class="section_title">회사소개첨부파일</div>
				<input type="file" name="attachFileUrl">
				<div class="section_title">병역특례채용희망</div>
				<input type="radio" name="mltsvcExcHope" value="y"> 특례채용희망
				<input type="radio" name="mltsvcExcHope" value="n"> 해당없음
				<div class="section_title">담당자이름</div>
				<input type="text" name="empName">
				<div class="section_title">담당자이메일</div>
				<input type="text" name="empEmail">
				<div class="section_title">담당자연락처</div>
				<input type="text" name="empTel">
				<input class="btn btn-onepick" type="submit" value="공고수정" onclick="editJobAd(event)">
				
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
const skillContainer = document.querySelector(".skillContainer");
const wantedTitle = document.querySelector("input[name=wantedTitle]");
const jobCont = document.querySelector("textarea[name=jobCont]");
const receiptCloseDt = document.querySelector("input[name=receiptCloseDt]");
const collectPsncnt = document.querySelector("input[name=collectPsncnt]");
const wkdWkhCnt = document.querySelector("input[name=wkdWkhCnt]");
const retirepay = document.querySelector("input[name=retirepay]");
const etcWelfare = document.querySelector("input[name=etcWelfare]");
const empName = document.querySelector("input[name=empName]");
const empEmail = document.querySelector("input[name=empEmail]");
const empTel = document.querySelector("input[name=empTel]");
const experience = document.querySelector("select[name=experience]");
const skillNameEl = document.querySelector("select[name=skillName]");
const showOptionbtn = document.querySelector(".showOptionbtn");
const addSkillBtn = document.querySelector(".add-skill-btn");
const empTpNm = document.querySelector("select[name=empTpNm]");
const salTpNm = document.querySelector("select[name=salTpNm]");
const mltsvcExcHope = document.querySelector("radio[name=mltsvcExcHope]");

let selectedSector1 = null;
let selectedSector2 = null;
let selectedPosition1 = null;
let selectedPosition2 = null;
let selectedRegion1 = null;
let selectedRegion2 = null;
let selectedSalary = null;
let selectedWorkType = null;
let skillExisted = false;
let arrItems = [];

const jno = "${jno}";

// 기존 데이터를 폼에 채워주는 함수
function getRecruitInfo() {
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function () {
    let data = JSON.parse(this.responseText);
    let jobad = data.jobad;
    let skills = data.skill;

    console.log(jobad)
    
    
    // 스킬 값 넣어주기
    skills.forEach(skill => {
      let skillItems = document.createElement("span");
      skillItems.classList = "skill_items";
      skillItems.setAttribute("id", skill.skillName);
      skillItems.style.margin = "5px";
      skillItems.innerHTML = skill.skillName + "<span onclick='deleteSkill(event)'>❌</span>";
      skillContainer.appendChild(skillItems);
      // 스킬 수정 안 하더라도 값이 선택되어 들어갈 수 있도록 넣어주기
      arrItems.push(skill.skillName);
    });

    // 기존 데이터 폼에 채워주기
    wantedTitle.value = jobad.wantedTitle;
    jobCont.value = jobad.jobCont;
    receiptCloseDt.value = jobad.receiptCloseDt;
    collectPsncnt.value = jobad.collectPsncnt;
    wkdWkhCnt.value = jobad.wkdWkhCnt;
    retirepay.value = jobad.retirepay;
    etcWelfare.value = jobad.etcWelfare;
    empName.value = jobad.empName;
    empEmail.value = jobad.empEmail;
    empTel.value = jobad.empTel;

    // 지역 1,2 텍스트로 넣어주기
    selectedRegion1 = jobad.region1;
    selectedRegion2 = jobad.region2;
    document.querySelector(".region1").innerHTML = jobad.region1 + " ▪ ";
    document.querySelector(".region2").innerHTML = jobad.region2;

    // 업종 1,2 텍스트로 넣어주기
    selectedSector1 = jobad.sector1;
    selectedSector2 = jobad.sector2;
    document.querySelector(".sector1").innerHTML = jobad.sector1 + " ▪ ";
    document.querySelector(".sector2").innerHTML = jobad.sector2;

    // 직무 1,2 텍스트로 넣어주기
    selectedPosition1 = jobad.position1;
    selectedPosition2 = jobad.position2;
    document.querySelector(".position1").innerHTML = jobad.position1 + " ▪ ";
    document.querySelector(".position2").innerHTML = jobad.position2;

    // select에  option값을 미리 선택하기(변수값에 따라서)
    selectOption(empTpNm, jobad.empTpNm);
    selectOption(salTpNm, jobad.salTpNm);
    selectOption(experience, jobad.experience);

    function selectOption(selectElement, value) {
      const checkOptionsLoaded = setInterval(() => {
        if (selectElement.options.length > 0) {
          clearInterval(checkOptionsLoaded);
          for (let i = 0; i < selectElement.options.length; i++) {
            if (selectElement.options[i].value == value) {
              selectElement.options[i].selected = true;
              break;
            }
          }
        }
      }, 100);
    }

    function checkRadioButton(name, value) {
      const radios = document.getElementsByName(name);
      for (let i = 0; i < radios.length; i++) {
        if (radios[i].value === value) {
          radios[i].checked = true;
          break;
        }
      }
    }

    // 가져온 데이터에 맞는 옵션 미리 선택해주기
    checkRadioButton('mltsvcExcHope', jobad.mltsvcExcHope);
  };

  xhttp.open("GET", "http://localhost:9001/api/v1/recruit/" + jno, true);
  xhttp.send();
}

// 수정을 위해 select 열고, 선택된 값을 저장
function setupEditButtons() {
  let sectorOpen = false;
  let positionOpen = false;
  let regionOpen = false;

  document.querySelector("#sectorBtn").addEventListener("click", function (e) {
    e.preventDefault();
    if (sectorOpen == false) {
      sector1El.style.display = "block";
      document.querySelector(".sector1").style.display = "none";
      sector2El.style.display = "block";
      document.querySelector(".sector2").style.display = "none";
      sectorOpen = true;
    } else if (sectorOpen == true) {
      // 선택한 값 저장해주기
      if (sector1El.value === "") sector1El.value = selectedSector1;
      if (sector2El.value === "") sector2El.value = selectedSector2;
      sectorOpen = false;
    }
  });

  document.querySelector("#positionBtn").addEventListener("click", function (e) {
    e.preventDefault();
    if (positionOpen == false) {
      position1El.style.display = "block";
      document.querySelector(".position1").style.display = "none";
      position2El.style.display = "block";
      document.querySelector(".position2").style.display = "none";
      positionOpen = true;
    } else if (positionOpen == true) {
      if (position1El.value === "") position1El.value = selectedPosition1;
      if (position2El.value === "") position2El.value = selectedPosition2;
      positionOpen = false;
    }
  });

  document.querySelector("#regionBtn").addEventListener("click", function (e) {
    e.preventDefault();
    if (regionOpen == false) {
      region1El.style.display = "block";
      document.querySelector(".region1").style.display = "none";
      region2El.style.display = "block";
      document.querySelector(".region2").style.display = "none";
      regionOpen = true;
    } else if (regionOpen == true) {
      if (region1El.value === "") region1El.value = selectedRegion1;
      if (region2El.value === "") region2El.value = selectedRegion2;
      regionOpen = false;
    }
  });
}

// 스킬 추가, 삭제, 저장 기능
function showSkillOption() {
  showOptionbtn.style.display = "none";
  addSkillBtn.style.display = "block";
  skillNameEl.style.display = "block";
}

function addSkill() {
  if (skillNameEl.value != "") {
    if (!skillContainer.querySelector("#" + skillNameEl.value)) {
      let skillItems = document.createElement("span");
      skillItems.classList = "skill_items";
      skillItems.setAttribute("id", skillNameEl.value);
      skillItems.style.margin = "5px";
      skillItems.innerHTML = skillNameEl.value + "<span onclick='deleteSkill(event)'>❌</span>";
      skillContainer.appendChild(skillItems);
      document.querySelector("#saveBtn").style.display = "block";
    }
  }
}

function deleteSkill(e) {
  e.target.parentElement.remove();
  document.querySelector("#saveBtn").style.display = "block";
}

function saveSkills(e) {
  arrItems = [];
  e.target.style.display = "none";
  const childNodes = document.querySelectorAll(".skill_items");

  showOptionbtn.style.display = "block";
  addSkillBtn.style.display = "none";
  skillNameEl.style.display = "none";

  childNodes.forEach(skill => {
    arrItems.push(skill.getAttribute("id"));
  });
}

// 폼 제출 시 서버로 데이터 보내기
function editJobAd(event) {
  event.preventDefault();

  // 선택된 값이 없으면 기본값을 넣기
  if (!selectedSector1) selectedSector1 = sector1El.value;
  if (!selectedSector2) selectedSector2 = sector2El.value;
  if (!selectedPosition1) selectedPosition1 = position1El.value;
  if (!selectedPosition2) selectedPosition2 = position2El.value;
  if (!selectedRegion1) selectedRegion1 = region1El.value;
  if (!selectedRegion2) selectedRegion2 = region2El.value;

  // 기본값이 여전히 비어있으면 formData에 기존 텍스트를 추가
  const form = document.querySelector("form");
  const formData = new FormData(form);
  
  formData.set("sector1", selectedSector1 || document.querySelector(".sector1").innerText.trim());
  formData.set("sector2", selectedSector2 || document.querySelector(".sector2").innerText.trim());
  formData.set("position1", selectedPosition1 || document.querySelector(".position1").innerText.trim());
  formData.set("position2", selectedPosition2 || document.querySelector(".position2").innerText.trim());
  formData.set("region1", selectedRegion1 || document.querySelector(".region1").innerText.trim());
  formData.set("region2", selectedRegion2 || document.querySelector(".region2").innerText.trim());

  fetch("http://localhost:9001/api/v1/recruit/" + jno, {
    method: "PUT",
    headers: {
        'jwtToken': localStorage.getItem("jwtToken"),
        'username': localStorage.getItem("username"),
        'role': localStorage.getItem("role")
    },
    body: formData,
  }).then(response => response.text()).then(result => {
    addSkills(result);
  }).catch(error => {
    console.log('Error:', error);
  });
}

// 스킬들을 테이블에 넣어주는 함수
function addSkills(jno) {

  fetch("http://localhost:9001/api/v1/recruit/skill/" + jno, {
    method: "PUT",
    mode: "cors", // Ensure CORS is enabled
    headers: {
    	"Content-Type": "application/json",
        'jwtToken': localStorage.getItem("jwtToken"),
        'username': localStorage.getItem("username"),
        'role': localStorage.getItem("role"),
        'Access-Control-Allow-Headers': 'Content-Type, jwtToken, username, role'
    },
    body: JSON.stringify(arrItems),
  }).then(response => {
    console.log(response)
  }).then(result => {
//     location.href = "/company/recruitList";
  }).catch(error => {
    console.log('Error:', error);
  });
}

// 초기화
document.addEventListener('DOMContentLoaded', function () {
  getRecruitInfo();
  setupEditButtons();
  
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
//	                   	console.log(data);
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
	                  sector2El.addEventListener('change', function() {
	                	  selectedSector2 = sector2El.value;
	                	  console.log(selectedSector1)
	                	  console.log(selectedSector2)
	                  })
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
//	                   	console.log(data)
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
	                  position2El.addEventListener('change', function() {
	                	  console.log("포지션2클릭")
	                	    selectedPosition2 = position2El.value;
	                	  
	                	  console.log(selectedPosition1)
	                	  console.log(selectedPosition2)
	                  })
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
	                      region2El.addEventListener('change', function() {
		                	    selectedRegion2 = region2El.value;
		                  })
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
//	       	console.log(data)
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
  
});


</script>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>













