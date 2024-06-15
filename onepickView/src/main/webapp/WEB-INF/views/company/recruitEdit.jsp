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
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="title">채용공고수정폼</div>
		<div class="recruit_detail"></div>
		<div class="recruit_form">
			<form>
				<div class="section_title">채용공고 제목</div>
				<input type="text" name="wantedTitle" placeholder="채용공고 제목을 입력하세요">
				<div class="section_title">모집 업종</div>
				<select name="sector1"><option value="">업종 상위 카테고리 선택</option></select>	<select name="sector2"><option value="">업종 하위 카테고리 선택</option></select>
				<div class="section_title">모집 직무</div>
				<select name="position1"><option value="">직무 상위 카테고리 선택</option></select> <select name="position2"><option value="">직무 하위 카테고리 선택</option></select>
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
				<select name="region1"><option value="">지역 상위 카테고리 선택</option></select>	<select name="region2"><option value="">직무 하위 카테고리 선택</option></select>
				<div class="section_title">근무시간</div>
				<input type="text" name="WkdWkhCnt">
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
const skillContainer = document.querySelector(".skillContainer")
const wantedTitle = document.querySelector("input[name=wantedTitle]");
const sector1 = document.querySelector("select[name=sector1]");
const sector2 = document.querySelector("select[name=sector2]");
const position1 = document.querySelector("select[name=position1]");
const position2 = document.querySelector("select[name=position2]");
const region1 = document.querySelector("select[name=region1]");
const region2 = document.querySelector("select[name=region2]");
const jobCont = document.querySelector("textarea[name=jobCont]");
const receiptCloseDt = document.querySelector("input[name=receiptCloseDt]");
const empTpNm = document.querySelector("select[name=empTpNm]");
const collectPsncnt = document.querySelector("input[name=collectPsncnt]");
const salTpNm = document.querySelector("select[name=salTpNm]");
const mltsvcExcHope = document.querySelector("radio[name=mltsvcExcHope]");
const WkdWkhCnt = document.querySelector("input[name=WkdWkhCnt]");
const retirepay = document.querySelector("input[name=retirepay]");
const etcWelfare = document.querySelector("input[name=etcWelfare]");
const empName = document.querySelector("input[name=empName]");
const empEmail = document.querySelector("input[name=empEmail]");
const empTel = document.querySelector("input[name=empTel]");
const experience = document.querySelector("select[name=experience]");
const skillNameEl = document.querySelector("select[name=skillName]");
const showOptionbtn = document.querySelector(".showOptionbtn");
const addSkillBtn = document.querySelector(".add-skill-btn");

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

const jno = "${jno}";


document.addEventListener('DOMContentLoaded', function() {
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
	      
	      getRecruitInfo();
});


//수정폼에 기존 값 넣어주기
function getRecruitInfo(){
	const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let data = JSON.parse(this.responseText);
		let jobad = data.jobad;
		let skills = data.skill;

		//스킬 값 넣어주기
		skills.forEach(skill=>{
		
			let skillItems = document.createElement("span");
			skillItems.classList = "skill_items"
			skillItems.setAttribute("id", skill.skillName);
			skillItems.style.margin="5px";
			skillItems.innerHTML=skill.skillName + "<span onclick='deleteSkill(event)'>❌</span>";
			skillContainer.appendChild(skillItems);
			//스킬 수정안하더라도 값이 선택되어 들어갈 수 있도록 넣어주기
			arrItems.push(skill.skillName);
	
		})

		
	/*
		/////////세부카테고리 목록 선택안되어짐
		
	*/
		
		
		wantedTitle.value=jobad.wantedTitle;
		jobCont.value = jobad.jobCont;
		receiptCloseDt.value = jobad.receiptCloseDt;
		collectPsncnt.value = jobad.collectPsncnt;
		WkdWkhCnt.value = jobad.WkdWkhCnt;
		retirepay.value = jobad.retirepay;
		etcWelfare.value = jobad.etcWelfare;
		empName.value = jobad.empName;
		empEmail.value = jobad.empEmail;
		empTel.value = jobad.empTel;

		
		//select에  option값을 미리 선택하기(변수값에 따라서)
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
		// 가져온 데이터에 맞는 옵션 미리 선택해주기
		selectOption(sector1, jobad.sector1);
		selectOption(sector2, jobad.sector2);
		selectOption(position1, jobad.position1);
		
		
		
		
		
		
		
		
		selectOption(position2, jobad.position2);
		selectOption(region1, jobad.region1);
		selectOption(region2, jobad.region2);
		selectOption(empTpNm, jobad.empTpNm);
		selectOption(salTpNm, jobad.salTpNm);
		selectOption(experience, jobad.experience);
		
		
		function checkRadioButton(name, value) {
		    // mltsvcExcHope이름가진 라디오 다 부르기
		    const radios = document.getElementsByName(name);
		   
		    for (let i = 0; i < radios.length; i++) {
		        // 라디오 value가 주어진 변수와 같은 요소 찾아서 checked 속성 true로 설정해주기
		        if (radios[i].value === value) {
		            radios[i].checked = true;
		            break; 
		        }
		    }
		}

		// 가져온 데이터에 맞는 옵션 미리 선택해주기
		checkRadioButton('mltsvcExcHope', jobad.mltsvcExcHope);
		
		document.querySelector(".recruit_detail").innerHTML = 
			"<div> 채용공고 제목 : " + jobad.wantedTitle +"</div><div> 모집업종 : "+ jobad.sector1 + "  ,  " + jobad.sector2 +"</div><div> 모집 직무 : "+ jobad.position1 + "   ,  "+ jobad.position2 +"</div><div> 직무내용 : " 
			+ jobad.jobCont + "</div><div> 접수마감일 : "  + jobad.receiptCloseDt + "</div><div> 고용형태 : "  + jobad.empTpNm + "</div><div> 모집인원 : " 
			+ jobad.collectPsncnt + "</div><div> 임금 조건 : "  + jobad.salTpNm + "</div><div> 병역특례채용희망 : "  + jobad.mltsvcExcHope +  "</div><div> 근무지역 : "  + jobad.region1 + "   ,  " + jobad.region2+
			 "</div><div> 근무시간 : "  + jobad.WkdWkhCnt + "</div><div> 퇴직금 : "  + jobad.retirepay + "</div><div> 기타복리후생 : "  + jobad.etcWelfare+ "</div><div> 담당자이름 : "  + jobad.empName + "</div><div> 담당자이메일 : "  + jobad.empEmail
			 + "</div><div> 담당자연락처 : "  + jobad.empTel + "</div>";
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/recruit/"+jno, true);
	xhttp.send();
}















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
	e.target.parentElement.remove()
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

function editJobAd(event){
	event.preventDefault();

	let form = document.querySelector("form");
	let formData = new FormData(form);
	

	 fetch("http://localhost:9001/api/v1/recruit/"+jno, {
		    method: "PUT",
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
				    method: "PUT",
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




</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>













