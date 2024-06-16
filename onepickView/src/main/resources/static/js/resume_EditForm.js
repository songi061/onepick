$(document).ready(function() {
    // 페이지 로드 후 실행되는 부분
    updateCheckboxValue(); // 초기 값 설정

    $('#disclo_check').change(function() {
        updateCheckboxValue();
    });

    function updateCheckboxValue() {
        if ($('#disclo_check').is(':checked')) {
            $('#disclo_check').val('public');
        } else {
            $('#disclo_check').val('private');
        }
        //console.log($('#disclo_check').val()); // 값 콘솔에 출력 (테스트용)
    }


	
});



//업종
 const xhttp4 = new XMLHttpRequest();
xhttp4.onload = function() {
    const selectSector = document.getElementById("select_sector2");
    
    const data = JSON.parse(this.responseText);

    data.forEach(item => {
        const sectorName = item["상위직무"];
        const option = document.createElement("option");
        option.value = item["상위직무"];
        option.text = sectorName;
        selectSector.appendChild(option);
    });
}
xhttp4.open("GET", "/json/job_category.json", true);
xhttp4.send();



//직무
const xhttp5 = new XMLHttpRequest();
xhttp5.onload = function() {
    const selectSector = document.getElementById("select_sector2");
    const selectJob = document.getElementById("select_job2");
    
    const data = JSON.parse(this.responseText);

    // 관심업종 선택 변경 시 관심직무 업데이트
    selectSector.addEventListener('DOMContentLoaded', function() {
        const selectedSectorCode = selectSector.value;

        // 관심직무 옵션 초기화
        selectJob.innerHTML = '<option value="">관심직무 선택</option>';

        data.forEach(item => {
            if (item["직무명"] == selectedSectorCode) {
                const option = document.createElement("option");
                option.text = item["직무 키워드명"];
                option.value = item["직무 키워드명"];
                selectJob.appendChild(option);
            }
        });
    });
}
xhttp5.open("GET", "/json/job.json", true);
xhttp5.send();



















