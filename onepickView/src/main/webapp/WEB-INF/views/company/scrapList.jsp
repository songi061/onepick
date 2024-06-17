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
<link href="/css/scrapList.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="title">스크랩한 구직자 리스트</div>
		<div class="scrap_list">
		
		</div>
		
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
const listContainer = document.querySelector('.scrap_list');

    const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let datas = JSON.parse(this.responseText);
	
		if (datas && datas.length > 0) {
           datas.forEach(data => {
       console.log(data)
        	   let age = 2024 - Number(data.user.birthDate.slice(0,4));
        	   console.log(age)
               const listItem = document.createElement('div');
               listItem.className = 'scrap_list_item';
               listItem.innerHTML = "<div class='profileImg_box img' ><img class='img' src=''></div><div class='scrap_info'><div class='scrap_title'><a href=''>"+ data.resume.title+"</a></div><div class='scrap_name'>"+ data.user.name+"</div><div>"+data.user.gender+"</div><div>" + age +
               " 세</div> <div class='scrap_job'>" + data.resume.job + "</div><div class='scrap_region'>" +data.resume.region1+"</div></div>";
               listContainer.appendChild(listItem);
               
               
               if(data.user.fileName == null){
            	   listItem.querySelector(".profileImg_box img").src="/img/no_img.jpg";
	       		}else{
	       			listItem.querySelector(".profileImg_box img").src="/images/" + myInfo.fileName;
	       		}
               
           });
		}else{
			 // 스크랩한 구직자가 없을경우
	        listContainer.innerHTML = '내가 스크랩한 구직자가 아직 존재하지 않습니다.';
		}
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/resume-scrap", true);
	xhttp.setRequestHeader("jwtToken", localStorage.getItem("jwtToken"));
	xhttp.setRequestHeader("username", localStorage.getItem("username"));
	xhttp.setRequestHeader("role", localStorage.getItem("role"));
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "jwtToken, username, role")
	xhttp.send();
</script>
</body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>