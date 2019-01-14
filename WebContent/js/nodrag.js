/**
 * drag 방지 스크립트
 * 
 * body 부분에 필요한 속성 추가
 * <body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
 * 
 */
var omitformtags = [ "input", "textarea", "select" ];

omitformtags = omitformtags.join("|");

function disableselect(e) {
	if (omitformtags.indexOf(e.target.tagName.toLowerCase()) == -1)
		return false;
}

function reEnable() {
	return true;
}

if (typeof document.onselectstart != "undefined")
	document.onselectstart = new Function("return false");
else {
	document.onmousedown = disableselect;
	document.onmouseup = reEnable;
}
