/* myscript.js */


function bbsCheck(f){		// 답변형 게시판 유효성 검사
	
	// 1) 작성자명 2자 이상 체크
	var wname=f.wname.value;
	wname=wname.trim();
	if(wname.length<=0){
		alert("작성자를 입력해주세요.");
		f.wname.focus();
		return false;
	}
	
	// 2) 제목 2자 이상 체크
	var subject=f.subject.value;
	subject=subject.trim();
	if(subject.length<2){
		alert("제목을 2자 이상 입력해주세요.");
		f.subject.focus();
		return false;
	}
	
	// 3) 내용 유무 체크
	var content=f.content.value;
	content=content.trim();
	if(content.length<=0){
		alert("내용을 입력해주세요.");
		f.content.focus();
		return false;
	}
	
	// 4) 비번 글자수 체크
	var passwd=f.passwd.value;
	passwd=passwd.trim();
	if(passwd.length<4){
		alert("비밀번호를 4자 이상 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	
	return true;
	
}// bbsCheck() end