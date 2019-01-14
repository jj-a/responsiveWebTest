/**
 * index.jsp / #clock-box
 */

var handler;

$().ready(function(){
	starttime();
});

function starttime() {
	if (handler == null) { // setInterval 중복 동작 방지
		handler = setInterval(function() {
			// background color random
			var color = [];
			color[0] = Math.random() * 256;
			color[1] = Math.random() * 256;
			color[2] = Math.random() * 256;
			document.getElementById("clock").style.backgroundColor = "rgb(" + color[0] + "," + color[1] + "," + color[2] + ")";

			showtime(); // 시계 불러오기

		}, 1000);
	}
}


function showtime() {
	// 현재 시스템의 날짜정보 가져오기
	var today = new Date();
	/*
	 * alert(today.getFullYear()); alert(today.getMonth()); // 0~11로 출력 alert(today.getDate());
	 */

	// OUTPUT EX > 2019.01.03 (목) PM 5:06
	var now = "";

	var weekName = [ "일", "월", "화", "수", "목", "금", "토" ];
	var yyyy = today.getFullYear();
	var mm = today.getMonth() + 1;
	mm = (mm < 10) ? ("0" + mm) : mm;
	var dd = today.getDate();
	dd = (dd < 10) ? ("0" + dd) : dd;
	var day = weekName[today.getDay()];
	var h = today.getHours();
	var apm = (h < 12) ? "AM" : "PM";
	h = (h > 12) ? (h - 12) : h;
	var min = today.getMinutes();
	min = (min < 10) ? ("0" + min) : min;
	var ss = today.getSeconds();
	ss = (ss < 10) ? ("0" + ss) : ss;

	now = yyyy + "." + mm + "." + dd + " (" + day + ") " + apm + " " + h + ":" + min + ":" + ss;

	// 시계 출력
	document.getElementById("clock").value = now;

}

function killtime() {
	clearInterval(handler);
	handler = null;
}

function endtime() {
	if (handler != null)
		killtime();
	document.getElementById("clock").value = "";
	document.getElementById("clock").style.backgroundColor = '';

}
