/**
 * iframesize.js
 * iframe 사이즈 자동 조절 (문서 크기에 따라 변경, 브라우저 크기에 따라 변경)
 */

$(function(){
	$("iframe.sub-content").load(function(){ //iframe 컨텐츠가 로드 된 후에 호출됩니다.
		var frame = $(this).get(0);
		var doc = (frame.contentDocument) ? frame.contentDocument : frame.contentWindow.document;
		$(this).height(doc.body.scrollHeight);
		$(this).width(doc.body.scrollWidth);
	});
});