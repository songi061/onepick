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
	  <div class='company-header'>
            <div class='com_file'>
                <img alt="기업 대표이미지">
            </div>
            <div class='company-info'>
                <h1 class='com_name'></h1>
                <div class='company-rating'>
                    ⭐ <span id="companyScore"></span>
                </div>
                <div class='company-details'>
                    <span class='com_sector'></span> · <span class='com_size'></span> <br>
                    <span class='com_addr'></span> <br>
                    <a href="" class='com_url' target="_blank"></a>
                </div>
            </div>
            <div class="ms-auto" id="likeBtn" >
            <img style="display:float; width:30px; height: 30px;"src="/icon/heart.png" alt="구독하기버튼" onclick="likeTheCom(event)">
        	</div>
        </div>
         <div class='section'>
            <div class='section-title'>기업 상세정보</div>
            <div><span class='title_s'>대표명 </span><span class='com_ceo'></span></div>
            <div><span class='title_s'>연매출 </span><span class='com_yrSales'></span> <span class='title_s'>원 </span></div>
            <div><span class='title_s'>사원 수 </span><span class='com_employeesNum'></span> <span class='title_s'>명</span></div>
        </div>
       	<div>
       	공고정보추가하기
       	</div>
		
		
		

		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

let cid = "${username}";
let liked = null;

//기업정보불러오기
    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let data = JSON.parse(this.responseText);
		const employeesNum = Number(data.employeesNum).toLocaleString('en-US');
		const yrSales = Number(data.yrSales).toLocaleString('en-US');
		let displayYrSales = data.yrSales ? yrSales : '정보 없음';
		//기업 정보 띄워주기
		document.querySelector(".com_name").innerHTML = data.name;
	    document.querySelector(".com_ceo").innerHTML = data.ceo;
	    document.querySelector(".com_sector").innerHTML = data.sector;
	    document.querySelector(".com_size").innerHTML = data.size;
	    document.querySelector(".com_yrSales").innerHTML = displayYrSales;
	    document.querySelector(".com_addr").innerHTML = data.addr;
	    document.querySelector(".com_employeesNum").innerHTML = employeesNum;
	    document.querySelector(".com_url").innerHTML = '기업 홈페이지';
	    document.querySelector(".com_url").href = "https://" + data.url;
	    //기업 기본 사진
	    if(data.fileName != null){
	    	document.querySelector(".com_file img").src = "/images/" + data.fileName;
	    }else{
	    	document.querySelector(".com_file img").src = "/img/no_img.jpg";
	    }
	    
	    //평균평점불러오기
		  const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  if(this.responseText != null || this.responseText !=""){
			  	document.querySelector("#companyScore").innerHTML = Number(this.responseText).toFixed(1);
			  }else{
			  	document.querySelector("#companyScore").innerHTML="0.0"
			  }
		    }
		  xhttp.open("GET", "http://localhost:9001/api/v1/company/avg-rating", true);
		  xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
		  xhttp.setRequestHeader("username", localStorage.getItem("username"));
		  xhttp.setRequestHeader("role", localStorage.getItem("role"));
		  xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
		  xhttp.send();
		  
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/company/detail/"+cid, true);
	xhttp.send();
	
// 	//구독상태체크
// 	function checkLikeStatus(){
// 		const response = fetch('http://localhost:9001/api/v1/interested-company?cid='+cid, {
// 		      method: 'GET',
// 		      headers: {
// 		        'jwtToken': localStorage.getItem('jwtToken'),
// 		        'username': localStorage.getItem('username'),
// 		        'role': localStorage.getItem('role'),
// 		        'Content-Type': 'application/json'
// 		      }
// 		    });
// 		const result = response.text();
// 		if(result == "existed"){
// 			//구독중인경우
// 			document.querySelector("#likeBtn img").src = "/icon/heart_full.png";
// 			liked = true;
// 		} else if(result = "not existed"){
// 			//구독중이지 않은 경우
// 			document.querySelector("#likeBtn img").src = "/icon/heart.png";
// 			liked = false;
// 		}
// 	}
	

  

</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>