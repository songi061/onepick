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
				<select id="sector">
				  <option value="volvo">Volvo</option>
				  <option value="saab">Saab</option>
				  <option value="opel">Opel</option>
				  <option value="audi">Audi</option>
				</select>
			</form>
		</div>
		
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

const jno = "${jno}";

console.log(jno);
const xhttp = new XMLHttpRequest();
xhttp.onload = function() {
	console.log(JSON.parse(this.responseText));
	let data = JSON.parse(this.responseText);
	document.querySelector(".recruit_detail").innerHTML = 
		"<div> 채용공고 제목 : " + data.wantedTitle +"</div><div> 모집업종 : "+ data.sector1 + "  ,  " + data.sector2 +"</div><div> 모집 직무 : "+ data.position1 + "   ,  "+ data.position2 +"</div><div> 직무내용 : " 
		+ data.jobCont + "</div><div> 접수마감일 : "  + data.receiptCloseDt + "</div><div> 고용형태 : "  + data.empTpNm + "</div><div> 모집인원 : " 
		+ data.collectPsncnt + "</div><div> 임금 조건 : "  + data.salTpNm + "</div><div> 병역특례채용희망 : "  + data.mltsvcExcHope +  "</div><div> 근무지역 : "  + data.region1 + "   ,  " + data.region2+
		 "</div><div> 근무시간 : "  + data.WkdWkhCnt + "</div><div> 퇴직금 : "  + data.retirepay + "</div><div> 기타복리후생 : "  + data.etcWelfare+ "</div><div> 담당자이름 : "  + data.empName + "</div><div> 담당자이메일 : "  + data.empEmail
		 + "</div><div> 담당자연락처 : "  + data.empTel + "</div>";
  }
xhttp.open("GET", "http://localhost:9001/api/v1/recruit/"+jno, true);
xhttp.send();

</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>