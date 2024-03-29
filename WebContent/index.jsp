<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="review.*"%>
<%@ page import="review.ReviewDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>The Review</title> 
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
	
		<!-- 제이쿼리 자바스트립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스트립트 추가하기 -->
	<script src="./js/popper.js"></script>
	<!-- 부트스트랩 자바스트립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
	
	
	<script>
	$(document).ready(function(){
		   var fileTarget = $('.filebox .upload-hidden');

		    fileTarget.on('change', function(){
		        if(window.FileReader){
		            // 파일명 추출
		            var filename = $(this)[0].files[0].name;
		        } 

		        else {
		            // Old IE 파일명 추출
		            var filename = $(this).val().split('/').pop().split('\\').pop();
		        };

		        $(this).siblings('.upload-name').val(filename);
		    });

		    //preview image 
		    var imgTarget = $('.preview-image .upload-hidden');

		    imgTarget.on('change', function(){
		        var parent = $(this).parent();
		        parent.children('.upload-display').remove();

		        if(window.FileReader){
		            //image 파일만
		            if (!$(this)[0].files[0].type.match(/image\//)) return;
		            
		            var reader = new FileReader();
		            reader.onload = function(e){
		                var src = e.target.result;
		                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
		            }
		            reader.readAsDataURL($(this)[0].files[0]);
		        }

		        else {
		            $(this)[0].select();
		            $(this)[0].blur();
		            var imgSrc = document.selection.createRange().text;
		            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

		            var img = $(this).siblings('.upload-display').find('img');
		            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
		        }
		    });
		});
	
</script>
	
	
	
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String category = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("category") != null){
		category = request.getParameter("category");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null){
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));	
		} catch (Exception e){
			System.out.println("검색 페이지 번호오류");
		}
	}
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
%>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">The review</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="dropdown" data-toggle="dropdown">
						회원관리
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown"> 
<%
	if(userID == null) {
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	}else{
%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="category" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공" <% if(category.equals("전공")) out.println("selected"); %>>전공</option>
				<option value="교양" <% if(category.equals("교양")) out.println("selected"); %>>교양</option>
				<option value="기타" <% if(category.equals("기타")) out.println("selected"); %>>기타</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천순" <% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2"
				placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal"
				href="#registerModal">등록하기</a> <a class="btn btn-danger mx-1 mt-2"
				data-toggle="modal" href="#reportModal">신고</a>
		</form>
<%
	ArrayList<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
	reviewList = new ReviewDAO().getList(category, searchType, search, pageNumber);
	if(reviewList != null)
		for(int i = 0; i < reviewList.size(); i++) {
			if(i == 5 ) break;
			ReviewDTO review = reviewList.get(i);
%>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%= review.getReviewTitle() %>&nbsp;<small><%= review.getUserID() %></small></div>
					<div class="col-4 text-right">
						종합<span style="color: red;"><%= review.getTotalScore() %></span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<p class="card-text"><%= review.getReviewContent() %></p>
				</div>
				<div class="card-footer">
				<div class="row">
					<div class="col-9 text-left">
						디자인<span style="color: red;"><%= review.getDesignScore() %></span>
						가격<span style="color: red;"><%= review.getPriceScore() %></span>
						기타<span style="color: red;"><%= review.getEtcScore() %></span>
						<span style="color: green;">(추천: <%= review.getRecommendCount() %>)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./recommendAction.jsp?reviewID=<%=review.getReviewID() %>">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?reviewID=<%=review.getReviewID() %>">삭제</a>
					</div>
				</div>
			</div>
		</div>
<%
		}
%>
	</section>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
		if(pageNumber <= 0 ){
%>		
		<a class="page-link disabled">이전</a>
<%
		} else {
%>
	<a class="page-link" href="./index.jsp?category=<%= URLEncoder.encode(category, "UTF-8")%>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=
	<%= pageNumber - 1 %>">이전</a>
<%
		}
%>
		</li>
 		<li>
<%
	if(reviewList.size() < 6) {
%>		
	<a class="page-link disabled">다음</a>
<%
	} else {
%>
	<a class="page-link" href="./index.jsp?category=<%= URLEncoder.encode(category, "UTF-8")%>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=
	<%= pageNumber + 1 %>">다음</a>
<%
		}
%>
		</li>
	</ul>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-rabel="close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reviewRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>카테고리</label>
								<select name="category" class="form-control">
									<option value="기타" selected>기타</option>
									<option value="디지털">디지털</option>
									<option value="서적">서적</option>
									<option value="가전/가구">가전/가구</option>
									<option value="의류/잡화">의류/잡화</option>
									<option value="화장품">화장품</option>
									<option value="등산/캠핑">등산캠핑</option>
								</select>
							</div>
							</div>
							<div class="form-group">
								<label>제목</label>
								<input type="text" name="reviewTitle" class="form-control" maxlength="30">
							</div>
							<div class="form-group">
								<label>내용</label>
								<textarea name="reviewContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
							</div>
							<div class="form-row">
								<div class="form-aroup col-sm-3">
									<label>총점</label>
									<select name="totalScore" class="form-control">
										<option value="5점" selected>5점</option>
										<option value="4점">4점</option>
										<option value="3점">3점</option>
										<option value="2점">2점</option>
										<option value="1점">1점</option>
									</select>
								</div>
								<div class="form-aroup col-sm-3">
									<label>디자인</label>
									<select name="designScore" class="form-control">
										<option value="5점" selected>5점</option>
										<option value="4점">4점</option>
										<option value="3점">3점</option>
										<option value="2점">2점</option>
										<option value="1점">1점</option>
									</select>
								</div>
								<div class="form-aroup col-sm-3">
									<label>가격</label>
									<select name="priceScore" class="form-control">
										<option value="5점" selected>5점</option>
										<option value="4점">4점</option>
										<option value="3점">3점</option>
										<option value="2점">2점</option>
										<option value="1점">1점</option>
									</select>
								</div>
								<div class="form-aroup col-sm-3">
									<label>편의성</label>
									<select name="etcScore" class="form-control">
										<option value="5점" selected>5점</option>
										<option value="4점">4점</option>
										<option value="3점">3점</option>
										<option value="2점">2점</option>
										<option value="1점">1점</option>
									</select>
								</div>
							</div>
					
		
		<br>
<div class="filebox bs3-primary preview-image">
              <input class="upload-name" value="파일선택" disabled="disabled" style="width: 200px;">

              <label for="input_file">업로드</label> 
              <input type="file" id="input_file" class="upload-hidden"> 
            </div>

<br>
							
							
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-primary">등록하기</button>
							</div>
					</form>
				</div>
			</div>
		</div>
	</div>
		<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-rabel="close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
							<div class="form-group">
								<label>신고 제목</label>
								<input type="text" name="reportTitle" class="form-control" maxlength="30">
							</div>
							<div class="form-group">
								<label>신고 내용</label>
								<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-danger">신고하기</button>
							</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy;  XXXXXXXXXX All Rights Reserved.
	</footer>


</body>
</html>