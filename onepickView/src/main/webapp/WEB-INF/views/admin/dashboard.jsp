<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>1PICK!</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="/css/adminstyle.css" rel="stylesheet">
    <link href="/css/dashboard.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>

<body class="d-flex flex-column h-100 min-h-100">
    <jsp:include page="../layout/adminHeader.jsp"></jsp:include>
    <div class="container">
        <div class="page_title">관리자 대시보드</div>

        <div class="dash_title">📜회원 현황</div>

        <ul id="dash_ul1" class="clearfix">
            <li class="dash_li li1">
                <p>총 회원 비율</p>
                <div class="graph_wrap">
                    <canvas id="memberChart"></canvas>
                </div>
            </li>
            <li class="dash_li li1">
                <p>개인회원 가입자 현황</p>
                <div class="graph_wrap">
                    <canvas id="registChart"></canvas>
                </div>
            </li>
            <li class="dash_li li1">
                <p>기업회원 가입자 현황</p>
                <div class="graph_wrap">
                    <canvas id="companyRegistChart"></canvas>
                </div>
            </li>
        </ul>

        <div class="dash_title">✨POPULAR</div>
        <ul id="dash_ul2">
            <li class="dash_li li2">
                <p>인기 기업 목록</p>
                <table class="table">
                    <thead>
                        <tr>
                            <th>순위</th>
                            <th>분야</th>
                            <th>기업명</th>
                            <th>구독 수</th>
                        </tr>
                    </thead>
                    <tbody id="interestedCopTableBody">

                    </tbody>
                </table>
            </li>
            <li class="dash_li li2">
                <p>인기 공고 목록</p>
                <table class="table">
                    <thead>
                        <tr>
                            <th>순위</th>
                            <th>기업명</th>
                            <th>공고명</th>
                            <th>스크랩 수</th>
                        </tr>
                    </thead>
                    <tbody id="jobadScrapTableBody">

                    </tbody>
                </table>
            </li>
        </ul>
    </div>
</body>
<script>
    $(document).ready(function () {
        $.ajax({
            url: "http://localhost:9001/api/v1/admin/dashboard-1",
            method: "GET",
            success: function (data) {
                const ctx = document.getElementById('memberChart').getContext('2d');
                const ctx2 = document.getElementById('registChart').getContext('2d');
                const ctx3 = document.getElementById('companyRegistChart').getContext('2d');

                new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: ['기업회원 수', '개인회원 수'],
                        datasets: [{
                            label: '명',
                            data: [data.companyCount, data.userCount],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });

                // 사용자 가입 라인 차트 데이터 설정
                const userLabels = Object.keys(data.weeklyUserRegistration);
                const userData = Object.values(data.weeklyUserRegistration);

                new Chart(ctx2, {
                    type: 'line',
                    data: {
                        labels: userLabels,
                        datasets: [{
                            label: '이번 주 개인회원 가입자 수',
                            data: userData,
                            fill: false,
                            borderColor: 'rgb(255, 99, 132)',
                            tension: 0.1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });

                // 회사 가입 라인 차트 데이터 설정
                const companyLabels = Object.keys(data.weeklyCompanyRegistration);
                const companyData = Object.values(data.weeklyCompanyRegistration);

                new Chart(ctx3, {
                    type: 'line',
                    data: {
                        labels: companyLabels,
                        datasets: [{
                            label: '이번 주 기업회원 가입자 수',
                            data: companyData,
                            fill: false,
                            borderColor: 'rgb(75, 192, 192)',
                            tension: 0.1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            },
            error: function (error) {
                console.log("에러 :", error);
                console.log("에러 상세 정보: ", error.responseText);
            }
        });

        $.ajax({
            url: "http://localhost:9001/api/v1/admin/dashboard-2",
            method: "GET",
            success: function (data) {
                var tbody1 = $("#interestedCopTableBody");
                tbody1.empty();

                $.each(data.interestedCompanies, function (index, item) {
                    var row = $("<tr>");
                    row.append($("<td>").text(index + 1));
                    row.append($("<td>").text(item[0].sector)); // 기업 분야
                    row.append($("<td>").text(item[0].name)); // 기업명
                    row.append($("<td>").text(item[1])); // 구독 수
                    tbody1.append(row);
                });

                var tbody2 = $("#jobadScrapTableBody");
                tbody2.empty();

                $.each(data.popularJobAds, function (index, item) {
                	console.log(data.popularJobAds);
                    var row = $("<tr>");
                    row.append($("<td>").text(index + 1));
                    row.append($("<td>").text(item[0].company.name));
                    row.append($("<td>").text(item[0].wantedTitle));     
                    row.append($("<td>").text(item[1])); // 스크랩 수
                    tbody2.append(row);
                });
            },
            error: function (error) {
                console.log("에러 :", error);
                console.log("에러 상세 정보: ", error.responseText);
            }
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
