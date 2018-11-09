
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
#jotCompileModal{
	top:0px !important
}

.modal.modal-fixed-footer .modal-content {
    height: calc(100% - 56px);
}

</style>

	<div id="jotCompileModal" class="modal modal-fixed-footer" style="top: 0 !important;max-height: 100%;height: 100%;bottom: 0;width:100%">
			<div class="modal-content" style ="padding:8px 0px"id="compileContent">
				<div class="row" style="margin-bottom:0px;" class="  blue-grey">
					<h5 id="jot-title">Merge: Create a group Journey of Thinking  </h5>
				</div>
				<div class="row">
					<div class="s12 right">
						<a id="compile-all-btn" class="  waves-effect  btn ">Individual Entries</a>
						<a id="save-jot-btn" class="  waves-effect  btn ">Save</a>
						<a id="cancel-jot-btn" class="  waves-effect  btn ">Cancel</a>
						<a id="write-jot-btn" class="  waves-effect  btn ">Write Summary</a>
						<a id="download-as-pdf" class="  waves-effect  btn ">Download as PDF</a>
						<a id="word-cloud" class="  waves-effect  btn ">Word Cloud</a>
						<a id="previous-edit" class="  waves-effect  btn ">Summary History</a>
						<a href="#!" class="modal-action modal-close waves-effect  btn">Close</a>
					</div>
				</div>
				<div id="jot-compile-content" style="word-break: break-word;word-wrap: break-word;"></div>
			</div>
		
			</div>
  
<!-- <div id="jot-history-list"></div> -->
<!-- <div id="jot-history-item"></div> -->
<script src="../js/jqcloud.min.js"></script>
<script type="text/javascript">


     
        
function tab(pid){
	
	  if(pid=="tab1"){
		  $("#wc-div").css("background","#ccc");
		  $("#jot-history").css("background","#fff")
	  }
	  if(pid=="tab2"){
		  $("#wc-div").css("background","#fff");
		  $("#jot-history").css("background","#ccc")
	  }
	  if(pid=="tab1"||pid=="tab2"){
		  var tabs=["tab1","tab2"];
		  for(var i=0;i<2;i++){
		   if(tabs[i]==pid){
			    document.getElementById(tabs[i]).style.display="block";
			  }else{
			    document.getElementById(tabs[i]).style.display="none";
			  }
		  }
	  }
	  
	  if(pid=="tab3"){
		  $("#jot-all").css("background","#ccc");
		  $("#jot-mine").css("background","#fff")
	  }
	  if(pid=="tab4"){
		  $("#jot-all").css("background","#fff");
		  $("#jot-mine").css("background","#ccc")
	  }
	  if(pid=="tab3"||pid=="tab4"){
		  var tabs=["tab3","tab4"];
		  for(var i=0;i<2;i++){
		   if(tabs[i]==pid){
			    document.getElementById(tabs[i]).style.display="block";
			  }else{
			    document.getElementById(tabs[i]).style.display="none";
			  }
		  }
	  }
	  
	  // for jot compile
	  
	  var tab4 = ["edit-panle","compile-all-panel","world-cloud-panel","history-panel"]
	  var tab5 = ["Write a Summary","Individual Entries","Word Cloud","Summary History"]
	  if(pid=="edit-panle"||pid=="compile-all-panel"||pid=="world-cloud-panel"||pid=="history-panel"){
		  for(var i=0;i<tab4.length;i++){
			  if(tab4[i]!=pid){
				  document.getElementById(tab4[i]).style.display="none";
			  }else{
				  $("#jot-title").html(tab5[i])
				  document.getElementById(tab4[i]).style.display="block";
			  }
		  }
	  }
	
	  
}
$("#cancel-jot-btn").click(function(){
	tab("compile-all-panel");
	$("#write-jot-btn").show()
	$("#download-as-pdf").hide()
	$("#word-cloud").show()
	$("#previous-edit").show()
	$("#cancel-jot-btn").hide() 
	$("#save-jot-btn").hide() 
})

$("#compile-all-btn").click(function(){
	tab("compile-all-panel");
	$("#write-jot-btn").show()
	$("#download-as-pdf").hide()
	$("#word-cloud").show()
	$("#previous-edit").show()
	$("#cancel-jot-btn").hide() 
	$("#save-jot-btn").hide() 
})

$("#write-jot-btn").click(function(){
	tab("edit-panle");
	$("#write-jot-btn").hide()
	$("#download-as-pdf").hide()
	$("#word-cloud").hide()
	$("#previous-edit").hide()
	$("#cancel-jot-btn").show() 
	$("#save-jot-btn").show() 
})
$("#download-as-pdf").click(function(){
	
})
$("#word-cloud").click(function(){
	tab("world-cloud-panel");
	$("#write-jot-btn").show()
	$("#download-as-pdf").hide()
	$("#word-cloud").show()
	$("#previous-edit").show()
	$("#cancel-jot-btn").hide() 
	$("#save-jot-btn").hide() 
	
})
$("#previous-edit").click(function(){

	showJotSummary()
})
function showJotEdit(){
	tab("edit-panle");
	$("#write-jot-btn").hide()
	$("#download-as-pdf").hide()
	$("#word-cloud").hide()
	$("#previous-edit").hide()
	$("#cancel-jot-btn").show() 
	$("#save-jot-btn").show()  
}

$("#jot-all").click(function(){
	tab("tab3")
	
})

$("#jot-mine").click(function(){
	tab("tab4")
})

window.last_problem ="";
window.last_idea="";
window.last_to_do=""
function jotCompile(){
	$("#jotCompileModal").modal('open')
	showCompiledJotSummary()
}
function showHistory(data){
	var html  = ""
	for(var i in data){
		html+="<div class=\"row\">"
			+"<p>"+data[i].first_name+"  "+data[i].last_name+":</p>"
			+"<p>"+data[i].create_time+"</p>"
			+"<p><b>Questions explored:</b></p>"
			+"<p>"+data[i].problem+"</p>"
			+"<p><b>Big ideas learned:</b></p>"
			+"<p>"+data[i].idea+"</p>"
			+"<p><b>Deeper research needed:</b></p>"
			+"<p>"+data[i].more+"</p>"
		+"</div>"
	}
	return html;
}

	
	function showJotSummary(){
		tab("history-panel");
		$("#write-jot-btn").show()
		$("#download-as-pdf").hide()
		$("#word-cloud").show()
		$("#previous-edit").show()
		$("#cancel-jot-btn").hide() 
		$("#save-jot-btn").hide() 
}

function showCompiledJotSummary(callback){

	$("#write-jot-btn").show()
	$("#download-as-pdf").hide()
	$("#word-cloud").show()
	$("#previous-edit").show()
	$("#cancel-jot-btn").hide() 
	$("#save-jot-btn").hide() 
	
	
	// not show the save button till,in jot edit model
	$("#jot-compile-content").empty().html("")
	var json = {
			 "database" :localdb,
			 "token" : super_token,
			 "tid":thread_id
	 }
	if(isSupertalk){
		json = {
				 "database" :"super_talk",
				 "token" : super_token,
				 "tid":thread_id
		 }
	}
	
	 $.ajax({
			url :  "/WSG/jot/summary/get/all",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus,jqXHR) {
				var all_problem ="";
				$("#problem_textarea .tmsg_text").each(function(i){
					all_problem+=" <li>"+$(this).text()+"</li>";
				});
				
				var all_idea_textarea="";
				$("#idea_textarea .tmsg_text").each(function(i){
					all_idea_textarea+=" <li>"+$(this).text()+"</li>";
				});
				var all_to_do_textarea="";
				$("#to_do_textarea .tmsg_text").each(function(i){
					all_to_do_textarea+=" <li>"+$(this).text()+"</li>";
				});
				
				
			
					 
					 
				 var json = $.parseJSON(data.obj);
				 var last_jot = null;
				 if(json === null){
					 window.last_problem=""
					 window.last_idea=""
					 window.last_to_do=""
					 
				 }else{
					 last_jot = json[0];
					 // show the last summary 
					 window.last_problem=last_jot.problem
					 window.last_idea=last_jot.idea
					 window.last_to_do=last_jot.more
				 }
				 
			
				 
				window.all_problem=all_problem.replace(/\[([edit\]]+)\]/g,"");
				window.all_idea_textarea= all_idea_textarea.replace(/\[([edit\]]+)\]/g,"");
				window.all_to_do_textarea=all_to_do_textarea.replace(/\[([edit\]]+)\]/g,"");
				
				
				window.problem=window.all_problem;
				window.idea=window.all_idea_textarea;
				window.more=window.all_to_do_textarea;
				
				var lefthtml =compileJot(all_problem,all_idea_textarea,all_to_do_textarea,"",'');
				
				var righthtml =showWordCloud(all_problem,all_idea_textarea,all_to_do_textarea);
				
				var html="<div class='row' id='compile-all-panel' style='display:block'>"
				html+='<div class="col s12" style="height: calc(100% - 115px);">'+lefthtml+'</div>'
				html+='</div>' 
				html+="<div class='row' id='world-cloud-panel' style='display:none'>"
				html+='<div class="col s12" style="height: calc(100% - 115px);background-color: #efefef; margin-top: 18px;">'+righthtml+'</div>'
				html+='</div>' 
				html+="<div class='row' id='history-panel' style='display:none'>"	
			  
				if(json instanceof Array){  // get the all the jot summary order by time
					var historyHtml = showHistory(json);
					html+='<div class="col s12" style="max-height: 90%; overflow: scroll; height: calc(100% - 115px);background-color: #efefef; margin-top: 18px;">'+historyHtml+'</div>'
				}
     			html+='</div>' 
     			
     			lefthtml="<div class=\"row\"  ><p>Compile a clean version of the Journey of Thinking for other students to easily read. You may select and copy the existing text from the right and paste it below to make further edits."
     			lefthtml+="</p>"	
     			lefthtml+="<p>This journey of Thinking was created by  "+new Date()+"</p><b> </b></div>"
     			lefthtml+="<b>Questions explored:</b>"
     			lefthtml+='<div class="row" style="margin-bottom: 0px; border-bottom: solid #ccc 1px; border-top: solid #ccc 1px; background-color: #efefef;">'
     			lefthtml+='<input onclick="insertJotSummaryTag(1)" title="We wanted to understand" type="button" src="../res/problem.gif" style=" background: url(&quot;../res/problem.gif&quot;); width:29px; height: 27px;  background-size: cover;">'
     			lefthtml+='</div>'
     			lefthtml+="<div class=\"row\" ><div contenteditable='true' id='jot-summary-problem' style='max-height: 150px;overflow-y: scroll; width:100%;height: 150px; border: solid 1px #ccc;'>"+window.last_problem+"</div></div>"
     			lefthtml+="<b>Big ideas learned:</b>"
     			lefthtml+='<div class="row" style="margin-bottom: 0px; border-bottom: solid #ccc 1px; border-top: solid #ccc 1px; background-color: #efefef;">'
     			lefthtml+='<input onclick="insertJotSummaryTag(2)" title="We used to think"  type="button" src="../res/think.gif" style=" background: url(&quot;../res/think.gif&quot;); width:29px; height: 27px;  background-size: cover;">'
     			lefthtml+='<input onclick="insertJotSummaryTag(3)" title="We now understand"  type="button" src="../res/insight.gif" style=" background: url(&quot;../res/insight.gif&quot;); width:29px; height: 27px;  background-size: cover;">'
     			lefthtml+='</div>'
     			lefthtml+="<div class=\"row\"><div contenteditable='true' id='jot-summary-idea' rows='10' style='max-height: 150px;overflow-y: scroll;  width:100%;height: 24%; border: solid 1px #ccc;'>"+window.last_idea+"</div></div>"
     			lefthtml+="<div class=\"row\"><b>Deeper research needed:</b></div>"
     			lefthtml+='<div class="row" style="margin-bottom: 0px; border-bottom: solid #ccc 1px; border-top: solid #ccc 1px; background-color: #efefef;">'
     			lefthtml+='<input onclick="insertJotSummaryTag(4)" title="We need to further understand" type="button" src="../res/understand.gif" style=" background: url(&quot;../res/understand.gif&quot;); width:29px; height: 27px;  background-size: cover;">'
     			lefthtml+='<input onclick="insertJotSummaryTag(5)" title="We need better theories about" type="button" src="../res/Better%20theory.gif" style=" background: url(&quot;../res/Better%20theory.gif&quot;); width:29px; height: 27px;  background-size: cover;">'
     			lefthtml+='<input onclick="insertJotSummaryTag(6)" title="We need to read more about"  type="button" src="../res/read.gif" style=" background: url(&quot;../res/read.gif&quot;); width:29px; height: 27px;  background-size: cover;">'
     			lefthtml+='<input onclick="insertJotSummaryTag(7)" title="We need evidence about"   type="button" src="../res/evidence.gif" style=" background: url(&quot;../res/evidence.gif&quot;); width:29px; height: 27px;  background-size: cover;">'
     			lefthtml+='<input onclick="insertJotSummaryTag(8)" title="We need to look at our different ideas about"   type="button" src="../res/disagree.gif" style=" background: url(&quot;../res/disagree.gif&quot;); width:29px; height: 27px;  background-size: cover;">'
     			lefthtml+='</div>'
     			lefthtml+="<div class=\"row\"><div contenteditable='true' id='jot-summary-to-do' rows='10' style='max-height: 150px;overflow-y: scroll; width:100%;height: 24%;border: solid 1px #ccc;'>"+window.last_to_do+"</div></div>"
     			rightHtml="<div class=\"row\"><p>Existing text in this Journey of Thinking: (show the author and time info)"
     			rightHtml+="</p></div>"
     			rightHtml+="<div><b>Questions explored:</b>  </div>"
     			rightHtml+="<div style='max-height: 25%;height: 25%;overflow-y: scroll;'>"+window.all_problem+"</div>"
     			rightHtml+="<div><b>Big ideas learned:</b></div>"
     			rightHtml+="<div style='max-height: 25%; height: 25%;overflow-y: scroll;'>"+window.all_idea_textarea+"</div>"
     			rightHtml+="<div><b>Deeper research needed:</b></div>"
     			rightHtml+="<div style='max-height: 25%;height: 25%;overflow-y: scroll;'>"+window.all_to_do_textarea+"</div>"

     			html+="<div class='row' id='edit-panle' style='display:none'>"
     			html+='<div class="col s7" style="height: calc(100% - 115px);">'+lefthtml+'</div>'
     			html+='<div class="col s5" style="height: calc(100% - 115px);background-color: #efefef; margin-top: 18px;">'+rightHtml+'</div>'
     			html+='</div>'
     			
     			
				$("#jot-compile-content").html("")
				$("#jot-compile-content").append(html)
				if(typeof(callback)!="undefined"){
					callback();
				}
			}})
			
			
}

function showWordCloud(a,b,c){	
	return '<iframe src="'+window.location.protocol+'//'+window.location.host+'/ITM3/wordcloud.jsp?&'
			+'localdb='+localdb+'&token='+super_token+'&projectid='+getUrlParameter('project_id')+'&threadid='+thread_id+'" height="'+eval(window.innerHeight-150)+'" frameborder="0" width="'+eval(window.innerWidth-50)+'"></iframe>';

}



// save jot summary to db
$("#save-jot-btn").click(function(){
	var json = {
			 "database" :localdb,
			 "token" : super_token,
			 "problem":$("#jot-summary-problem").html().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
			 "tid":thread_id,
			 "summaryidea":$("#jot-summary-idea").html().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
			 "more":  $("#jot-summary-to-do").html().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
			 "authorid":id,
			 "ctime":new Date()
	 }
	
	
	if(isSupertalk){
		json = {
				 "database" :"super_talk",
				 "token" : super_token,
				 "problem":$("#jot-summary-problem").html().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
				 "tid":thread_id,
				 "summaryidea":$("#jot-summary-idea").html().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
				 "more":  $("#jot-summary-to-do").html().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
				 "authorid":id,
				 "ctime":new Date()
		 }
	}
	
	
	
	
	 $.ajax({
			url :  "/WSG/jot/summary/add",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus,jqXHR) {
				if(data.code=="success"){ // if successfully add the jot summary . 
					
					showCompiledJotSummary(showJotEdit)
				}
			}})
	
})

function compileJot(problem,idea,to_do,time,author){
	if(time!=""){
		var html ="<div class=\"row\" ><p>Using this tool to create a compiled “clean” version of the Journey of Thinking for other students to easily read. Contributors: list those who have typed in the JoT; Compiled by: list those who have edited the summary/compiled text."
			html+="</p><p>This journey of Thinking was created by  "+time+" by  "+author+"</p></div>"	
			html+="<div style=\"border-top: solid 1px #ccc;border-left: solid 1px #ccc;border-right: solid 1px #ccc;background: #eee; padding:10px;\"><b>Questions explored:</b></div>"
			html+="<div class=\"row\"    style=\"     padding: 5px 10px;  border: solid 1px #ccc;\min-height: 180px;\" >"+problem.replace(/\[([edit\]]+)\]/g,"")+"</div>"
			html+="<div  style=\"border-top: solid 1px #ccc;border-left: solid 1px #ccc;border-right: solid 1px #ccc;background: #eee; padding:10px;\"><b>Big ideas learned:</b></div>"
			html+="<div class=\"row\" style=\"     padding: 5px 10px;  border: solid 1px #ccc;min-height: 180px; \">"+idea.replace(/\[([edit\]]+)\]/g,"")+"</div>"
			html+="<div style=\"border-top: solid 1px #ccc;border-left: solid 1px #ccc;border-right: solid 1px #ccc;background: #eee; padding:10px;\"><b>Deeper research needed:</b></div>"
			html+="<div class=\"row\" style=\"     padding: 5px 10px;  border: solid 1px #ccc;   min-height: 180px;\">"+to_do.replace(/\[([edit\]]+)\]/g,"")+"</div>"
			
		return html
	}else{
		var html ="<div class=\"row\" ><p>Using this tool to create a compiled “clean” version of the Journey of Thinking for other students to easily read. Contributors: list those who have typed in the JoT; Compiled by: list those who have edited the summary/compiled text."
			html+="</p></div>"
			html+="<div style=\"border-top: solid 1px #ccc;border-left: solid 1px #ccc;border-right: solid 1px #ccc;background: #eee; padding:10px;\"><b>Questions explored:</b></div>"
			html+="<div class=\"row\"  style=\"    padding: 5px 10px;   border: solid 1px #ccc;\min-height: 180px;\" >"+problem.replace(/\[([edit\]]+)\]/g,"")+"</div>"
			html+="<div style=\"border-top: solid 1px #ccc;border-left: solid 1px #ccc;border-right: solid 1px #ccc;background: #eee; padding:10px;\"><b>Big ideas learned:</b></div>"
			html+="<div class=\"row\"  style=\"     padding: 5px 10px;  border: solid 1px #ccc;\min-height: 180px;\" >"+idea.replace(/\[([edit\]]+)\]/g,"")+"</div>"
			html+="<div  style=\"border-top: solid 1px #ccc;border-left: solid 1px #ccc;border-right: solid 1px #ccc;background: #eee; padding:10px;\"><b>Deeper research needed:</b></div>"
			html+="<div class=\"row\"  style=\"     padding: 5px 10px;  border: solid 1px #ccc;\min-height: 180px;\" >"+to_do.replace(/\[([edit\]]+)\]/g,"")+"</div>"
			
		return html
	}
	
}




		function findNoteTitle(noteId){
			
			var json = {
					 "database" :localdb,
					 "token" : super_token,
					 "noteid":nid
			 }
			
			if(isSupertalk){
				json = {
						 "database" :localdb,
						 "token" : super_token,
						 "noteid":nid
				 }
			}
			
			 $.ajax({
					url :  "/WSG/note/get/bystrid",
					type : "POST",
					data : JSON.stringify(json),
					dataType : "json",
					success : function(data, textStatus,jqXHR) {
						 if(data.code=="success"){
							findNoteAuthor(noteId)
						 }
					}})
			
		}
		
		
		websocket.onmessage = function(event) {
			var data=JSON.parse(event.data);
			database=localdb;
			if(isSupertalk){
				database ="super_talk"
			}
			if(	
					data.database==database
					&&data.thread==thread_id
					&&data.project==project_id
					&&data.uid!='<%=session.getAttribute("id")%>'
			){
				if(data.action=="refresh"){
					
					// refresh the  thread graph page
					var $toastContent = $("<span>"+data.message+"</span>").add($('<button onclick="location.reload()">Reload</button>'));
					Materialize.toast(data.message, 8000)
					return	
				}
				if(data.cate=="problem"){
						$("#problem_textarea").append(
								"<div class='tmsg' data-id="+data.id+"><label class='name'>&nbsp;"+data.username+" : "+new Date(data.create_time).Format("yyyy-MM-dd hh:mm:ss")
								+"</label><div class='tmsg_text'>"+(data.content).replace("[ We wanted to understand:]","<b>[ We wanted to understand:]</b>")+"</div></div>"
								)
								scrollToBottom($("#problem_textarea"))
						
				}
				if(data.cate=="idea"){
					$("#idea_textarea").append(
							"<div class='tmsg' data-id="+data.id+"><label class='name'>&nbsp;"+data.username+" : "+new Date(data.create_time).Format("yyyy-MM-dd hh:mm:ss")
							+"</label><div class='tmsg_text'>"+data.content.replace("[ We used to think:]","<b>[ We used to think:]</b>")
 							.replace("[ We now understand:]","<b> [ We now understand:]</b>")+"</div></div>"
							)
							scrollToBottom($("#idea_textarea"))
				}
				if(data.cate=="more"){
					$("#to_do_textarea").append(
							"<div class='tmsg' data-id="+data.id+"><label class='name'>&nbsp;"+data.username+" : "+new Date(data.create_time).Format("yyyy-MM-dd hh:mm:ss")
							+"</label><div class='tmsg_text'>"+data.content
 							.replace("[ We need to further understand ]","<b>[ We need to further understand ]</b>")
 							.replace("[ We need better theories about ]","<b>[ We need better theories about ]</b>")
 							.replace("[ We need to read more about ]","<b>[ We need evidence about ]</b>")
 							.replace("[ We need evidence about ]","<b>[ We need evidence about ]</b>")
 							.replace("[ We need to look at our different ideas about ]","<b>[ We need to look at our different ideas about ]</b>")+"</div></div>"
							)
								scrollToBottom($("#to_do_textarea"))
				}
				
				
			}
		
		
		};		
		
		
		function scrollToBottom(e){
			e.scrollTop(e[0].scrollHeight)
		}
	
	
		function sendMsg(cate,data){
				// save Jot into Database
				saveJot(cate,data)
				// websocket 
				data.cate=cate
				websocket_broadcast(data);
		}

		
		
		function websocket_broadcast(jsondata){
			$.ajax({
				url : "/ITM3/msg/broadcast",
				type:"post",
				data:JSON.stringify(jsondata),
				dataType:"json",
				contentType: 'application/json',
				success:function(data){
				}
			});
		}
		
		
		function saveJot(cate,data) {
			// SAVE  JOT
			var jsondata = {
				"database" :localdb,
				"token" : super_token,
				"threadid" :thread_id,
				"ourproblem":"",
				"createtime":new Date(),
				"authorid":id,
				"bigidea" : "",
				"more" : ""
			};
			
			if(isSupertalk){
				jsondata = {
						"database" :"super_talk",
						"token" : super_token,
						"threadid" :thread_id,
						"ourproblem":"",
						"createtime":new Date(),
						"authorid":id,
						"bigidea" : "",
						"more" : ""
					};
			}
			
			if(cate=="problem"){
				jsondata.ourproblem=data.content.replace(/'/g,"\\\'").replace(/"/g,"\\\"")
				$("#problem_textarea").append(
								"<div class='tmsg' ><label class='name'>&nbsp;"+data.username+" : "+new Date(data.create_time).Format("yyyy-MM-dd hh:mm:ss")
								+"</label><div class='tmsg_text'>"+(data.content).replace("[ We wanted to understand:]","<b>[ We wanted to understand:]</b>")+"</div></div>"
								)
								scrollToBottom($("#problem_textarea"))
			  $("#my_problem_textarea").append(
								"<div class='tmsg' ><label class='name'>&nbsp;"+data.username+" : "+new Date(data.create_time).Format("yyyy-MM-dd hh:mm:ss")
								+"</label><div class='tmsg_text'>"+(data.content).replace("[ We wanted to understand:]","<b>[ We wanted to understand:]</b>")+"</div></div>"
								)
								scrollToBottom($("#my_problem_textarea"))
								
			}
			if(cate=="idea"){
				jsondata.bigidea=data.content.replace(/'/g,"\\\'").replace(/"/g,"\\\"")
				$("#idea_textarea").append(
							"<div class='tmsg'><label class='name'>&nbsp;"+data.username+" : "+new Date(data.create_time).Format("yyyy-MM-dd hh:mm:ss")
							+"</label><div class='tmsg_text'>"+data.content.replace("[ We used to think:]","<b>[ We used to think:]</b>")
 							.replace("[ We now understand:]","<b> [ We now understand:]</b>")+"</div></div>"
							)
							scrollToBottom($("#idea_textarea"))
					$("#my_idea_textarea").append(
							"<div class='tmsg'><label class='name'>&nbsp;"+data.username+" : "+new Date(data.create_time).Format("yyyy-MM-dd hh:mm:ss")
							+"</label><div class='tmsg_text'>"+data.content.replace("[ We used to think:]","<b>[ We used to think:]</b>")
 							.replace("[ We now understand:]","<b> [ We now understand:]</b>")+"</div></div>"
							)
							scrollToBottom($("#my_idea_textarea"))
			}
			if(cate=="more"){
				jsondata.more=data.content.replace(/'/g,"\\\'").replace(/"/g,"\\\"")
					$("#to_do_textarea").append(
							"<div class='tmsg' ><label class='name'>&nbsp;"+data.username+" : "+new Date(data.create_time).Format("yyyy-MM-dd hh:mm:ss")
							+"</label><div class='tmsg_text'>"+data.content
 							.replace("[ We need to further understand ]","<b>[ We need to further understand ]</b>")
 							.replace("[ We need better theories about ]","<b>[ We need better theories about ]</b>")
 							.replace("[ We need to read more about ]","<b>[ We need evidence about ]</b>")
 							.replace("[ We need evidence about ]","<b>[ We need evidence about ]</b>")
 							.replace("[ We need to look at our different ideas about ]","<b>[ We need to look at our different ideas about ]</b>")+"</div></div>"
							)
								scrollToBottom($("#to_do_textarea"))
								
				$("#my_to_do_textarea").append(
							"<div class='tmsg' ><label class='name'>&nbsp;"+data.username+" : "+new Date(data.create_time).Format("yyyy-MM-dd hh:mm:ss")
							+"</label><div class='tmsg_text'>"+data.content
 							.replace("[ We need to further understand ]","<b>[ We need to further understand ]</b>")
 							.replace("[ We need better theories about ]","<b>[ We need better theories about ]</b>")
 							.replace("[ We need to read more about ]","<b>[ We need evidence about ]</b>")
 							.replace("[ We need evidence about ]","<b>[ We need evidence about ]</b>")
 							.replace("[ We need to look at our different ideas about ]","<b>[ We need to look at our different ideas about ]</b>")+"</div></div>"
							)
								scrollToBottom($("#my_to_do_textarea"))
			}
			
			$.ajax({
				url : "/WSG/jot/add",
				type : "POST",
				data : JSON.stringify(jsondata),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					if (data.code == "success") {
						var json = data.obj;
						if ($.trim(json) != "No data aviliable.") {
							$.notify("Journey of thinking has been updated. ","success")
						} else {
							$.notify("Error ", "warn")
						}
					}
				}
			})
		};
		

		
		
		
	
		
		
	  function initJOT(){
		var jsondata = {
				"database" :localdb,
				"token" : super_token,
				"threadid" :thread_id
		};
		if(isSupertalk){
			jsondata = {
					"database" :"super_talk",
					"token" : super_token,
					"threadid" :thread_id
			};
		}
		$.ajax({
			url : "/WSG/jot/get/bythread",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="success"){
                	 var json =data.obj;
                	 if($.trim(json)!="No data aviliable."){
                		 var d = $.parseJSON(json); 
                		 for(var i in d){
	                		 if(d[i].author ==id&&d[i].ourproblem!=""){
	            				 $("#my_problem_textarea").append(
	      								"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
	      								+"</label><div class='tmsg_text'>"+d[i].ourproblem.replace("[ We wanted to understand:]","<b>[ We wanted to understand:]</b>")
	      								+"<a class='edit_jot' onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
	      								)
	            			 }
	                		 
	                		 if(d[i].author ==id&&d[i].bigidea!=""){
	      						$("#my_idea_textarea").append(
	          							"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
	          							+"</label><div class='tmsg_text'>"+d[i].bigidea.replace("[ We used to think:]","<b>[ We used to think:]</b>")
	          							.replace("[ We now understand:]","<b> [ We now understand:]</b>")
	          							+"<a onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
	          							)
	             			 }
	                		 
	                		 
	                		 if(d[i].author ==id&&d[i].more!=""){
	      						$("#my_to_do_textarea").append(
	          							"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
	          							+"</label><div class='tmsg_text'>"+d[i].more
	          							.replace("[ We need to further understand ]","<b>[ We need to further understand ]</b>")
	          							.replace("[ We need better theories about ]","<b>[ We need better theories about ]</b>")
	          							.replace("[ We need to read more about ]","<b>[ We need evidence about ]</b>")
	          							.replace("[ We need evidence about ]","<b>[ We need evidence about ]</b>")
	          							.replace("[ We need to look at our different ideas about ]","<b>[ We need to look at our different ideas about ]</b>")
	          							.replace("[ We now understand:]","<b> [ We now understand:]</b>")
	          							+"<a onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
	          							)
	              			 }
                		 }
                		 
                		 
                		 if("<%=session.getAttribute("role")%>"=="3"){
                			 for(var i in d){
                    			 if(d[i].ourproblem!=""){
             						$("#problem_textarea").append(
             								"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
             								+"</label><div class='tmsg_text'>"+d[i].ourproblem.replace("[ We wanted to understand:]","<b>[ We wanted to understand:]</b>")
             								+"<a class='edit_jot' onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
             								)
             								
             						
             					}
                    			
                    			 
             					if(d[i].bigidea!=""){
             					$("#idea_textarea").append(
             							"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
             							+"</label><div class='tmsg_text'>"+d[i].bigidea.replace("[ We used to think:]","<b>[ We used to think:]</b>")
             							.replace("[ We now understand:]","<b> [ We now understand:]</b>")
             							+"<a onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
             							)
             					}
             					
             				
             					if(d[i].more!=""){
             					$("#to_do_textarea").append(
             							"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
             							+"</label><div class='tmsg_text'>"+d[i].more
             							.replace("[ We need to further understand ]","<b>[ We need to further understand ]</b>")
             							.replace("[ We need better theories about ]","<b>[ We need better theories about ]</b>")
             							.replace("[ We need to read more about ]","<b>[ We need evidence about ]</b>")
             							.replace("[ We need evidence about ]","<b>[ We need evidence about ]</b>")
             							.replace("[ We need to look at our different ideas about ]","<b>[ We need to look at our different ideas about ]</b>")
             							.replace("[ We now understand:]","<b> [ We now understand:]</b>")
             							+"<a onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
             							)
             					}
             					
             				
                    			 
                    		 }
                		 }else{
                			 for(var i in d){
                    			 if(d[i].ourproblem!=""){
                    				 if(d[i].author==id){
                    					 $("#problem_textarea").append(
                  								"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
                  								+"</label><div class='tmsg_text'>"+d[i].ourproblem.replace("[ We wanted to understand:]","<b>[ We wanted to understand:]</b>")
                  								+"<a class='edit_jot' onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
                  								)
                  								
                    				 }else{
                    						$("#problem_textarea").append(
                     								"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
                     								+"</label><div class='tmsg_text'>"+d[i].ourproblem.replace("[ We wanted to understand:]","<b>[ We wanted to understand:]</b>")
                     								+"</div></div>"
                     								) 
                    				 }
             					}
             					if(d[i].bigidea!=""){
             						 if(d[i].author==id){
             							 
             							$("#idea_textarea").append(
                     							"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
                     							+"</label><div class='tmsg_text'>"+d[i].bigidea.replace("[ We used to think:]","<b>[ We used to think:]</b>")
                     							.replace("[ We now understand:]","<b> [ We now understand:]</b>")
                     							+"<a onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
                     							)
             						 }else{
             							$("#idea_textarea").append(
                     							"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
                     							+"</label><div class='tmsg_text'>"+d[i].bigidea.replace("[ We used to think:]","<b>[ We used to think:]</b>")
                     							.replace("[ We now understand:]","<b> [ We now understand:]</b>")
                     							+"</div></div>"
                     							)
             						 }
             				
             					}
             					if(d[i].more!=""){
             						 if(d[i].author==id){
             							$("#to_do_textarea").append(
                     							"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
                     							+"</label><div class='tmsg_text'>"+d[i].more
                     							.replace("[ We need to further understand ]","<b>[ We need to further understand ]</b>")
                     							.replace("[ We need better theories about ]","<b>[ We need better theories about ]</b>")
                     							.replace("[ We need to read more about ]","<b>[ We need evidence about ]</b>")
                     							.replace("[ We need evidence about ]","<b>[ We need evidence about ]</b>")
                     							.replace("[ We need to look at our different ideas about ]","<b>[ We need to look at our different ideas about ]</b>")
                     							.replace("[ We now understand:]","<b> [ We now understand:]</b>")
                     							+"<a onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
                     							)
             						 }else{
             							$("#to_do_textarea").append(
                     							"<div class='tmsg' data-id="+d[i].id+"><label class='name'>&nbsp;"+d[i].username+" : "+new Date(d[i].time_stamp).Format("yyyy-MM-dd hh:mm:ss")
                     							+"</label><div class='tmsg_text'>"+d[i].more
                     							.replace("[ We need to further understand ]","<b>[ We need to further understand ]</b>")
                     							.replace("[ We need better theories about ]","<b>[ We need better theories about ]</b>")
                     							.replace("[ We need to read more about ]","<b>[ We need evidence about ]</b>")
                     							.replace("[ We need evidence about ]","<b>[ We need evidence about ]</b>")
                     							.replace("[ We need to look at our different ideas about ]","<b>[ We need to look at our different ideas about ]</b>")
                     							.replace("[ We now understand:]","<b> [ We now understand:]</b>")
                     							+"</div></div>"
                     							)
             							 
             						 }
             					
             					}
                    			 
                    			 
                    		 }
                			 
                		 }
                	
                		 
                		 scrollToBottom($("#problem_textarea"))
                		 scrollToBottom($("#idea_textarea"))
                		 scrollToBottom($("#to_do_textarea"))
                	 }
				}
			}
		})
		
		
	}
	  
	 initJOT()
	
	  
	  	
		function jotNormal(){
			$("#jot_large").show()
			$("#jot_normal").hide()
  			$("#draggableJof").css("width","50%")
  		}
		
		function jotEnlarge(){
			$("#jot_large").hide()
			$("#jot_normal").show()
			$("#draggableJof").css("width","80%")
		}
	
	  function jotEdit(element){
		  var jotId=$(element.parentElement.parentElement).data("id");
		  var cate =$(element.parentElement.parentElement.parentElement).attr("id");
		  var content=$(element.parentElement).text().replace("[edit]","")
		
		  if(cate ==="my_problem_textarea"||cate ==="problem_textarea"){
			   $("#edit-problem-id").val(jotId);
			   $("#problem_text_area_input").val(content)
			   $("#write_our_problem_modal").modal('open'); 
		  }
		  if(cate ==="my_idea_textarea"||cate ==="idea_textarea"){
			    $("#edit-idea-id").val(jotId);
			    $("#think_text_area_input").val(content)
		  		$("#write_idea_modal").modal('open');
		  }
		  if(cate ==="my_to_do_textarea"||cate ==="to_do_textarea"){
			    $("#edit-to-do-id").val(jotId);
			    $("#understand_text_area_input").val(content)
		  		$("#write_to_do_modal").modal('open');
		  }
	  }
	  
	  $('body').on('keyup', '#change_jot', function (e) {
		  
		  if(e.keyCode == 13)
			{
			  // the user click enter button
			 
			 jotUpdate(
					 $(this.parentElement.parentElement.parentElement).attr("id"),
					 $(this).data("id"),
					 $(this).val()
					)
					  $(this.parentElement).html(
 							"<div class='tmsg_text'>"+ $(this).val()
 							.replace("[ We need to further understand ]","<b>[ We need to further understand ]</b>")
 							.replace("[ We need better theories about ]","<b>[ We need better theories about ]</b>")
 							.replace("[ We need to read more about ]","<b>[ We need evidence about ]</b>")
 							.replace("[ We need evidence about ]","<b>[ We need evidence about ]</b>")
 							.replace("[ We need to look at our different ideas about ]","<b>[ We need to look at our different ideas about ]</b>")
 							.replace("[ We wanted to understand:]","<b>[ We wanted to understand:]</b>")
 							.replace("[ We used to think:]","<b>[ We used to think:]</b>")
 							+"<a onclick='jotEdit(this)' style='color: #039be5; cursor: pointer;'>&nbsp;&nbsp;[edit]</a></div></div>"
 							)
			}
		});
     
     
	  
	  function jotUpdate(cate,Jid,content){
			var jsondata={
					"database" :localdb,
					"token" : super_token,
					"mtime":new Date(),
					"editorId":id,
					"ourproblem":"",
					"bigidea":"",
					"more":"",
					"jotId":Jid
			}
			
			if(isSupertalk){
				 jsondata={
						"database" :"super_talk",
						"token" : super_token,
						"mtime":new Date(),
						"editorId":id,
						"ourproblem":"",
						"bigidea":"",
						"more":"",
						"jotId":Jid
				}
			}
		  if(cate == "problem_textarea"){
			  jsondata["ourproblem"]=content.replace(/'/g,"\\\'").replace(/"/g,"\\\"")
		  }
		 if(cate == "idea_textarea"){
			 jsondata["bigidea"]=content.replace(/'/g,"\\\'").replace(/"/g,"\\\"")
		  }
		 if(cate == "to_do_textarea"){
			 jsondata["more"]=content.replace(/'/g,"\\\'").replace(/"/g,"\\\"")
		 }
			
			$.ajax({
				url : "/WSG/jot/update",
				type : "POST",
				data : JSON.stringify(jsondata),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					
					Materialize.toast("Journey of thinking upated", 8000)
					}
				})
		 
	  }
		

		
		var jot_websocket_data ={
				'uid':id,
				'token':super_token,
				'username':urname,
				'database':localdb,
				'project' :project_id,
				'thread' :thread_id,
				'cate' : '',
				'action' : 'add',
				'create_time' : new Date(),
				'to' : 'all',
				'content' : ""
			}
		if(isSupertalk){
			jot_websocket_data ={
					'uid':id,
					'token':super_token,
					'username':urname,
					'database':localdb,
					'project' :project_id,
					'thread' :thread_id,
					'cate' : '',
					'action' : 'add',
					'create_time' : new Date(),
					'to' : 'all',
					'content' : ""
				}
		}

	$("#problem").click(
			function() {
				$("#problem_text_area_input").insertAtCaret("[ We wanted to understand:]");
			});

	$('#problem_text_area_button').click(function(e) {
		if($("#edit-problem-id").val()==""){
			jot_websocket_data.content = $("#problem_text_area_input").val().replace(/\n/g,"<br />")
			sendMsg("problem", jot_websocket_data)
			
		}else{
			var data=$("#problem_text_area_input").val().replace(/\n/g,"<br />")
			jotUpdate("problem_textarea",$("#edit-problem-id").val(),data)
			data.cate = "problem";
			websocket_broadcast(data);
			$( "div[data-id='"+$("#edit-problem-id").val()+"'] .tmsg_text" ).html($("#problem_text_area_input").val()+" <a onclick=\"jotEdit(this)\" style=\"color: #039be5; cursor: pointer;\">&nbsp;&nbsp;[edit]</a> ")

		}
		$("#edit-problem-id").val("");
		$("#problem_text_area_input").val("");
		$("#write_our_problem_modal").modal('close'); 
	});

	$("#think").click(
			function() {
				$("#think_text_area_input").insertAtCaret("[ We used to think:]");
			});

	$('#think_text_area_button').click(function(e) {
		if($("#edit-idea-id").val()==""){
			jot_websocket_data.content = $("#think_text_area_input").val().replace(/\n/g,"<br />")
			sendMsg("idea", jot_websocket_data)
		}else{
			var data=$("#think_text_area_input").val().replace(/\n/g,"<br />")
			jotUpdate("idea_textarea",$("#edit-idea-id").val(),data)
			data.cate = "idea";
			websocket_broadcast(data);
			$( "div[data-id='"+$("#edit-idea-id").val()+"'] .tmsg_text" ).html($("#think_text_area_input").val()+" <a onclick=\"jotEdit(this)\" style=\"color: #039be5; cursor: pointer;\">&nbsp;&nbsp;[edit]</a> ")
		}
		$("#edit-idea-id").val("");
		$("#think_text_area_input").val("");
		  $("#write_idea_modal").modal('close');
	});

	$("#insight").click(
			function() {
				$("#think_text_area_input").insertAtCaret("[ We now understand:]");
			});


	$("#understand").click(
			function() {
				$("#understand_text_area_input").insertAtCaret("[ We need to further understand ]");
			});

	$('#understand_text_area_button').click(function(e) {
		if($("#edit-to-do-id").val()!=""){
			var data=$("#understand_text_area_input").val().replace(/\n/g,"<br />")
			jotUpdate("to_do_textarea",$("#edit-to-do-id").val(),data)
			data.cate = "more";
			websocket_broadcast(data);
			$( "div[data-id='"+$("#edit-to-do-id").val()+"'] .tmsg_text" ).html(("#understand_text_area_input").val()+" <a onclick=\"jotEdit(this)\" style=\"color: #039be5; cursor: pointer;\">&nbsp;&nbsp;[edit]</a> ")

		}else{
			jot_websocket_data.content = $("#understand_text_area_input").val().replace(/\n/g,"<br />")
			sendMsg("more", jot_websocket_data)
		}
		$("#understand_text_area_input").val("");
		$("#edit-to-do-id").val("")
		$("#write_to_do_modal").modal('close');
	});

	$("#bettertheory").click(
			function() {
				$("#understand_text_area_input").insertAtCaret("[ We need better theories about ]");
			});



	$("#read").click(
			function() {
				$("#understand_text_area_input").insertAtCaret("[ We need to read more about ]");
			});




	$("#evidence").click(
			function() {
				$("#understand_text_area_input").insertAtCaret("[ We need evidence about ]");
			});

	$("#disagree")
			.click(
					function() {
						$("#understand_text_area_input").insertAtCaret("[ We need to look at our different ideas about ]");
					});
	
	
	function insertJotSummaryTag(index){
		if(index==1){
			$("#jot-summary-problem").append("[ We wanted to understand:]");
		}
		if(index==2){
			$("#jot-summary-idea").append("[ We used to think:]");
		}
		if(index==3){
			$("#jot-summary-idea").append("[ We now understand:]");
		}
		if(index==4){
			$("#jot-summary-to-do").append("[ We need to further understand ]");
			
		}
		if(index==5){
			$("#jot-summary-to-do").append("[ We need better theories about ]");
		}
		if(index==6){
			$("#jot-summary-to-do").append("[ We need to read more about ]");
		}
		if(index==7){
			$("#jot-summary-to-do").append("[ We need evidence about ]");
		}
		if(index==8){
			$("#jot-summary-to-do").append("[ We need to look at our different ideas about ]");
		}
	
		
	}
	


	Date.prototype.Format = function(fmt) { //author: meizz 
		var o = {
			"M+" : this.getMonth() + 1, //月份 
			"d+" : this.getDate(), //日 
			"h+" : this.getHours(), //小时 
			"m+" : this.getMinutes(), //分 
			"s+" : this.getSeconds(), //秒 
			"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
			"S" : this.getMilliseconds() //
		};
		if (/(y+)/.test(fmt))
			fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
						: (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	}
</script>

