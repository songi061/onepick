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
<link href="/css/userSearchList.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<h3 class="mb-3 mt-4">인재채용</h3>
		<div class="row">
			<div class="col-md-6 col-xl-4">
				<a class="d-block underline-none border p-4 rounded d-flex pointer" href="">
					<div class="profileImg_box me-3">
						<img src="" alt="사진">
					</div>
					<div>
						<div id="resumeTitle">이력서 제목</div>
						<div>홍길동(남성, 만 30세)</div>
						<div>디지털마케터</div>
						<div>경영학과 졸업</div>
					</div>
				</a>
			</div>
		</div>
	</div>
	


<jsp:include page="../layout/footer.jsp"></jsp:include>

<script>

  
	
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>