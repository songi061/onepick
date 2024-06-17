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
<link href="/css/main.css" rel="stylesheet">
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
       	<div class="section">
       	  <div class='section-title'>해당 기업 현재 채용진행 중인 공고</div>
       	  <div class='company-recruit'></div>
       	  
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
		  
		  const xhttp1 = new XMLHttpRequest();
			xhttp1.onload = function () {
				let objs = JSON.parse(this.responseText);
				objs.forEach(obj => {
					let logoSrc = obj.company.fileName == null ? "/img/no_img.jpg" : "/images/" + obj.company.fileName;
					document.querySelector(".company-recruit").innerHTML += 
						"<div class='col-md-6 col-xl-4 mb-3'>"
					+ "<a class='d-block d-flex align-items-center border text-decoration-none rounded p-4 pointer recruit_box' href='/company/recruitDetail?jno=" + obj.jno + "''>"
					+ "<div class='logo w-25 me-3'><img src='" + logoSrc + "' alt='회사로고'></div>"
					+ "<div class='w-75'>"
					+ "<div class='companyName fs-6'>" + obj.company.name + "</div>"
					+ "<div class='recruitTitle fs-4 fw-bold'>" + obj.wantedTitle + "</div>"
					+ "<div class='fs-6 text-secondary'> 공고 마감일 " + obj.receiptCloseDt + "</div>"
					+ "<div class='recruitInfo text-ellipsis fs-6 text-secondary'> 모집 인원 " + obj.collectPsncnt + ", " + obj.position1 + ", " + obj.position2 + ", " + obj.region1 + ", " + obj.region2  + "</div>"
					+ "</div></a></div>";
				});
				
			}
			xhttp1.open("GET", "http://localhost:9001/api/v1/recruit/company-recruit/"+cid);
			xhttp1.send();
			//구독상태체크하기
			checkLikeStatus();
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/company/detail/"+cid, true);
	xhttp.send();
	
	//구독상태체크
	function checkLikeStatus(){
		fetch('http://localhost:9001/api/v1/interested-company?cid='+cid, {
		      method: 'GET',
		      headers: {
		        'jwtToken': localStorage.getItem('jwtToken'),
		        'username': localStorage.getItem('username'),
		        'role': localStorage.getItem('role'),
		        'Content-Type': 'application/json'
		      }
		    }).then(response => {
		        if (!response.ok) {
		          throw new Error('Network response was not ok: ' + response.statusText);
		        }
		        return response.text(); 
		      })
		      .then(result => {
		        if (result === "existed") {
		          document.querySelector("#likeBtn img").src = "/icon/heart_full.png";
		          liked = true;
		        } else if (result === "not existed") {
		          document.querySelector("#likeBtn img").src = "/icon/heart.png";
		          liked = false;
		        } else {
		          console.error('Unexpected response:', result);
		        }
		      })
		      .catch(error => {
		        console.error('There was a problem with the fetch operation:', error);
		      });
		
		
	}
		
	function likeTheCom() {
		console.log("ccccc")
		if(localStorage.getItem("role") == "ROLE_USER"){
			if(liked == true){
				if (confirm("정말 해당 기업을 구독 리스트에서 삭제하시겠습니까?")) {
					//구독취소하기
					const xhttp = new XMLHttpRequest();
					xhttp.onload = function () {
						if (this.responseText == "done") {
							//비어있는 버튼으로 바꿔주기
							document.querySelector("#likeBtn img").src = "/icon/heart.png";
						} 
					}
					xhttp.open("delete", 'http://localhost:9001/api/v1/interested-company?cid='+cid, true);
					xhttp.setRequestHeader("username", localStorage.getItem("username"));
					xhttp.send();
				}
			}else if(liked == false){
				//구독하기
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function () {
					if (this.responseText == "done") {
						alert("성공적으로 해당기업을 구독 했습니다!")
						//버튼 색칠한거로 바꿔주기
						document.querySelector("#likeBtn img").src = "/icon/heart_full.png";
					} 
				}
				xhttp.open("POST", 'http://localhost:9001/api/v1/interested-company?cid='+cid, true);
				xhttp.setRequestHeader("username", localStorage.getItem("username"));
				xhttp.send();
			}
			
		}else{
			alert("공고 스크랩은 일반 사용자만 사용 가능한 기능입니다.")
		}
		
	} 
  

</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>