<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet">
<style>
.textbox{
	width: 30%;
	height : 40px;
  	padding: 12px 20px;
  	margin: 10px;
  	box-sizing: border-box;
  	border: 2px solid #F5ECCE;
  	font-size : 14px;
}

.selectbox{
width: 150px;
  height: 35px;
  border-radius: 4px;
  border: 2px solid #F5ECCE;
  text-align : center;
  font-size : 14px;
}

.datebox{
border: 1px solid lightgrey; 
  position: relative; 
  height : 30px;
  box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.2);
  border-radius: 4px;
  text-align: center;
  font-size : 14px;
  margin: 20px;
}

#longtext{
	width: 60%;
	height : 200px;
  	padding: 12px 20px;
  	margin: 10px;
  	box-sizing: border-box;
  	border: 2px solid #F5ECCE;
  	font-size : 14px;
}
</style>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
<form>
	<input type="checkbox" id="disclo_check" name="disclo" value="public">
  	<label for="disclo_check">공개여부</label><br>
	이력서 제목<input type="text" name="title" placeholder="이력서 제목을 입력해주세요" class="textbox"><br>
	자기소개서 제목<input type="text" name="selfInfoTitle" placeholder="자기소개서 제목을 입력해주세요" class="textbox"><br>
	자기소개서 내용<br>
	<textarea name="selfInfoContent" placeholder="자기소개서 내용을 입력해주세요" id="longtext"></textarea><br>
	
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
	<select name="region2_2" id="select4" class="selectbox">
		<option value="">구 선택</option>
	</select>
	</div>
	
	<br>
	
	<div>
	<label for="select_sector">관심업종</label>
	<select name="sectors" id="select_sector" class="selectbox">
		<option value="">관심업종 선택</option>
	</select>
	
	<label for="select_job">관심직무</label>
	<select name="job" id="select_job" class="selectbox">
		<option value="">관심직무 선택</option>
	</select>
	</div>
	
	<br>
	포트폴리오 URL<input type="text" name="portfolioUrl" placeholder="내용을 입력하세요" class="textbox"><br>
	
	<div>
		<span>사회활동</span><br>
		시작일<input type="date" name="startDay" class="datebox">
		종료일<input type="date" name="endDay" class="datebox"><br>
		참여기관<input type="text" name="org" placeholder="내용을 입력하세요" class="textbox"><br>
		활동내역<input type="text" name="content" placeholder="내용을 입력해주세요" class="textbox"><br>
	</div>
	
	<div>
		<span>자격증</span><br>
		자격증명<input type="text" name="name" placeholder="내용을 입력하세요" class="textbox"><br>
		발급기관<input type="text" name="org" placeholder="내용을 입력하세요" class="textbox"><br>
		취득일<input type="date" name="getDate" class="datebox"><br>
	</div>
	
	<div>
		<span>학력사항</span><br>
		입학일자<input type="date" name="accDate" class="datebox">
		졸업일자<input type="date" name="gradDate" class="datebox"><br>
		학교명<input type="text" name="eduName" placeholder="내용을 입력하세요" class="textbox">
		전공학과<input type="text" name="major" placeholder="내용을 입력하세요" class="textbox"><br>
		학점<input type="text" name="score" placeholder="내용을 입력하세요" class="textbox">
		<label for="select_degree">상태</label>
		<select name="status" id="select_degree" class="selectbox">
			<option value="graduate">졸업</option>
			<option value="dropout">중퇴</option>
			<option value="deferral">휴학</option>
		</select><br>
	</div>
	
	<div>
		<span>경력사항</span><br>
		입사일자<input type="date" name="startDate" class="datebox">
		퇴사일자<input type="date" name="endDate" class="datebox"><br>
		회사명<input type="text" name="name" placeholder="내용을 입력하세요" class="textbox">
		직급<input type="text" name="rank" placeholder="내용을 입력하세요" class="textbox"><br>
		<label for="select_career">상태</label>
		<select name="status" id="select_career" class="selectbox">
			<option value="unemployed">무직</option>
			<option value="working">재직중</option>
			<option value="etc">기타</option>
		</select>
		
		<label for="select_career2">업종</label>
		<select name="type" id="select_career2" class="selectbox">
			<option value="">업종 선택</option>
		</select><br>
		
		<label for="select_career3">직무</label>
		<select name="position" id="select_career3" class="selectbox">
			<option value="">직무 선택</option>
		</select>
		
		업무<input type="text" name="work" placeholder="내용을 입력하세요" class="textbox"><br>
	</div>
	
	<div>
		<span>보유능력</span><br>
		<label for="select_skill">타입</label>
		<select name="skillName" id="select_skill" class="selectbox">
			<option value="">스킬 선택</option>
		</select>
		내용<input type="text" name="content" placeholder="내용을 입력하세요" class="textbox">
	</div>
	
	<input type="button" value="등록하기" onclick="" class="btn btn-onepick">
</form>
</div>


<script>

//희망근무지역
const xhttp1 = new XMLHttpRequest();
xhttp1.onload = function() {
	const select1 = document.getElementById("select1");
    const select2 = document.getElementById("select2");
    const select3 = document.getElementById("select3");
    const select4 = document.getElementById("select4");
    
    let data = JSON.parse(this.responseText);

    // Populate select1 and select3 with keys from the data
    data.forEach((item, idx) => {
        const key = Object.keys(item)[0];
        /* console.log(idx + "번째 데이터 : " + key); */

        // Create separate option objects for select1 and select3
        const option1 = document.createElement("option");
        option1.value = key;
        option1.text = key;
        select1.appendChild(option1);

        const option2 = document.createElement("option");
        option2.value = key;
        option2.text = key;
        select3.appendChild(option2);
    });

    // Function to update select2 based on select1's selected value
    function updateSelect1() {
        const selectedKey = select1.value;

        // Clear previous options
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

    // Function to update select4 based on select3's selected value
    function updateSelect2() {
        const selectedKey = select3.value;

        // Clear previous options
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
    
    select1.addEventListener('change', updateSelect1);
    select3.addEventListener('change', updateSelect2);
  }
xhttp1.open("GET", "/json/korea-administrative-district.json", true);
xhttp1.send();





//관심업종
const xhttp2 = new XMLHttpRequest();
xhttp2.onload = function() {
	const select = document.getElementById("select_sector");

    let data = JSON.parse(this.responseText);

    data.forEach((item, idx) => {
        const sectorName = item["산업/업종명"];
        /* console.log(idx + "번째 데이터 : " + sectorName); */

        // Create option object for select
        const option = document.createElement("option");
        option.value = sectorName;
        option.text = sectorName;
        select.appendChild(option);
    });
    
  }
xhttp2.open("GET", "/json/sector.json", true);
xhttp2.send();



















</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>