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
<link href="/css/recruitDetail.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		
		<div class="recruit_detail">
		</div>
			<button class="btn btn-onepick scrap-btn">  공고 스크랩하기</button>
			<button class="btn btn-onepick pply-btn">지원하기</button>
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

const jno = "${jno}";

console.log(jno);
const xhttp = new XMLHttpRequest();
xhttp.onload = function() {
	console.log(JSON.parse(this.responseText));
	let data = JSON.parse(this.responseText);
	let jobad = data.jobad;
	let skills = data.skill;
	let displayMlService = jobad.mltsvcExcHope == 'y' ? '🅾️' : '✖️ '
	document.querySelector(".recruit_detail").innerHTML = 
		"<div class='title'>" + data.wantedTitle +"</div><div class='section'><div class='section-title'>요약</div><div> 📅 마감 " + jobad.receiptCloseDt 
		+ "</div><div> 📈 모집인원 "+jobad.collectPsncnt+"</div><div> 💼 직무 " + jobad.position1 + "   ,  "+ jobad.position2 +"</div><div> 📶 경력 " + jobad.experience + "</div><div> ✔️ 고용형태 " +
		jobad.empTpNm + "</div><div> 📍 근무지역 " + jobad.region1 + "   ,  " + jobad.region2+ "</div><div class='skillContainer'> 🪪 스킬 : </div></div><div class='section'><div class='section-title'>주요 업무</div><div>" +
		jobad.jobCont + "</div></div><div class='section'><div class='section-title'>복지 및 혜택</div><div>" +jobad.etcWelfare +"</div></div><div class='section'><div class='section-title'>추가 정보</div><div> 근무시간 " + jobad.wkdWkhCnt + "</div><div> 퇴직금 " + jobad.retirepay +
		"</div><div> 임금 조건 " + jobad.salTpNm + "</div><div> 병역특례채용희망 " + displayMlService + "</div></div><div class='section'><div class='section-title'>담당자정보</div><div> 담당자 이름  : "+
		jobad.empName + "</div><div> 담당자이메일 : "  + jobad.empEmail + "</div><div> 담당자연락처 : "  + jobad.empTel + "</div></div>";
		const skillContainer = document.querySelector(".skillContainer");
		 skills.forEach(skill=>{
				let skillItems = document.createElement("span");
				skillItems.classList = "skill_items"
				skillItems.style.margin="5px";
				skillItems.innerHTML= "📌 " + skill.skillName + ", ";
				skillContainer.appendChild(skillItems);
			  console.log(skill.skillName)
			  
		  })
  
  }
 
xhttp.open("GET", "http://localhost:9001/api/v1/recruit/"+jno, true);
xhttp.send();

</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>