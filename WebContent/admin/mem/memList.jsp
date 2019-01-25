<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../../member/ssi.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stylesheet.css?ver=1.014">


<div class="wrap">
	<h3>회원목록</h3>
	<p>전체 회원수: <%=dao.recordCount()%></p>

	<table class="list">
		<tr>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>가입일</th>
			<th>등급</th>
		</tr>
		<%
			String col=Utility.checkNull(request.getParameter("col"));
			ArrayList<MemberDTO> list = dao.list(col);
			
			if (list == null) {
				out.println("<tr><td colspan='7'>자료 없음</td>");
			} else {

				// 데이터 로드
				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);
					String mlevel=dto.getMlevel();
		%>
		<tr>
			<td class="list-name"><%=dto.getId()%></td>
			<td class="list-name">
				<%
					for (int j = 0; j < dto.getPasswd().length(); j++)
								out.print("*");
				%>
			</td>
			<td class="list-name"><%=dto.getMname()%></td>
			<td class="list-ip"><%=Utility.checkNull(dto.getTel())%></td>
			<td class="list-ip"><%=dto.getEmail()%></td>
			<td class="list-date"><%=dto.getMdate().substring(0,10)%></td>
			<td class="list-no">
			<%
			switch(mlevel){
			case "A1" :
				out.print("관리자"); break;
			case "B1" :
				out.print("부관리자"); break;
			case "C1" :
				out.print("우수회원"); break;
			case "D1" :
				out.print("일반회원"); break;
			case "E1" :
				out.print("비회원"); break;
			case "F1" :
				out.print("탈퇴회원"); break;
			case "X1" :
				out.print("휴면계정"); break;
			}
			%>
			(<%=dto.getMlevel()%>)
			</td>
		</tr>
		<%
				} // for end
		%>
		<tr>
			<td colspan="7">
				<form action="memList.jsp">
					<select name="col" onchange="sort(this.form)">
						<option value="id" <% if(col.equals("")||col.equals("id")) out.print("selected"); %>>ID 순
						<option value="mname" <% if(col.equals("mname")) out.print("selected"); %>>이름 순
						<option value="mdate" <% if(col.equals("mdate")) out.print("selected"); %>>가입일 순
					</select>
				</form>
		</tr>
		<%
			} // if else end
		%>
	</table>
</div>


<script>
	function sort(f) {
		f.submit();
	}
	
	function levelChange(f) {
		var message="회원 등급을 변경할까요?";
		if(confirm(message)) f.submit();
	}
	
</script>
