<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize.css" media="screen,projection"/>
<link type="text/css" rel="stylesheet"
	href="css/customerize.css" media="screen,projection" />
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

<header>

    <nav class="top-nav blue-grey">
        <div class="nav-wrapper">
            <div class="container">
                <div class="nav-wrapper blue-grey row">
                    <a href="#" class="brand-logo center">Register a Community</a>
                </div>
            </div>
        </div>
    </nav>

</header>

<main>
    <div class="container">
        <div class="row">
    <form class="col s12">
        <div class="row">
        <div class="input-field col s12">
          <input  id="school" type="text" class="validate">
          <label for="school">School/Community Name</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input  id="website" type="text" class="validate">
          <label for="website">WebSite</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input  id="person" type="text" class="validate">
          <label for="person">Contact Person</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input  id="phone" type="text" class="validate">
          <label for="phone">phone</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input  id="email" type="email" class="validate">
          <label for="email">Email</label>
        </div>
      </div>
    <div class="row">
        <div class="input-field col s12">
          <input  id="street" type="text" class="validate">
          <label for="street">Street</label> 
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input  id="city" type="text" class="validate">
          <label for="city">City</label> 
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input  id="state" type="text" class="validate">
          <label for="state">State/Province</label> 
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input  id="country" type="text" class="validate">
          <label for="country">Country</label> 
        </div>
      </div>
        <div class="row">
        <div class="input-field col s12">
          <input  id="zipcode" type="text" class="validate">
          <label for="zipcode">Zipcode</label> 
        </div>
      </div>
       <div class="row">
        <div class="input-field col s12">
          <input  id="mcode" type="text" class="validate">
          <label for="mcode">Manager Code</label> 
        </div>
      </div>
       <div class="row">
        <div class="input-field col s12">
          <input  id="wcode" type="text" class="validate">
          <label for="wcode">Write Code</label> 
        </div>
      </div>
       <div class="row">
        <div class="input-field col s12">
          <input  id="rcode" type="text" class="validate">
          <label for="rcode">Read only code</label> 
        </div>
      </div>
       <div class="row">
        <div class="input-field col s12">
        <a  id="register" class="waves-effect waves-light btn">Register</a>
         </div>
      </div>
    </form>
  </div>
    </div>
</main>



<!--Import jQuery before materialize.js-->
<script src="js/jquery-3.1.0.js"></script>
<script src="js/notify.js"></script>
<script type="text/javascript" src="js/materialize.min.js"></script>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script type="text/javascript">
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

    $("#register").click(function () {
    	 var school=$("#school").val()
         var email=$("#email").val()
         var website=$("#website").val()
         var person = $("#person").val().replace(/'/g,"\\\'").replace(/"/g,"\\\"")
         var phone=$("#phone").val()
         var email=$("#email").val()
         var street = $("#street").val().replace(/'/g,"\\\'").replace(/"/g,"\\\"")
         var city=$("#city").val().replace(/'/g,"\\\'").replace(/"/g,"\\\"")
         var state=$("#state").val().replace(/'/g,"\\\'").replace(/"/g,"\\\"")
         var country=$("#country").val().replace(/'/g,"\\\'").replace(/"/g,"\\\"")
         var mcode = $("#mcode").val().replace(/'/g,"\\\'").replace(/"/g,"\\\"")
         var wcode=$("#wcode").val().replace(/'/g,"\\\'").replace(/"/g,"\\\"")
         var rcode=$("#rcode").val().replace(/'/g,"\\\'").replace(/"/g,"\\\"")
         var zipcode=$("#zipcode").val().replace(/'/g,"\\\'").replace(/"/g,"\\\"")
        if(""==school||""==email||""==website|""==person||""==phone||""==email||""==street||""==city||""==state||""==country||""==mcode||""==wcode||""==rcode){
             $.notify('All the fields are required', 'warn');
            return
        }
    	 var jsondata = {
                 'token':'20171029163219826664',
                 'database':'itm3',
                 'email': $.trim($("#email").val()),
                 'kfdb':"",
                 'URL':"",
                 'username':"",
                 'password':"",
                 'ITMlocaldb':"none",
                 'port':0,
                 'communityname':$.trim(school),
                 'gradelevel':"",
                 'schoolname':$.trim(school),
                 'email':$.trim(email),
                 'state':$.trim(state),
                 'country':$.trim(country),
                 'city':$.trim(city),
                 'street':$.trim(street),
                 'schoolphone':$.trim(phone),
                 'zipcode':$.trim(zipcode),
                 'contactperson':$.trim(person),
                 'accesscode':$.trim(rcode),
                 'createtime':new Date(),
                 'modifytime':"",
                 'website':$.trim(website),
                 'registertime':new Date(),
                 'managercode':$.trim(mcode),
                 'writecode':$.trim(wcode),
                 'registertoken':getUrlParameter("token"),
                 'registerusername':getUrlParameter("username")
                	 }
                  register(jsondata)
           
    });
    
    
    function  register(jsondata){
    	
              $.ajax({
                url :  "/WSG/community/add",
                type : "POST",
                data : JSON.stringify(jsondata),
                dataType : "json",
                success : function(data, textStatus, jqXHR) {
                	if(data.code=="failure"){
                		   $.notify('Sorry, register require is not sent, please contact ITM manager ,thank you . ', 'success');

                	}else{
                		   $.notify('Register require has been sent , please wait for confirm, thank you . ', 'success');

                	}
                                },
                error : function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                }
            });
    }



    
    $(".modal").modal();
    $(document).ready(function(){

    })
</script>
</body>
</html>