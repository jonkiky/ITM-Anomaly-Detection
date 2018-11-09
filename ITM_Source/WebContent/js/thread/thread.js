	
	$(".button-collapse").sideNav();
	$(".in-community").hide();
	$("#show_slide").click(function() {
		$('.button-collapse').sideNav('show');
	});
	$(".modal").modal({
		startingTop: '50%'
	});
	
	// get current community info 
		function get_community_info(call_back){
			
			if(null!=getUrlParameter("community_id")){
				var userdata = {
						"database" : "itm3",
						"token" : token,
						"cid" : community_id
					};
				$.ajax({
					url : "/WSG/community/byid",
					type : "POST",
					data : JSON.stringify(userdata),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						var json = $.parseJSON(data.obj);
						if(null!=json){
							//localdb=json[0].localdb;
							community=json[0].community_name;
						}else{
							
							console.log("do not find this community")
						}
						get_project_info(call_back)
					},
					error : function(jqXHR, textStatus, errorThrown) {
						setTimeout(function(){ 
							Materialize.toast('Invalid URL', 4000)
							 //window.history.back();
						}, 3000);
					}
				});
			}else{
				setTimeout(function(){ 
					Materialize.toast('Invalid URL', 4000)
					 //window.history.back();
				}, 3000);
			}
			
		}
		
		// get current project info
		
		function get_project_info(call_back){
			
			if(null!=project_id){
				var userdata = {
						"database" :localdb,
						"token" : token,
						"projectid" : project_id
					};
				$.ajax({
					url : "/WSG/project/get/byid",
					type : "POST",
					data : JSON.stringify(userdata),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						var json = $.parseJSON(data.obj);
						if(null!=json){
							project_name=json[0].title;
					
						}else{
									console.log("do not find this project")
						}
						call_back()
					},
					error : function(jqXHR, textStatus, errorThrown) {
						setTimeout(function(){ 
							Materialize.toast('Invalid URL', 4000)
							 //window.history.back();
						}, 3000);
					}
				});
			}else{
				setTimeout(function(){ 
					Materialize.toast('Invalid URL', 4000)
					// window.history.back();
				}, 3000);
			}
			
		}
		
		

		
		var sel = "null";
		var title="null";
		var new_data_note_id = [];
		var data_note_id;
		var date = new Date();
		var content = "";
		var reason;
		
		window.uid=id
			function initNavBar(){
			// get thread by project id
		    
			var projectdata = {
					"database" :localdb,
					"token" : token,
					"projectid" : project_id
				};
				$.ajax({
							url :  "/WSG/project/thread/get",
							type : "POST",
							data : JSON.stringify(projectdata),
							dataType : "json",
							success : function(data, textStatus,jqXHR) {
								var json = $.parseJSON(data.obj);

								if(null!=json){
									
									if(isCrossProject){
										var html2 ="<a href='../dashboard.jsp'>[CROSSPROJECT]"+community+"</a>-><a href='../project/openedit.jsp?community_id="+community_id+"&localdb="+localdb+"'>"+project_name+"</a> >"
										var html =' <div style="float:left"><select id="thread_list">'	
									
										for (var i in json) {
											// add html to copy note panel
											
											if(json[i].thread_id!=thread_id){
												html=html+'  <option value="'+json[i].thread_id+'" style="width: 400px;">'+json[i].threadfocus+'</option>'
											}else{
												 html =html+''
													    +''
													    +'<option value="" disabled selected style="width: 400px;">'+json[i].threadfocus+'</option>'
											}
										}
										    html=html+'</select></div><div style="float:left"><a href="javascript:showThreadInfo('+thread_id+')"><i class="material-icons">info</i></a></div>'
										    +' ';
										    
										    $("#page_title").html(html2);
										    $("#page_title").after(html);
									
									}else{
										
										var html2 ="<a href='../dashboard.jsp'>"+community+"</a>-><a href='../project/openedit.jsp?community_id="+community_id+"&localdb="+localdb+"'>"+project_name+"</a> >"
										var html =' <div style="float:left"><select id="thread_list">'	
										for (var i in json) {
											if(json[i].thread_id!=thread_id){
												html=html+'  <option value="'+json[i].thread_id+'" style="width: 400px;">'+json[i].threadfocus+'</option>'
											}else{
												 html =html+''
													    +''
													    +'<option value="" disabled selected style="width: 400px;">'+json[i].threadfocus+'</option>'
											}
										}
										    html=html+'</select></div><div style="float:left"><a href="javascript:showThreadInfo('+thread_id+')"><i class="material-icons">info</i></a></div>'
										    +' ';
										    
										    $("#page_title").html(html2);
										    $("#page_title").after(html)	}
									
									
								
								}
								$('select').material_select();
							},
							error : function(jqXHR, textStatus,
									errorThrown) {
								//console.log(jqXHR.responseText);
							}
						});
			
			
		}
		
		
		$('nav').on('change', 'select', function(){ 
						console.log($("nav select option:selected" ).text())
						console.log($("nav select option:selected" ).val())
						
						$.ajax({
							url : '../SET_THREAD_FOCUS',
							type : 'POST',
							data : {
								thread_id : $("nav select option:selected" ).val(),
								thread_name : $("nav select option:selected" ).text()
							},
								success : function(response) {
									window.location.href = "thread.jsp?localdb="+localdb+"&token="+token+"&community_id="+community_id+"&project_id="+project_id+"&thread_id="+$("nav select option:selected" ).val();
								}
							});
						
		});
		
				
	function storeHighlightedContent(reason){
			var jsondata = {
                    'token':token,
                    'database':localdb,
                    'noteid' : data_note_id,
                    'reason' : reason.replace("\'","\\\'").replace("\"","\\\""),
                    'content' : content.replace("\'","\\\'").replace("\"","\\\""),
                    'threadid' :thread_id, 
                    'authorid': id,
                    'ctime' : new Date()
                     }
		 $.ajax({
                url :  "/WSG/thread/note/highlight/add",
                type : "post",
                data:JSON.stringify(jsondata),
                dataType:"json",
                success : function(data, textStatus, jqXHR) {
                    var highlighted_y = $("#note_position_y").val();
                    var highlighted_x = $("#note_position_x").val();
                    
                    var highlighted_temp_trace = {
    					x : [highlighted_x],
						y : [highlighted_y],
						mode : 'markers+text',
						type : 'scatter',
						textposition : 'left',
						marker : {
							size : 13,
							color : 'red'
						},
						hoverinfo: 'none'
                    }
                    window.hasHighlighted = true;
                    Plotly.addTraces(TESTER, [highlighted_temp_trace]);
                    
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                }
            });
		}

	function checkHighlight(allContent, data_note_id){
        var getHighlightedText = {
                'token':token,
                'database':localdb,
                'noteid' : data_note_id,
                 }
        $.ajax({
            url : "/WSG/thread/note/highlight/get",
            type : "post",
            data:JSON.stringify(getHighlightedText),
            dataType:"json",
            success : function(data, textStatus, jqXHR) {
                var json = $.parseJSON(data.obj);
                var output=allContent;
                
                if(null!=json){
                for(var item = 0; item < json.length; item++){
                	cleanText = json[item].content.replace(/<\/?[^>]+(>|$)/g, "").replace(/\&nbsp;/g, '');
                if(json[item].reason == 'A “juicy” question for research'){
                        var regex = new RegExp(json[item].content,'gi');
                        output=output.replace(regex, '<span style="background-color:#fdff4a;">'+json[item].content+"</span>");
                }
                 else if(json[item].reason == 'An “Aha” insight'){
                        var regex = new RegExp(json[item].content,'gi');
                        output=output.replace(regex, '<span style="background-color:#72e567;">'+json[item].content+"</span>");
                    } 
                else if(json[item].reason == 'A seed idea to refine'){
                        var regex = new RegExp(json[item].content,'gi');
                        output=output.replace(regex, '<span style="background-color:#fdb760;">'+json[item].content+"</span>");
                    } 
                else if(json[item].reason == 'An important fact to consider'){
                          var regex = new RegExp(json[item].content,'gi');
                        output=output.replace(regex, '<span style="background-color:#a6acff;">'+json[item].content+"</span>");
                    } 
                else if(json[item].reason == 'Conflicting ideas to look into'){
                          var regex = new RegExp(json[item].content,'gi');
                        output=output.replace(regex, '<span style="background-color:#ff5b5b;">'+json[item].content+"</span>");
                    } 
                else if(json[item].reason == 'A gap of knowledge'){
                          var regex = new RegExp(json[item].content,'gi');
                        output=output.replace(regex, '<span style="background-color:#c0b1d0;">'+json[item].content+"</span>");
                    }
                else{
                    output=output;
              }
                $("#content").html(output)
                 }
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
        });
       }

	$(document).ready(function() {
				var communitydata = {
						"database" : localdb,
						"token" : token
					};
				$.ajax({
					url :  "/WSG/scaffold/get/all",
					type : "POST",
					data : JSON.stringify(communitydata),
					dataType : "json",
					success : function(data, textStatus,
							jqXHR) {
						var json = $.parseJSON(data.obj);
						//console.log(json);
						//scaffold structure: id, title, p_title
						for(e in json){
							var sf = {};
							sf.id = json[e].id;
							sf.title = json[e].title;
							if(scaffold_pkgs[json[e].p_title] == undefined){
								scaffold_pkgs[json[e].p_title] = [];
							}
							scaffold_pkgs[json[e].p_title].push(sf);
						}
						var scaffold_pkg_dom = document.getElementById("scaffold_pkg");
				   	 	var s = "";
						for(s in scaffold_pkgs){
				   	 		var opt = document.createElement("option");
				   	 		opt.setAttribute("value",s);
				   	 		opt.innerHTML = s;
				   	 		scaffold_pkg_dom.appendChild(opt);
				   	 	}
						scaffold_pkg_dom.addEventListener('click', function(e){
							e.stopPropagation();
							e.preventDefault();
				   	 	});
				   	 	scaffold_pkg_dom.addEventListener('change', function(){
				   	 		showScaffolds($(this).val());
				   	 	});
				   	 	$('#scaffold_pkg').val(s);
				   	 	showScaffolds(s);
					},
					error : function(jqXHR, textStatus,
							errorThrown) {
						//console.log(jqXHR.responseText);
					}
				});
				
				
				var projectdata = {
						"database" : localdb,
						"token" : token,
						"projectid" : project_id
					};
				
					$.ajax({
								url :  "/WSG/project/user/get",
								type : "POST",
								data : JSON.stringify(projectdata),
								dataType : "json",
								success : function(data, textStatus,
										jqXHR) {
									var json = $.parseJSON(data.obj);
									if(json!=null){
										for (var i = 0; i < json.length; i++) {
											tr = $('<div class="blk_2"/>');
											tr.append('<input type="checkbox" id="author'+json[i].str_id+'" name="user_group" value="'+json[i].str_id+'" /> <label for="author'+json[i].str_id+'">'+json[i].first_name+ ' '+json[i].last_name+'</label>');
											$('#coauthor').append(tr);
										}
									}
								
								},
								error : function(jqXHR, textStatus,
										errorThrown) {
									//console.log(jqXHR.responseText);
								}
							});
					
					var threaddata = {
							"database" : localdb,
							"token" : token,
							"threadid" : thread_id
						};
						$.ajax({
									url :  "/WSG/view/get/bythreadid",
									type : "POST",
									data : JSON.stringify(threaddata),
									dataType : "json",
									success : function(data, textStatus,
											jqXHR) {
										var json = $.parseJSON(data.obj);
										if(null!=json){
											for (var i = 0; i < json.length; i++) {
												tr = $('<div class="blk_2"/>');
												tr.append('<input type="checkbox" id="view'+json[i].view_id+'" name="view_group" value="'+json[i].view_id+'" /> <label for="view'+json[i].view_id+'">'+json[i].title+'</label>');
												$('#views').append(tr);
											}
										}
									
									},
									error : function(jqXHR, textStatus,
											errorThrown) {
										//console.log(jqXHR.responseText);
									}
								});
						
						
						
				var userdata = {
							"database" : localdb,
							"token" : token,
							"username" : current_user
					};
					$.ajax({
								url :  "/WSG/user/get/byusername",
								type : "POST",
								data : JSON.stringify(userdata),
								dataType : "json",
								success : function(data, textStatus,
										jqXHR) {
									var json = $.parseJSON(data.obj);
									//console.log(json);
									if(json == null){
										GAuthorized = false;
									}
									else{
										//console.log(json[0].refresh_token);
										GAuthorized = (json[0].refresh_token == null ? false : true);
										current_user_info = json[0];
									}
									
									//GAuthorized = true;
									if(GAuthorized){
										$('#write').attr("href","#googledoc");
									}
									else{
										$('#write').attr("onclick","show_note_write()");
									}
								},
								error : function(jqXHR, textStatus,
										errorThrown) {
									//console.log(jqXHR.responseText);
								}
							});
					
					
				$('#write_in_google').click(function(){
					//alert("go to google editor");
					var title=$('#note_title').val();
				 	if(title == '' || title.trim() == ''){
				 		$(".loading").html("Title cannot be empty.");
				 		$(".loading").css("display", "block");
				 		$(".loading").css("color", "red");
				 		return;
				 	}
				 	var coauthors = ""; 
				 	$('input[name="user_group"]:checked').each(function(){ 
				 		coauthors = coauthors + $(this).val() + ",";
				 	});
				 	if(coauthors != "") {
				 		coauthors = coauthors.substring(0, coauthors.length-1);
				 	}
				 	var views = ""; 
				 	$('input[name="view_group"]:checked').each(function(){ 
				 	  views = views + $(this).val() + ",";
				 	});
				 	if(views != "") {
				 		views = views.substring(0, views.length-1);
				 	}
				 	if(views == '' || views.trim() == ''){
				 		$(".loading").html("Please select at least one view.");
				 		$(".loading").css("display", "block");
				 		$(".loading").css("color", "red");
				 		return;
				 	}
				 	var scaffolds = "";
				 	$('input[name="scaffold_group"]:checked').each(function(){
				 		scaffolds = scaffolds + $(this).val() + ","
				 	});
				 	if(scaffolds != "") {
				 		scaffolds = scaffolds.substring(0, scaffolds.length-1);
				 	}
				 	var plain_content=$('#plain_content').val();
				 	$(".loading").html("<img src=\"../res/ajax-loader.gif\"/>Creating note .....");
				 	$(".loading").css("display", "block");
				 	$(".loading").css("color", "black");
				 	
				 	var data = {
				 			project_id: parseInt($('#projectid').text()),
			   	    	    thread_id: parseInt($('#threadid').text()),
			   	    	    username: current_user,
			   	    	    title: title,
			   	    	    coauthors:coauthors,
			   	    	    views: views,
			   	    	    scaffolds: scaffolds,
			   	    	    plain_content:plain_content.replace("\'","\\\'").replace("\"","\\\"")
			   	    };
	   	  			$.ajax({
		   	    	    type: "POST",
		   	    	    async: true,
		   	    	    url:  "https://itm.arcc.albany.edu/IIUSs/google/note/add",
		   	    	    data: data,
		   	    	    success: function(response) {
		   	    	    	if(response =='session expired'){
		   	    	    		parent.location.href = "../";
		   	    	    	}
		   	    	    	else{
		   	    	   	    	//todo... find a way to synchronized with google Drive
		   	    	   	    	var data = $.parseJSON(response.obj);
		   	    	   	  		/* $(".loading").html("note created!");
						 		$(".loading").css("display", "block");
						 		$(".loading").css("color", "green"); */
		   	    	   	    	$('#cancelWrite').trigger('click');
		   	    	   	  		currentDocid = data.docid;
	   	    	   	    		popupWindow = window.open('http://docs.google.com/document/d/'+currentDocid+'/edit',
	   	    	   	 			"_blank","directories=no, status=no, menubar=no, scrollbars=yes, resizable=no,width=850, height=500,top=100,left=300");
	   	    	   	    		setTimeout(pullDataFromGoogle, 500);
		   	    	    	}
		   	    	    },
		   	    	    error: function(response) {
		   	    	    	alert(response);
		   	    	    }
		   	    	  });
				})
				
				$('#savePlainText').click(function(){
					var title=$('#note_title').val();
				 	if(title == '' || title.trim() == ''){
				 		$(".loading").html("Title cannot be empty.");
				 		$(".loading").css("display", "block");
				 		$(".loading").css("color", "red");
				 		return;
				 	}
				 	var coauthors = ""; 
				 	$('input[name="user_group"]:checked').each(function(){ 
				 		coauthors = coauthors + $(this).val() + ",";
				 	});
				 	if(coauthors != "") {
				 		coauthors = coauthors.substring(0, coauthors.length-1);
				 	}
				 	var views = ""; 
				 	$('input[name="view_group"]:checked').each(function(){ 
				 	  views = views + $(this).val() + ",";
				 	});
				 	if(views != "") {
				 		views = views.substring(0, views.length-1);
				 	}
				 	if(views == '' || views.trim() == ''){
				 		$(".loading").html("Please select at least one view.");
				 		$(".loading").css("display", "block");
				 		$(".loading").css("color", "red");
				 		return;
				 	}
				 	var scaffolds = "";
				 	$('input[name="scaffold_group"]:checked').each(function(){
				 		scaffolds = scaffolds + $(this).val() + ","
				 	});
				 	if(scaffolds != "") {
				 		scaffolds = scaffolds.substring(0, scaffolds.length-1);
				 	}
				 	var plain_content=$('#plain_content').val();
				 	if(plain_content == '' || plain_content.trim() == ''){
				 		$(".loading").html("Note content cannot be empty.");
				 		$(".loading").css("display", "block");
				 		$(".loading").css("color", "red");
				 		return;
				 	}
				 	$(".loading").html("<img src=\"../res/ajax-loader.gif\"/>Creating note .....");
				 	$(".loading").css("display", "block");
				 	$(".loading").css("color", "black");
				 	
				 	var data = {
				 			project_id: parseInt($('#projectid').text()),
			   	    	    thread_id: parseInt($('#threadid').text()),
			   	    	    username: current_user,
			   	    	    title: title,
			   	    	    coauthors:coauthors,
			   	    	    views: views,
			   	    	    scaffolds: scaffolds,
			   	    	    plain_content:plain_content.replace("\'","\\\'").replace("\"","\\\"")
			   	    };
	   	  			$.ajax({
		   	    	    type: "POST",
		   	    	    async: true,
		   	    	    url:  "https://itm.arcc.albany.edu/IIUSs/google/note/add",
		   	    	    data: data,
		   	    	    success: function(response) {
		   	    	    	if(response =='session expired'){
		   	    	    		parent.location.href = "../";
		   	    	    	}
		   	    	    	else{
		   	    	   	    	//todo... find a way to synchronized with google Drive
		   	    	   	    	var data = $.parseJSON(response.obj);
		   	    	   	  		$(".loading").html("note created!");
						 		$(".loading").css("display", "block");
						 		$(".loading").css("color", "green");
		   	    	   	    	$('#cancelWrite').trigger('click');
		   	    	   	  		currentDocid = data.docid;
		   	    	   	  		pullDataFromGoogle();
		   	    	    	}
		   	    	    },
		   	    	    error: function(response) {
		   	    	    	alert(response);
		   	    	    }
		   	    	  });
				})
				
				$('#gotoAuthorzation').click(function(){
					$.ajax({
						url :  "https://itm.arcc.albany.edu/IIUSs/google/oAuth2/getUrl",
						type : "POST",
						data : {"username":current_user},
						dataType : "json",
						success : function(data, textStatus,
								jqXHR) {
							console.log(data);
							window.location.replace(data.obj);
						},
						error : function(jqXHR, textStatus,
								errorThrown) {
						}
					});
				})
				

				$(".modal").modal({
					startingTop: '50%'
				}); 

				$("#draggable").draggable({cancel : '.not_draggable'}).resizable(
						{
							minHeight: 500,
							minWidth: 750
						});

				var noteinfo = [
								'"My Theory" by Erika Irwin',
								'"Great theory! Why?" by Kirk Stacey',
								'"blood" by Ty Mortier, Finn Burke, Calvin Marlow',
								'"Bruises and blood journey of thinking" by Finn Burke, Calvin Marlow',
								'"Blood and Dreams" by Finn Burke',
								'"blood" by Calvin Marlow' ]

				$("#jofedit").click(function() {
					$("#draggableJof").toggle();
				});

			

				$(".edit").click(function() {
					$(".notedetail").removeClass("s12");
					$(".notedetail").addClass("s8");
					$("html, body").animate({
						scrollTop : $(document).height()
					}, "slow");
					$(".joteditpart").show();
				});

			
				$("#highlight").click(
								function() {
									if (!$(this).hasClass("showed")) {
										$("#newtest li input")
												.show();
										$("#newtest li label")
												.show();
										$(this).addClass("showed");
										$("#highlightbar")
												.append(
														'<a class="btn" id="highlightdone"><i class="material-icons left">done</i>Done</a>');
									}
								});

				$(document).on('click', '#highlightdone',
						function() {
							$("#newtest li input").hide();
							$("#newtest li label").hide();
							$("#highlight").removeClass("showed");
							$(this).remove();
						});


				$("#button-collapse-right").click(function() {
					$("html, body").animate({
						scrollTop : $(document).height()
					}, "slow");
					$("#newshow").removeClass("s12");
					$("#newshow").addClass("s6");
				});

			
				$("#Vertical").click(function() {
					window.location.href = "./detail2.jsp";
				});

			});
	
	
	

	function showScaffolds(idx){
		var scaffolds = scaffold_pkgs[idx];
		var scaffold_data = document.getElementById("scaffold");
		scaffold_data.innerHTML = "";
		if(null!=scaffolds){
			for(var m = 0; m< scaffolds.length; m++){
				var div = document.createElement("div");
				div.setAttribute("class","blk_1");
		    	var input = document.createElement("input");
			   	  input.setAttribute("type","checkbox");
			   	  input.setAttribute("id","scaffold"+scaffolds[m].id);
			   	  input.setAttribute("name","scaffold_group");
			   	  input.setAttribute("value",scaffolds[m].title);
			   	div.appendChild(input);
			   	var label = document.createElement("label");
			   	label.setAttribute("for","scaffold"+scaffolds[m].id);
			   	label.innerHTML = scaffolds[m].title;
			   	div.appendChild(label);
			   	scaffold_data.appendChild(div);	
			}
		}

	}
	
	function pullDataFromGoogle(){
		if(popupWindow && !popupWindow.closed){
			setTimeout(pullDataFromGoogle, 500);
		}
		else{
			$.ajax({
		   	    type: "POST",
		   	    async: true,
		   	    url:  "https://itm.arcc.albany.edu/IIUSs/google/note/refresh",
		   	    data: {
		   	      docid:currentDocid,
		   	      username: current_user
		   	    },
		   	    success: function(response) {
		   	    	location.reload(true);
		   	    },
		   	    error: function(response) {
		   	    	alert(response);
		   	    }
		   	  });
		}
		
	}
	
	
	
	var realdatatitle_left = [];
	var realdatatime_left = [];
	var realdataauthor_left = [];
	var realdataweight_left = [];
	var realdatatitleauthor = [];
	var realdatacontent = [];
	var realdatacontentsubstring = [];
	var realdatacontentsubstring1 = [];
	var realdataid = [];
	var realdataid1 = [];
	var realdatanoteid=[];
	var realdatanoteidandyrange = [];
	var new_data_title = [];
	var new_data_time = [];
	var new_data_author = [];
	var new_data_content = [];
	var realdatatitle_left1 = [];
	var realdatatime_left1 = [];
	var realdataweight_left1 = [];
	var realdataauthor_left1 = [];
	var realdatatitleauthor1 = [];
	var realdatacontent1 = [];
	var realdataid1 = []
	var new_data_title1 = [];
	var new_data_time1 = [];
	var new_data_author1 = [];
	var new_data_content1 = [];
	var note_read = [];
	var note_view_length = [];
	//realdatacontent.push(null);
	var temp_realdatatitle_left1 = [];
	var temp_realdatatime_left1 = [];
	var temp_realdataweight_left1 = [];
	var temp_realdatatitleauthor1 = [];
	var new_data_note_str_id=[]
	var thread_title = '';
	var stripes_colors=["#f4f4f4","#aeaeae"];
	var stripeColor = '';
	var timeforxaxisrange = [];
	var milliseconds_start_date = '';
	var milliseconds_end_date = '';
	var range_yaxis2 = [];
	var uniquerange_yaxis2 = [];
	var all_shapes=[] ;
	var all_yaxis2_traces =[];
	var data_note_str_id="";
	var realdatatitle_highlighted = [];
	var realdatatitle_highlighted1 = [];
	var realdatacreatedtime_highlighted = [];
	var timeforxaxisrange_highlighted = [];
	var realdataauthor_highlighted = [];
	var realdataauthor_highlighted1 = [];
	var realdatacontent_highlighted = [];
	var realdataweight_highlighted = [];
	var realdatanoteid_highlighted = [];
	var all_yaxis2_traces_highlighted = [];
	var highlighted_note_id = [];
	var highlighted_note_weighted_position = [];
	var title_highlighted = "";
	var showHighlight = false;
	var buildonfromtoid = [];
	var buildontonoteid = [];
	var buildonfromnoteid = [];
	var realdatanoteidtitleauthor = [];
	var realdatanoteidtitle = [];
	var realdatanoteidauthor = [];
	var realdatanoteidcontent = [];
	var buildonallids = [];
	var notebuildonfromtoid = [];
	var globalData;
	var notedid_highlightedcontent_reason = [];
	var note_id_highlighted = [];
	var realdatanoteid_compilelist=[];
	var realdatanoteid_content = [];
	var compile_Graph = false;
	var compile_graph_note_id = [];
	var json_highlighted;
	var compileHighlightChecker = false;
	var json_compile_graph_data;
	var realdatafirstname = [];
	var realdatalastname = [];
	var compile_graph_highlighted_note_id = [];
	var highlighted_only_data=null;
	
	var notecountdata = {
            "database" : localdb,
            "token" : token,
            "threadid": thread_id
      };
	var kfSupports = {};
	
      $.ajax({
        url :  "/WSG/thread/note/to_id",
        type : "POST",
        data : JSON.stringify(notecountdata),
        dataType : "json",
        success : function(data, textStatus, jqXHR) {
      	  var json = $.parseJSON(data.obj);
      	  if(json!=null){
      		  for(var m=0; m<json.length; m++){
	        		  notebuildonfromtoid.push(json[m].from_note_id+"@#$"+json[m].to_note_id);  
	        	  }  
      	  }
        },
        error : function(jqXHR, textStatus, errorThrown) {
          return null;      }
      });
	
	
	$('#showtitle').addClass('showed');
	
	
    function elemLoop(jq, func) {
        var len = jq.length;
        for (var i = 0; i < len; i++) {
            var elem = jq.get(i);
            func(elem);
        }
    }

    function createScaffoldStartTag(title) {
        var tag = '';
		tag = tag + ' <span class="kfSupportStartMark"> &nbsp; </span>';
		tag = tag + ' <span class="kfSupportStartLabel">' + title + '</span> ';
        return tag;
    };
    function createScaffoldEndTag() {
		return ' <span class="kfSupportEndMark"> &nbsp; </span> ';
    };
    var querySupports = {
			query: {type: 'supports'}
		};

		$.ajax({
			url :  kfurl + "api/links/" + community_id + '/search',
			type : "POST",
			data : JSON.stringify(querySupports),
			dataType : "json",
			headers: { 'Authorization': 'bearer ' + kftoken, 
				'Content-Type': 'application/json'},
			success : function(data) {
				data.forEach(function(note){
					kfSupports[note._id] = note;
				});
				prepareNotes();
			},
			error : function(jqXHR, textStatus,
					errorThrown) {
				console.log('Error query supports from KF6');
				prepareNotes();
			}
		});
		//prepareNotes()
	
		function prepareNotes() {
			var projectdata = {
					"database" : localdb,
					"token" :  token,
					"authorid" :  id,
					"threadid" : threadid
					
				};
			$.ajax({
			url :  "/WSG/thread/note/get",
			type : "POST",
			data : JSON.stringify(projectdata),
			dataType : "json",
			success : function(data) {
				var json = $.parseJSON(data.obj);
				globalData = $.parseJSON(data.obj);
				if(null!=json){
				
				if(json.length<20){
					var tester_height= 800
					$("#tester").height(tester_height);
				}
				else{
				var tester_height= json.length*23;
				$("#tester").height(tester_height);
				}
				
				// Json contains duplicate note info, due to the co-author. 
				// For example: if a note has two authors, it has two records. 
				// Realdate need to combine the different between two records 
				
				
				var current_note_id = null;
				
				$.each(json, function(item) {
					if (current_note_id != json[item].note_id){
						current_note_id=json[item].note_id;
						

    					realdataauthor_left.push(json[item].first_name + " "+ json[item].last_name);
    					
    					var x0=json[item].create_time;
    					var date_x0 = new Date(x0);
    					
    					realdatatime_left.push(date_x0);
    					realdatafirstname.push(json[item].first_name);
    					realdatalastname.push(json[item].last_name)
    					timeforxaxisrange.push(json[item].create_time);
    					realdataweight_left.push(parseInt(item));
    					realdatatitle_left.push(json[item].title);
    					realdatatitleauthor.push(json[item].title + " by " + json[item].first_name + " "+ json[item].last_name);
    					realdataid.push(json[item].id);
    					realdatanoteid.push(json[item].note_id);
    					realdatanoteid_compilelist.push(json[item].note_id);
    					
    					realdatanoteidandyrange.push(json[item].note_id+"@#$"+parseInt(item));
    					
    					realdatanoteidtitleauthor.push(json[item].note_id+"@#$"+json[item].title + " by " + json[item].first_name + " "+ json[item].last_name);
    					        					
    					realdatanoteidauthor.push(json[item].note_id+"@#$"+json[item].first_name + " "+ json[item].last_name);
    					realdatanoteidtitle.push(json[item].note_id+"@#$"+json[item].title);
    					
    					realdatanoteid_content.push(json[item].note_id+"@#$"+json[item].content);
    					
    					if(json[item]){
    						
    						content = json[item].content;
    					}
    					
    				
    				if(content != null){
    					cleanText = content.replace(/<\/?[^>]+(>|$)/g, "").replace(/\&nbsp;/g, '');
    					var pattern = new RegExp(/<\/?[^>]+(>|$)/g)
    					if(pattern.test(content)){
    						content=$.trim("<span>"+content+"</span>")
    						$(content).find("img").each(function( index ) {
    							content =content.replace( $(this).attr("src"), kfurl+$(this).attr("src"))
    							});
    					}

    					var doc = '<div>' + content + '</div>';
    					var jq = $(doc);
    					elemLoop(jq.find('*'), function(elem) {
    						if ($(elem).hasClass('KFSupportStart')){
    							elem.innerHTML = createScaffoldStartTag('(missing link)');
    							if (kfSupports[elem.id]) {
    								elem.innerHTML = createScaffoldStartTag(kfSupports[elem.id]._from.title);
    							}
    						} else if ($(elem).hasClass('KFSupportEnd')){
    							elem.innerHTML = createScaffoldEndTag();
    						}
    					});
    					cleanText = jq.html();
    	
    					realdatacontent.push(cleanText);
    					globalData[realdatacontent.length-1].content=cleanText
    					realdatanoteidcontent.push(json[item].note_id+"@#$"+cleanText);
    					new_data_content.push(parseInt(item)+"@#$"+cleanText);
    				}
    				
    				new_data_title.push(parseInt(item)+"@#$"+json[item].title);
    				new_data_author.push(parseInt(item)+"@#$"+json[item].first_name + " "+ json[item].last_name)
    				new_data_note_id.push(parseInt(item)+"@#$"+json[item].id);
    				new_data_note_str_id.push(parseInt(item)+"@#$"+json[item].note_id);
			}else{
							
				realdatanoteidtitleauthor[realdatanoteidtitleauthor.length-1]=
					realdatanoteidtitleauthor[realdatanoteidtitleauthor.length-1]+"," + json[item].first_name + " "+ json[item].last_name
							
					realdataauthor_left[realdataauthor_left.length-1]=
								realdataauthor_left[realdataauthor_left.length-1]+","+json[item].first_name + " "+ json[item].last_name;
							realdatanoteidauthor[realdatanoteidauthor.length-1]=
								realdatanoteidauthor[realdatanoteidauthor.length-1]+","+json[item].first_name + " "+ json[item].last_name;
							realdatatitleauthor[realdatatitleauthor.length-1]=
								realdatatitleauthor[realdatatitleauthor.length-1]+"," + json[item].first_name + " "+ json[item].last_name;
							new_data_author[new_data_author.length-1]=
								new_data_author[new_data_author.length-1]+", "+json[item].first_name + " "+ json[item].last_name;
    												
						}
				
			})
				
				var notecountdata = {
						"database" : localdb,
						"token" : token,
						"authorid": id,
						"threadid": thread_id,
				};
				$.ajax({
					url :  "/WSG/note_view_record/get",
					type : "POST",
					data : JSON.stringify(notecountdata),
					dataType : "json",
					success : function(data1, textStatus,jqXHR) {
					var json1=$.parseJSON(data1.obj);
					if(json1!=null){
						note_view_length=json1.length;
						$.each(json1, function(item) {
							realdataauthor_left1.push(json1[item].first_name + " "+ json1[item].last_name);
							
							var x0=json1[item].create_time;
							var date_x0 = new Date(x0);
							realdatatime_left1.push(date_x0);
							
							realdataid1.push(json1[item].note_id);
							realdatatitle_left1.push(json1[item].title);
							realdatatitleauthor1.push(json1[item].title + " by " + json1[item].first_name + " "+ json1[item].last_name);
							content = json1[item].content;
							
							if(content != null){
								cleanText = content.replace(/<\/?[^>]+(>|$)/g, "").replace(/\&nbsp;/g, '');
								realdatacontent.push(cleanText);
								realdatacontentsubstring1.push("Title: "+json1[item].title+" Content: "+cleanText.substring(0, 50)+" ...");
							}
							
						})
					}
					if(realdataid1.length>0){
						for(var m=0;m<realdataid1.length;m++){
							var temp_index = realdatanoteid.indexOf(realdataid1[m]);
							realdataweight_left1.push(temp_index);
						}
					}
					
					var temp_y1 = '';
					var start_date = timeforxaxisrange.sort()[0];
					 var date = new Date(start_date);
					 milliseconds_start_date = (date.getTime()); 
					 
					 var end_date = timeforxaxisrange.sort()[timeforxaxisrange.length-1]; 
					 var date1 = new Date(end_date);
					 milliseconds_end_date = (date1.getTime()); 
						
					 testing_milliseconds=((milliseconds_end_date-milliseconds_start_date)/(24*60*60*1000));
					 
					 var uniqueAuthors = [];
					 
					 $.each(realdataauthor_left, function(i, el){
					     if($.inArray(el, uniqueAuthors) === -1) uniqueAuthors.push(el);
					 });
					 for(var i=0; i<uniqueAuthors.length;i++){
						 var y0 = +realdataauthor_left.indexOf(uniqueAuthors[i])-0.5;
						 range_yaxis2.push(realdataauthor_left.indexOf(uniqueAuthors[i]));
						 var y1 = +realdataauthor_left.indexOf(uniqueAuthors[i+1])-0.5;
						 temp_y1 = +realdataauthor_left.indexOf(uniqueAuthors[i+1]);
						 if(y1==-1.5){
							 y1=realdataauthor_left.length;
						 }
						 if(temp_y1==-1){
							 temp_y1 = +realdataauthor_left.length;
						 }
						 if(temp_y1>=realdataauthor_left.length){
							 y1= +realdataauthor_left.length;
						 }
						 if(temp_y1>=realdataauthor_left.length){
							 temp_y1= +realdataauthor_left.length;
						 }
						 range_yaxis2.push(temp_y1);
						 
						 if(i % 2 == 0){
							 stripeColor = stripes_colors[0];
						 }
						 else{
							 stripeColor = stripes_colors[1];
						 }
						 var final_milliseconds_start_date;
						 var final_milliseconds_end_date;
						 
						 
						 
						 if(testing_milliseconds<5){
							 final_milliseconds_start_date = milliseconds_start_date-(0.75*24*60*60*1000);
							 final_milliseconds_end_date = milliseconds_end_date+(1*24*60*60*1000);
						 }
						 else if(testing_milliseconds>=5 || testing_milliseconds<20){
							 final_milliseconds_start_date = milliseconds_start_date-(5*24*60*60*1000);
							 final_milliseconds_end_date = milliseconds_end_date+(2*24*60*60*1000);
						 }
						 else if(testing_milliseconds>=20 || testing_milliseconds<50){
							 final_milliseconds_start_date = milliseconds_start_date-(7*24*60*60*1000);
							 final_milliseconds_end_date = milliseconds_end_date+(3*24*60*60*1000);
						 }
						 else if(testing_milliseconds>=50 || testing_milliseconds<100){
							 final_milliseconds_start_date = milliseconds_start_date-(7*24*60*60*1000);
							 final_milliseconds_end_date = milliseconds_end_date+(4*24*60*60*1000);
						 }
						 else if(testing_milliseconds>=100){
							 final_milliseconds_start_date = milliseconds_start_date-(7*24*60*60*1000);
							 final_milliseconds_end_date = milliseconds_end_date+(4.5*24*60*60*1000);
						 }
						 
						 var shape = "shape"+""+i;
						 shape = {
							type: 'rect',
						    xref: 'x',
						    yref: 'y',
						    x0: final_milliseconds_start_date,
						    x1: final_milliseconds_end_date,
						    y0: y0,
						    y1: y1,
						    fillcolor: stripeColor,
						    opacity: 0.1,
						    line: {
						    	color: "white",
						    	width: 1
						        }
						    }
						 all_shapes.push(shape);
						 
						 
						 var trace_milliseconds_end_date;
						 trace_milliseconds_end_date = milliseconds_end_date+(2.5*24*60*60*1000);
						 if(testing_milliseconds<5){
							 trace_milliseconds_end_date = milliseconds_end_date+(1*24*60*60*1000);
						 }
						 
						 var trace = "trace"+""+i;
						 trace = {
								 x: [trace_milliseconds_end_date, trace_milliseconds_end_date],
								 y: [(y0+y1)/2,y1],
								 text: [uniqueAuthors[i]], 
								 type : 'line',
								 mode: 'text',
								 textposition:'right', 
								 hoverinfo: "text",
								 textfont: {
									    color: 'rgb(148, 103, 189)',
									    size: 12										          
									 }
						    }
						 all_yaxis2_traces.push(trace); 
					 }
					 var data = [];
					
					 if(note_view_length>0){
							var trace_left = {
									x : realdatatime_left,
									y : realdataweight_left,
									text : realdatatitle_left,
									mode : 'markers+text',
									type : 'scatter',
									textposition : 'left',
									marker : {
										size : 9,
										color : 'blue'
									},
									hoverinfo: 'x+text'
								};
							var trace_author_right = {
									  x: realdatatime_left,
									  y: realdataauthor_left,
									  mode : 'none',
									  yaxis: 'y2',
									  type: 'scatter'
									};
							
							var trace_right = {
								x : realdatatime_left1,
								y : realdataweight_left1,
								mode : 'markers+text',
								type : 'scatter',
								textposition : 'left',
								marker : {
									size : 10,
									color : 'red'
								},
							hoverinfo: 'none'
							};
							var tempdata = [trace_left, trace_right]
							data=tempdata.concat(all_yaxis2_traces);
						 }
						 else{
							 var trace_left = {
										x : realdatatime_left,
										y : realdataweight_left,
										text : realdatatitle_left,
										mode : 'markers+text',
										type : 'scatter',
										textposition : 'left',
										marker : {
											size : 9,
											color : 'blue'
										},
										hoverinfo: 'x+text'
									};
							 var trace_author_right = {
									  x: realdatatime_left,
									  y: realdataauthor_left,
									  mode : 'none',
									  yaxis: 'y2',
									  type: 'scatter'
									};
							 var tempdata = [trace_left];
							 
						 }
						 
					 thread_title = "This thread includes " + realdataweight_left.length +" note(s) by "+ uniqueAuthors.length+" author(s).";
						 
					 var highlightdata = {
								"database" :localdb ,
								"token" : token,
								"threadid" : threadid
							}
							$.ajax({
								url : "/WSG/highlight/get/byauthor/bythread",
								type : "POST",
								data : JSON.stringify(highlightdata),
								dataType : "json",
								success : function(data) {
									if(data.code=="success"){
										 json_highlighted = $.parseJSON(data.obj);
										
										for(var m=0;m<json_highlighted.length;m++){
											var x0=json_highlighted[m].create_time;
											var date_x0 = new Date(x0);
											realdatacreatedtime_highlighted.push(date_x0);
											
											var temp_index = realdatanoteid.indexOf(json_highlighted[m].note_id);
											highlighted_note_weighted_position.push(temp_index);
											}
											 
											 var notes_highlighted_trace = {
													 	x : realdatacreatedtime_highlighted,
														y : highlighted_note_weighted_position,
														mode : 'markers',
														type : 'scatter',
														marker : {
															size : 13,
															color : 'red'
														},
													hoverinfo: 'none'
											 }
											all_yaxis2_traces.push(notes_highlighted_trace)
										
									}
									
									data=tempdata.concat(all_yaxis2_traces);
									window.noteData=data
									Plotly.newPlot(TESTER, data, {
										title: thread_title,
										shapes: all_shapes,
										xaxis:{
											showgrid: true,
											side: 'top',
											zeroline : true,
											zerolinecolor: 'rgb(148, 103, 189)',
											showline : true,
											tick0: 0,
											tickfont : {
												color : 'rgb(148, 103, 189)',
												size : 18
											}
										},
										yaxis : {
											showgrid: false,
											autorange : false,
											zeroline : false,
											showline : false,
											autotick : true,
											showticklabels : false,
											range: [-0.5, realdataweight_left.length]
										},
										hovermode : 'closest',
										showlegend : false
									}, {
										showLink : false,
										displayModeBar : false
									});
									

									
									
									var dragLayer = document.getElementsByClassName('nsewdrag')[0];
									
									TESTER.on('plotly_hover', function(data){
										dragLayer.style.cursor = 'pointer'
										var marker_y = data.points[0].y;
										var marker_x = data.points[0].x;
										if((buildonallids.indexOf(realdatanoteid[marker_y])!==-1 && data.points["0"].data.mode != "markers+text")){
											
											var traceIndices = [];
											
											for(var i = 0; i < TESTER.data.length; i++) {
											   if(i !== data.points[0].curveNumber && data.points["0"].data.type=="line") {
											    traceIndices.push(i);
											    
											  }
											}
											Plotly.restyle(TESTER, 'opacity', 0.1, traceIndices);
										}
								})
									
									TESTER.on('plotly_unhover', function(data){
										dragLayer.style.cursor = ''
											var update = {
											    opacity: 1
											};
										Plotly.restyle(TESTER,update);
										
									})
									
									show_buildon();
									$("#showbuildon").addClass('showed');
									$("#showbuildon").attr('checked',true);
									
									TESTER.on('plotly_click', function(data) {
										if(data.points[0].y%1==0){
											$("#draggable").css("top",window.scrollY+100);
											$("#draggable").css("right",window.innerWidth/4);
											 $("#draggable").show();
											i = data.points[0].y
											currenton = i;
											
											finalDataTitle="";
											finalDataAuthor="";
											finalDataContent="";
											finalDataNoteId="";
											finalDataThreadId="";
											finalDataNoteStrId=""
											
											for(var m=0;m<new_data_title.length;m++){
												if(new_data_title[m].split('@#$')[0]==i){
													finalDataTitle=new_data_title[m].split('@#$')[1];
												}
											}
											for(var m=0;m<new_data_author.length;m++){
												if(new_data_author[m].split('@#$')[0]==i){
													finalDataAuthor=new_data_author[m].split('@#$')[1];
												}
											}
											for(var m=0;m<new_data_content.length;m++){
												if(new_data_content[m].split('@#$')[0]==i){
													finalDataContent=new_data_content[m].split('@#$')[1];
												}
											}
											for(var m=0;m<new_data_note_id.length;m++){
												if(new_data_note_id[m].split('@#$')[0]==i){
													finalDataNoteId=new_data_note_id[m].split('@#$')[1];
												}
											}
											for(var m=0;m<new_data_note_str_id.length;m++){
												if(new_data_note_str_id[m].split('@#$')[0]==i){
													finalDataNoteStrId=new_data_note_str_id[m].split('@#$')[1];
												}
											}
											$("#title").text("\"" + finalDataTitle + "\"" + " by "+ finalDataAuthor);
											$("#content").html(finalDataContent);
											$("#note_position_y").val(data.points[0].y);
											$("#note_position_x").val(data.points[0].x);
											
											note_position = i;
											title=new_data_title[i];
											data_note_id = +finalDataNoteId;
											$("#note_open_id").val(finalDataNoteStrId);
											data_note_str_id = finalDataNoteStrId;
											checkHighlight(finalDataContent, data_note_id);
											
											noteRead(data_note_id);
											
											temp_realdatatitle_left1.push(new_data_title[i]);
											temp_realdatatime_left1.push(data.points[0].x);
											temp_realdataweight_left1.push(i);
											temp_realdatatitleauthor1.push(new_data_title[i] + " by "+ new_data_author[i])
										}
									});
									
								}
							});
						
					},
					error : function(jqXHR, textStatus,
							errorThrown) {
					}
				});
			}
				else{
					Materialize.toast("This new idea thread does not have any note yet. Click Write to create a new note. Click Import to find and add existing notes to this thread.",2000);
					}
				}

			});
		}
		

		
		var currenton = 0;

		function addThreadView(thread,view){
			var json = {
					"database" : localdb,
					"token" : token,
					"tid":thread,
					"vid":view
			}
			$.ajax({
				url : "/WSG/thread_view/add",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data,textStatus,jqXHR) {
					console.log(data)
				}
				})
				
		}
		function show_nothing() {
			TESTER.data[0].mode = 'markers';
			Plotly.redraw(TESTER);
		}

		$("#showtitle").click(function() {
			if ($(this).hasClass("showed")) {
				if ($("#showauthor").hasClass("showed")) {
					show_author();
					if ($("#showbuildon").hasClass("showed")) {
						show_buildon();
					}
				} else {

					show_nothing();
				}
				
				$(this).removeClass("showed");
			} 
			else {
				if ($("#showauthor").hasClass("showed")) {
					show_author_title();
				} else {
					show_title();
				}
				if ($("#showbuildon").hasClass("showed")) {
					show_buildon();
				}
				$(this).addClass("showed");
			}
		});
		$("#import").click(function(){
			window.location.href = "thread_import.jsp?localdb="+localdb+"&token="+token+"&c_id="+community_id+"&projectid="+project_id+"&threadid="+thread_id;
		})
		$("#showauthor").click(function() {
			if ($(this).hasClass("showed")) {
				if ($("#showtitle").hasClass("showed")) {
					show_title();
					if ($("#showbuildon").hasClass("showed")) {
						show_buildon();
					}
				} else {
					show_nothing();
				}
				
				$(this).removeClass("showed");
			} else {
				if ($("#showtitle").hasClass("showed")) {
					show_author_title();
				} else {
					show_author();
				}
				if ($("#showbuildon").hasClass("showed")) {
					show_buildon();
				}
				$(this).addClass("showed");
			}
		});

		
		 $("#highlight").click(function(e) {
			 $('#showbuildon').attr('checked', false);
			 $('#showtitle').attr('checked', false);
			 $('#showauthor').attr('checked', false);
			 $("#showbuildon").attr("disabled", true);
			 $("#showtitle").attr("disabled", true);
			 $("#showauthor").attr("disabled", true);
			 if (showHighlight) {
				 $("#showbuildon").attr("disabled", false);
				 $("#showtitle").attr("disabled", false);
				 $("#showauthor").attr("disabled", false);
				 $('#showbuildon').attr('checked', false);
				 $('#showtitle').attr('checked', true);
				 $('#showbuildon').attr('checked', true);
				 $('#showauthor').attr('checked', false);
				 $('#showtitle').addClass('showed');
				 
				 if(realdataid.length<20){
						var tester_height= 800
						$("#tester").height(tester_height);
					}
					else{
					var tester_height= realdataid.length*23;
					$("#tester").height(tester_height);
					}
					
				 
				 show_title();
				 show_buildon();
				 showHighlight = false;
			 }
			 else{
			 	show_highlight();
			 	showHighlight = true;
			 }
		}); 
		
		

		$("#showbuildon").click(function() {
							if ($(this).hasClass("showed")) { 
								if ($("#showtitle").hasClass("showed")) {
									if ($("#showauthor").hasClass("showed")) {
										show_author_title();
									}
									else{
										show_title();
									}
								}
								else if ($("#showauthor").hasClass("showed")) {
									if ($("#showtitle").hasClass("showed")) {
										show_author_title();
									}
									else{
										show_author();
									}
								}
								else{
									show_nothing();
								}
								
								
								$(this).removeClass("showed");
							}
							else{
								$(this).addClass("showed");
								show_buildon();
							
							}
						});
		
			function randomColor(){
				var letters = '0123456789ABCDEF';
				var color = '#';
				for (var i = 0; i < 6; i++) {
					color += letters[Math.floor(Math.random() * 16)];
				}
					  return color;
				}
		
	$(".btn-close").click(function() {
		$("#draggable").hide();
	});
	$(".btn-add-note-close").click(function() {
		$("#google_authorization_confirm").hide();
	});
	
	
	
	
	
	
	$("#btn-save").click(function(){
		if($("#btn-save").data("mode")=="new"){
			add()
		}
		if($("#btn-save").data("mode")=="edit"){
			update()
		}
		if($("#btn-save").data("mode")=="buildon"){
			buildon()
		}
})

	function addBuildOn(fid,tid){
		 var json = {
				 "database" :localdb ,
				 "token" : token,
				 "fromnoteid":fid,
				 "tonoteid":tid,
				 "linktype":"buildon"
		 }
		 $.ajax({
				url :  "/WSG/note_note/add",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1)
					 }
				}})
				
	}
	
	function addViewNote(nid){
		// add project teacher
		if($("#selected-views").val()!=""){
			var vids= $("#selected-views").val()
			for(var i in vids){
			var json = {
					 "database" :localdb ,
					 "token" : token,
					 "viewid":vids[i],
					 "noteid":nid
			 }
			$.ajax({
				url :  "/WSG/view_note/add",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1)
						 // co-author
						 
						
					 }
					 addCoAuthor(nid)
				}
			})
		}}else{
			addCoAuthor(nid)
			
		}
	}
	
	function add(){
		 var nid =project_id+thread_id+Math.floor((Math.random() * 10000) + 1).toString();
		 var json = {
				 "database" :localdb ,
				 "token" : token,
				 "title":$("#add_note_title").val().replace("\'","\\\'").replace("\"","\\\""),
				 "noteid":nid,
				 "content":tinyMCE.activeEditor.getContent().replace("\'","\\\'").replace("\"","\\\""),
				 "ctime":new Date(),
				 "offset":"-1"
		 }
		 $.ajax({
				url :  "/WSG/note/add",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1);
						 // view add
						 addViewNote(nid)
					 }
				}})
	}
	
	

	function update(){
		updateNote()
	}
	
	function updateNote(){
		 var json = {
				 "database" :localdb ,
				 "token" : token,
				 "title":$("#add_note_title").val().replace("\'","\\\'").replace("\"","\\\""),
				 "noteid":data_note_str_id,
				 "content":tinyMCE.activeEditor.getContent().replace("\'","\\\'").replace("\"","\\\""),
				 "mtime":new Date(),
				 "offset":"-1",
				 "reason":""
		 }
		 $.ajax({
				url :  "/WSG/note/update",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1);
						 // view add
						 updateViewNote(data_note_str_id)
					 }
				}})
	}
	
	
	function buildon(){
		var currentNoteId =$("#btn-save").data("noteid")
		 var nid =project_id+thread_id+Math.floor((Math.random() * 10000) + 1).toString()
		 var json = {
				 "database" :localdb ,
				 "token" : token,
				 "title":$("#add_note_title").val().replace("\'","\\\'").replace("\"","\\\""),
				 "noteid":nid,
				 "content":tinyMCE.activeEditor.getContent().replace("\'","\\\'").replace("\"","\\\""),
				 "ctime":new Date(),
				 "offset":"-1"
		 }
		 $.ajax({
				url :  "/WSG/note/add",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1);
						 // view add
						 addBuildOn(currentNoteId,nid)
					 }
				}})
		
	}
	
	
	
	
	function addThreadNote(nid){
		 var json = {
				 "database" :localdb ,
				 "token" : token,
				 "projectid":project_id,
				 "noteid":nid,
				 "threadid":thread_id,
				 "ctime":new Date()
		 }
		$.ajax({
			url :  "/WSG/thread/note/add",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus,
					jqXHR) {
				 if(data.code=="success"){
					 console.log(1)
					 
				 } 
				 //$.notify("A new note has been created","success")
				 
				 $("#google_authorization_confirm").modal("close");
				 
				 //location.reload(true);
			}})
	}


	function addCoAuthor(nid){
		var json = {
				 "database" :localdb ,
				 "token" : token,
				 "authorid":id,
				 "noteid":nid
		 }
		$.ajax({
			url :  "/WSG/note/author/add",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus,
					jqXHR) {
				 if(data.code=="success"){
					 console.log(1)
					 //thread note
					 
				 }
				 addThreadNote(nid)
				 
			}
		})
		
			if($("#select-user").val()!=""){
				var uids= $("#select-user").val()
				for(var i in uids){
			var json2 = {
					 "database" :localdb ,
					 "token" : token,
					 "authorid":uids[i],
					 "noteid":nid
			 }
			$.ajax({
				url :  "/WSG/note/author/add",
				type : "POST",
				data : JSON.stringify(json2),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1)
					 }
					 
				}
			})
		}}
		
	}

	function addViewNote(nid){
		// add project teacher
		if($("#selected-views").val()!=""){
			var vids= $("#selected-views").val()
			for(var i in vids){
			var json = {
					 "database" :localdb ,
					 "token" : token,
					 "viewid":vids[i],
					 "noteid":nid
			 }
			$.ajax({
				url :  "/WSG/view_note/add",
				type : "POST",
				data : JSON.stringify(json),
				dataType : "json",
				success : function(data, textStatus,
						jqXHR) {
					 if(data.code=="success"){
						 console.log(1)
						 // co-author
						 
						
					 }
					 addCoAuthor(nid)
				}
			})
		}}else{
			addCoAuthor(nid)
			
		}
	}

	tinymce.init({
	    selector: '#add_note_content',
	    height : "180",
	    theme: 'modern',
	    menu: {
	        file: {title: 'File', items: 'print'},
	        edit: {title: 'Edit', items: 'undo redo | cut copy paste pastetext | selectall'},
	        table: {title: 'Table', items: 'inserttable tableprops deletetable | cell row column'},
	      },
	    plugins: [
	      'advlist autolink lists link image charmap print preview hr anchor pagebreak',
	      'searchreplace wordcount visualblocks visualchars code fullscreen',
	      'insertdatetime media nonbreaking save table contextmenu directionality',
	      'template paste textcolor colorpicker textpattern imagetools codesample toc help'
	    ],
	    toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent |forecolor backcolor',
	    image_advtab: true,
	  });


	$(document).ready(function() {
		$(".jot_text_area").css("min-height",window.innerHeight-380+"px");
		$(".jot_text_area").css("max-height",window.innerHeight-380+"px");
			
			
		$('#button-collapse').sideNav('hide');
		$('#button-collapse').sideNav({
			menuWidth : 300, // Default is 240
			edge : 'left', // Choose the Vertical origin
			closeOnClick : true
		// Closes side-nav on <a> clicks, useful for Angular/Meteor
		});
		$('#button-collapse2').sideNav({
			menuWidth : 300, // Default is 240
			edge : 'left', // Choose the Vertical origin
			closeOnClick : true
		// Closes side-nav on <a> clicks, useful for Angular/Meteor
		});
		$('#button-collapse-right').sideNav({
			menuWidth : 500, // Default is 240
			edge : 'right', // Choose the Vertical origin
			closeOnClick : true
		// Closes side-nav on <a> clicks, useful for Angular/Meteor
		});
	});
	document.addEventListener("DOMContentLoaded", function(){
		$('.preloader-background').delay(2500).fadeOut('slow');
		$('.preloader-wrapper')
			.delay(2500)
			.fadeOut();
	});
	
	
$(document).ready(function() {
		
		var highlightdata = {
				"database" :localdb ,
				"token" : token,
				"threadid" : thread_id
			}
			$.ajax({
				url : "/WSG/highlight/get/byauthor/bythread",
				type : "POST",
				data : JSON.stringify(highlightdata),
				dataType : "json",
				success : function(data) {
					var temp_note_id_highlighted = [];
					if (data.code == "success") {
						var json = $.parseJSON(data.obj);
						for(var m=0; m<json.length;m++){
							temp_note_id_highlighted.push(json[m].note_id);
							notedid_highlightedcontent_reason.push(json[m].note_id+"@#$"+json[m].highlighted_content+"@#$"+json[m].highlight_reason);
						}
						
						$.each(temp_note_id_highlighted, function(i, el){
						     if($.inArray(el, note_id_highlighted) === -1) note_id_highlighted.push(el);
						 });
					}
				}
			});
		
		
	
	function initLevel2(){
		initNavBar()
		initUser()
		initViews()
		$('select').material_select();
	}
	function init(){
		if(isCrossProject||project_role==0){
			//hide write 
			$("#write").hide()
			//hide import
			$("#import").hide()
			// hide compile
			$(".file-field").hide()
			// hide Jot
			$("#write").hide()
			$("#thread_edit_btn").hide()
			$("#thread_del_btn").hide()
			$("#problem_text_area_input").hide()
			$("#think_text_area_input").hide()
			$("#understand_text_area_input").hide()
			$(".edit_jot").hide()
			
		}
		if(project_role!=3){
			$(".edit_jot").hide()
		}
		

		get_community_info(initLevel2)
		
		
				
	}
	init()

	})
	

	function initViews(){
		$("#iFrame").attr("src","viewlist.jsp?id="+Math.floor(Math.random() * 11))
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
		}
	}
	function initKFViews(){
		var jsondata = {
				community_id :community_id ,
				thread_id: thread_id
		};
		$.ajax({
			url :  "https://itm.arcc.albany.edu/IIUSs/thread/view/get",
			type : "POST",
			data : JSON.stringify(jsondata),
			dataType:"json",
			contentType: "application/json",
			success : function(data, textStatus, jqXHR) {
				if(data.code=="success"){
                	 var json =data.obj;
                	 initTable(json)
				}
			}
		})
	}
	
	
	function initUser(){
			var d =JSON.parse(localStorage.users);
       		  for( var i in d){
					   $("#select-user").append(
					   $("<option id='user_"+d[i].str_id+"'></option>")
				        .attr("value",d[i].str_id)
				        .text(d[i].first_name+"　"+d[i].last_name)
				        )
				   }
				   $("#select-user").trigger('contentChanged');
       	 }
	
	  $('select').on('contentChanged', function() {
					 $(this).material_select();
			});
	  
	  
	 
		
	  
		$(".jofsave").click(function() {
			$("#draggableJof").hide();
			// SAVE  JOT
			var jsondata = {
				"database" :localdb ,
				"token" : token,
				"threadid" : thread_id,
				"ourproblem":$("#problem_textarea").val().replace("\'","\\\'").replace("\"","\\\""),
				"createtime":new Date(),
				"authorid":id,
				"bigidea" : $("#idea_textarea").val().replace("\'","\\\'").replace("\"","\\\""),
				"more" : $("#to_do_textarea").val().replace("\'","\\\'").replace("\"","\\\"")
			};
			$.ajax({
				url :  "/WSG/jot/add",
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
		});
	
		$("#google_authorization_confirm").draggable({cancel : '.not_draggable'});
						
		 $(document).on('change', '.file-field input[type="file"]', function () {
		      var file_field = $(this).closest('.file-field');
		      var path_input = file_field.find('input.file-path');
		      var files      = $(this)[0].files;
		      var file_names = [];
		      for (var i = 0; i < files.length; i++) {
		        file_names.push(files[i].name);
		      }
		      path_input.val(file_names.join(", "));
		      path_input.trigger('change');
		      uploadFile(files)
		 });
		 
		 function uploadFile(files){
			 var fd = new FormData();
			 fd.append('uploadFile',files[0])
				  $.ajax({
				    type: 'post',
				    url: 'https://itm.arcc.albany.edu/IFSs/uploadFile',
				    data: fd,
	                processData: false,
	                cache: false,
	                contentType:false,
				    success: function (data) {
				     console.log(data);
				      var json = "https://itm.arcc.albany.edu/IFSs/resources/data/"+$.trim((data.obj).split("@")[2]);
				      addAttachementIntoThread(json)
				    }
				  });
		 }
		 
		 
		 function addAttachementIntoThread(data){
			 
			 var jsondata = {
						"database" :localdb ,
						"token" : token,
						"tid" : thread_id,
						"filePath":data,
						"ctime":new Date()
					};
			 
				
				$.ajax({
					url :  "/WSG/thread/attachment/add",
					type : "POST",
					data : JSON.stringify(jsondata),
					dataType : "json",
					success : function(data, textStatus,
							jqXHR) {
						if (data.code == "success") {
							var json = data.obj;
							if ($.trim(json) != "No data aviliable.") {
								$.notify("Attachment has be uploaded. ","success")
							} else {
								$.notify("Error ", "warn")
							}
						}
					}
				})
		 }
		 function compile_list_highlight_check(note_content, noteid){
				
			 var output = note_content;
			 var content = "";
			 
			 for(var n=0; n<notedid_highlightedcontent_reason.length;n++){
				 if(notedid_highlightedcontent_reason[n].split("@#$")[0] == noteid){
				 var reason = notedid_highlightedcontent_reason[n].split("@#$")[2];
				 content = notedid_highlightedcontent_reason[n].split("@#$")[1];
				 if(reason == 'A “juicy” question for research'){
		                 var regex = new RegExp(content,'gi');
		                 output=output.replace(regex, '<span style="background-color:#fdff4a;">'+content+"</span>");
		         }
		          else if(reason == 'An “Aha” insight'){
		                 var regex = new RegExp(content,'gi');
		                 output=output.replace(regex, '<span style="background-color:#72e567;">'+content+"</span>");
		             } 
		         else if(reason == 'A seed idea to refine'){
		                 var regex = new RegExp(content,'gi');
		                 output=output.replace(regex, '<span style="background-color:#fdb760;">'+content+"</span>");
		             } 
		         else if(reason == 'An important fact to consider'){
		                   var regex = new RegExp(content,'gi');
		                 output=output.replace(regex, '<span style="background-color:#a6acff;">'+content+"</span>");
		             } 
		         else if(reason == 'Conflicting ideas to look into'){
		                   var regex = new RegExp(content,'gi');
		                 output=output.replace(regex, '<span style="background-color:#ff5b5b;">'+content+"</span>");
		             } 
		         else if(reason == 'A gap of knowledge'){
		                   var regex = new RegExp(content,'gi');
		                 output=output.replace(regex, '<span style="background-color:#c0b1d0;">'+content+"</span>");
		             }
		         else{
		             output=output;
		       }
					 
				 }
			 }
			 return output;
		 
			 
		 }
		 
		
		
			$("#compileAll").click(function () {
				$("#sort_by_btn").removeAttr("disabled");
				compile_Graph = false;
				compileHighlightChecker = false;
	            $("#compileboxContent").empty();
	            
	            for (var i = 0; i < realdatatitle_left.length; i++) {
	            	var note_content = realdatacontent[i];
	            	
	            	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(realdatanoteid[i]) > -1) {
	            		note_content = compile_list_highlight_check(note_content,realdatanoteid[i]);
	            	}
	            	
	            	$("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+realdatanoteid[i]+'\')">' + realdatatitle_left[i] + '" by ' + realdataauthor_left[i] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
	                	if(notebuildonfromtoid.length>0){
	                		find_build_on(realdatanoteid[i],1,realdatanoteid,realdatacontent,realdatatitle_left,realdataauthor_left)
	                	}
	               
	            }
	        });
			
			function find_build_on(nodeid,level,idlist,content,title,author){
				for(var m=0;m<notebuildonfromtoid.length;m++){
        			if(nodeid==notebuildonfromtoid[m].split("@#$")[0]){
        				var temp_index = idlist.indexOf(notebuildonfromtoid[m].split("@#$")[1]);
        				if(temp_index>=0){
        					var buildon_note_content = content[temp_index];
        	            	
        	            	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(notebuildonfromtoid[m].split("@#$")[1]) > -1) {
        	            		buildon_note_content = compile_list_highlight_check(content[temp_index],notebuildonfromtoid[m].split("@#$")[1]);
        	            	}
        	            	var t = 30*level
        					$("#compileboxContent").append('<div style="width:100%;"><div style="margin-left:'+t+'px; background-color:#e8e8fd" class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+notebuildonfromtoid[m].split("@#$")[1]+'\')">' + title[temp_index] + '" by ' + author[temp_index] + '</a></b></span><p style="font-size:15px;">' + buildon_note_content + '</p></div></div></div>');
        					level=level+1
        					if(level>=10){
        						level =10;
        					}
        					find_build_on(notebuildonfromtoid[m].split("@#$")[1],level,idlist,content,title,author)
        				}
        			}
        		
        		}
			}
		
		
			$("#timeorder").click(function () {
				if(compileHighlightChecker){
					$("#compileboxContent").empty();
					$("#compileboxContent").append('<div class="row" style="margin:10px"><span style="background:#fdff4a;font-size:14px">A “juicy” question for research</span> | <span style="background:#72e567;font-size:14px">An “Aha” insight</span> | <span style="background:#fdb760;font-size:14px">A seed idea to refine</span> | <span style="background:#a6acff;font-size:14px">An important fact to consider</span> | <span style="background:#ff5b5b;;font-size:14px">Conflicting ideas to look into</span> | <span style="background:#c0b1d0;;font-size:14px">A gap of knowledge</span></div>');
					
					var realdatatitle_left_sorted = [];
		            var realdataauthor_left_sorted = [];
		            var realdatacontent_sorted = [];
		            var realdatanoteid_sorted = [];
		   			
					
					 highlighted_only_data.sort(function(a,b) {
						    if ( a.create_time > b.create_time )
						        return -1;
						    if ( a.create_time < b.create_time )
						        return 1;
						    return 0;
						});
						
						$.each(highlighted_only_data, function(item) {
			            	
			            	realdatatitle_left_sorted.push(realdatacontent[item].title);
			            	realdataauthor_left_sorted.push(highlighted_only_data[item].first_name + " "+ json_highlighted[item].last_name);
			            	realdatacontent_sorted.push(highlighted_only_data[item].content);
			            	realdatanoteid_sorted.push(highlighted_only_data[item].note_id);
			            	
			            });
					
					for (var i = 0; i < realdatanoteid_sorted.length; i++) {
						var note_content = compile_list_highlight_check(realdatacontent_sorted[i],realdatanoteid_sorted[i]);
		            	
		            	
		                $("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+realdatanoteid_sorted[i]+'\')">' + realdatatitle_left_sorted[i] + '" by ' + realdataauthor_left_sorted[i] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
		                	if(notebuildonfromtoid.length>0){
		                		find_build_on(realdatanoteid_sorted[i],1,realdatanoteid_sorted,realdatacontent_sorted,realdatatitle_left_sorted,realdataauthor_left_sorted)
		                	} 
		               
		            }	
					
				}
				else if(compile_Graph){
					$("#compileboxContent").empty();
					 
					 
					var realdatatitle_left_sorted = [];
		            var realdataauthor_left_sorted = [];
		            var realdatacontent_sorted = [];
		            var realdatanoteid_sorted = [];
		            
		           
		            
		            json_compile_graph_data.sort(function(a,b) {
					    if ( a.create_time > b.create_time )
					        return -1;
					    if ( a.create_time < b.create_time )
					        return 1;
					    return 0;
					});
					
					$.each(json_compile_graph_data, function(item) {
		            	
		            	realdatatitle_left_sorted.push(json_compile_graph_data[item].title);
		            	realdataauthor_left_sorted.push(json_compile_graph_data[item].first_name +" "+json_compile_graph_data[item].last_name);
		            	realdatacontent_sorted.push(json_compile_graph_data[item].content);
		            	realdatanoteid_sorted.push(json_compile_graph_data[item].note_id);
		            	
		            });
					
					for (var i = 0; i < realdatatitle_left_sorted.length; i++) {
						var note_content = realdatacontent_sorted[i];
		            	
		            	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(realdatanoteid_sorted[i]) > -1) {
		            		note_content = compile_list_highlight_check(note_content,realdatanoteid_sorted[i]);
		            	}
		                $("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+realdatanoteid_sorted[i]+'\')">' + realdatatitle_left_sorted[i] + '" by ' + realdataauthor_left_sorted[i] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
		                	if(notebuildonfromtoid.length>0){
		                		find_build_on(realdatanoteid_sorted[i],1,realdatanoteid_sorted,realdatacontent_sorted,realdatatitle_left_sorted,realdataauthor_left_sorted)
		                	}
		               
		            }	
					
			         
				}else{
					$("#compileboxContent").empty();
		            
		            var realdatatitle_left_sorted = [];
		            var realdataauthor_left_sorted = [];
		            var realdatacontent_sorted = [];
		            var realdatanoteid_sorted = [];
		            

		            globalData.sort(function(a,b) {
					    if ( a.create_time > b.create_time )
					        return -1;
					    if ( a.create_time < b.create_time )
					        return 1;
					    return 0;
					});
		            
		            
		            $.each(globalData, function(item) {
		            	
		            	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(realdatanoteid[i]) > -1) {
		            		note_content = compile_list_highlight_check(note_content,realdatanoteid[i]);
		            	}
		            	
		            	realdatatitle_left_sorted.push(globalData[item].title);
		            	realdataauthor_left_sorted.push(globalData[item].first_name + " "+ globalData[item].last_name);
		            	realdatacontent_sorted.push(globalData[item].content);
		            	realdatanoteid_sorted.push(globalData[item].note_id);
		            	
		            });
		            
		            
		            for (var i = 0; i < realdatatitle_left_sorted.length; i++) {
						var note_content = realdatacontent_sorted[i];
		            	
		            	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(realdatanoteid_sorted[i]) > -1) {
		            		note_content = compile_list_highlight_check(note_content,realdatanoteid_sorted[i]);
		            	}
		                $("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+realdatanoteid_sorted[i]+'\')">' + realdatatitle_left_sorted[i] + '" by ' + realdataauthor_left_sorted[i] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
		                	if(notebuildonfromtoid.length>0){
		                		find_build_on(realdatanoteid_sorted[i],1,realdatanoteid_sorted,realdatacontent_sorted,realdatatitle_left_sorted,realdataauthor_left_sorted)
		                	}
		               
		            }	
				}
				
	            
	        });
			
			
			$("#compile_list_sort_author").click(function () {
				if(compileHighlightChecker){
					$("#compileboxContent").empty();
					$("#compileboxContent").append('<div class="row" style="margin:10px"><span style="background:#fdff4a;font-size:14px">A “juicy” question for research</span> | <span style="background:#72e567;font-size:14px">An “Aha” insight</span> | <span style="background:#fdb760;font-size:14px">A seed idea to refine</span> | <span style="background:#a6acff;font-size:14px">An important fact to consider</span> | <span style="background:#ff5b5b;;font-size:14px">Conflicting ideas to look into</span> | <span style="background:#c0b1d0;;font-size:14px">A gap of knowledge</span></div>');
					
					var realdatatitle_left_sorted = [];
		            var realdataauthor_left_sorted = [];
		            var realdatacontent_sorted = [];
		            var realdatanoteid_sorted = [];
		            
		           
		            
		            highlighted_only_data.sort(function(a,b) {
		            	if ( a.last_name < b.last_name )
						 	return -1;
						if ( a.last_name > b.last_name )
						 	return 1;
					    return 0;
					});
					
					$.each(highlighted_only_data, function(item) {
		            	
		            	realdatatitle_left_sorted.push(highlighted_only_data[item].title);
		            	realdataauthor_left_sorted.push(highlighted_only_data[item].first_name + " "+ json_highlighted[item].last_name);
		            	realdatacontent_sorted.push(highlighted_only_data[item].content);
		            	realdatanoteid_sorted.push(highlighted_only_data[item].note_id);
		            	
		            });
					
					
					
					
					for (var i = 0; i < realdatanoteid_sorted.length; i++) {
						var note_content = compile_list_highlight_check(realdatacontent_sorted[i],realdatanoteid_sorted[i]);
		            	
		            	
		                $("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+realdatanoteid_sorted[i]+'\')">' + realdatatitle_left_sorted[i] + '" by ' + realdataauthor_left_sorted[i] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
		                	if(notebuildonfromtoid.length>0){
		                		find_build_on(realdatanoteid_sorted[i],1,realdatanoteid_sorted,realdatacontent_sorted,realdatatitle_left_sorted,realdataauthor_left_sorted)
		                	} 
		               
		            }	
					
				}
				else if(compile_Graph){
					$("#compileboxContent").empty();
					 
					 
					var realdatatitle_left_sorted = [];
		            var realdataauthor_left_sorted = [];
		            var realdatacontent_sorted = [];
		            var realdatanoteid_sorted = [];
		            
		           
		            
		            json_compile_graph_data.sort(function(a,b) {
		            	if ( a.last_name < b.last_name )
						 	return -1;
						if ( a.last_name > b.last_name )
						 	return 1;
					    return 0;
					});
					
					$.each(json_compile_graph_data, function(item) {
		            	
		            	realdatatitle_left_sorted.push(json_compile_graph_data[item].title);
		            	realdataauthor_left_sorted.push(json_compile_graph_data[item].first_name +" "+json_compile_graph_data[item].last_name );
		            	realdatacontent_sorted.push(json_compile_graph_data[item].content);
		            	realdatanoteid_sorted.push(json_compile_graph_data[item].note_id);
		            	
		            });
					
					for (var i = 0; i < realdatatitle_left_sorted.length; i++) {
						var note_content = realdatacontent_sorted[i];
		            	
		            	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(realdatanoteid_sorted[i]) > -1) {
		            		note_content = compile_list_highlight_check(note_content,realdatanoteid_sorted[i]);
		            	}
		                $("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+realdatanoteid_sorted[i]+'\')">' + realdatatitle_left_sorted[i] + '" by ' + realdataauthor_left_sorted[i] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
		                	if(notebuildonfromtoid.length>0){
		                		find_build_on(realdatanoteid_sorted[i],1,realdatanoteid_sorted,realdatacontent_sorted,realdatatitle_left_sorted,realdataauthor_left_sorted)
		                	}
		               
		            }	
					
			         
				}
				else{
					
					$("#compileboxContent").empty();
		            
		            var realdatatitle_left_sorted = [];
		            var realdataauthor_left_sorted = [];
		            var realdatacontent_sorted = [];
		            var realdatanoteid_sorted = [];
		            
		            globalData.sort(function(a,b) {
					    if ( a.last_name < b.last_name )
					        return -1;
					    if ( a.last_name > b.last_name )
					        return 1;
					    return 0;
					});
		            
		            
		            $.each(globalData, function(item) {
		            	
		            	realdatatitle_left_sorted.push(globalData[item].title);
		            	realdataauthor_left_sorted.push(globalData[item].first_name + " "+ globalData[item].last_name);
		            	realdatacontent_sorted.push(globalData[item].content);
		            	realdatanoteid_sorted.push(globalData[item].note_id);
		            	
		            });
		            
		            
		            for (var i = 0; i < realdatatitle_left_sorted.length; i++) {
		                
						var note_content = realdatacontent_sorted[i];
		            	
		            	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(realdatanoteid_sorted[i]) > -1) {
		            		note_content = compile_list_highlight_check(note_content,realdatanoteid_sorted[i]);
		            	}
		                $("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+realdatanoteid_sorted[i]+'\')">' + realdatatitle_left_sorted[i] + '" by ' + realdataauthor_left_sorted[i] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
		                	if(notebuildonfromtoid.length>0){
		                		find_build_on(realdatanoteid_sorted[i],1,realdatanoteid_sorted,realdatacontent_sorted,realdatatitle_left_sorted,realdataauthor_left_sorted)
		                	}
		               
		            }
					
				}
				
	            
	        });
			
			function openNote(id){
					$("#draggable").css("top",window.scrollY+100);
					$("#draggable").css("right",window.innerWidth/4);
					 $("#draggable").show();
					i =realdatanoteid.indexOf(id);
					finalDataTitle="";
					finalDataAuthor="";
					finalDataContent="";
					finalDataNoteId="";
					finalDataThreadId="";
					finalDataNoteStrId=""
					
					for(var m=0;m<new_data_title.length;m++){
						if(new_data_title[m].split('@#$')[0]==i){
							finalDataTitle=new_data_title[m].split('@#$')[1];
						}
					}
					for(var m=0;m<new_data_author.length;m++){
						if(new_data_author[m].split('@#$')[0]==i){
							finalDataAuthor=new_data_author[m].split('@#$')[1];
						}
					}
					for(var m=0;m<new_data_content.length;m++){
						if(new_data_content[m].split('@#$')[0]==i){
							finalDataContent=new_data_content[m].split('@#$')[1];
						}
					}
					for(var m=0;m<new_data_note_id.length;m++){
						if(new_data_note_id[m].split('@#$')[0]==i){
							finalDataNoteId=new_data_note_id[m].split('@#$')[1];
						}
					}
					for(var m=0;m<new_data_note_str_id.length;m++){
						if(new_data_note_str_id[m].split('@#$')[0]==i){
							finalDataNoteStrId=new_data_note_str_id[m].split('@#$')[1];
						}
					}
					$("#title").text("\"" + finalDataTitle + "\"" + " by "+ finalDataAuthor);
					$("#content").html(finalDataContent);

					
					note_position = i;
					title=new_data_title[i];
					data_note_id = +finalDataNoteId;
					$("#note_open_id").val(finalDataNoteStrId);
					data_note_str_id = finalDataNoteStrId;
					checkHighlight(finalDataContent, data_note_id);
					
					noteRead(data_note_id);
					
					temp_realdatatitle_left1.push(new_data_title[i]);
					temp_realdataweight_left1.push(i);
					temp_realdatatitleauthor1.push(new_data_title[i] + " by "+ new_data_author[i])
					
					
			}
			
			
			$("#compile_list_sort_Title").click(function () {
				
				if(compile_Graph){
					$("#compileboxContent").empty();
					 
					 var gd = document.getElementById('tester');
						var xRange = gd.layout.xaxis.range;
						var yRange = gd.layout.yaxis.range;
			            
						for(var m=0; m< realdatanoteidandyrange.length; m++){
			            	if(realdatanoteidandyrange[m].split("@#$")[1]>=yRange[0] && realdatanoteidandyrange[m].split("@#$")[1]<=yRange[1]){
			            		var temp_index = realdatanoteid.indexOf(realdatanoteidandyrange[m].split("@#$")[0]);
			            		if(temp_index>=0){
			            			compile_graph_note_id.push(realdatanoteid[temp_index]);
			            			var note_content = realdatacontent[temp_index];
			                    	
			                    	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(realdatanoteid[temp_index]) > -1) {
			                    		note_content = compile_list_highlight_check(note_content,realdatanoteid[temp_index]);
			                    	}
			            			
			            			$("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+realdatanoteidandyrange[m].split("@#$")[0]+'\')">' + realdatatitle_left[temp_index] + '" by ' + realdataauthor_left[temp_index] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
			            		}
			                }	
			            }
			         
				}
				else{
					$("#compileboxContent").empty();
		            
		            var realdatatitle_left_sorted = [];
		            var realdataauthor_left_sorted = [];
		            var realdatacontent_sorted = [];
		            var realdatanoteid_sorted = [];
		            
		            
		            globalData.sort(function(a,b) {
					    if ( a.title < b.title )
					        return -1;
					    if ( a.title > b.title )
					        return 1;
					    return 0;
					});
		            
		            
		            $.each(globalData, function(item) {
		            	
		            	realdatatitle_left_sorted.push(globalData[item].title);
		            	realdataauthor_left_sorted.push(globalData[item].first_name + " "+ globalData[item].last_name);
		            	realdatacontent_sorted.push(globalData[item].content);
		            	realdatanoteid_sorted.push(globalData[item].note_id);
		            	
		            });
		            
		            
		            for (var i = 0; i < realdatatitle_left_sorted.length; i++) {
						var note_content = realdatacontent_sorted[i];
		            	
		            	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(realdatanoteid_sorted[i]) > -1) {
		            		note_content = compile_list_highlight_check(note_content,realdatanoteid_sorted[i]);
		            	}
		                $("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+realdatanoteid_sorted[i]+'\')">' + realdatatitle_left_sorted[i] + '" by ' + realdataauthor_left_sorted[i] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
		                
		                	if(notebuildonfromtoid.length>0){
		                		find_build_on(realdatanoteid_sorted[i],1,realdatanoteid_sorted,realdatacontent_sorted,realdatatitle_left_sorted,realdataauthor_left_sorted)
		                	}
		               
		            }
				}
				
	            
	        });
			
			
			
			$("#compile_list_sort_Highlight").click(function () {
				
				if(get_project_infoChecker){
					
				}
				
				else if(compile_Graph){
					$("#compileboxContent").empty();
					
					$("#compileboxContent").append('<div class="row" style="margin:10px"><span style="background:#fdff4a;font-size:14px">A “juicy” question for research</span> | <span style="background:#72e567;font-size:14px">An “Aha” insight</span> | <span style="background:#fdb760;font-size:14px">A seed idea to refine</span> | <span style="background:#a6acff;font-size:14px">An important fact to consider</span> | <span style="background:#ff5b5b;;font-size:14px">Conflicting ideas to look into</span> | <span style="background:#c0b1d0;;font-size:14px">A gap of knowledge</span></div>');
					 
					
					 for(var m=0;m< compile_graph_highlighted_note_id.length;m++){
			            	var temp_index = compile_graph_note_id.indexOf(compile_graph_highlighted_note_id[m]);
			            	if(temp_index>=0){
			            		compile_graph_note_id.splice(temp_index,1);
			            	}
			            }
					 
					 
			            var title_author = "";
			        	var note_content = "";
			        	
			        	
			            for(var m1=0;m1< compile_graph_highlighted_note_id.length;m1++){
			            	
			            	var note_index = realdatanoteid.indexOf(compile_graph_highlighted_note_id[m1]);
			            	
			            		for(var n=0; n < realdatanoteid_content.length ; n++){
			            			if(realdatanoteid_content[n].split("@#$")[0]==compile_graph_highlighted_note_id[m1]){
			            				note_content = realdatanoteid_content[n].split("@#$")[1];
			            			}
			            		}
			            		for(var n=0; n < realdatanoteidtitle.length ; n++){
			            			if(realdatanoteidtitle[n].split("@#$")[0]==compile_graph_highlighted_note_id[m1]){
			            				title_author ='"'+ realdatanoteidtitle[n].split("@#$")[1]+'" by ' +realdataauthor_left[note_index];
			            			}
			            		}
			            		var temp_content = note_content;
			            		temp_content = compile_list_highlight_check(temp_content,compile_graph_highlighted_note_id[m1]);
			            		$("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;"><b><a onclick="openNote(\''+i+'\')">' + title_author + '</a></b></span><p style="font-size:15px;">' + temp_content + '</p></div></div></div>');
			            		if(notebuildonfromtoid.length>0){
			            			find_build_on(realdatanoteid[i],1,realdatanoteid,realdatacontent,realdatatitle_left,realdataauthor_left)
			                	}
			            }
			            
			            for(var j=0; j< compile_graph_note_id.length; j++){
			            	var note_index = realdatanoteid.indexOf(compile_graph_note_id[j]);
			            	for(var n=0; n < realdatanoteid_content.length ; n++){
			        			if(realdatanoteid_content[n].split("@#$")[0]==compile_graph_note_id[j]){
			        				note_content = realdatanoteid_content[n].split("@#$")[1];
			        			}
			        		}
			        		for(var n=0; n < realdatanoteidtitle.length ; n++){
			        			if(realdatanoteidtitle[n].split("@#$")[0]==compile_graph_note_id[j]){
			        				title_author ='"'+ realdatanoteidtitle[n].split("@#$")[1]+'" by ' +realdataauthor_left[note_index];
			        			}
			        		}
			            	
			        		$("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;"><b><a onclick="openNote(\''+compile_graph_note_id[j]+'\')">' + title_author + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
			        		if(notebuildonfromtoid.length>0){
			         			find_build_on(realdatanoteid[i],1,realdatanoteid,realdatacontent,realdatatitle_left,realdataauthor_left)
			            	}
			            }
				}
				else{
					$("#compileboxContent").empty();
					$("#compileboxContent").append('<div class="row" style="margin:10px"><span style="background:#fdff4a;font-size:14px">A “juicy” question for research</span> | <span style="background:#72e567;font-size:14px">An “Aha” insight</span> | <span style="background:#fdb760;font-size:14px">A seed idea to refine</span> | <span style="background:#a6acff;font-size:14px">An important fact to consider</span> | <span style="background:#ff5b5b;;font-size:14px">Conflicting ideas to look into</span> | <span style="background:#c0b1d0;;font-size:14px">A gap of knowledge</span></div>');
		            for(var m=0;m< note_id_highlighted.length;m++){
		            	var temp_index = realdatanoteid_compilelist.indexOf(note_id_highlighted[m]);
		            	if(temp_index>=0){
		            		realdatanoteid_compilelist.splice(note_id_highlighted[m],1);
		            	}
		            }
		            var title_author = "";
		        	var note_content = "";
		        	
		        	
		        	
		            for(var m1=0;m1< note_id_highlighted.length;m1++){
		            	var note_index = realdatanoteid.indexOf(note_id_highlighted[m1]);
		            		for(var n=0; n < realdatanoteid_content.length ; n++){
		            			if(realdatanoteid_content[n].split("@#$")[0]==note_id_highlighted[m1]){
		            				note_content = realdatanoteid_content[n].split("@#$")[1];
		            			}
		            		}
		            		for(var n=0; n < realdatanoteidtitle.length ; n++){
		            			if(realdatanoteidtitle[n].split("@#$")[0]==note_id_highlighted[m1]){
		            				title_author ='"'+ realdatanoteidtitle[n].split("@#$")[1]+'" by ' +realdataauthor_left[note_index];
		            			}
		            		}
		            		var temp_content = note_content;
		            		temp_content = compile_list_highlight_check(temp_content,note_id_highlighted[m1]);
		            		$("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;"><b><a onclick="openNote(\''+note_id_highlighted[m1]+'\')">' + title_author + '</a></b></span><p style="font-size:15px;">' + temp_content + '</p></div></div></div>');
		            		if(notebuildonfromtoid.length>0){
		             			find_build_on(realdatanoteid[i],1,realdatanoteid,realdatacontent,realdatatitle_left,realdataauthor_left)
		         			   
		                	}
		            }
		            
		            
		            for(var j=0; j< realdatanoteid_compilelist.length; j++){
		            	var note_index = realdatanoteid.indexOf(realdatanoteid_compilelist[j]);
		            	for(var n=0; n < realdatanoteid_content.length ; n++){
		        			if(realdatanoteid_content[n].split("@#$")[0]==realdatanoteid_compilelist[j]){
		        				note_content = realdatanoteid_content[n].split("@#$")[1];
		        			}
		        		}
		        		for(var n=0; n < realdatanoteidtitle.length ; n++){
		        			if(realdatanoteidtitle[n].split("@#$")[0]==realdatanoteid_compilelist[j]){
		        				title_author ='"'+ realdatanoteidtitle[n].split("@#$")[1]+'" by ' +realdataauthor_left[note_index];
		        			}
		        		}
		            	
		        		$("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;"><b><a onclick="openNote(\''+realdatanoteid_compilelist[j]+'\')">' + title_author + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
		        		if(notebuildonfromtoid.length>0){
		         			find_build_on(realdatanoteid[i],1,realdatanoteid,realdatacontent,realdatatitle_left,realdataauthor_left)
		            	}
		            }	
				}
	        });
			
			$("#compileHighlight").click(function () {
				compile_Graph = false;
				compileHighlightChecker = true;
				
					$("#compileboxContent").empty();
					$("#compileboxContent").append('<div class="row" style="margin:10px"><span style="background:#fdff4a;font-size:14px">A “juicy” question for research</span> | <span style="background:#72e567;font-size:14px">An “Aha” insight</span> | <span style="background:#fdb760;font-size:14px">A seed idea to refine</span> | <span style="background:#a6acff;font-size:14px">An important fact to consider</span> | <span style="background:#ff5b5b;;font-size:14px">Conflicting ideas to look into</span> | <span style="background:#c0b1d0;;font-size:14px">A gap of knowledge</span></div>');
		           	var compile_graph_data_arr = [];
					for(var m=0;m< note_id_highlighted.length;m++){
		            	var temp_index = realdatanoteid_compilelist.indexOf(note_id_highlighted[m]);
		            	if(temp_index>=0){
		            		realdatanoteid_compilelist.splice(note_id_highlighted[m],1);
		            	}
		            }
		            var title_author = "";
		        	var note_content = "";
		        	var note_first_name = "";
		        	var note_last_name = "";
		        	
		            for(var m1=0;m1< note_id_highlighted.length;m1++){
		            	
		            	var note_index = realdatanoteid.indexOf(note_id_highlighted[m1]);
		            	
		            		for(var n=0; n < realdatanoteid_content.length ; n++){
		            			if(realdatanoteid_content[n].split("@#$")[0]==note_id_highlighted[m1]){
		            				note_content = realdatanoteid_content[n].split("@#$")[1];
		            			}
		            		}
		            		for(var n=0; n < realdatanoteidtitle.length ; n++){
		            			if(realdatanoteidtitle[n].split("@#$")[0]==note_id_highlighted[m1]){
		            				title_author ='"'+ realdatanoteidtitle[n].split("@#$")[1]+'" by ' +realdataauthor_left[note_index];
		            				note_first_name = realdataauthor_left[note_index].split(" ")[0];
		            				note_last_name = realdataauthor_left[note_index].split(" ")[1];
		            			}
		            		}
		            		var temp_content = note_content;
		            		temp_content = compile_list_highlight_check(temp_content,note_id_highlighted[m1]);
		            		
		            		
		            		
		            		var compile_graph_data = {};
		            		compile_graph_data.title = realdatatitle_left[note_index];
		                	compile_graph_data.first_name = note_first_name;
		                	compile_graph_data.last_name = note_last_name
		                	compile_graph_data.content = temp_content;
		                	compile_graph_data.create_time = realdatatime_left[note_index];
		                	compile_graph_data.note_id = note_id_highlighted[m1];
		                	compile_graph_data_arr.push(compile_graph_data);
		            		
		            		
		            		$("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;"><b><a onclick="openNote(\''+compile_graph_data.note_id+'\')">' + title_author + '</a></b></span><p style="font-size:15px;">' + temp_content + '</p></div></div></div>');
		            		if(notebuildonfromtoid.length>0){
		             			find_build_on(realdatanoteid[i],1,realdatanoteid,realdatacontent,realdatatitle_left,realdataauthor_left)
		                	}  
		            }
		            
		           	highlighted_only_data = compile_graph_data_arr;
					console.log(highlighted_only_data);
	        });
			
				
				$('#exportLink').click(function () {
					var doc = new jsPDF();
					var specialElementHandlers = {
					    '#compileboxContent': function (element, renderer) {
					        return true;
					    }
					};
				    doc.fromHTML($('#compileboxContent').html(), 15, 15, {
				        'width': 170,
				            'elementHandlers': specialElementHandlers
				    });
				    doc.save('compile_list_'+new Date()+'.pdf');
				});
			
			
			$("#compileGraph").click(function () {
				compileHighlightChecker = false;
				var compile_graph_data_arr = [];
				compile_Graph = true;
				
				compile_graph_note_id = [];
				
	            $("#compileboxContent").empty();
	            
	            var gd = document.getElementById('tester');
				var xRange = gd.layout.xaxis.range;
				var yRange = gd.layout.yaxis.range;
	            
				compile_graph_highlighted_note_id = [];
				
	            for(var m=0; m< realdatanoteidandyrange.length; m++){
	            	if(realdatanoteidandyrange[m].split("@#$")[1]>=yRange[0] && realdatanoteidandyrange[m].split("@#$")[1]<=yRange[1]){
	            		var temp_index = realdatanoteid.indexOf(realdatanoteidandyrange[m].split("@#$")[0]);
	            		
	            		var compile_graph_data = {};
	            		compile_graph_data.title = realdatatitle_left[temp_index];
	                	compile_graph_data.first_name = realdatafirstname[temp_index];
	                	compile_graph_data.last_name = realdatalastname[temp_index];
	                	compile_graph_data.content = realdatacontent[temp_index];
	                	compile_graph_data.create_time = realdatatime_left[temp_index];
	                	compile_graph_data.note_id = realdatanoteid[temp_index];
	                	compile_graph_data_arr.push(compile_graph_data);
	            		
	                	
	                	
	            		if(temp_index>=0){
	            			compile_graph_note_id.push(realdatanoteid[temp_index]);
	            			var note_content = realdatacontent[temp_index];
	                    	
	                    	if (note_id_highlighted.length>0 && note_id_highlighted.indexOf(realdatanoteid[temp_index]) > -1) {
	                    		note_content = compile_list_highlight_check(note_content,realdatanoteid[temp_index]);
	                    		compile_graph_highlighted_note_id.push(realdatanoteid[temp_index]);
	                    	}
	                    	
	            			$("#compileboxContent").append('<div style="width:100%;"><div class="card z-depth-3"><div class="card-content"><span class="card-title" style="font-size:16px;">"<b><a onclick="openNote(\''+compile_graph_data.note_id+'\')">' + realdatatitle_left[temp_index] + '" by ' + realdataauthor_left[temp_index] + '</a></b></span><p style="font-size:15px;">' + note_content + '</p></div></div></div>');
	            		}
	                }	
	            }
	            json_compile_graph_data = compile_graph_data_arr;
	        });
			
		
		  $('#search.autocomplete').autocomplete({
		        source:function(request, response){
		          var notecountdata = {
		              "database" : localdb,
		              "token" : token,
		              "threadid": thread_id,
		        };
		        $.ajax({
		          url :  "/WSG/thread/keywords/get",
		          type : "POST",
		          data : JSON.stringify(notecountdata),
		          dataType : "json",
		          success : function(data, textStatus, jqXHR) {

		             if(data.code=="success"){
		               
		               var keywords={}
		               if($.trim(data.obj)!="No data aviliable."){
		                 var json = $.parseJSON(data.obj);
		                 for(var i in json){
		                   if(json[i].keywords in keywords){
		                     keywords[json[i].keywords]+=1;
		                   }else{
		                     keywords[json[i].keywords]=1;
		                   }
		                 }
		               }
		              
		               var availableTags = Object.keys(keywords).sort(function(a, b) {
		                  return data[b] - data[a];
		                });

		             
		              
		              response(availableTags)
		                
		                
		            }
		             return null;
		            
		          },
		          error : function(jqXHR, textStatus, errorThrown) {
		            return null;      }
		        });
		        
		        
		        }
		        });
		  
		  function visit(url, success) {
		        var xhr = new XMLHttpRequest();
		        xhr.open('GET', url, true);
		        xhr.setRequestHeader("Authorization", "bearer "+kftoken);
		        xhr.onreadystatechange = function() {
		            if (xhr.readyState == 4) {
		                if (success) success(xhr.response);
		            }
		        };
		        xhr.send(null);
		    }
		  
			
			
			$("#copyNote").click(function(){
				// clean 
				$("#copy_note_modal .modal-content").empty().html();
				// get thread list
				var projectdata = {
						"database" :localdb,
						"token" : token,
						"projectid" : project_id
					};
					$.ajax({
						url :  "/WSG/project/thread/get",
						type : "POST",
						data : JSON.stringify(projectdata),
						dataType : "json",
						success : function(data, textStatus,jqXHR) {
							var json = $.parseJSON(data.obj);
							if(null!=json){
								var tr2 =$("#copy_note_modal .modal-content")
								var html4 ='<div><b>Copy note to threads</b><br> please select a thread(s) that you want to copy this note to .<br><br></div><div id="copy-note-select-thread"></div>'
								tr2.append(html4)
								for (var i in json) {
								  if(json[i].thread_id!=thread_id){
										var tr =$("#copy_note_modal #copy-note-select-thread")
										var html3 ='<div style="height:25px;"><div width="50px" style="float:left"><input class="thread_list_id" type="checkbox" value="'+json[i].thread_id+'"  id="notes_'+json[i].thread_id+'"><label for="notes_'+json[i].thread_id+'"></label>'
													+ '</div>'
										if(null!=json[i].threadfocus){
												 html3 = html3+'<div style="float:left" class="cell-title">'+json[i].threadfocus+'</div>'
	 										}else{
												 html3 = html3+'<div style="float:left" class="cell-title"> null </div>'
											}
												 html3 = html3+'</div>'
											tr.append(html3)
										} 

									}
								
								
								}
							filterOutThreadHasSelectedNote()
							}

					})
					
				
				
			})
			
			
			function filterOutThreadHasSelectedNote(){
				// get thread info
				var json = {
						 "database" :localdb ,
						 "token" : token,
						 "noteid":data_note_str_id	
						 }
				$.ajax({
					url :  "/WSG/note/thread/bynoteid",
					type : "POST",
					data : JSON.stringify(json),
					dataType : "json",
					success : function(data, textStatus,
							jqXHR) {
						 if(data.code=="success"){
							 var obj = JSON.parse(data.obj)
								 var checkbox = $(".thread_list_id")
				            		$.each(checkbox,function(index){
				            			 for(var i in obj){
				            				if(checkbox[index].value==String(obj[i].thread_id)){
				            					$(checkbox[index]).attr( "disabled",true);
				            					$(checkbox[index]).parent().next().append(" (already exists)")
				            				}	
				            			 }
				            		})
							
							 $("#copy_note_modal").modal('open');
						 }
					}})
			}
			
			var requestArray=[]
			
			
			$("#copy-action").click(function(){
				var selected = $('#copy-note-select-thread input:checked');
				if(selected.length==0){
					Materialize.toast("No thread is selected.",2000)
					return
				}
				$('#copy-note-select-thread input:checked').each(function(e){
					var json = {
					 "database" :localdb ,
					 "token" : token,
					 "projectid":project_id,
					 "threadid":$(this).val(),
					 "cid":community_id,
					 "noteid":data_note_str_id,
					 "ctime":new Date()
					 }	
					 var followRequest =$.ajax({
							url :  "/WSG/thread/note/add",
							type : "POST",
							data : JSON.stringify(json),
							dataType : "json",
							success : function(data, textStatus,
									jqXHR) {
								 if(data.code=="success"){
									
								 }
							}})
					requestArray.push(followRequest)
				})
				
				 $.when.apply(null,requestArray).then( 
						 finishCopyNote()
		    		 )
			})
			
			function finishCopyNote(){
				Materialize.toast("Note has been copy to the threads.",2000)
				$("#copy_note_modal").modal('close');
			}
			
			

			$(document).ready(function () {
				$("#show_problem_textarea").click(function(){
					$('#write_our_problem_modal').modal({'dismissible':false});
					$("#write_our_problem_modal").modal('open');
					
					
				})
				$("#show_idea_textarea").click(function(){
					$('#write_idea_modal').modal({'dismissible':false});
					$("#write_idea_modal").modal('open');
					
				})
				$("#show_to_do_textarea").click(function(){
					$('#write_to_do_modal').modal({'dismissible':false});
					$("#write_to_do_modal").modal('open');
				})
			});
			
			

			
			$("#search-btn").click(function () { 
			  if($("#search").val()==""){
				  // nothing apply for search, it means restore the plotly. 
				  
				  location.reload();
				  
			  }else{

		          // remove the buildon traces. Without remove these traces,the related notes will still show in the graph. 
		          // Do not know why need to remove the last 2 traces. 
		          // To me, it looks like it only one traces been add into plotly. But it works
		         if(TESTER.data[1].x!=""){
		        	 for(var i in buildonfromtoid){
		 	          	Plotly.deleteTraces(TESTER,[-2,-1]);
		        	 }
		         }
		        
		         if(window.hasHighlighted){
		        	 Plotly.deleteTraces(TESTER,[-1]);
		         }
		          
		          // remve the note read data from TESTER. 
		         TESTER.data[1].x = [];
		         TESTER.data[1].y = [];
		         TESTER.data[1].text = [];
		         

		          var tmpauthor = [];
		          var tmptitle = [];
		          var tmpweight = [];
		          var tmptime = [];
		          var tmpcontent = [];
		          var tmpcolor = []
		        	   for (var i = 0; i < realdatatitle_left.length; i++) {
		              	 
		                   if (String(realdatatitle_left[i]).toLowerCase().indexOf(String($("#search").val()).toLowerCase()) >= 0
									||String(realdatacontent[i]).toLowerCase().indexOf(" "+String($("#search").val()).toLowerCase()) >= 0) {
		                       console.log(String(realdatatitle_left[i]));
		                       console.log(i);
		                       tmpauthor.push(realdataauthor_left[i]);
		                       tmptitle.push(realdatatitle_left[i]);
		                       tmpweight.push(realdataweight_left[i]);
		                       tmptime.push(realdatatime_left[i]);
		                       tmpcontent.push(realdatacontent[i]);
		                       //tmpcolor.push('red');
		                   }
		               }
		          
		          if (tmpauthor.length > 0) {
		              TESTER.data[0].x = tmptime;
		              TESTER.data[0].y = tmpweight;
		              TESTER.data[0].text = tmptitle;
		              TESTER.data[1].x = [];
		              TESTER.data[1].y = [];
		              TESTER.data[1].text = [];
		              Plotly.redraw(TESTER);
		          }else{
		        	  TESTER.data[0].x = [];
		              TESTER.data[0].y = [];
		              TESTER.data[0].text = [];
		              //TESTER.data[0].marker.color = 'blue';
		              Plotly.redraw(TESTER);
		          }
				  
				  
			  }	
	          
	          
	      });

			function show_note_write() {
				if(kfurl=='null/'){
				// this is ITM user. 
				$("#new-note-for-itm").show()
				$("#new-note-for-kf-select-view").hide()
				$("#add-note-title").html("New Note")
				$("#google_authorization_confirm").css("top",window.scrollY+200)
				
				$("#btn-save").data("mode", "new");
				$('#selected-views').find('option').prop('selected', false);
				$("#selected-views").trigger('contentChanged');
				$('#select-user').find('option').prop('selected', false);
				$("#select-user").trigger('contentChanged');
				tinyMCE.activeEditor.setContent("")
				$("#google_authorization_confirm").css("top",window.scrollY+200)
				$("#google_authorization_confirm").show()
				
				}else{
					// show view information 
					// this is kf user. 
					// get veiw info 
					var jsondata = {
					"database" :localdb ,
					"token" :token,
					"tid":thread_id
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
				            		 for(var i in d){
				            			 //selected_views.push(d[i].view_id)
				            			 
				            			 var viewId = d[i].view_id;
				            			 if (selected_views.indexOf(viewId) === -1 ){
											 selected_views.push(viewId);
				            			 }
				            			 
				            			}
				            		$("#new-note-for-itm").hide()
				         			$("#new-note-for-kf-select-view").hide()
				         			$("#google_authorization_confirm").hide()
				         			showKFWriteNote()
				            	 }else{
				            		$("#new-note-for-itm").hide()
				     				$("#new-note-for-kf-select-view").show()
				     				initViews()
				     				$("#google_authorization_confirm").css("top",window.scrollY+200)
				     				$("#google_authorization_confirm").show()
				            	 }
							}else{
			            		$("#new-note-for-itm").hide()
			     				$("#new-note-for-kf-select-view").show()
			     				initViews()
			     				$("#google_authorization_confirm").css("top",window.scrollY+200)
			     				$("#google_authorization_confirm").show()
			            	 }
						}
					})
					
				
					
				}
			}
			
			
			$("#btn-new-note-select-views").click(function(){
				var checked = false;
				$("#iFrame").contents().find('#new-note-select-views input:checked').each(function(){
					checked=true;
					var viewId = $(this).attr('value');
					if (selected_views.indexOf(viewId) === -1) {
						selected_views.push(viewId);
					}
				})
				if(!checked){
					$.notify("please select a view ","warn")
					return
				}
				
				$("#new-note-for-itm").hide()
				$("#new-note-for-kf-select-view").hide()
				$("#google_authorization_confirm").hide()
				showKFWriteNote()
			})
			
			
			
	
		  var selected_views =[]
		
		function showKFWriteNote(){
		
			var json = {
					//"communityId" : "558abcb01f3b621e75d9bc08",
					"communityId" : community_id,
					"type" : "Note",
					"title" : "",
					"created" : new Date(),
					"modified" : new Date(),
					"status" : "unsaved",
					"permission" : "protected",
					"authors" : [
						id

					],
					"data" : {
						"body" : ""
					},
					"keywords" : [ ],
					"text4search" : ""
				}
			 $.ajax({
					url : kfurl+"api/contributions/"+community_id,
					type : "POST",
					data : JSON.stringify(json),
					contentType:"application/json",
					beforeSend: function(request) {
						    request.setRequestHeader("Authorization", "bearer "+kftoken);
					},
					dataType : "json",
					success : function(data, textStatus,jqXHR) {
						if(textStatus=="success"&&jqXHR.status==201){
							if(selected_views!=[]){
								// get all view ids
								var vids= selected_views
								// create link to kf
								for(var i in vids){
									//Don't add note in views if it's a buildon, 
									//KF will automatically add it
									if($("#btn-save").data("mode") != "buildon"){
										createLink(data._id,vids[i]);
									}
									addViewNote(data._id,vids[i]);
								}
							}
							// if it is a  buildon , it will create buildon in ITM and KF
							if($("#btn-save").data("mode")=="buildon"){
								var currentNoteId =$("#btn-save").data("noteid")
								addBuildOn(currentNoteId,data._id);
								addKFbuildon(currentNoteId,data._id)
							}
							//open editor
							var url=kfurl+"api/contributions/"+community_id+"/"+data._id+"?access_token="+kftoken
							addThreadNote(data._id)
							//location.reload()
							openByIFrame(url, data._id, 850, 500);
						}
					}
				})
		}
		
		
		function openByIFrame(url, wid, width, height) {
            var str = '<iframe style="min-width: 100%;" id="' + wid + '" title="*" src="' + url + '"></iframe>';
            $('#kf6-editor').append(str);
            $('#' + wid).dialog({
                width: width,
                height: height,
                create: function () {
                    $(this).css('padding', '1px');
                    var contentWindow = document.getElementById(wid).contentWindow;
                    contentWindow.wid = wid;
                    contentWindow.openContribution = function (id) {
                        return $scope.openContribution(id);
                    };
                    contentWindow.setInternalWindowTitle = function (title) {
                        $('#' + wid).dialog('option', 'title', title);
                    };
                },
                close: function () { /*we need to erase element*/
                	console.log("KF editor closed!");
                	$(this).dialog('destroy').remove();
					window.location.reload();
                }
            });
            return wid;
        }

		window.addEventListener("message", function(event) {
			if (kfurl.indexOf(event.origin) === -1) {
			    return;
			}

			if (event.data.noteId && event.data.request === 'close'){
				$('#' + event.data.noteId).dialog('destroy').remove();
				window.location.reload();
			}
		}, false);
		
		
		function sleepFor( sleepDuration ){
		    var now = new Date().getTime();
		    while(new Date().getTime() < now + sleepDuration){ /* do nothing */ } 
		}
		
		function addKFbuildon(fid,tid){
			
			console.log("complete add buildon to kf")
		}
		
		
		function createLink(note_id,view_id){
			var json = {
					"from" : view_id,
					"to" : note_id,
					"type" : "contains",
					"communityId" : community_id,
					"data" : {
						"y" : 100,
						"x" : 100
					},
				}
			
			$.ajax({
				url : kfurl+"api/links/",
				type : "POST",
				data : JSON.stringify(json),
				contentType:"application/json",
				beforeSend: function(request) {
					    request.setRequestHeader("Authorization", "bearer "+kftoken);
				},
				dataType : "json",
				success : function(data, textStatus,jqXHR) {
					if(textStatus=="success"&&jqXHR.status==201){
					}
				}
			})

		}
		
		$("#btn-edit-note").click(function(){
			// show edit 
			// data_note_id
			if(kfurl=='null'){
			// if it is ITM user
			 var json = {
					 "database" :localdb ,
					 "token" : token,
					 "noteid":data_note_id
			 }
			 $.ajax({
					url :  "/WSG/note/get/byid",
					type : "POST",
					data : JSON.stringify(json),
					dataType : "json",
					success : function(data, textStatus,
							jqXHR) {
						 if(data.code=="success"){
							 var json = $.parseJSON(data.obj);
							 initViewNote()
							 // init title
							 $("#add_note_title").val(json[0].title)
							 $("#add-note-title").html("Edit Note");
							 
							 // init texteare
							// $("#add_note_content").val(json[0].content)
							 tinyMCE.activeEditor.setContent(json[0].content)
							 
							 
							
						 }
					}})
					
			}else{
				// kf user
				
				$("#new-note-for-itm").hide()
				$("#new-note-for-kf-select-view").hide()
				$("#draggable").toggle();
				var url=kfurl+"api/contributions/"+community_id+"/"+data_note_str_id+"?access_token="+kftoken
				$("#google_authorization_confirm").hide()
				openByIFrame(url, data_note_str_id, 850, 500);
			}
			
		})
		
	
		
		 function initViewNote(){
			 var json = {
					 "database" :localdb ,
					 "token" : token,
					 "noteid":data_note_str_id
			 }
			 $.ajax({
					url :  "/WSG/note/view/get",
					type : "POST",
					data : JSON.stringify(json),
					dataType : "json",
					success : function(data, textStatus,
							jqXHR) {
						 if(data.code=="success"){
							 var json = $.parseJSON(data.obj);
							 for(var i in json){
								 $('#selected-views').find('option[value="'+json[i].view_id+'"]').prop('selected', true);
							 }
							 
							 $("#selected-views").trigger('contentChanged'); 
							  
						 }
						 initCoAuthor()
					}})
					
			
		}
		 function initCoAuthor(){
				 var json = {
					 "database" :localdb ,
					 "token" : token,
					 "noteid":data_note_str_id
			 }
			 $.ajax({
					url :  "/WSG/note/author/get",
					type : "POST",
					data : JSON.stringify(json),
					dataType : "json",
					success : function(data, textStatus,
							jqXHR) {
						 if(data.code=="success"){
							 var json = $.parseJSON(data.obj);
							 $("#add-note-title").html("Edit Note")
							 for(var i in json){
								 $('#select-user').find('option[value="'+json[i].author_id+'"]').prop('selected', true);
							 }
							 
							 $("#select-user").trigger('contentChanged'); 
							 
							
						 }
						 
							 $("#new-note-for-itm").show()
							$("#new-note-for-kf-select-view").hide()
							$("#add-note-title").html("Edit Note")
							
						 	$("#draggable").toggle();
							$("#btn-save").data("mode","edit");
							$("#google_authorization_confirm").css("top",window.scrollY+200);
							$("#google_authorization_confirm").show()
					}})
					
					
		 }
		 
		 function updateViewNote(nid){
				// del privious view note , then add new view note relationship
				 var json = {
						 "database" :localdb ,
						 "token" : token,
						 "noteid":nid
				 }
				 $.ajax({
						url :  "/WSG/view_note/del",
						type : "POST",
						data : JSON.stringify(json),
						dataType : "json",
						success : function(data, textStatus,
								jqXHR) {
							 if(data.code=="success"){
								 console.log(1);
								 // add view note ~~ add 
								 updateCoAuthor(nid)
							 }
						}})	
				
			}
		 $("#close").click(function() {
				$("#draggable").hide();
				var temp_trace = {
						x : temp_realdatatime_left1,
						y : temp_realdataweight_left1,
						mode : 'markers+text',
						type : 'scatter',
						textposition : 'left',
						marker : {
							size : 10,
							color : 'red'
						},
						hoverinfo: 'none'
				};
				
				Plotly.addTraces(TESTER, [temp_trace])
			});
			
			
			
			function updateCoAuthor(nid){
				// del privious view note , then add new view note relationship
				 var json = {
						 "database" :localdb ,
						 "token" : token,
						 "noteid":nid
				 }
				 $.ajax({
						url :  "/WSG/note/author/del/bynote",
						type : "POST",
						data : JSON.stringify(json),
						dataType : "json",
						success : function(data, textStatus,
								jqXHR) {
							 if(data.code=="success"){
								 console.log(1);
								 // delete  co author
								 addViewNote(nid)
							 }
						}})	
			}
			
			
			function closeJot(){
				
				$("#draggableJof").toggle();
				
				
				
			}
			
			
			$("#btn-build-on-note").click(function(){
					console.log(data_note_str_id)
					$("#draggable").toggle();
					$("#btn-save").data("mode", "buildon");
					$("#btn-save").data("noteid", data_note_str_id);
					
					
					if(kfurl=='null'){
						// this is ITM user. 
					$("#new-note-for-itm").show()
					$("#new-note-for-kf-select-view").hide()
					$("#add-note-title").html("New Note")
					$("#google_authorization_confirm").css("top",window.scrollY+200)
					
					$('#selected-views').find('option').prop('selected', false);
					$("#selected-views").trigger('contentChanged');
					$('#select-user').find('option').prop('selected', false);
					$("#select-user").trigger('contentChanged');
					tinyMCE.activeEditor.setContent("")
					$("#google_authorization_confirm").css("top",window.scrollY+200)
					$("#google_authorization_confirm").show()
				}else{
					// show view information 
					// this is ITM user. 
					$("#new-note-for-itm").hide()
					$("#new-note-for-kf-select-view").hide()
						
					//$("#google_authorization_confirm").css("top",window.scrollY+200)
					//$("#google_authorization_confirm").show()
					showKFWriteBuildOnNote(data_note_str_id)
				}
				
			})
			function showKFWriteBuildOnNote(str_id){
				 var json = {
						 "database" :localdb ,
						 "token" : token,
						 "noteid": str_id
				 }
				 $.ajax({
						url :  "/WSG/note/view/get",
						type : "POST",
						data : JSON.stringify(json),
						dataType : "json",
						success : function(data, textStatus,
								jqXHR) {
							 if(data.code=="success"){
								 console.log(1);
								 // delete  co author
								 AddBuildonWithViewIds($.parseJSON(data.obj))
							 }
						}})	
			}
			
			

			
			function addViewNote(nid,vid){
				
				 var json = {
						 "database" :localdb ,
						 "token" : token,
						 "noteid":nid,
						 "viewid":vid
				 }
				 $.ajax({
						url :  "/WSG/note/view/add",
						type : "POST",
						data : JSON.stringify(json),
						dataType : "json",
						success : function(data, textStatus,jqXHR) {
						}})	
				
			}
			function AddBuildonWithViewIds(vids){
				var json = {
						"communityId" : community_id,
						"type" : "Note",
						"title" : "",
						"created" : new Date(),
						"modified" : new Date(),
						"status" : "unsaved",
						"permission" : "protected",
						"authors" : [
							id
						],
						"data" : {
							"body" : ""
						},
						"keywords" : [ ],
						"text4search" : ""
					}
				
				// if it is a buildon , add a note as buildson in KF
                if($("#btn-save").data("mode")=="buildon"){
                    var currentNoteId =$("#btn-save").data("noteid");
                    json.buildson = currentNoteId;
                }
				
				 $.ajax({
						url : kfurl+"api/contributions/"+community_id,
						type : "POST",
						data : JSON.stringify(json),
						contentType:"application/json",
						beforeSend: function(request) {
							    request.setRequestHeader("Authorization", "bearer "+kftoken);
						},
						dataType : "json",
						success : function(data, textStatus,jqXHR) {
							if(textStatus=="success"&&jqXHR.status==201){
								if(null != vids){
									for(var i in vids){
										createLink(data._id,vids[i].view_id);
										addViewNote(data._id,vids[i].view_id);
									}
								}
								// if this buildon , it will create buildon in ITM and KF
								if($("#btn-save").data("mode")=="buildon"){
									//Don't add note in views if it's a buildon, 
									//KF will automatically add it
									if($("#btn-save").data("mode") != "buildon"){
										createLink(data._id,vids[i].view_id);
									}
									addBuildOn(currentNoteId,data._id);
									addKFbuildon(currentNoteId,data._id)
								}
								//open editor
								var url=kfurl+"api/contributions/"+community_id+"/"+data._id+"?access_token="+kftoken
								addThreadNote(data._id)
								openByIFrame(url, data._id, 850, 500);
								
							}
						}
					})
			}
			
			
			$("#removeNote").click(function(){
				var json = {
						 "database" :localdb ,
						 "token" : token,
						 "noteid":data_note_str_id,
						 "projectid":project_id,
						 "threadid":thread_id
				 }
				 $.ajax({
						url :  "/WSG/thread/note/del",
						type : "POST",
						data : JSON.stringify(json),
						dataType : "json",
						success : function(data, textStatus,jqXHR) {
							window.location.reload();
						}})	
			})
				 
				
			$("#delNote").click(function(){
				 var json = {
						 "database" :localdb ,
						 "token" : token,
						 "noteid":data_note_str_id,
				 }
				 $.ajax({
						url :  "/WSG/note/del",
						type : "POST",
						data : JSON.stringify(json),
						dataType : "json",
						success : function(data, textStatus,jqXHR) {
							window.location.reload();
						}})	
				
			})
			
			
			
function show_highlight(){
	var highlightdata = {
		"database" :localdb,
		"token" : token,
		"threadid" : thread_id
	}
	
	$.ajax({
		url : "/WSG/highlight/get/byauthor/bythread",
		type : "POST",
		data : JSON.stringify(highlightdata),
		dataType : "json",
		success : function(data) {
			if(data.code=="success"){
				var json = $.parseJSON(data.obj);
				
				if(json.length<20){
					var tester_height= 800
					$("#tester").height(tester_height);
				}
				else{
				var tester_height= json.length*23;
				$("#tester").height(tester_height);
				}
				
				var realdatatitle_highlighted = [];
				var realdatatitle_highlighted1 = [];
				var realdatacreatedtime_highlighted = [];
				var timeforxaxisrange_highlighted = [];
				var realdataauthor_highlighted = [];
				var realdataauthor_highlighted1 = [];
				var realdatacontent_highlighted = [];
				var realdataweight_highlighted = [];
				var realdatanoteid_highlighted = [];
				var all_yaxis2_traces_highlighted = [];
				for(var m=0;m<json.length;m++){
					realdatatitle_highlighted1.push(json[m].title+"@#$"+parseInt(m)); 
					realdatatitle_highlighted.push(json[m].title); 
					
					var x0=json[m].create_time;
					var date_x0 = new Date(x0);
					realdatacreatedtime_highlighted.push(date_x0);
					timeforxaxisrange_highlighted.push(date_x0);
					realdataauthor_highlighted.push(json[m].first_name +" "+json[m].last_name+"@#$"+parseInt(m));
					realdataauthor_highlighted1.push(json[m].first_name +" "+json[m].last_name);
					realdataweight_highlighted.push(parseInt(m));
					realdatanoteid_highlighted.push(json[m].note_id+"@#$"+parseInt(m));
					content = json[m].content;
					if(content != null){
						cleanText = content.replace(/<\/?[^>]+(>|$)/g, "").replace(/\&nbsp;/g, '');
						realdatacontent_highlighted.push(cleanText+"@#$"+parseInt(m));
						
					}
				}
				
				var trace_left_highlighted = {
					x : realdatacreatedtime_highlighted,
					y : realdataweight_highlighted,
					text : realdatatitle_highlighted,
					mode : 'markers+text',
					type : 'scatter',
					textposition : 'left',
					marker : {
						size : 10,
						color : 'blue'
					},
					hoverinfo: 'x+text'
				};
				
				var start_date = timeforxaxisrange_highlighted.sort()[0];
				var date = new Date(start_date);
				var milliseconds_start_date_highlighted = (date.getTime()); 
				 
				var end_date = timeforxaxisrange_highlighted.sort()[timeforxaxisrange_highlighted.length-1]; 
				var date1 = new Date(end_date);
				var milliseconds_end_date_highlighted = (date1.getTime()); 
				 
				var all_shapes_highlighted = [];
				var range_yaxis2_highlight = [];
				var uniqueAuthors = [];
				 $.each(realdataauthor_highlighted1, function(i, el){
				     if($.inArray(el, uniqueAuthors) === -1) uniqueAuthors.push(el);
				 });
				 for(var i=0; i<uniqueAuthors.length;i++){
					 
					 var y0 = +realdataauthor_highlighted1.indexOf(uniqueAuthors[i])-0.5;
					 range_yaxis2_highlight.push(realdataauthor_highlighted1.indexOf(uniqueAuthors[i]));
					 
					 var y1 = +realdataauthor_highlighted1.indexOf(uniqueAuthors[i+1])-0.5;
					 temp_y1 = +realdataauthor_highlighted1.indexOf(uniqueAuthors[i+1]);
					
					 if(y1==-1.5){
						 y1=realdataauthor_highlighted1.length;
					 }
					 if(temp_y1==-1){
						 temp_y1 = +realdataauthor_highlighted1.length;
					 }
					 range_yaxis2_highlight.push(temp_y1);
					 
					 if(i % 2 == 0){
						 stripeColor = stripes_colors[0];
					 }
					 else{
						 stripeColor = stripes_colors[1];
					 }
					 
					 var shape = "shape"+""+i;
					 shape = {
						type: 'rect',
					    xref: 'x',
					    yref: 'y',
					    x0: milliseconds_start_date-(10*24*60*60*1000),
					    x1: milliseconds_end_date+(2*24*60*60*1000),
					    y0: y0,
					    y1: y1,
					    fillcolor: stripeColor,
					    opacity: 0.1,
					    line: {
					    	color: "white",
					    	width: 1
					        }
					    }
					 all_shapes_highlighted.push(shape);
					 
					 var trace = "trace"+""+i;
					 trace = {
							 x: [milliseconds_end_date+2.5*24*60*60*1000, milliseconds_end_date+2.5*24*60*60*1000],
							 y: [(y0+y1)/2,y1],
							 text: [uniqueAuthors[i]], 
							 type : 'line',
							 mode: 'text',
							 textposition:'right', 
							 hoverinfo: "text",
							 textfont: {
								    color: 'rgb(148, 103, 189)',
								    size: 12										          
								 }
					    }
					 
					 all_yaxis2_traces_highlighted.push(trace); 
					 
				 }
				 var tempdata_highlighted = [trace_left_highlighted];
				 var data_highlight = tempdata_highlighted.concat(all_yaxis2_traces_highlighted);
				title_highlighted = "You have " +realdataweight_highlighted.length+" highlighted note(s) by " +uniqueAuthors.length+ " author(s)."
				window.hasHighlighted = true;
				Plotly.newPlot(TESTER, data_highlight, {
					title: title_highlighted,
					shapes: all_shapes_highlighted,
					xaxis:{
						showgrid: true,
						side: 'top',
						zeroline : true,
						zerolinecolor: 'rgb(148, 103, 189)',
						showline : true,
						tick0: 0,
						tickformat:"%m-%d-%y",
						tickfont : {
							color : 'rgb(148, 103, 189)',
							size : 14
						},
						mirror: "all"
					},
					yaxis : {
						showgrid: false,
						autorange : false,
						zeroline : false,
						showline : false,
						autotick : true,
						showticklabels : false,
						range: [-0.5, realdataweight_highlighted.length]
					},
					hovermode : 'closest',
					showlegend : false
				}, {
					showLink : false,
					displayModeBar : false
				});
				var dragLayer = document.getElementsByClassName('nsewdrag')[0];
				
				TESTER.on('plotly_hover', function(data){
					dragLayer.style.cursor = 'pointer'
					var marker_y = data.points[0].y;
					if(buildonallids.indexOf(realdatanoteid[marker_y])!==-1){
						
						var traceIndices = [];
						
						for(var i = 0; i < TESTER.data.length; i++) {
						   if(i !== data.points[0].curveNumber && data.points["0"].data.type=="line") {
						    traceIndices.push(i);
						    
						  }
						}
						Plotly.restyle(TESTER, 'opacity', 0.1, traceIndices);
					}
			})
				
				TESTER.on('plotly_unhover', function(data){
					dragLayer.style.cursor = ''
						var update = {
						    opacity: 1
						};
					Plotly.restyle(TESTER,update);
					
				})
				TESTER.on('plotly_click', function(data) {
					console.log(data);
					if(data.points[0].y%1==0){
						$("#draggable").css("top",window.scrollY+100);
						$("#draggable").css("right",window.innerWidth/4);
						 $("#draggable").show();
						i = data.points[0].y
						currenton = i;
						
						finalDataTitle="";
						finalDataAuthor="";
						finalDataContent="";
						finalDataNoteId="";
						finalDataThreadId="";
						finalDataNoteStrId=""
						
						for(var m=0;m<realdatatitle_highlighted1.length;m++){
							if(realdatatitle_highlighted1[m].split('@#$')[1]==i){
								finalDataTitle=realdatatitle_highlighted1[m].split('@#$')[0];
							}
						}
						for(var m=0;m<realdataauthor_highlighted.length;m++){
							if(realdataauthor_highlighted[m].split('@#$')[1]==i){
								finalDataAuthor=realdataauthor_highlighted[m].split('@#$')[0];
							}
						}
						for(var m=0;m<realdatacontent_highlighted.length;m++){
							if(realdatacontent_highlighted[m].split('@#$')[1]==i){
								finalDataContent=realdatacontent_highlighted[m].split('@#$')[0];
							}
						}
						for(var m=0;m<realdatanoteid_highlighted.length;m++){
							if(realdatanoteid_highlighted[m].split('@#$')[1]==i){
								finalDataNoteId=realdatanoteid_highlighted[m].split('@#$')[0];
							}
						}
						for(var m=0;m<new_data_note_str_id.length;m++){
							if(new_data_note_str_id[m].split('@#$')[0]==i){
								finalDataNoteStrId=new_data_note_str_id[m].split('@#$')[1];
							}
						}
						$("#title").text("\"" + finalDataTitle + "\"" + " by "+ finalDataAuthor);
						$("#content").html(finalDataContent);
						$("#note_position_y").val(data.points[0].y);
						$("#note_position_x").val(data.points[0].x);
						
						
						data_note_id = +finalDataNoteId;
						$("#note_open_id").val(finalDataNoteStrId);
						checkHighlight(finalDataContent, data_note_id);
					}
				});
				
			}
			else{
				showHighlight=false;
				 $("#showbuildon").attr("disabled", false);
				 $("#showtitle").attr("disabled", false);
				 $("#showauthor").attr("disabled", false);
				$('#showbuildon').attr('checked', true);
				 $('#showtitle').attr('checked', true);
				 $('#showauthor').attr('checked', false);
				 $("#highlight").removeClass('showed');
				 $("#highlight").prop('checked',false);
				 Materialize.toast('No highlighted note(s) found for this thread!', 3000); 
			}
			
		}
	});
}

		