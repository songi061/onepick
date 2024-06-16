<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1PICK!</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link href="/css/adminstyle.css" rel="stylesheet">
<link href="/css/faqList.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"
    integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
    crossorigin="anonymous"></script>
</head>
<body class="d-flex flex-column h-100 min-h-100">
<jsp:include page="../layout/adminHeader.jsp"></jsp:include>
<div class="container">
  <div id="page_title">FAQ</div>
  <div class="accordion" id="faqAccordion">
    <!-- FAQ 항목이 추가될 곳 -->
  </div>

  <a href="/admin/faqForm"><button class="btn btn-onepick">FAQ 작성하기</button></a>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script>
$(document).ready(function(){
    // 페이지 로드 시 단일 AJAX 호출
    $.ajax({
        url: "http://localhost:9001/api/v1/faq",
        method: "GET",
        success: function(data){
            console.log("받은 데이터: ", data); // 데이터를 확인하기 위해 추가

            // 기존 FAQ 항목을 지움
            $("#faqAccordion").empty();

            // 데이터 처리
            $.each(data, function(index, faq){
                var faqItemId = "collapse" + faq.fqno;

                var accordionItem = 
                "<div class='accordion-item'>" +
                    "<h2 class='accordion-header'>" +
                      "<button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#" + faqItemId + "' aria-expanded='false' aria-controls='" + faqItemId + "'>" +
                        faq.title +
                        "<div class='ms-auto'>" +
                          "<button class='btn btn-warning btn-sm mx-2 edit-btn' data-fqno='" + faq.fqno + "'>수정</button>" +
                          "<button class='btn btn-danger btn-sm delete-btn' data-fqno='" + faq.fqno + "'>삭제</button>" +
                        "</div>" +
                      "</button>" +
                    "</h2>" +
                    "<div id='" + faqItemId + "' class='accordion-collapse collapse' data-bs-parent='#faqAccordion'>" +
                      "<div class='accordion-body'>" +
                        faq.response +
                      "</div>" +
                    "</div>" +
                "</div>";

                $("#faqAccordion").append(accordionItem);
            });

            // 이벤트 핸들러 추가
            $(".edit-btn").on("click", function(){
                var fqno = $(this).data("fqno");
                window.location.href = "/admin/faqEdit?fqno=" + fqno;
            });

            $(".delete-btn").on("click", function(event){
                var fqno = $(this).data("fqno");
                confirmDelete(event, fqno);
            });
        },
        error: function(error){
            console.log("에러 :", error);
            console.log("에러 상세 정보: ", error.responseText);
        }
    });
});

function confirmDelete(event, fqno) {
    if (confirm("정말 삭제하시겠습니까?")) {
        deleteFaq(fqno);
    }
}

function deleteFaq(fqno){
	event.preventDefault();
    $.ajax({
        url: "http://localhost:9001/api/v1/faq/" + fqno,
        method: "DELETE",
        success: function(response){
            alert("삭제되었습니다.");
            console.log(response);
            window.location.href = "/admin/faqList";
        },
        error: function(error){
            console.log("에러 :", error);
            console.log("에러 상세 정보: ", error.responseText);
        }
    });
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
