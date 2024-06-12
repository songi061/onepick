<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="layout/header.jsp"></jsp:include>
<div class="container">
    <form name="frm">
        <div>카테고리</div>
        <select name="category">
            <option>회원가입/로그인</option>
            <option>보안 서비스</option>
            <option>이력서</option>
            <option>입사지원</option>
            <option>채용정보</option>
            <option>이벤트</option>
        </select>

        <div>
            <p>제목</p><input type="text" name="title">
        </div>
        <div>
            <p>작성자</p>
            <label>
                <input type="radio" name="usernameOption" value="anonymous"><span>익명</span>
            </label>
            <label>
                <input type="radio" name="usernameOption" value="real"><span>실명</span>
            </label>
        </div>
        <div>
            <p>내용</p><input type="text" name="content">
        </div>
        <div>
            <p>공개여부</p>
            <label>
                <input type="radio" name="secretOption" value="public"><span>공개</span>
            </label>
            <label>
                <input type="radio" name="secretOption" value="private"><span>비공개</span>
            </label>
        </div>
        <input type="submit" onclick="submitForm(event)">
        <input type="hidden" name="username">
        <input type="hidden" name="secret">
    </form>

</div>
<jsp:include page="layout/footer.jsp"></jsp:include>
</body>
<script>

    function submitForm(event){
    	event.preventDefault();
        alert("등록 완료되었습니다.");

        var form = document.forms['frm'];
        var usernameOption = form['usernameOption'].value;
        var secretOption = form['secretOption'].value;

        if(usernameOption === "anonymous"){
            form['username'].value = "익명";
        }else if(usernameOption === "real"){
            form['username'].value = "이름"; // 이 부분은 실제 사용자 이름을 세션에서 가져와서 설정해야 합니다.
        }

        if(secretOption === "public"){
            form['secret'].value = false;
        }else if(secretOption === "private"){
            form['secret'].value = true;
        }

        var formData = $(form).serialize();

        $.ajax({
            type: 'POST',
            url: 'http://localhost:9001/api/v1/qna',
            data: formData,
            success: function(response){
                console.log(response);
            },
            error: function(){
                console.log("에러 발생");
            }
        })
    }
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>