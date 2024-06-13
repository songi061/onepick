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
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		
		<div class="recruit_form">
		채용공고등록폼
			<form>
				<input type="text" name="wantedTitle" placeholder="채용공고 제목을 입력하세요">
				<div class="section_title">모집 업종</div>
				<select name="sector1"></select>	<select name="sector2"></select>
				<div class="section_title">모집 직무</div>
				<select name="position1"></select> <select name="position2"></select>
				<div class="section_title">상세 직무내용</div>
				<textarea name="jobCont"></textarea>
				<div class="section_title">필요스킬</div>
				<input type="text" name="skillName">
				<div class="section_title">접수마감일</div>
				<input type="date" name="receiptCloseDt">
				<div class="section_title">경험</div>
				<select name="experience">
					<option value="경력무관">경력무관</option>
					<option value="신입">신입</option>
					<option value="1~5년">1~5년</option>
					<option value="6~10년">6~10년</option>
					<option value="11년 이상">11년 이상</option>
				</select>
				<div class="section_title">고용형태</div>
				<select name="empTpNm"></select>
				<div class="section_title">모집인원</div>
				<input type="text" name="collectPsncnt" value="1"> 명
				<div class="section_title">임금조건</div>
				<select name="salTpNm"></select>
				<div class="section_title">근무지역</div>
				<select name="region1"></select>	<select name="region2"></select>
				<div class="section_title">근무시간</div>
				<input type="text" name="WkdWkhCnt">
				<div class="section_title">퇴직금</div>
				<input type="text" name="retirepay">
				<div class="section_title">기타복리후생</div>
				<input type="text" name="etcWelfare">
				<div class="section_title">회사소개첨부파일</div>
				<input type="file" name="attachFileUrl">
				<div class="section_title">담당자이름</div>
				<input type="text" name="empName">
				<div class="section_title">담당자이메일</div>
				<input type="text" name="empEmail">
				<div class="section_title">담당자연락처</div>
				<input type="text" name="empTel">
				<input class="btn btn-onepick" type="submit" value="공고등록" onclick="regJobAd(event)">
				
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

let selectedSector1 = null;
let selectedSector1El = null;
let selectedPosition1 = null;
let selectedPosition1El = null;
let selectedRegion1 = null;
let selectedRegion1El = null;
let selectedSalary = null;
let selectedWorkType = null;

//제출버튼 클릭시 서버로 데이터 보내주기

function regJobAd(event){
	event.preventDefault();

	let form = document.querySelector("form");
	let formData = new FormData(form);

	 fetch("http://localhost:9001/api/v1/recruit/", {
		    method: "POST",
		    headers: {
		        "username": "aaa",
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
			    console.log(result);
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>