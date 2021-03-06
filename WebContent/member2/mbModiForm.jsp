<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3>회원정보 수정</h3>

<%-- 수정화면이 나오기 전에 비밀번호 확인, 비회원 확인 --%>
<c:choose>
	<c:when test="${sessionScope.s_id==null || sessionScope.s_mlevel=='E1' || sessionScope.s_mlevel=='F1'}">
		<%-- 비회원, 로그인 안한 경우 --%>
		<script>
			alert("로그인 후 접근 가능한 페이지입니다.");
			location.href="${pageContext.request.contextPath}/member/loginform.do";
		</script>
	</c:when>
	<c:when test="${member==null}">
	<%-- 회원정보를 불러올 수 없는 경우 --%>
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
	
	<form name="modForm" method="post" action="modify.do" onsubmit="return memberUdtCheck(this)">
		<input type="hidden" name="id" value="${member.id}">
		<span style="color: red; font-size: 11pt; text-align: right;">* : 필수입력</span> <br>
		<table border="1" class="writefrm">
			<tr>
				<th>*아이디</th>
				<td>${member.id}</td>
				<td><h6 style="margin:0 auto;">아이디 수정 불가</h6></td>
			</tr><tr>
				<th>*비밀번호 수정</th>
				<td><input type="password" name="passwd" id="passwd" size="10" maxlength="20" placeholder="수정 시에만 입력"></td>
				<td><h6 style="margin:0 auto;">특수문자를 포함한 <br>6~16자 이내의 영문, 숫자</h6></td>
			</tr><tr>
				<th>*비밀번호 확인</th>
				<td colspan="2"><input type="password" name="repasswd" id="repasswd" size="10" maxlength="20" placeholder="수정 시에만 입력"></td>
			</tr><tr>
				<th>*이름</th>
				<td><input type="text" name="mname" id="mname" value="${member.mname}" size="10" required></td>
				<td><h6 style="margin:0 auto;">2~20자 이내의 이름</h6></td>
			</tr><tr>
				<th>*이메일</th>
				<td colspan="2">
				<input type="text" name="email" id="email" value="${member.email}" size="30" readonly> 
				<input type="button" name="emailbt" value="Email 중복확인" onclick="emailCheck()">
				</td>
			</tr><tr>
				<th>전화번호</th>
				<td colspan="2"><input type="text" name="tel" id="tel" value="${member.tel}" size="10"></td>
			</tr><tr>
				<th>우편번호</th>
				<td>
				<input type="text" name="zipcode" id="zipcode" value="${member.zipcode}" size="7" readonly> 
				<input type="button" value="주소찾기" onclick="DaumPostcode()">
				</td>
				<td><h6 style="margin:0 auto;">주소찾기 클릭하여 주소 입력</h6></td>
			</tr><tr>
				<th>주소</th>
				<td colspan="2"><input type="text" name="address1" id="address1" value="${member.address1}" size="45" readonly></td>
			</tr><tr>
				<th>나머지주소</th>
				<td colspan="2"><input type="text" name="address2" id="address2" value="${member.address2}" size="45"></td>
			</tr><tr>
				<th>*직업</th>
				<td colspan="2"><select name="job" id="job">
					<option value="0" >선택하세요.</option>
					<option value="A01" <c:if test="${member.job=='A01'}">selected</c:if>>회사원</option>
					<option value="A02" <c:if test="${member.job=='A02'}">selected</c:if>>전산관련직</option>
					<option value="A03" <c:if test="${member.job=='A03'}">selected</c:if>>학생</option>
					<option value="A04" <c:if test="${member.job=='A04'}">selected</c:if>>주부</option>
					<option value="A05" <c:if test="${member.job=='A05'}">selected</c:if>>기타</option>
				</select></td>
			</tr><tr>
				<td colspan="3"><input type="submit" value="수정">&nbsp;&nbsp;
				<input type="reset" value="지우기">&nbsp;&nbsp;
				<input type="button" value="취소" onclick="history.back()"></td>
			</tr>
		</table>
	
		<!-- ----- DAUM 우편번호 API 시작 ----- -->
		<div id="wrap" style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 110px; position: relative">
			<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap"
				style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1" onclick="foldDaumPostcode()" alt="접기 버튼">
		</div>
	
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<script>
			// 우편번호 찾기 화면을 넣을 element
			var element_wrap = document.getElementById('wrap');
	
			function foldDaumPostcode() {
				// iframe을 넣은 element를 안보이게 한다.
				element_wrap.style.display = 'none';
			}
	
			function DaumPostcode() {
				// 현재 scroll 위치를 저장해놓는다.
				var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
				new daum.Postcode({
					oncomplete : function(data) {
						// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = data.address; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수
	
						// 기본 주소가 도로명 타입일때 조합한다.
						if (data.addressType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
						}
	
						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('address1').value = fullAddr;
	
						// iframe을 넣은 element를 안보이게 한다.
						// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
						element_wrap.style.display = 'none';
	
						// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
						document.body.scrollTop = currentScroll;
	
						$('#address2').focus();
					},
					// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
					onresize : function(size) {
						element_wrap.style.height = size.height + 'px';
					},
					width : '100%',
					height : '100%'
				}).embed(element_wrap);
	
				// iframe을 넣은 element를 보이게 한다.
				element_wrap.style.display = 'block';
			}
		</script>
		<!-- ----- DAUM 우편번호 API 종료----- -->
	
	</form>
	</c:otherwise>
</c:choose>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>
