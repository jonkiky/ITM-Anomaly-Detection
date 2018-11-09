<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<html>
<head>

<html>
<head>

<meta charset="UTF-8">
<style>
boody {
	    padding-left: 20px;
}
</style>


</head>

<body>

							
						
							<div class="row" >
								<div id="new-note-select-views" >
								</div>
							</div>
						
					
					
	<script src="../js/jquery-3.1.0.js"></script>
	<script type="text/javascript" src="../js/materialize.js"></script>
	<script src="https://d3js.org/d3.v4.min.js"></script>
	<script src='../js/tinymce/tinymce.min.js'></script>
	<script src="../js/notify.js"></script>
	<script src="../js/itm.js"></script>
	<script>
function initViews(){
		var jsondata = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>'
		};
		$.ajax({
			url :  "/WSG/view/get/all",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="success"){
                	 var json =data.obj;
                	 if($.trim(json)!="No data aviliable."){
                		 var d = $.parseJSON(json); 
                		 initTable(d)
                	 }
				}
			}
		})
	}
	
function initTable(data){
	$("#new-note-select-views").html("")
	if(null!=data&&""!=data){
		for (var i in data) {
			var tr =$("#new-note-select-views")
			var html ='<div><span width="50px"><input class="note_list_id" type="checkbox" value="'+data[i].view_id+'"  id="notes_'+data[i].view_id+'"><label for="notes_'+data[i].view_id+'"></label>'
							+ '</span>'
							if(null!=data[i].title){
								 html = html+'<span class="cell-title">'+data[i].title+'</span>'
							}else{
								 html = html+'<span class="cell-title"> null </span>'
							}
							 html = html+'</div>'
							 tr.append(html)
		}
		// if the thread already has view associate with it. 
		select_views()
	}
}	

function select_views(){
	var tid =getUrlParameter('threadid');
	if(typeof(tid)!="undefined"){
		var jsondata = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
				"tid":tid
		};
		$.ajax({
			url :  "/WSG/thread_view/getbythreadid",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="success"){
	            	 var json =data.obj;
	            	 if($.trim(json)!="No data aviliable."){
	            		 var d = $.parseJSON(json); 
	            		 var checkbox = $(".note_list_id")
	            		$.each(checkbox,function(obj){
	            			for(var i in d){
	            				if(checkbox[obj].value==d[i].view_id){
	            					$(checkbox[obj]).prop( "checked", true );
	            					break;
	            				}	
	            			}
	            		})
	            	 }
				}
			}
		})
	}
	
}
	
initViews();
	</script>
	
	</body>
</html>