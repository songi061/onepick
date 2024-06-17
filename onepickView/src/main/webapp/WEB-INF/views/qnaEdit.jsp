<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>1PICK!</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/qnaEdit.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    </head>

    <body class="d-flex flex-column h-100 min-h-100">
        <jsp:include page="layout/header.jsp"></jsp:include>
        <div class="container">
            <div class="page_title">Q&A</div>
              <button class="qnaBtn qbn2" id="qnaListButton">목록</button>

            <form name="frm">
                <div id="frm_category">
                    <p>카테고리</p>
                    <select name="category" id="category">
                        <option>서비스 이용 문의</option>
                        <option>불량정보·오류 신고</option>
                        <option>서비스 제안·칭찬</option>
                    </select>
                </div>
                <div id="frm_title">
                    <p>제목</p><input type="text" name="title" id="title">
                </div>
                <div id="frm_user">
                    <p>작성자</p>
                    <input type="text" name="username" id="username_input" readonly>
                </div>
                <div class="frm_content">
                    <p>내용</p><textarea name="content" id="content"></textarea>
                </div>
                <div class="frm_content" id="response_section">
                    <p>답변</p><textarea name="response" id="response"></textarea>
                </div>
                <input type="submit" onclick="submitForm(event)" value="수정" class="qnaBtn">
                <input type="hidden" name="bno" id="bno" value="${bno}">
            </form>
        </div>
        <jsp:include page="layout/footer.jsp"></jsp:include>
    </body>
    <script>
        $(document).ready(function () {
        	
        	$('#qnaListButton').click(function() {
                window.history.back(); // 이전 페이지로 이동
            });
        	
            var bno = ${ bno };
            console.log("bno 값:" + bno);

            $.ajax({
                url: "http://localhost:9001/api/v1/qna/" + bno,
                method: "GET",
                success: function (qna) {
                    $("#title").val(qna.title);
                    $("#category").val(qna.category);
                    $("#content").val(qna.content);
                    $("#username").text(qna.user ? qna.user.username : (qna.company ? qna.company.username : ''));
                    $("#username_input").val(qna.user ? qna.user.username : (qna.company ? qna.company.username : ''));
                    $("#bno").val(qna.bno);
                    
                    // Admin 체크 및 response 섹션 숨기기
                    if (username !== 'admin') {
                        $('#response_section').hide();
                    }
                },
                error: function (error) {
                    console.log("에러 :", error);
                    console.log("에러 상세 정보: ", error.responseText);
                }
            });
        });



        function submitForm(event) {
            event.preventDefault();
            alert("등록 완료되었습니다.");

            var form = document.forms['frm'];
            var formData = $(form).serialize();

            $.ajax({
                type: 'PUT',
                url: 'http://localhost:9001/api/v1/qna',
                data: formData,
                success: function (qna) {
                    console.log(qna);
                    const storedUsername = localStorage.getItem("username"); // 로컬 스토리지에서 username 가져오기

                    if (qna.user && qna.user.username === storedUsername) {
                        window.location.href = "/user/myQnaList";
                    } else if (qna.company && qna.company.username === storedUsername) {
                        window.location.href = "/company/myQnaList";
                    } else if (storedUsername === "admin") {
                        window.location.href = "/admin/qnaList";
                    } else {
                        alert("해당 사용자 또는 기업의 QnA 리스트가 없습니다.");
                    }
                },
                error: function (error) {
                    console.log("에러 :", error);
                    console.log("에러 상세 정보: ", error.responseText);
                }
            })
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

    </html>