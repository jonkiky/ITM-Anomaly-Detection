<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="../css/materialize.css"
	media="screen,projection" />
	<link type="text/css" rel="stylesheet"
	href="../css/customerize.css" media="screen,projection" />
<script src="../js/d3.v3.min.js"></script>
<script src="../js/d3.tip.v0.6.3.js"></script>

<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">
<script src="../js/plotly-latest.min.js"></script>
<script src="../js/jquery-3.1.0.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/jquery.sessionTimeout.js"></script>
<script type="text/javascript" src="../js/materialize.min.js"></script>
<script src="../js/jqcloud.min.js"></script>
<link type="text/css" rel="stylesheet"  href="../css/jqcloud.min.css" media="screen,projection">
</head>
<style type="text/css">

.selected{

	background-color: #eee !important;

}
.btn, .btn-large {
    color: #000;
    background-color: #fff;
}

.btn:hover, .btn-large:hover{
    color: #000;
    background-color: #eee;
}

#keyword-list .col.s1 {
    width: 11.333333%;
    margin-left: auto;
    left: auto;
    right: auto;
    height: 31px;
}
#keyword-list .btn {
    width: 100%;
}

i.material-icons {
    position: absolute;
    margin-left: -35px;
    margin-top: 20px;
    cursor: pointer;
}

.thread-title{
	   margin-bottom: 0px;
	   border-top: solid 1px #ccc;
	   border-left: solid 1px #ccc;
	   border-right: solid 1px #ccc;
	   background: #eee; 
	   padding:10px;
}
.thread-content{
		margin-bottom: 0px;
	    padding:5px 10px;
	    border: solid 1px #ccc;
	    min-height: 180px;
}

mark {
    background: orange;
    color: inherit;
    padding: 0;
}

[type="checkbox"]:not(:checked), [type="checkbox"]:checked {
     position:relative; 
     opacity: 100; 
     left: 0px;
}
</style>
<body>



<div class="container" id="jot">
	<div  class="row">
		<div class="col s12">
			<p><b><h4>View the Journeys of Thinking from all buddy projects (including our own project)</h4></b></p>
		</div>
	</div>
	
	<div class="row">
		<div style="padding:24px;" class="col s12 card">	   
		  <div class="row">
		  		<div class="col s12">Idea threads with Journeys of Thinking: #. </div>
		  </div>
		  <div class="row">
		  	<div class="col s12">You can view based on keywords setup in thread info (select one or more): </div>
		  </div>
		  <div class="row" id="keyword-list">
		      <div class="col"  style="padding-top:4px;"  v-for="item in keywords">
		      	<a class="btn keyword_itm" data-position="bottom" :id="'keyword'+item.keyword"  v-on:click="clickKeyWord(event)"> {{ item.keyword }}</a>
		      </div>
		   </div>
	    
	    <div  class="row">
	    	<div class="col s6"></div>
			<div class="col s6">
				<div class="search-wrapper focused">
				<br><br>
	            	Or type a word to  search:<input id="searchData" placeholder="Search"><i id='startSearch' class="material-icons">search</i>
	          	</div>
	          </div>
			</div>
		</div>
    </div>
     
    
	<!-- 
	 <div class="row" >
      <div class="col s12">select thread(s) and show in the word cloud</div>
    </div>
	
	<div class="row" id="keyword-list">
      <div class="col s12" >
      	<a class="btn btn-primary pull-right" style="width:300px" v-on:click="showWordCloud">Show Word Cloud</a>
      </div>
    </div> -->
    
    
    		 			
    
    <div id="thread-list">
		 <div class="row"  v-for="p in project">
		 	<div class="col s12 thread card"  v-for="t in p.thread">
		 		<div  style=" margin-bottom: 0px;">
		 			
		 			<p class="card-title">
		 				<span>
		 				 <input  type="checkbox" name="checkbox-thread" v-bind:value="t.thread_key" />
		 						{{t.thread}}( project name :{{p.project_title}},community name : {{p.community}})
		 				</span>
		 				<span>
		 						<a class="btn btn-primary pull-right selected"  v-on:click="showWordCloud_single(t.thread_key)">
		 							<small><b>Show Word Cloud</b></small>
		 						</a>
		 				</span>
		 			</p>
			      </div>
		 	
				<div class="">
					<div class="row thread-title" >
						<b>Questions explored:</b>
					</div>
					<div class="row thread-content" >
						<li v-for="jot in getJotQuestion(t.thread_key)"  v-html="jot"> </li>
					</div>
					<div class="row thread-title" >
						<b>Big ideas learned:</b>
					</div>
					<div class="row thread-content" >
						<li v-for="jot in getJotIdea(t.thread_key)"  v-html="jot"> </li>
					</div>
					<div class="row thread-title" >
						<b>Deeper research needed:</b>
					</div>
					<div class="row thread-content" >
					<li v-for="jot in getJotMore(t.thread_key)"  v-html="jot"> </li> 
				</div>
				</div>
			</div>
		</div>
    </div>
	 

</div>

<footer  style=" position: fixed; bottom: 0px; width: 100%; background-color: #cccccc !important
">
            <div class="container">
            	<a class=" black text-lighten-4 right" href="#!" style="color:#fff">&nbsp;&nbsp;&nbsp;DownLoad All&nbsp;&nbsp;&nbsp;</a>
            	
            	<a class="black text-lighten-4 right" href="#!" style="color:#fff">&nbsp;&nbsp;&nbsp;DownLoad Selected&nbsp;&nbsp;&nbsp;</a>
            </div>
        </footer>
        

  <!-- Modal Structure -->
  <div id="modal1" class="modal modal-fixed-footer">
    <div class="modal-content">
      <div id="jot-compile-content">
      </div>
      </p>
      
    </div>
    <div class="modal-footer">
      <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
    </div>
  </div>            
<div id="editor"></div>


	<!--Import jQuery before materialize.js-->
	<script type="text/javascript" src="../js/materialize.min.js"></script>
	<script src="https://d3js.org/d3.v4.min.js"></script>
	<script src="../js/itm.js"></script>
	<script src="../js/jspdf.min.js"></script>
	<script src="../js/sigma.min.js"></script>
	<script src="../js/plugins/sigma.parsers.json.min.js"></script>
	<script src="../js/itm.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue"></script>
    <script src="../js/jquery.mark.js"></script>
	<script type="text/javascript">
        $(function() {
            var mark = function() {
                var keyword = $("#searchData").val();
                var options = { "separateWordSearch": false};

                $(".thread").unmark({
                    done: function() {
                        $(".thread").mark(keyword,options);
                    }
                });
            };
            $("#searchData").on("input", mark);
        });


        $(document).ready(function(){
	    $('.tooltipped').tooltip();
        $("#searchData").on("keyup", function() {
            app.search();
        });
	  });
        

        
        
   
        
	var app = new Vue({
	    el: '#jot',
	    data: {
	    	localdb:"<%=session.getAttribute("localdb")%>",
	    	token:"<%=session.getAttribute("token")%>",
	    	super_token:'<%=session.getAttribute("super_token")%>',
	    	community:"<%=session.getAttribute("community")%>",
	    	c_id:"<%=session.getAttribute("community_id")%>",
	    	community_id:getUrlParameter("community_id"),
	    	type:"<%=session.getAttribute("role")%>",
	    	urname:"<%=session.getAttribute("username")%>",
	    	id:"<%=session.getAttribute("id")%>",
	    	itmdb:"<%=session.getAttribute("ITMDatabase")%>",
	    	domain:"<%=session.getAttribute("domain")%>",
	    	token:"<%=session.getAttribute("token")%>",
	    	school:"<%=session.getAttribute("school")%>",
	    	country:"<%=session.getAttribute("country")%>",
	    	city:"<%=session.getAttribute("city")%>",
	    	project_id:"<%=session.getAttribute("projectid")%>",
	    	db:"itm3",
	    	project:"",
	    	// keywords:["keyword1","keyword1"]
	    	keywords:[],
	    	// tmp_keywords:[keyword] = index in words, 
	    	// it used to store tmp data. it must has a way to avoid using tmp variable .
	    	tmp_keywords:[],
	    	// thread_keyword :
	    	//	{ 	community:p.community_id,
			//	 	community_name:p.community,
			//	 	project:p.project_id,
			//	 	project_name:p.project_title,
			//	  	thread:p["keywords"][i].id,
			//	  	thread_name:p["keywords"][i].threadfocus
			//	}
	    	thread_keyword:[],
	    	// thread_jot[community_id+project_id+thread.id]=jot
	    	threads_jot:[],
	    	//threads_jot_summary:[community_id+project_id+thread.id]
	    	threads_jot_summary:[]
	    	
	    },
	    created:function(){
	    	this.getMyBuddyProject(this.getJots);
	    	 $('.modal').modal();
	    	
	    	$( document ).ajaxComplete(function() {
	    		app.$forceUpdate();
	    		
	    	});
	    },
	    methods: {
	    	clickKeyWord:function(e){
	    		$( e.target).toggleClass( "selected" );
			 	app.search();
	    	},
	    	showWordCloud_single:function(key){
	    		//key = t.thread_key
	    		var q =app.getJotQuestion(key);
	    		var i =app.getJotIdea(key);
	    		var m =app.getJotMore(key);
	    		
	    		
	    		// get selected thread ids 
	    		var content =q+" "+i+" "+m;
	    		this.wordcloud(content);
				$(".modal").modal("open")
				
				
	    	},
	    	search:function(){
	    		 var keywords = []
				 // get search keyword
				if($("#searchData").val()!=""){
					keywords.push($("#searchData").val().trim().toLowerCase())
				}
				 $("#keyword-list").find(".selected").each(function(){
					 keywords.push($(this).text().trim().toLowerCase())
				 })
				 
				 if(keywords.length!=0){
					 $(".thread").filter(function() {
						  var flag =true;
						  var thread_title =$(this).find(".card-title").text().toLowerCase();
    				  	  var thread_content=$(this).find(".thread-content").text().toLowerCase();
						 for(var i in keywords){
							 if(thread_title.indexOf(keywords[i])==-1
	    							  &&thread_content.indexOf(keywords[i])==-1){
	    						  flag = false;
	    					  }
						 }
						 
						 if(!flag){ // hide
	    				  		if($(this).is(":visible")){
	    				  			$(this).toggle()
	    				  		}
	    				  	}else{// show
	    				  		if(!$(this).is(":visible")){
	    				  			$(this).toggle()
	    				  		}
	    				  	}
					 })
				 }else{
					 
					 $(".thread").filter(function() {
							if(!$(this).is(":visible")){
	    				  			$(this).toggle()
	    				  		}
					 })
					 
				 }
	    	},
	    	getMyBuddyProject:function(callback){
	    		var json = {
						"database" :this.db,
						"token" : this.token,
						"pid":this.project_id,
						"cid":this.c_id
					};
				$.ajax({
					url :  "/WSG/my_buddy_project/get",
					type : "POST",
					data : JSON.stringify(json),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						//console.log(data);
						if(data.code=="success"){
							  if($.trim(data.desc)!=$.trim("No data aviliable.")){
								  var json = $.parseJSON(data.obj);
									  app.project=json;
									  callback();
								}else{
									console.log("does not find any buddy project");
								}
						}else{
							console.log("get my buddy project fails");
						}
						
					}
				})
	    	},
	    	getJots:function(){
	    		if(this.project!=""){
	    			for(var i in this.project){
	    				var p = this.project[i];
	    				this._getJots(p);
	    				this._getJotSummary(p);
	    				this._getKeywords(p);
	    			}
	    		}else{
	    			console.log("does not find any buddy project");
	    		}
	    	},
	    	_getKeywords:function(p){
	    		p["keywords"]=[];
	    		var json = {
						"database" :p.localdb ,
						"token" : this.super_token,
						"pid":p.project_id,
						"projectid":p.project_id
					};
				
				$.ajax({
					url :  "/WSG/thread/keywords/getbyprojectid",
					type : "POST",
					data : JSON.stringify(json),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						//console.log(data);
						if(data.code=="success"){
							  if($.trim(data.desc)!=$.trim("No data aviliable.")){
								  var json = $.parseJSON(data.obj);
								  for(var i in json){
									  if(json[i].keywords!=""){
										  var key =json[i].keywords.split(",");
										 	for(var j in key){
										 		p["keywords"].push({
										 			keywords: key[j],
										 			id: json[i].id,
													threadfocus: json[i].threadfocus
										 		})
										 	}
									  }
								  }
								  for(var i=0;i < p["keywords"].length;i++){
										  if(p["keywords"][i].keywords!=""){
											  if(typeof(app.tmp_keywords[p["keywords"][i].keywords])=="undefined"){
												  app.tmp_keywords[p["keywords"][i].keywords]= app.keywords.length;
												  app.keywords[app.keywords.length]={
														  	keyword:p["keywords"][i].keywords
												  			}
												app.thread_keyword[p["keywords"][i].keywords]=[{
													  	community:p.community_id,
													  	community_name:p.community,
													  	project:p.project_id,
													  	project_name:p.project_title,
													  	thread:p["keywords"][i].id,
													  	thread_name:p["keywords"][i].threadfocus
												  		}]
											  }else{
												  
												  app.thread_keyword[p["keywords"][i].keywords].push({
													  	community:p.community_id,
													  	community_name:p.community,
													  	project:p.project_id,
													  	project_name:p.project_title,
													  	thread:p["keywords"][i].id,
													  	thread_name:p["keywords"][i].threadfocus
												  		})
											  }
										  }
										 
									  }
								}else{
									console.log("does not find any buddy project");
									p["keywords"] = "";
								}
						}else{
							console.log("get my buddy project fails");
							p["keywords"] = "";
						}
						
					}
				})
	    		
	    	},
	    	_getJots:function(p){
	    		var json = {
						"database" :p.localdb ,
						"token" : this.super_token,
						"pid":p.project_id,
						"projectid":p.project_id
					};
				
				$.ajax({
					url :  "/WSG/project/jot/get/byprojectid",
					type : "POST",
					data : JSON.stringify(json),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						//console.log(data);
						if(data.code=="success"){
							  if($.trim(data.desc)!=$.trim("No data aviliable.")){
								  var jot = $.parseJSON(data.obj);
								  p["thread"] = [];
								  for(var i in jot){
									  if(typeof(app.threads_jot[p.community_id.toString()+p.project_id.toString()+jot[i].thread_id.toString()])=="undefined"){
										  p["thread"].push({
											  thread:jot[i].threadfocus,
											  thread_key:p.community_id.toString()+p.project_id.toString()+jot[i].thread_id.toString()
										  })
										  app.threads_jot[p.community_id.toString()+p.project_id.toString()+jot[i].thread_id.toString()]=[jot[i]];
										}else{
										  app.threads_jot[p.community_id.toString()+p.project_id.toString()+jot[i].thread_id.toString()].push(jot[i]);
										}
								  }
								}else{
									console.log("does not find any buddy project");
									p["jot"] = "";
								}
						}else{
							console.log("get my buddy project fails");
							p["jot"] = "";
						}
						
					}
				})
	    	},
	    	_getJotSummary:function(p){
	    		var json = {
						"database" :p.localdb ,
						"token" : this.super_token,
						"pid":p.project_id,
						"projectid":p.project_id
					};
				
	    		$.ajax({
					url :  "/WSG/jot/last/summary/getbyprojectid",
					type : "POST",
					data : JSON.stringify(json),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						if(data.code=="success"){
							  if($.trim(data.desc)!=$.trim("No data aviliable.")){
								  var jot = $.parseJSON(data.obj);
								  p["jot_summary"] = jot;
								  for(var i in jot){
									  if(typeof(app.threads_jot_summary[p.community_id.toString()+p.project_id.toString()+jot[i].thread_id.toString()])=="undefined"){
										  app.threads_jot_summary[p.community_id.toString()+p.project_id.toString()+jot[i].thread_id.toString()]=[jot[i]];
										}else{
										  app.threads_jot_summary[p.community_id.toString()+p.project_id.toString()+jot[i].thread_id.toString()].push(jot[i]);
										}
								  }
								}else{
									console.log("does not find any buddy project");
									p["jot_summary"] = "";
								}
						}else{
							console.log("get my buddy project fails");
							p["jot_summary"] = "";
						}
						
					}})
	    	},
	    	getJotQuestion:function(key){
	    		// find the key in jot_summary
	    		if(typeof(this.threads_jot_summary[key])=="undefined"){
	    			// this thread does no contain any jot summary
	    			if(typeof(this.threads_jot[key])=="undefined"){
		    			// this thread does no contain any jot 
		    			return ["No Information"]
		    		}else{
		    			var jots = this.threads_jot[key]
		    			var output =[]
		    			for(var i in jots ){
		    				if(jots[i].ourproblem!=""){
		    					output.push(jots[i].ourproblem)
		    				}
		    			}
		    			
		    			if(output.length ==0 ){
		    				output=["No Information"]
		    			}
		    			return output
		    		}
	    		}else{
	    			// it has summary
	    			return [
	    			        "[Journey of thinking Summary]",
	    			        this.threads_jot_summary[key][this.threads_jot_summary[key].length-1].problem
	    			        ]
	    			
	    			
	    		}
	    		
	    	},
	    	getJotIdea:function(key){
	    		
	    		if(typeof(this.threads_jot_summary[key])=="undefined"){
	    			// this thread does no contain any jot summary
	    			if(typeof(this.threads_jot[key])=="undefined"){
		    			// this thread does no contain any jot 
		    			return ["No Information"]
		    		}else{
		    			var jots = this.threads_jot[key]
		    			var output =[]
		    			for(var i in jots ){
		    				if(jots[i].bigidea!=""){
		    					output.push(jots[i].bigidea)
		    				}
		    			}
		    			
		    			if(output.length ==0 ){
		    				output=["No Information"]
		    			}
		    			return output
		    			return output
		    		}
	    		}else{
	    			// it has summary
	    			return [
	    			        "[Journey of thinking Summary]",
	    			        this.threads_jot_summary[key][this.threads_jot_summary[key].length-1].idea
	    			        ]
	    			
	    			
	    		}
	    		
	    	},
	    	getJotMore:function(key){
	    		
	    		if(typeof(this.threads_jot_summary[key])=="undefined"){
	    			// this thread does no contain any jot summary
	    			if(typeof(this.threads_jot[key])=="undefined"){
		    			// this thread does no contain any jot 
		    			return ["No Information"]
		    		}else{
		    			var jots = this.threads_jot[key]
		    			var output =[]
		    			for(var i in jots ){
		    				if(jots[i].more!=""){
		    					output.push(jots[i].more)
		    				}
		    			}
		    			if(output.length ==0 ){
		    				output=["No Information"]
		    			}
		    			return output
		    		}
	    		}else{
	    			// it has summary
	    			return [
	    			        "[Journey of thinking Summary]",
	    			        this.threads_jot_summary[key][this.threads_jot_summary[key].length-1].more
	    			        ]
	    			
	    			
	    		}
	    		
	    	},
	    	showKeywordsDetails:function(keywords,e){
	    		$('#keywords'+keywords).tooltip('methodName');
	    	},
	    	showWordCloud:function(){
	    		// get selected thread ids 
	    		var content ="";
	    		$('#thread-list input:checked').each(function(){
	    			console.log(1)
	    			var tags = /(<([^>]+)>)/ig;
	    			content =content + $(this).parent().parent().next().find(".thread-content").html().replace(tags," ");
	    		})
	    		this.wordcloud(content);
				$(".modal").modal("open")
				
	    	},
	    	saveAsPdf:function(cate){
	    		var content = ""
	    		if(cate =="1"){
	    			content=$("#thread-list").html()
	    		}
	    		
	    		if(cate =="2"){
	    			var cc = "";
	    			content=$("#thread-list").clone();
	    			for(var i=0;i<content.find("input").length;i++){
	    				if(content.find("input")[i].checked){
	    					cc=cc+$(content.children()[i]).html()
	    				}
	    			}
	    			content=cc
	    		}
	    		
	    		var specialElementHandlers = {
	    			    '#editor': function (element, renderer) {
	    			        return true;
	    			    }
	    			};
	    		
	    		
	    		var doc = new jsPDF();
			    doc.fromHTML(content, 15, 15, {
			        'width': 170,
			        'elementHandlers': specialElementHandlers
			    });
			    doc.save('cross_community_Journeys_of_Thinking_from_all_buddy_projects_'+new Date()+'.pdf');
			    
	    	},
	    	wordcloud:function(content){
	    		// strip html tag from content
	    		content=content.replace(/(<([^>]+)>)/ig,"");
	    		$("#jot-compile-content").empty().html("");
	    		var pattern = /\w+/g, string = content;

	    							var matchedWords = string.match(pattern);
	    				
	    							var counts = matchedWords.reduce(function(stats, word) {
	    								if (stats.hasOwnProperty(word)) {
	    									stats[word] = stats[word] + 1;
	    								} else {
	    									stats[word] = 1;
	    								}
	    								return stats;
	    				
	    							}, {});
	    				
	    							stopwords = ['we','want','to','understand','used','think','now','further','more',
	    							             'wanted','&nbsp','nbsp','How','Journey','Summary','thinking',
	    							             'about','need','better','read','need','theories',
	    							             'ideas','look','different','evidence','WE','We',
	    							             'a', 'about', 'above', 'across', 'after', 'afterwards', 'again',
	    									'against', 'all', 'almost', 'alone', 'along', 'already', 'also',
	    									'although', 'always', 'am', 'among', 'amongst', 'amoungst', 'amount',
	    									'an', 'and', 'another', 'any', 'anyhow', 'anyone', 'anything',
	    									'anyway', 'anywhere', 'are', 'around', 'as', 'at', 'back', 'be',
	    									'became', 'because', 'become', 'becomes', 'becoming', 'been', 'before',
	    									'beforehand', 'behind', 'being', 'below', 'beside', 'besides',
	    									'between', 'beyond', 'bill', 'both', 'bottom', 'but', 'by', 'call',
	    									'can', 'cannot', 'cant', 'co', 'computer', 'con', 'could', 'couldnt',
	    									'cry', 'de', 'describe', 'detail', 'did', 'do', 'done', 'down', 'due',
	    									'during', 'each', 'eg', 'eight', 'either', 'eleven', 'else',
	    									'elsewhere', 'empty', 'enough', 'etc', 'even', 'ever', 'every',
	    									'everyone', 'everything', 'everywhere', 'except', 'few', 'fifteen',
	    									'fifty', 'fill', 'find', 'fire', 'first', 'five', 'for', 'former',
	    									'formerly', 'forty', 'found', 'four', 'from', 'front', 'full',
	    									'further', 'get', 'give', 'go', 'had', 'has', 'hasnt', 'have', 'he',
	    									'hence', 'her', 'here', 'hereafter', 'hereby', 'herein', 'hereupon',
	    									'hers', 'herself', 'him', 'himself', 'his', 'how', 'however',
	    									'hundred', 'i', 'ie', 'if', 'in', 'inc', 'indeed', 'interest', 'into',
	    									'is', 'it', 'its', 'itself', 'keep', 'last', 'latter', 'latterly',
	    									'least', 'less', 'ltd', 'made', 'many', 'may', 'me', 'meanwhile',
	    									'might', 'mill', 'mine', 'more', 'moreover', 'most', 'mostly', 'move',
	    									'much', 'must', 'my', 'myself', 'name', 'namely', 'neither', 'never',
	    									'nevertheless', 'next', 'nine', 'no', 'nobody', 'none', 'noone', 'nor',
	    									'not', 'nothing', 'now', 'nowhere', 'of', 'off', 'often', 'on', 'once',
	    									'one', 'only', 'onto', 'or', 'other', 'others', 'otherwise', 'our',
	    									'ours', 'ourselves', 'out', 'over', 'own', 'part', 'per', 'perhaps',
	    									'please', 'put', 'rather', 're', 's', 'same', 'see', 'seem', 'seemed',
	    									'seeming', 'seems', 'serious', 'several', 'she', 'should', 'show',
	    									'side', 'since', 'sincere', 'six', 'sixty', 'so', 'some', 'somehow',
	    									'someone', 'something', 'sometime', 'sometimes', 'somewhere', 'still',
	    									'such', 'system', 'take', 'ten', 'than', 'that', 'the', 'their',
	    									'them', 'themselves', 'then', 'thence', 'there', 'thereafter',
	    									'thereby', 'therefore', 'therein', 'thereupon', 'these', 'they',
	    									'thick', 'thin', 'third', 'this', 'those', 'though', 'three', 'three',
	    									'through', 'throughout', 'thru', 'thus', 'to', 'together', 'too',
	    									'top', 'toward', 'towards', 'twelve', 'twenty', 'two', 'un', 'under',
	    									'until', 'up', 'upon', 'us', 'very', 'via', 'was', 'we', 'well',
	    									'were', 'what', 'whatever', 'when', 'whence', 'whenever', 'where',
	    									'whereafter', 'whereas', 'whereby', 'wherein', 'whereupon', 'wherever',
	    									'whether', 'which', 'while', 'whither', 'who', 'whoever', 'whole',
	    									'whom', 'whose', 'why', 'will', 'with', 'within', 'without', 'would',
	    									'yet', 'you', 'your', 'yours', 'yourself', 'yourselves', 'yes' ]
	    				
	    							/* Now that `counts` has our object, we can log it. */
	    							stopwords.forEach(function(element) {
	    								delete counts[element];
	    							});
	    							
	    				
	    							for ( var key in counts) {
	    								if (key.slice(0, -1) in counts)
	    									delete counts[key];
	    								else if (key.slice(0, -2) in counts)
	    									delete counts[key];
	    							}
	    				
	    							var ttt = [];
	    							for ( var key in counts) {
	    								// ttt.push({text: words[j], weight: parseFloat(weights[j])*100});
	    								ttt.push({
	    									text : key,
	    									weight : counts[key]
	    								});
	    							}
	    							newdiv = $('<div class="center-align"></div>').jQCloud(ttt, {
	    								  width: window.innerWidth/2,
	    								  height: window.innerHeight/2
	    								});
	    							$("#jot-compile-content").append(newdiv);
	    	}
	    	
	    }
	  });
	
	
		
		
	</script>
	
	
</body>
</html>