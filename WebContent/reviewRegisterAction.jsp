<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="review.*"%>
<%@ page import="review.ReviewDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요..');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String category = null;
	String reviewTitle = null;
	String reviewContent = null;
	String totalScore = null;
	String designScore = null;
	String priceScore =null ;
	String etcScore = null;
	

	if (request.getParameter("category") != null) {
		category = request.getParameter("category");
	}
	if (request.getParameter("reviewTitle") != null) {
		reviewTitle = request.getParameter("reviewTitle");
	}
	if (request.getParameter("reviewContent") != null) {
		reviewContent = request.getParameter("reviewContent");
	}
	if (request.getParameter("totalScore") != null) {
		totalScore = request.getParameter("totalScore");
	}
	if (request.getParameter("designScore") != null) {
		designScore = request.getParameter("designScore");
	}
	if (request.getParameter("priceScore") != null) {
		priceScore = request.getParameter("priceScore");
	}
	if (request.getParameter("etcScore") != null) {
		etcScore = request.getParameter("etcScore");
	}
	
	if (category == null || reviewTitle == null || reviewContent == null || totalScore == null ||
		designScore == null || priceScore == null || etcScore == null ||reviewTitle.equals("") || reviewContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	ReviewDAO reviewDAO = new ReviewDAO();
		int result = reviewDAO.write(new ReviewDTO(0, userID, 
				category, reviewTitle, 
		reviewContent, totalScore, designScore, priceScore, etcScore, 0));
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('리뷰 등록에 실패했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else {
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp';");
			script.println("</script>");
			script.close();
		}
%>
