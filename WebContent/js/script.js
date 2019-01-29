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
} // visitCheck() end


function idCheck(){
	// 아이디 중복확인
	window.open("idCheckForm.jsp","idwin","width=450,height=300");
	
	var sc=parseInt(screen.width);
	var sy=parseInt(screen.height);
	var x=(sx/2)+50;
	var y=(sy/2)-25;
	
	win.moveTo(x,y);
	
} // idCheck() end


function emailCheck(){
	// 이메일 중복확인
	window.open("mailCheckForm.jsp","mailwin","width=450,height=300");
	
	var sc=parseInt(screen.width);
	var sy=parseInt(screen.height);
	var x=(sx/2)+50;
	var y=(sy/2)-25;
	
	win.moveTo(x,y);
	
} // emailCheck() end


function memberCheck(f) {

	var id=f.id.value;
	var passwd=f.passwd.value;
	var repasswd=f.repasswd.value;
	var email=f.email.value;
	var mname=f.mname.value;
	var job=f.job.value;
	
	id=id.trim();
	passwd=passwd.trim();
	repasswd=repasswd.trim();
	email=email.trim();
	mname=mname.trim();
	
	
	// 정규표현식
	var reid= /^[a-zA-Z0-9]+[a-zA-Z0-9_]+[a-zA-Z0-9]{4,10}$/;	// 아이디 형식
	var repw = /^((?=.*[a-zA-Z])|(?=.*\d))((?=.*\W)).{6,16}$/;	// 비밀번호 형식
	var remail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;		// 이메일 형식

	
	// 아이디 작성 여부
	if(id.length<=0){
		alert("ID 중복확인을 눌러 아이디를 작성해주세요.");
		f.idbt.focus();
		return false;
	}
	
	// 아이디 4~10글자 이내
	if(id.length<4 || id.length>10){
		alert("아이디는 4~10자 이내로 가능합니다.");
		f.id.focus();
		return false;
	}
	
	// 정규식 아이디 영문,숫자로만 구성 여부
	if(reid.test(id)==false){
		alert("아이디는 영문 대/소문자, 숫자, '_'의 조합으로만 가능하며, 맨앞과 마지막엔 '_'가 올 수 없습니다.");
		f.id.focus();
		return false;
	}
	
	// 비밀번호 6~16글자 이내
	if(passwd.length<6 || passwd.length>16){
		alert("비밀번호는 6~16자 이내로 가능합니다.");
		f.passwd.focus();
		return false;
	}
	
	// 정규식 비밀번호 특수문자 포함여부
	if(repw.test(passwd)==false){
		alert("비밀번호는 영문 대/소문자 또는 숫자에 특수문자를 1자 이상 조합하여 가능합니다.");
		f.passwd.focus();
		return false;
	}
	
	// 비밀번호=비번확인 일치여부
	if(passwd!=repasswd){
		alert("비밀번호 확인이 다릅니다. 다시 확인해주세요.");
		f.passwd.focus();
		return false;
	}
	
	//이름 2~20글자 이내
	if(mname.length<2 || mname.length>20){
		alert("이름은 2~20자 이내로 가능합니다.");
		f.mname.focus();
		return false;
	}
	
	// 이메일 작성 여부
	if(email.length<=0){
		alert("Email 중복확인을 눌러 이메일을 작성해주세요.");
		f.emailbt.focus();
		return false;
	}
	
	// 이메일에 @문자 있는지
	if(remail.test(email)==false){
		alert("이메일 형식이 올바르지 않습니다.");
		f.email.focus();
		return false;
	}
	/*
	if(email.indexOf("@")==-1 || email.indexOf(".")==-1 || email.indexOf("@")>email.indexOf(".")){
		// 나중에 정규식으로 다듬기
		// 정규식 : /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		alert("이메일 형식이 올바르지 않습니다.");
		f.email.focus();
		return false;
	}
	*/
	
	// 직업 선택 여부
	if(job=="0"){
		alert("직업을 선택해주세요.");
		f.job.focus();
		return false;
	}
	
	return true;
	
} // memberCheck() end



function memberUdtCheck(f) {

	var passwd=f.passwd.value;
	var repasswd=f.repasswd.value;
	var email=f.email.value;
	var mname=f.mname.value;
	var job=f.job.value;
	
	passwd=passwd.trim();
	repasswd=repasswd.trim();
	email=email.trim();
	mname=mname.trim();
	
	
	// 정규표현식
	var repw = /^((?=.*[a-zA-Z])|(?=.*\d))((?=.*\W)).{6,16}$/;	// 비밀번호 형식
	var remail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;		// 이메일 형식


	// 비밀번호가 한 칸만 쓰여있을 때
	if((passwd==""&&repasswd!="") || (passwd!=""&&repasswd=="")){
		alert("비밀번호 수정 시 비밀번호 수정과 비밀번호 확인 둘 다 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	
	if(passwd.length>0){	// passwd check
		
		// 비밀번호 6~16글자 이내
		if(passwd.length<6 || passwd.length>16){
			alert("비밀번호는 6~16자 이내로 가능합니다.");
			f.passwd.focus();
			return false;
		}
		
		// 정규식 비밀번호 특수문자 포함여부
		if(repw.test(passwd)==false){
			alert("비밀번호는 영문 대/소문자 또는 숫자에 특수문자를 1자 이상 조합하여 가능합니다.");
			f.passwd.focus();
			return false;
		}
		
		// 비밀번호=비번확인 일치여부
		if(passwd!=repasswd){
			alert("비밀번호 확인이 다릅니다. 다시 확인해주세요.");
			f.passwd.focus();
			return false;
		}
	} // passwd check end
	
	//이름 2~20글자 이내
	if(mname.length<2 || mname.length>20){
		alert("이름은 2~20자 이내로 가능합니다.");
		f.mname.focus();
		return false;
	}
	
	// 이메일 작성 여부
	if(email.length<=0){
		alert("Email 중복확인을 눌러 이메일을 작성해주세요.");
		f.emailbt.focus();
		return false;
	}
	
	// 이메일에 @문자 있는지
	if(remail.test(email)==false){
		alert("이메일 형식이 올바르지 않습니다.");
		f.email.focus();
		return false;
	}
	/*
	if(email.indexOf("@")==-1 || email.indexOf(".")==-1 || email.indexOf("@")>email.indexOf(".")){
		// 나중에 정규식으로 다듬기
		// 정규식 : /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		alert("이메일 형식이 올바르지 않습니다.");
		f.email.focus();
		return false;
	}
	*/
	
	// 직업 선택 여부
	if(job=="0"){
		alert("직업을 선택해주세요.");
		f.job.focus();
		return false;
	}
	
	return true;
	
} // memberUdtCheck() end



function loginCheck(f){
	// 로그인 유효성 검사

	// 아이디 4~10글자 이내
	if(id.length<4 || id.length>10){
		alert("아이디는 4~10자 이내입니다.");
		f.id.focus();
		return false;
	}

	// 비밀번호 6~16글자 이내
	if(passwd.length<6 || passwd.length>16){
		alert("비밀번호는 6~16자 이내입니다.");
		f.passwd.focus();
		return false;
	}
	
	return true;
	
} // loginCheck() end


function pdsCheck(f){
	// 포토갤러리 유효성 검사
	
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

	// 4) 비번 글자수 체크
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호를 4자 이상 입력해주세요.");
		f.passwd.focus();
		return false;
	}

	// 첨부한 파일의 확장명 출력
	var filename = f.filename.value;
	filename = filename.trim();
	
	if(filename.length<5){
		alert("첨부파일을 선택해주세요.");
		return false;
	}
	
	var fileextend=filename.substring(filename.lastIndexOf(".")+1);
	fileextend=fileextend.toLowerCase();	// 소문자 변환
	
	if(!(fileextend=="jpg" || fileextend=="jpeg" || fileextend=="bmp" || fileextend=="gif" || fileextend=="png" 
		|| fileextend=="tif" || fileextend=="tiff" || fileextend=="raw")){
		alert("이미지 파일만 첨부 가능합니다.");
		return false;
	}
	
	return true;
	
} // pdsCheck() end


function pdsUdtCheck(f){
	// 포토갤러리 수정 유효성 검사
	
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

	// 4) 비번 글자수 체크
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호를 4자 이상 입력해주세요.");
		f.passwd.focus();
		return false;
	}

	// 첨부한 파일의 확장명 출력
	var filename = f.filename.value;
	filename = filename.trim();
	
	if(filename.length>0){
		var fileextend=filename.substring(filename.lastIndexOf(".")+1);
		fileextend=fileextend.toLowerCase();	// 소문자 변환
		
		if(!(fileextend=="jpg" || fileextend=="jpeg" || fileextend=="bmp" || fileextend=="gif" || fileextend=="png" 
			|| fileextend=="tif" || fileextend=="tiff" || fileextend=="raw")){
			alert("이미지 파일만 첨부 가능합니다.");
			return false;
		}
	}
	
	return true;
	
} // pdsUdtCheck() end


function move(f, file){
	f.action=file;
	f.submit();
} // move() end
