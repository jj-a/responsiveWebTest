<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--@ include file="./auth.jsp"--%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<c:choose>
	<c:when test="${sessionScope.s_id==null || sessionScope.s_mlevel=='E1' || sessionScope.s_mlevel=='F1'}">
	<%-- 비회원, 로그인 안한 경우 --%>
	<%
			// cookie 불러오기
			Cookie cookies[]=request.getCookies();
			String c_id="";
			String checked="";
			if(cookies!=null){
				for(int i=0;i<cookies.length;i++){
					if(cookies[i].getName().equals("c_id")){
						c_id=cookies[i].getValue();
						checked="checked";
					}
				}
			}
	%>
	<h3><a href="#"> 로그인 </a></h3>
	
	<form name="loginFrm" method="post" action="login.do" onsubmit="return loginCheck(this)">
		<table class="writefrm" border=1>
			<tr>
				<td>ID</td>
				<td colspan=2><input type="text" name="id" id="id" value="<%=c_id %>" size="10" maxlength="16" placeholder="아이디"></td>
			</tr>
			<tr>
				<td>PASSWORD</td>
				<td colspan=2><input type="password" name="passwd" id="passwd" size="10" maxlength="16" placeholder="비밀번호"></td>
			</tr>
			<tr>
				<td colspan=3><input type="image" src="../images/bt_login.gif" style="cursor: pointer"></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="c_id" value="SAVE" <%=checked%>> Save ID</td>
				<td onclick="window.location='agreement.do'" onmouseover="style='cursor:pointer;'">JOIN</td>
				<td onclick="window.location='findmember.do'" onmouseover="style='cursor:pointer;'">Find ID/PW</td>
			</tr>
		</table>
	</form>
	</c:when>
	
	<c:otherwise>
	<%-- 로그인 되있는 경우 - 마이페이지 --%>
	<h3><a href="#"> 마이페이지 </a></h3>
	
	<table class="writefrm" border=1>
		<tr>
			<td colspan="3"><h4>${sessionScope.s_id} 님</h4></td>
		</tr><tr>
			<td onclick="window.location='logout.do'" onmouseover="style='cursor:pointer;'">LOGOUT</td>
			<td onclick="window.location='check.do?page=modifyform'" onmouseover="style='cursor:pointer;'">회원정보수정</td>
			<td onclick="window.location='check.do?page=withdraw'" onmouseover="style='cursor:pointer;'">회원탈퇴</td>
		</tr>
	</table>
	</c:otherwise>
</c:choose>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

