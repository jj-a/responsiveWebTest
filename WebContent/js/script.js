/* myscript.js */

function bbsCheck(f) { // 답변형 게시판 유효성 검사

	// 1) 작성자명 2자 이상 체크
	var wname = f.wname.value;
	wname = wname.trim();
	if (wname.length <= 0) {
		alert("작성자를 입력해주세요.");
		f.wname.focus();
		return false;
	}

	// 2) 제목 2자 이상 체크
	var subject = f.subject.value;
	subject = subject.trim();
	if (subject.length < 2) {
		alert("제목을 2자 이상 입력해주세요.");
		f.subject.focus();
		return false;
	}

	// 3) 내용 유무 체크
	var content = f.content.value;
	content = content.trim();
	if (content.length <= 0) {
		alert("내용을 입력해주세요.");
		f.content.focus();
		return false;
	}

	// 4) 비번 글자수 체크
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호를 4자 이상 입력해주세요.");
		f.passwd.focus();
		return false;
	}

	return true;

}// bbsCheck() end



function delPwCheck(f) {
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호를 4자 이상 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	var msg="삭제 후엔 다시 되돌릴 수 없습니다. 계속 진행하시겠습니까?";
	if(confirm(msg)) return true;	// 확인 시 삭제 작업 수행
	else return false;
} // delPwCheck() end


function upPwCheck(f) {
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호를 4자 이상 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	return true;
} // upPwCheck() end



function searchCheck(f) {
	var word = f.word.value;
	word = word.trim();
	if (word.length <=0) {
		alert("검색어를 입력하세요.");
		return false;
	}
	return true;
} // searchCheck() end


// 방문자수 체크
function visitCheck(f) {
	var visited;
}



function move(f, file){
	f.action=file;
	f.submit();
}
