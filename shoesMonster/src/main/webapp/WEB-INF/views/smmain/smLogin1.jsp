<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<link href="../resources/build/css/smmain.css" rel="stylesheet">

</head>
<body>

<div class="page">
  <div class="container">
    <div class="left" style="text-align: center;">
   	 <img src="/resources/images/shoes.png" height="300" width="300">
    <div class="img"></div>
<!--       <div class="eula">Shoes Monster</div> -->
    </div>
    <div class="right">
      <svg viewBox="0 0 320 300">
        <defs>
          <linearGradient
                          inkscape:collect="always"
                          id="linearGradient"
                          x1="13"
                          y1="193.49992"
                          x2="307"
                          y2="193.49992"
                          gradientUnits="userSpaceOnUse">
            <stop
                  style="stop-color:#ff00ff;"
                  offset="0"
                  id="stop876" />
            <stop
                  style="stop-color:#ff0000;"
                  offset="1"
                  id="stop878" />
          </linearGradient>
        </defs>
        <path d="m 40,120.00016 239.99984,-3.2e-4 c 0,0 24.99263,0.79932 25.00016,35.00016 0.008,34.20084 -25.00016,35 -25.00016,35 h -239.99984 c 0,-0.0205 -25,4.01348 -25,38.5 0,34.48652 25,38.5 25,38.5 h 215 c 0,0 20,-0.99604 20,-25 0,-24.00396 -20,-25 -20,-25 h -190 c 0,0 -20,1.71033 -20,25 0,24.00396 20,25 20,25 h 168.57143" />
      </svg>
      
      <div class="form">
      	<form action="" method="post">
        <label for="ID">ID</label>
        <input type="text" id="ID" name="emp_id">
        <label for="password">Password</label>
        <input type="password" id="password" name="emp_pw">
        <input type="submit" id="submit" value="Login">
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>