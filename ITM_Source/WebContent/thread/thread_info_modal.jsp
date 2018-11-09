
<div id="thread_info_modal" class="modal modal-fixed-footer" style="top:0px !important; max-height: 100%;height: 100%;bottom: 0;width:100%">
	<input id ="thread_id" type="hidden">
	<div class="modal-content" style="font-size: 20px">
		<h4>Thread info</h4>
		<div class="input-field col s12" id="thread_name_edit_panel">
			<input id="thread_name" type="text" class="validate"> <label
				for="thread_name">Name/focus:</label>
		</div>
		<div class="col s12" id="thread_name_panel">
			<b>Name/focus:</b><span id="thread_name_content"></span>
		</div>
		<div class="col s12" id="keywords_edit_panel">
			<div>keywords :</div>
			<div class="col s12" >
				<div class="chips chips-placeholder" id="thread_keywords"></div>
			</div>
		</div>
		<div class="col s12" id="keywords_panel">
		</div>
		<div><b>Key resource (books/websites/videos) we may use</b></div>
		<div id="key_resource2" > 
				</div>
		<div id="key_resource3" style="padding-left:15px"> 
				</div>
		<div class="row" id="new-note-for-kf-select-view-content" >
			<b>New notes written in the thread will also be saved in Knowledge Forum.View(S) selected:</b>			
		</div>
		<div id="wf_views">
				<div class="row" id="new-note-for-kf-select-view" >
						<div class="col s12 " style="height: 30px">New notes written in the thread will also be saved in Knowledge Forum.</div>	
						<div class="col s8 " style="height: 30px">Select a Knowledge Forum view(s) for this note...  </div>	
						<div class="col s12 ">
							<iframe id="eidt_iFrame"  style="width: 100%;"></iframe>
						</div>
							
				</div>
			</div>	
			<br>
			<div class="divider"></div>
		<div id="wondering_area_edit">
		<div class="row" >
			<p>This thread contributes to the following wondering area(s):</p>
		</div>
		<div id="wondering_area"></div>
		</div>
		<div id="wondering_area_seleced"></div>
	</div>
	<div class="modal-footer">
		<span><a style="margin-left: 10px; margin-right: 16px;"
			class="modal-action modal-close waves-effect waves-green btn-flat "
			href="#!">Close</a></span>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#!"
			id="thread_del_btn"  style="margin-left: 10px;"
			class="modal-action waves-green btn-flat">Delete</a>
			
		</span>
		<span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#!"
			id="thread_edit_btn" data-mode="edit"  style="margin-left: 10px;"
			class="modal-action waves-green btn-flat">Edit</a>
			
		</span>

	</div>
</div>
<script src="/ITM3/js/tinymce/tinymce.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#eidt_iFrame").attr("src",window.location.protocol  + "//"+ window.location.host + 'ITM3/thread/viewlist.jsp')
});	
	      

$("#thread_info_modal").css("top","0px")
$(document).ready(function(){
	tinymce.init({
		 selector: '#key_resource',
	    height : "180",
	    menubar: false,
	    plugins: [
	      'advlist autolink lists link image charmap print preview hr anchor pagebreak',
	      'searchreplace wordcount visualblocks visualchars code fullscreen',
	      'insertdatetime media nonbreaking save table contextmenu directionality',
	      'template paste textcolor colorpicker textpattern imagetools codesample toc help'
	    ],
	    toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent |forecolor backcolor',
	    image_advtab: true,
	  });
	
	
	
	});

	function initEdit(content){
		tinymce.init({
		    selector: '#key_resource2',
		    height : "180",
		    menubar: false,
		    plugins: [
		      'advlist autolink lists link image charmap print preview hr anchor pagebreak',
		      'searchreplace wordcount visualblocks visualchars code fullscreen',
		      'insertdatetime media nonbreaking save table contextmenu directionality',
		      'template paste textcolor colorpicker textpattern imagetools codesample toc help'
		    ],
		    toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent |forecolor backcolor',
		    image_advtab: true,
		  });
		tinyMCE.activeEditor.setContent(content)
	}

	$("#thread_del_btn").click(function(){
		if("<%=session.getAttribute("role")%>"!="2"&&"<%=session.getAttribute("role")%>"!="3"){
			Materialize.toast('Please contact teacher to delete this thread !', 3000); 
			return
		}
		if(confirm("Are you sure you want to delete this thread?")){
			var threadInfo = {
					"database" :'<%=session.getAttribute("localdb")%>' ,
					"token" : '<%=session.getAttribute("token")%>',
					"threadid" :$("#thread_info_modal #thread_id").val(),
					"projectid" : <%=session.getAttribute("projectid")%>
			}
				$.ajax({
							url :  "/WSG/project/thread/del",
							type : "POST",
							data : JSON.stringify(threadInfo),
							dataType : "json",
							success : function(data, textStatus,jqXHR) {
								//location.reload(true);		
								delThread($("#thread_info_modal #thread_id").val())
								
								}
							})
		}
	
		
	})
	
	function delThread(id){
		// this function update thread status
		var threadInfo = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
				"tid" :id
		}
			$.ajax({
						url :  "/WSG/thread/del",
						type : "POST",
						data : JSON.stringify(threadInfo),
						dataType : "json",
						success : function(data, textStatus,jqXHR) {
							location.reload(true);		
							}
						})
		
	}
	function addThreadViewRelationship(tid){
		var checked = false;
		 var selected_views =[];
			$("#eidt_iFrame").contents().find('#new-note-select-views input:checked').each(function(){
						checked=true;
						selected_views.push($(this).attr('value'))
					})
					
					if(!checked){
						 Materialize.toast("please select a view ",3000)
						return
					}
			
			for(var i in selected_views){
				addThreadView(tid,selected_views[i]);
				location.reload(true);
			}
		
		
	}
	
	$("#thread_edit_btn").click(function(){
		if("<%=session.getAttribute("role")%>"!="2"&&"<%=session.getAttribute("role")%>"!="3"){
			Materialize.toast('Please contact teacher to edit this thread !', 3000); 
			return
		}
		
		if( $('#wondering_area input:checked').val()!="on"){
			Materialize.toast('Please select a wondering area !', 3000);
			return
		}
		if($("#thread_edit_btn").data("mode")=="edit"){
			$("#thread_info_modal .modal-content").removeAttr("style");
			$("#thread_edit_btn").html("Save")
			$("#thread_edit_btn").data("mode","save");
			
			$("#thread_info_modal .mce-tinymce").show();
			$("#thread_info_modal #key_resource3").hide();
			
			$("#wf_views").show();
			$("#new-note-for-kf-select-view-content").hide();
			
			$("#keywords_edit_panel").show();
			$("#keywords_panel").hide();
			
			$("#wondering_area_eidt").show();
			$("#wondering_area_seleced").hide();
			
			$("#thread_name_edit_panel").show();
			$("#thread_name_panel").hide();
			
			
		}else{
			var checked = false;
			 var selected_views =[];
				$("#eidt_iFrame").contents().find('#new-note-select-views input:checked').each(function(){
							checked=true;
							selected_views.push($(this).attr('value'))
						})
						
						if(!checked){
							 Materialize.toast("please select a view ",3000)
							return
						}
			
			
			//  update thread info
			var keywords = $('#thread_info_modal #thread_keywords').material_chip('data')
			var keyword = "";
			for(var i in keywords){
				keyword=keyword+keywords[i].tag+","
			}
			
			var threadInfo = {
					"database" :'<%=session.getAttribute("localdb")%>' ,
					"token" : '<%=session.getAttribute("token")%>',
					"threadid" :$("#thread_info_modal #thread_id").val(),
					"threadfocus":$("#thread_info_modal #thread_name").val().replace(/'/g,"\\\'").replace(/"/g,"\\\""),
					"authorid":'<%=session.getAttribute("id")%>',
					"mtime":new Date(),
					"resource":tinyMCE.activeEditor.getContent().replace(/'/g,"\\\'").replace(/"/g,"\\\"").replace(/\n/g, ""),
					"keywords":keyword.replace(/'/g,"\\\'").replace(/"/g,"\\\"")
			}
				$.ajax({
							url :  "/WSG/thread/update",
							type : "POST",
							data : JSON.stringify(threadInfo),
							dataType : "json",
							success : function(data, textStatus,jqXHR) {
												console.log("111")		
								}
							})
							
		  // delete thread wondering area relationship
		  $.ajax({
				url :  "/WSG/thread/wondering/del/threadid",
				type : "POST",
				data : JSON.stringify(threadInfo),
				dataType : "json",
				success : function(data, textStatus,jqXHR) {
					 // add new thread wondering area relationship
					addThreadWonderingAreaRelationship()
					}
				})
		 
		   // delete thread view  relationship
		   var threadInfo2 = {
					"database" :'<%=session.getAttribute("localdb")%>' ,
					"token" : '<%=session.getAttribute("token")%>',
					"tid" :$("#thread_info_modal #thread_id").val(),
			}
		  $.ajax({
				url :  "/WSG/thread_view/del",
				type : "POST",
				data : JSON.stringify(threadInfo2),
				dataType : "json",
				success : function(data, textStatus,jqXHR) {
					 // add new thread wondering area relationship
					addThreadViewRelationship($("#thread_info_modal #thread_id").val())
					}
				})
		 
		  
			$("#thread_edit_btn").data("mode","save");
		}
		
		
	})
	
	
	function addThreadWonderingAreaRelationship(){
		 
		 $('#wondering_area input:checked').each(function(e) {
				var wid=$(this).data("id");
				var wname=$(this).val(); 
				var thread_w_json = {
				"database" :localdb ,
				"token" : token,
				"threadid":$("#thread_info_modal #thread_id").val(),
				"areaid" : wid
				};

				$.ajax({
					url : "/WSG/thread/wondering/add",
					type : "POST",
					data : JSON.stringify(thread_w_json),
					dataType : "json",
					success : function(data, textStatus,jqXHR) {
						 // add new thread wondering area relationship
						}
				})
			})
			
			location.reload(true);		
		
	}
	
	function showThreadInfo(threadid){
		
			$("#thread_edit_btn").html("Edit")
			$("#thread_edit_btn").data("mode","edit");
			
		// hide thread view edit page. only shows words
		$("#wf_views").hide();
		$("#new-note-for-kf-select-view-content").show();
		
		
		$("#keywords_edit_panel").hide();
		$("#keywords_panel").show();
		
		$("#wondering_area_edit").hide();
		$("#wondering_area_seleced").show();
		
		$("#thread_name_edit_panel").hide();
		$("#thread_name_panel").show();
	
		// get thread info 
		threadid=$.trim(threadid)
	    $("#eidt_iFrame").attr('src',window.location.protocol+"//"+window.location.host+"/ITM3/thread/viewlist.jsp?threadid="+threadid);
		if(threadid!=""){
			$("#thread_info_modal #thread_id").val(threadid)
		}
		
		var jsondata = {
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
				"tid":threadid
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
	            		 $("#new-note-for-kf-select-view-content").empty().html("");
	            		 $("#new-note-for-kf-select-view-content").append("<p><b>New notes written in the thread will also be saved in Knowledge Forum. View(S) Selected:</b></p>");
	            		 
	            		 for(var i in d){
	            			 $("#new-note-for-kf-select-view-content").append("<p>&nbsp;&nbsp;&nbsp;&nbsp;"+d[i].title+"</p>");
	            		 }
	            	 }
				}
			}
		})
		
		
		var projectdata = { 
				"database" :'<%=session.getAttribute("localdb")%>' ,
				"token" : '<%=session.getAttribute("token")%>',
			   "threadid" :threadid
		};
		$.ajax({
			url :  "/WSG/thread/get",
			type : "POST",
			data : JSON.stringify(projectdata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				var json = $.parseJSON(data.obj);
				console.log(json);
				if (null != json) {

					$("#thread_info_modal #thread_name").val(json[0].threadfocus);
					$("#thread_info_modal #thread_name_content").html(json[0].threadfocus);
					$("#thread_info_modal #key_resource2").empty().html("");
					$("#thread_info_modal #key_resource2").append("&nbsp;&nbsp;&nbsp;&nbsp;"+json[0].resources);
					$("#thread_info_modal #key_resource3").empty().html("");
					$("#thread_info_modal #key_resource3").append("&nbsp;&nbsp;&nbsp;&nbsp;"+json[0].resources);
					initEdit(json[0].resources)
					
					$("#thread_info_modal .mce-tinymce").hide();
					$("#thread_info_modal #key_resource3").show();
					$("#thread_info_modal #key_resource3").css("pointer-events","auto");

					var words = [];
					var kword = null
					if (json[0].keywords) {
						kword = json[0].keywords.split(',')
					}
					$("#keywords_panel").empty().html();
					$("#keywords_panel").append("<b>Keywords:</b>&nbsp;&nbsp;&nbsp;&nbsp;"+kword)
					for ( var i in kword) {
						if (kword[i] != "") {
							words.push({
								tag : kword[i]
							})
							
						}

					}

					$('.chips-placeholder').material_chip({
						placeholder : 'Enter a keyword',
						secondaryPlaceholder : '+Keyword',
					});
					if (words.length != 0) {
						$('.chips-placeholder').material_chip({
							data : words
						});

					}

					$("#thread_info_modal").modal("open");
					Materialize.updateTextFields();
				}
			}
		})
		
		

		$.ajax({
			url :  "/WSG/thread/wondering_area/get",
			type : "POST",
			data : JSON.stringify(projectdata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				var json = $.parseJSON(data.obj);
				console.log(json);
				if (null != json) {
					initWondering_area_in_thread_info(json)
				}
			}
		})

	}
	
	
	function initWondering_area_in_thread_info(d){
		///wondering_area/get
		var userdata = {
			"database" : '<%=session.getAttribute("localdb")%>',
			"token" : '<%=session.getAttribute("token")%>',
			"pid" : <%=session.getAttribute("projectid")%>
		};
		$.ajax({
			url :  "/WSG/wondering_area/get/byprojectid",
			type : "POST",
			data : JSON.stringify(userdata),
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				var json = $.parseJSON(data.obj);
				if(null!=json){
					$("#thread_info_modal #wondering_area").text(" ");
					$("#wondering_area_seleced").empty().html();
					$("#wondering_area_seleced").append("<b>Wondering area(s)selected:</b>")
					for (var i = 0; i < json.length; i++) {
						if(json[i].status=="accepted"){
							var isSelected = false;
							for ( var j in d) {
									if(json[i].name==d[j].name){
										isSelected = true;
										break;
									}						
							}
							
							if(isSelected){
								var p = '<p><input type="checkbox" checked="checked"  data-id="'+json[i].id+'" id="wf_thread_info'+json[i].id+'" /><label for="wf_thread_info'+json[i].id+'">'+json[i].name+'</label></p>';
								$("#thread_info_modal #wondering_area").append(p);
								$("#wondering_area_seleced").append("<p>&nbsp;&nbsp;&nbsp;&nbsp;"+json[i].name+"</p>")
							}
							else{
								var p = '<p><input type="checkbox" data-id="'+json[i].id+'" id="wf_thread_info'+json[i].id+'" /><label for="wf_thread_info'+json[i].id+'">'+json[i].name+'</label></p>';
								$("#thread_info_modal #wondering_area").append(p);
							}
						}
						
					}
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			}
		});
	}
	
</script>