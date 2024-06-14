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
  <h1>FAQ</h1>

  <div class="accordion" id="faqAccordion">
    <!-- FAQ 항목이 추가될 곳 -->
  </div>
</div>
<jsp:include page="layout/footer.jsp"></jsp:include>
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
        },
        error: function(error){
            console.log("에러 :", error);
            console.log("에러 상세 정보: ", error.responseText);
        }
    });
});

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
