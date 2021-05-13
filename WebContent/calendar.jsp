<%@page import="com.koreait.myCalendar.SolaToLunar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.koreait.myCalendar.MyCalendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만년달력</title>

<link rel="stylesheet" href="calendar.css">

</head>
<body>

<%
	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(calendar.MONTH) + 1;

	try {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		if (month >= 13) {
			year++;
			month = 1;
		} else if (month <= 0) {
			year--;
			month = 12;
		}

	} catch (NumberFormatException e) {
		
	}
	
//	달력을 출력할 달의 양력 음력 대조 결과를 얻어온다.
	SolaToLunar.solaToLunar(year, month);
	
%>

<table width="700" align="center" border="1" cellpadding="5" cellspacing="1">

	<tr>
		<th>
			<input type="button" value="이전달" onclick="location.href='?year=<%=year%>&month=<%=month - 1%>'"/>
		</th>
		<th id="title" colspan="5">
			<%=year%>년 <%=month%>월
		</th>
		<th>
			<button type="button" onclick="location.href='?year=<%=year%>&month=<%=month + 1%>'">다음달</button>
		</th>
	</tr>
	
	<tr>
		<td id="sunday">일</td>
		<td class="etcday">월</td>
		<td class="etcday">화</td>
		<td class="etcday">수</td>
		<td class="etcday">목</td>
		<td class="etcday">금</td>
		<td id="saturday">토</td>
	</tr>

	<tr>
<%
	int week = MyCalendar.weekDay(year, month, 1);
	int start = 0;
	if (month == 1) {
		start = 31 - week;
	} else {
		start = MyCalendar.lastDay(year, month - 1) - week;
	}

	for (int i = 0; i < week; i++) {
		if (i == 0) {
			out.println("<td class='beforesun'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
		} else {
			out.println("<td class='before'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
		}
	}

	for (int i = 1; i <= MyCalendar.lastDay(year, month); i++) {
		
		boolean flag = false;
		int child = 0;
		if (MyCalendar.weekDay(year, 5, 5) == 6) {
			flag = true;
			child = 7;
		} else if (MyCalendar.weekDay(year, 5, 5) == 0) {
			flag = true;
			child = 6;
		}
		
		week = MyCalendar.weekDay(year, month, i);
		if (flag && month == 5 && i == child) {
			out.println("<td class='holiday'>" + i + "<br/><span>어린이날<br/>대체공휴일</span></td>");
		} else if (month == 1 && i == 1) {
			out.println("<td class='holiday'>" + i + "<br/><span>신정</span></td>");
		} else if (month == 3 && i == 1) {
			out.println("<td class='holiday'>" + i + "<br/><span>삼일절</span></td>");
		} else if (month == 5 && i == 1) {
			out.println("<td class='holiday'>" + i + "<br/><span>근로자의날</span></td>");
		} else if (month == 5 && i == 5) {
			out.println("<td class='holiday'>" + i + "<br/><span>어린이날</span></td>");
		} else if (month == 6 && i == 6) {
			out.println("<td class='holiday'>" + i + "<br/><span>현충일</span></td>");
		} else if (month == 8 && i == 15) {
			out.println("<td class='holiday'>" + i + "<br/><span>광복절</span></td>");
		} else if (month == 10 && i == 3) {
			out.println("<td class='holiday'>" + i + "<br/><span>개천절</span></td>");
		} else if (month == 10 && i == 9) {
			out.println("<td class='holiday'>" + i + "<br/><span>한글날</span></td>");
		} else if (month == 12 && i == 25) {
			out.println("<td class='holiday'>" + i + "<br/><span>크리스마스</span></td>");
		}
		
		else {
			switch (week) {
				case 0:
					out.println("<td class='sun'>" + i + "</td>");
					break;
				case 6:
					out.println("<td class='sat'>" + i + "</td>");
					break;
				default:
					out.println("<td class='etc'>" + i + "</td>");
					break;
			}
		}
		
		if(week == 6 && i != MyCalendar.lastDay(year, month)) {
			out.println("</tr><tr>");
		}
	}

	if (month == 12) {
		week = MyCalendar.weekDay(year + 1, 1, 1);
	} else {
		week = MyCalendar.weekDay(year, month + 1, 1);
	}

	start = 0;
	for (int i = week; i <= 6; i++) {
		if (week == 0) {
			break;
		}
		if (i == 6) {
			out.println("<td class='aftersat'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
		} else {
			out.println("<td class='after'>" + (month == 12 ? 1 : month + 1) + "/" + ++start + "</td>");
		}
	}
%>
	</tr>

	<tr>
		<td colspan="7">
			<form action="?" method="post">
			
				<select class="select" name="year">
<%
	for (int i = 1950; i <= 2050; i++) {
		if (i == calendar.get(Calendar.YEAR)) {
			out.println("<option selected='selected'>" + i + "</option>");
		} else {
			out.println("<option>" + i + "</option>");
		}
	}
%>
				</select>년
				<select class="select" name="month">
<%
	for (int i = 1; i <= 12; i++) {
		out.println("<option>" + i + "</option>");
	}
%>
				</select>월
				<input class="select" type="submit" value="보기"/>
				
			</form>
		</td>
	</tr>

</table>

</body>
</html>
