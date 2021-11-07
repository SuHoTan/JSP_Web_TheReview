<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- ��Ʈ��Ʈ�� CSS �߰��ϱ� -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- Ŀ���� CSS �߰��ϱ� -->
	<link rel="stylesheet" href="./css/custom.css">
	
		<!-- �������� �ڹٽ�Ʈ��Ʈ �߰��ϱ� -->
	<script src="./js/jquery.min.js"></script>
	<!-- ���� �ڹٽ�Ʈ��Ʈ �߰��ϱ� -->
	<script src="./js/popper.js"></script>
	<!-- ��Ʈ��Ʈ�� �ڹٽ�Ʈ��Ʈ �߰��ϱ� -->
	<script src="./js/bootstrap.min.js"></script>
</head>
<body>

  
  	 <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<a class="navbar-brand" href="index.jsp"><img src="./image/thereview.jpg" height ="40px"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
				<br>
					<a class="nav-link" href="index.jsp"> <p style="font-size: 21px;" >��õ ��ǰ</p></a>
				</li>
				<li class="nav-item dropdown">
				<br>
					<a class="nav-link dropdown-toggle" href="#" id="dropdown" data-toggle="dropdown">
						 <p style="font-size: 21px;" >������</p>
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown"> 

					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="������ �Է��ϼ���." aria-label="search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">�˻�</button>
			</form>
		</div>
	</nav>
	
		  <!-- Header -->
  <header class="bg-primary py-2 mb">
    <div class="container h-30">
      <div class="row h-300 align-items-center">
        <div class="col-lg-12" style= text-align:center; >
        <a class="navbar-brand" href="#">
        <br><br><br>
          <img src="./image/logo.jpg" alt ="logo" /> 
          </a>
          <p class="lead mb-5 text-white-50"></p>
        </div>
      </div>
    </div>
  </header>
  
  
     <div class="container marketing">
     
     <br><br><br><br>
     
             <div class="row featurette">
          <div class="col-md-7">
            <h2 class="featurette-heading">���� �״���� ���� <span class="text-muted">The Review</span></h2>
            <p class="lead">�ִ� �״���� ���並 �ø��� ��ǰ�� ���� �ڽ��� ������ �����ϸ� &nbsp;&nbsp;&nbsp;&nbsp;
                          �����ϱ� ���� ���Դϴ�.</p>
          </div>
          <div class="col-md-5">
            <img class="featurette-image img-fluid mx-auto" src="./image/thereview.jpg" alt="Generic placeholder image">
          </div>
        </div>
     
     
            <hr class="featurette-divider">

        <!-- Three columns of text below the carousel -->
        <div class="row">
          <div class="col-lg-4">
            <img class="rounded-circle" src="./image/signup.jpg" alt="Generic placeholder image" width="140" height="140">
            <h2>ȸ������</h2>
            <p>���̵� �����ôٱ���? �̰����� �����ϼ���.</p>
            <p><a class="btn btn-secondary" href="#" role="button">ȸ������ &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
          <div class="col-lg-4">
            <img class="rounded-circle" src="./image/login.jpg" alt="Generic placeholder image" width="140" height="140">
            <h2>�α���</h2>
            <p>���񽺸� �̿��Ͻ÷��� ���̵�� �α��� ���ּ���.</p>
            <p><a class="btn btn-secondary" href="#" role="button">�α��� &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
          <div class="col-lg-4">
            <img class="rounded-circle" src="./image/question.png" alt="Generic placeholder image" width="140" height="140">
            <h2>������ ����</h2>
            <p>Ȩ������ ����, ���۱� ����, ���� ���� �� �����ڿ��� �����ϰ� �����ø� �Ʒ���ư�� �����ּ���</p>
            <p><a class="btn btn-secondary" href="#" role="button">���� &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
        </div><!-- /.row -->
 


        <hr class="featurette-divider">

        <!-- /END THE FEATURETTES -->

      </div><!-- /.container -->
  
  
  
  
  
  
  
	
		<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; xxxxxxx All Rights Reserved.
	</footer>
	

</body>
</html>