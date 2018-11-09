<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%  session.invalidate(); %>
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize.css" media="screen,projection"/>
 <link type="text/css" rel="stylesheet" href="css/jquery-ui.css" media="screen,projection"/>

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta charset="UTF-8">

    <style>
        main {
            margin-top: 20px;
        }
    </style>


</head>

<body>


<main>
    <div class="container">
        <div class="row">
            <div class="col s8" style="font-size:17px;">
                <h4><image style="width: 600px;" src="res/title.png"></image></h4>
                <div class="blue-grey lighten-5">
                    <p>Idea Thread Mapper (ITM) is a research-based collaborative platform for students to conduct deep inquiry and sustained knowledge building. Its features support student collaboration within each classroom and cross communities.</p>
                    <li>Within each classroom, students develop sustained threads of inquiry to investigate deep problems in their areas of study. They contribute and build on one anotherâs ideas to develop deep understanding in each idea thread and work together to organize their whole inquiry project.</li>
                	<li>Beyond working with their own peers, students share productive threads of ideas with other classrooms and engage in âSuper Talksâ with students from around the world for mutual learning and collaborative problem solving.</li>
                </div>
                <br>

                <div class="divider"></div>

                <div class="blue-grey lighten-5">
                    <p>Using ITM, students and teachers can:</p>
                    <li>Set up a <b>Project</b> for their classroomâs inquiry work and add project members</li>
                    <li>Create <b>Cross-Project Connections</b> including live âbuddy projectsâ and archived âresource projectsâ</li>
                    <li>Structure the inquiry project by setting up <b>Wondering Areas</b> (themes) and <b>Idea Threads</b>, each focusing on a more specific problem/topic in a Wondering Area</li>
                    <li>Participate in the discussion in each idea thread and updating its <b>Journey of Thinking</b></li>
                    <li><b>Map</b> out different idea threads to review progress and see connections</li>
                    <li>Launch and participant in â<b>Super Talk</b>â threads to discuss challenging problems with students from the buddy projects.</li>
                </div>
                <br>
                

                
            </div>
            <div class="col s4">
                <br><br><br>
                <div class="card blue-grey">
                    <div class="card-content white-text">
                        <span class="card-title">Already a user?</span>
                    </div>
                    <form action="USER_LOGIN"  method="post" onsubmit="return validateForm()">
                    <div class="card-action">
                        <div class="input-field col s12">
                            <input id="account" name="email" type="text"  >
                            <label for="account">Email</label>
                        </div>
                        <div class="input-field col s12">
                            <input id="password" name="pwd" type="password" class="validate">
                            <label for="password">Password</label>
                        </div>
                        <br><br>
                         <input class="waves-effect waves-light btn center white-text" id="login" type="submit" value="Login">
                        <br><br>
                         <a class="waves-effect waves-light btn center white-text" id="kf6_login">login as KF6 User </a>
                    </div>
                    </form>
                </div>

                <br><br><br>
                <div class="card blue-grey">
                    <div class="card-content white-text">
                        <span class="card-title">New user?<br><br> <a href="register.jsp" class="waves-effect waves-light btn center white-text" id="register">register</a></span>
                    </div>
                </div>
            </div>
            
            <div class="col s12" style="font-size:15px">
            <div class="divider"></div>
            <p>
                The development of ITM is funded by National Science Foundation through two Cyberlearning grants awarded to Dr. Jianwei Zhang and Dr. Mei-Hwa Chen at the University at Albany.
            </p></div>
        </div>
    </div>
</main>





<div class="fixed-action-btn click-to-toggle" style="bottom: 45px; right: 24px;">
    <a class="btn">Language</a>
    <ul>
        <li><a class="btn">English</a></li>
        <li><a class="btn">FranÃ§ais</a></li>
        <li><a class="btn">ä¸­æç®ä½</a></li>
        <li><a class="btn">ä¸­æç¹é«</a></li>
    </ul>
</div>

<!--Import jQuery before materialize.js-->
<script src="js/jquery-3.1.0.js"></script>
<script type="text/javascript" src="js/materialize.min.js"></script>
<script src="js/jquery-3.1.0.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/jquery.sessionTimeout.js"></script>
<script type="text/javascript">

   $("#kf6_login").click(function(){
	   if(window.location.protocol=="http:"){   
		window.location.href ="/IIUSs/kf6/login.jsp"
	   }else{
		   window.location.href ="/IIUSs/kf6/login.jsp"  
	   }
   })
   
	function validateForm() {
	    if ($("#account").val()=="") {
	        Materialize.toast('User name is null', 4000)
	        return false;
	    }
	    if ($("#password").val()=="") {
	    	 Materialize.toast('Password is null', 4000)
	        return false;
	    }
	}
	
	
	var getUrlParameter = function getUrlParameter(sParam) {
	    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
	        sURLVariables = sPageURL.split('&'),
	        sParameterName,
	        i;

	    for (i = 0; i < sURLVariables.length; i++) {
	        sParameterName = sURLVariables[i].split('=');

	        if (sParameterName[0] === sParam) {
	            return sParameterName[1] === undefined ? true : sParameterName[1];
	        }
	    }
	};
	
	var status =getUrlParameter('flag');
	if(status=="fails"){
		 Materialize.toast("Wrong user name or password", 4000)
		 
	}
	
</script>
</body>
</html>