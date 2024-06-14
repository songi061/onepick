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
<link href="/css/reviewForm.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="title">내가 받은 평점 리스트</div>
		<div class="received_list">
			내가 받은 평점이 아직 존재하지 않습니다.
		</div>
		<div class="title">내가 쓴 평점 리스트</div>
			내가 쓴 평점이 아직 존재하지 않습니다.
		<div class="registered_list">
		</div>
		
	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>
	const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		let datas = JSON.parse(this.responseText);
// 		console.log(datas)
		console.log(datas.registeredList)
	
		
		const receivedListContainer = document.querySelector('.received_list');
		const registeredListContainer = document.querySelector('.registered_list');
		
// 	       datas.receivedList.forEach(data => {
// 	    	   console.log(data)
// 	           const receivedListItem = document.createElement('div');
// 	    	   receivedListItem.className = 'received_list_item';
// // 	    	   receivedListItem.innerHTML = "<div><div>"+ data.jobAd.wantedTitle+"</div><span style='display:none;' class='jno'>"+ data.jobAd.jno+"</span><div>"+ data.resume.title+"</div><span style='display:none;' class='userId'>"+ data.user.username+"</span><div class='user_name'>"+data.user.name+"</div><div> 면접날짜 : " + data.moddate.slice(0,10) +
// // 	           "</div> <button data-bs-toggle='modal' data-bs-target='#exampleModal' class='btn btn-onepick' onclick='openRegModal(event)'>평점등록</button> </div>";
// 	           receivedListContainer.appendChild(receivedListItem);
//            });
	       let rating;
	       datas.registeredList.forEach(data=>{
        	   console.log(data)
        	   rating = Number(data.rating);
        	   console.log(rating)
        	   const registeredListItem = document.createElement('div');
        	   registeredListItem.className = 'registered_list_item';
        	   registeredListItem.innerHTML = "<div><div class='user_name'>"+data.user.name+"</div><div class='reviewContainer'></div>"
        	   registeredListContainer.appendChild(registeredListItem);
        	   
        	   
        	   
           })
             const reviewContainer = document.querySelector(".reviewContainer")

               // rating 값에 따라 별 이미지 반복 추가
               for (let i = 0; i < rating; i++) {
                   const starImg = document.createElement('img');
                   starImg.src = '/icon/star_full.png'; 
                   starImg.style.width="30px";
                   reviewContainer.appendChild(starImg);
               }
	  }
	xhttp.open("GET", "http://localhost:9001/api/v1/company/review-list", true);
	xhttp.setRequestHeader("username", "aaa");
	xhttp.setRequestHeader("role", "ROLE_COMPANY");
	xhttp.setRequestHeader("Access-Control-Expose-Headers", "username, role")
	xhttp.send();

</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>