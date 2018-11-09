	$(document).ready(function() {
		
		
		   var data = {};
			
			initWondering_area()
			initThread()
			
			var nodeColor='';
			var textColor='';

			$('.modal').modal();
			$('select').material_select();
			$('.chips-placeholder').material_chip({
				placeholder : 'Enter a keyword',
				secondaryPlaceholder : '+Keyword',
			});
			$('.datepicker').pickadate({
				selectMonths : false, // Creates a dropdown to control month
				selectYears : 15
			// Creates a dropdown of 15 years to control year
			});
			$(".button-collapse").sideNav();
			$("#show_slide").click(function() {
				$('.button-collapse').sideNav('show');
			});

			$('.collection').delegate('a', 'click', function() {
				window.location.href = "../thread/open.html";
			});
		
			
			$("#thread_mapping").click(function() {
				$('#thread_mapping_modal').modal('open');
			});
			
			

			$(".modal_close_btn").click(function() {
				$('#thread_mapping_modal').modal('close');
			});

			$(".modal_close_sure").click(function() {
				$('#modal_close_popup').modal("close");
				$('#add_thread_modal').modal("close");
				$('#add_field_modal').modal("close");
				$('#view_area_modal').modal("close");
				$('#modal_edit_done').modal("close");
				$('#thread_mapping_modal').modal("close");
				$('#color_label_modal').modal("close");
				$('#thread_color_label_modal').modal("close");
				$('#detail_wa_and_thread').modal("close");
			});
			
			$("#what_is_wa_and_thread").click(function(){
				$("#detail_wa_and_thread").modal('open');
			})	
	});
	
	
	
	function getAreaThreadSize(wid){
		var json = {
					"database" :localdb ,
					"token" : token,
					"wid" : wid
				};
		 $.ajax({
	  			url :  "/WSG/area/thread/note/count/get",
	  			type : "POST",
	  			data : JSON.stringify(json),
	  			dataType : "json",
	  			success : function(data, textStatus,jqXHR) {
	  				var json1 = $.parseJSON(data.obj);
	  				if(json1!=null){
	  					for(var i = 0 ; i < json1.length ; i++){
		  					area_size.push(json1[i].wondering_area+"/"+json1[i].thread_name+"_"+json1[i].size);
	  					}
	  				}
	  			},
	  			error : function(jqXHR, textStatus, errorThrown) {
	  			}
	  		});
	}
		
		
		function drawTree(projectData1){
			var color = '#939393';
			var projectData = $.parseJSON(projectData1);
			
			
			var margin = {top: 0, right: 180, bottom: 20, left: 200},
				    width = 1280 - margin.right - margin.left,
				    height = 730;

			var i = 0,
				    duration = 750,
				    root;

			var tree = d3.layout.tree()
				    .size([height, width]);

			var diagonal = d3.svg.diagonal()
				    .projection(function(d) { return [d.y, d.x]; });
				
			 tip = d3.tip() //mouse over tooltip
				  .attr('class', 'd3-tip')
				  .style("position", "absolute")
				  .offset([-30, 0])
				 
				  .html(function(d) {
					  if(projecttitle.indexOf(d.name) !== -1){
						  var string1= d.name;
						  string1 = string1.split('@#$')[0];
						  return "<strong>Project Name: </strong><hr><span style='color:darkorange'>" + string1 +"</span>";
					  }
					  else if(wonderingarea.indexOf(d.name) !== -1){
						  var focusGroupMember='';
						  var spanTag = "<br><strong>Focus group members: </strong><span style='color:darkorange'><br>";
						  focusGroupMember = focusGroupMember + spanTag;
						  var counter = 0;
						  var unique_focused_group_memebers = [];
						  $.each(all_focused_group_memebers, function(i, el){
							     if($.inArray(el, unique_focused_group_memebers) === -1) unique_focused_group_memebers.push(el);
							 });
						  
						  
						  if(unique_focused_group_memebers.length>0){
							  counter = 0;
							  for(var n=0;n<unique_focused_group_memebers.length;n++){
								  if(d.name.split("@#$")[1]==unique_focused_group_memebers[n].split("@#$")[0]){
									  counter = counter + 1;
									  focusGroupMember = focusGroupMember +counter+". "+ unique_focused_group_memebers[n].split("@#$")[1]+"<br>";
								  }
								}
						  }
						  else{
							  counter = 0;
							  spanTag=" ";
							  focusGroupMember=" ";
						  }
						  var string1= d.name;
						  string1 = string1.split('@#$')[0];
						 if(overarching_questions.length>0){
							 for(var m = 0 ; m < overarching_questions.length; m++){
								 if(overarching_questions[m].split('@#$')[0] == string1){
									 return "<strong>Wondering Area: </strong><span style='color:darkorange'>" + string1 + "</span><br/><strong>Overarching questions: </strong><span style='color:darkorange'>"+overarching_questions[m].split('@#$')[1]+"</span>"+focusGroupMember;
								 }
							 }
						 }
						 else {
							    return "<strong>Wondering Area: </strong><span style='color:darkorange'>" + string1 + "</span>";
						 }
					  }
					  else if(threadname.indexOf(d.name) !== -1){
						  var string1= d.name;
						  string1 = string1.split('@#$')[0];
						  return "<strong>Idea Thread: </strong><hr><span style='color:darkorange'>" + string1 +"</span>";
					  }
					  else if(area_size.length>0){
			    			for(var n = 0; n < area_size.length; n++){
			    				var str = area_size[n];
			    				var stroke_size = 0;
			    				str = str.substring(0, str.indexOf('_'));
			    				if(str == (d.source.name.split('@#$')[0]+"/"+d.target.name.split('@#$')[0])){
			    					stroke_size = area_size[n].replace(d.source.name.split('@#$')[0]+"/"+d.target.name.split('@#$')[0]+"_","");
			    					return "<strong>Total number of note(s): </strong><span style='color:darkorange'>" + stroke_size +"</span>";
			    				}
			    			}
			    		}
				  });
			
			
			
			var projectMenu = []
			if(!isCrossProject||!project_role==0){
				projectMenu=[ //right click options for project
								{
									title: 'Add wondering area',
									action: function(elm, d, i) {
									add_wf_click();
									}
								}
			                   ]
			}
			
			var wonderingAreaMenu = [ //right click options for wondering area
								{
									title: 'Info',
									changetitle:'Info',
									action: function(elm, d, i) {
									    var string1= d.name;
										string1 = string1.split('@#$')[1];
									    wondering_area_id= parseInt(string1);
									    showAreaInfo(wondering_area_id);		
										  
									},
									changeaction :  function(elm, d, i) {
										    var string1= d.name;
											string1 = string1.split('@#$')[1];
										    wondering_area_id= parseInt(string1);
										    showAreaInfo(wondering_area_id);		
										  
									},
								}
			                         ]
				if(!isCrossProject||!project_role==0){
					
						
					wonderingAreaMenu = [
								{
									title: 'Add Thread',
									changetitle:'Add Thread',
									action: function(elm, d, i) {
										var string1= d.name;
										string1 = string1.split('@#$')[1];
										wondering_area_id= parseInt(string1);
										add_thread_click(wondering_area_id,d.name.split('@#$')[0]);				
									},
									changeaction :  function(elm, d, i) {
										var string1= d.name;
										string1 = string1.split('@#$')[1];
										wondering_area_id= parseInt(string1);
										add_thread_click(wondering_area_id,d.name.split('@#$')[0]);		
										  
									},
								},
								{
									title: 'Info',
									changetitle:'Info',
									action: function(elm, d, i) {
									    var string1= d.name;
										string1 = string1.split('@#$')[1];
									    wondering_area_id= parseInt(string1);
									    showAreaInfo(wondering_area_id);		
										  
									},
									changeaction :  function(elm, d, i) {
										    var string1= d.name;
											string1 = string1.split('@#$')[1];
										    wondering_area_id= parseInt(string1);
										    showAreaInfo(wondering_area_id);		
										  
									},
								},
								{
									title: 'Color Label',
									changetitle:'Color Label',
									action: function(elm, d, i) {
									    var string1= d.name;
										string1 = string1.split('@#$')[1];
									    wondering_area_id= parseInt(string1);
									    $('#wonderingAreaId').val(wondering_area_id);
										$('#color_label_modal').modal("open"); 
										$('#wonderingArea').text(d.name.split('@#$')[0]);
										$('#wonderingAreaText').val(d.name.split('@#$')[0]);
										generateColorWheel(d.name.split('@#$')[0]);
									},
									changeaction: function(elm, d, i) {
										    var string1= d.name;
											string1 = string1.split('@#$')[1];
										    wondering_area_id= parseInt(string1);
										    $('#wonderingAreaId').val(wondering_area_id);
											 $('#color_label_modal').modal("open"); 
											 $('#wonderingArea').text(d.name.split('@#$')[0]);
											 $('#wonderingAreaText').val(d.name.split('@#$')[0]);
											 generateColorWheel(d.name.split('@#$')[0]);
									}
								},
								{
									title: 'Set as My Focus',
									action: function(elm, d, i) {
										var area_name = d.name.split('@#$')[0];
										var wondering_area_id;
										var string1= d.name;
										string1 = string1.split('@#$')[1];
										wondering_area_id= parseInt(string1);
										var my_focus="yes";
										addMyFocus(area_name,wondering_area_id,my_focus);
										 
									},
								changetitle:'Remove from my Focus',
								changeaction: function(elm, d, i) {
									var area_name = d.name.split('@#$')[0];
									var wondering_area_id;
									var string1= d.name;
									string1 = string1.split('@#$')[1];
									wondering_area_id= parseInt(string1);
									var my_focus="no";
									addMyFocus(area_name,wondering_area_id,my_focus);
									 
								}
								}
							]
				}
				
			var threadMenu =[{ //right click options for idea thread
					title: 'Info',
					action: function(elm, d, i) {
						showThreadInfo(d.name.split('@#$')[1]);
						
					}
				   }
				]
			if(!isCrossProject||!project_role==0){
				[
					{
						title: 'Info',
						action: function(elm, d, i) {
							showThreadInfo(d.name.split('@#$')[1]);
							
						}
					},
					{
						title: 'Color Label',
						action: function(elm, d, i) {
							 $('#thread_color_label_modal').modal("open"); 
							 $('#t_heading').text(d.name.split('@#$')[0]);
							 $('#t_name').val(d.name.split('@#$')[0]);
							 $('#t_id').val(d.name.split('@#$')[1]);
							 generateColorWheelThread(d.name.split('@#$')[0]);
						}
					},
					
				]
			
			
			}
			
		
			width = window.innerWidth-margin.right;
			
			console.log(width);
			console.log(height);
			var svg = d3.select("#viz_container").append("svg")
				    .attr("viewBox", "0 0 " + width + " " + height )
        			.attr("preserveAspectRatio", "xMidYMid meet")
				  	.append("g")
				    .attr("transform", "translate(155,-15)");
				 
				 svg.call(tip);
			
				
				 
			function mydata(treeData) {
				  root = treeData;
				  root.x0 = height / 2;
				  root.y0 = 0;

			function collapse(d) {
				    if (d.children) {
				      d._children = d.children;
				      d._children.forEach(collapse);
				      d.children = null;
				    }
				  }
				  root.children.forEach(collapse);
				  update(root);
				}
				mydata(projectData);
				d3.select(self.frameElement).style("height", "650px");
				
				function checkMyFocus(wid){
					var json = {
		  					"database" :localdb ,
		  					"token" : token,
		  					"area" : name,
		  					"wid" : wid,
		  					"author_id" : id
		  				};
		  		$.ajax({
		  			url :  "/WSG/wondering_area/color_label/text/get",
		  			type : "POST",
		  			data : JSON.stringify(json),
		  			dataType : "json",
		  			success : function(data, textStatus,jqXHR) {
		  				var json1 = $.parseJSON(data.obj);
		  				if(data.code!=="failure"){
		  					for(var i = 0 ; i < json1.length ; i++){
		  						if(json1[i].my_focus=='yes'){
		  							area.push(json1[i].wondering_area);
		  				}
		  					}
		  				}
		  			},
		  			error : function(jqXHR, textStatus, errorThrown) {
		  			}
		  		});
				}	
			function update(source) {

				  // Compute the new tree layout.
				  var nodes = tree.nodes(root).reverse(),
				      links = tree.links(nodes);

				  // Normalize for fixed-depth.
				  nodes.forEach(function(d) { d.y = d.depth * (window.innerWidth-margin.right-250)/2; });

				  // Update the nodes…
				  var node = svg.selectAll("g.node")
				      .data(nodes, function(d) { return d.id || (d.id = ++i); });

				  // Enter any new nodes at the parent's previous position.
				  var nodeEnter = node.enter().append("g")
				      .attr("class", "node")
				      .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; })
				      .on("click", click)
				      .style("pointer-events", "all");
				 
				  d3.contextMenu = function (projectMenu,wonderingAreaMenu,threadMenu, openCallback) {
						
						// create the div element that will hold the context menu
						d3.selectAll('.d3-context-menu').data([1])
							.enter()
							.append('div')
							.attr('class', 'd3-context-menu');

						// close menu
						d3.select('body').on('click.d3-context-menu', function() {
							d3.select('.d3-context-menu').style('display', 'none');
						});

						return function(data, index) {
							if (data.children) {
							    data._children = data.children;
							    data.children = null;
							    checkMyFocus(data.name.split('@#$')[1]);
								} 
							  else {
							    data.children = data._children;
							    data._children = null;
							    checkMyFocus(data.name.split('@#$')[1]);
								}
							
							if(wonderingarea.indexOf(data.name)!==-1){
							d3.selectAll('.d3-context-menu').html('');
							var list = d3.selectAll('.d3-context-menu').append('ul');
							list.selectAll('li').data(wonderingAreaMenu).enter()
								.append('li')
								.html(function(d) {
									if(focusedarea.length>0){
										for(var m=0;m<focusedarea.length;m++){
											if(focusedarea[m]==data.name){
												return d.changetitle;
											}
										}
										for(var m=0;m<focusedarea.length;m++){
											if(focusedarea[m]!=data.name){
												return d.title;
											}
											
										}
									}
									else{
										return d.title;
									}
								})
								.on('click', function(d, i) {
									if(focusedarea.length>0){
										for(var m=0;m<focusedarea.length;m++){
											if(focusedarea[m]==data.name){
												d.changeaction(elm,data, index);
												d3.select('.d3-context-menu').style('display', 'none');
											}
											else{
												d.action(elm, data, index);
												d3.select('.d3-context-menu').style('display', 'none');
											}
										}
									}
									else{
										d.action(elm, data, index);
										d3.select('.d3-context-menu').style('display', 'none');
									}
								});
							if (openCallback) openCallback(data, index);

							// display context menu
							d3.select('.d3-context-menu')
								.style('left', (d3.event.pageX - 2) + 'px')
								.style('top', (d3.event.pageY - 2) + 'px')
								.style('display', 'block');

							d3.event.preventDefault();
							}
							else if(threadname.indexOf(data.name)!==-1){
									var elm = this;
									
									d3.selectAll('.d3-context-menu').html('');
									var list = d3.selectAll('.d3-context-menu').append('ul');
									list.selectAll('li').data(threadMenu).enter()
										.append('li')
										.html(function(d) {
											return d.title;
										})
										.on('click', function(d, i) {
											d.action(elm, data, index);
											d3.select('.d3-context-menu').style('display', 'none');
										});
									if (openCallback) openCallback(data, index);

									// display context menu
									d3.select('.d3-context-menu')
										.style('left', (d3.event.pageX - 2) + 'px')
										.style('top', (d3.event.pageY - 2) + 'px')
										.style('display', 'block');

									d3.event.preventDefault();
									
							}
							else{

								var elm = this;
								
								d3.selectAll('.d3-context-menu').html('');
								var list = d3.selectAll('.d3-context-menu').append('ul');
								list.selectAll('li').data(projectMenu).enter()
									.append('li')
									.html(function(d) {
										return d.title;
									})
									.on('click', function(d, i) {
										d.action(elm, data, index);
										d3.select('.d3-context-menu').style('display', 'none');
									});
								if (openCallback) openCallback(data, index);

								// display context menu
								d3.select('.d3-context-menu')
									.style('left', (d3.event.pageX - 2) + 'px')
									.style('top', (d3.event.pageY - 2) + 'px')
									.style('display', 'block');

								d3.event.preventDefault();
								
							}
						};
					};
				  
					
					
				  nodeEnter.append("circle")
				      .attr("r", function(d) { return d._children ? 15 : 22 })
				      .style("fill", function(d) {
				      if(focusedarea.length>0){
				    	  for(var i=0;i<focusedarea.length;i++){
				    		  if(focusedarea[i]==d.name){
				    			  return "green";
				    		  }
				    	  }
				    	  for(var i=0;i<focusedarea.length;i++){
				    		  if(focusedarea[i]!=d.name){
				    			  return color;
				    		  }
				    	  }
				      }
				    	  else {
				    		  return color;
				    	  }
				      })
				      .attr('cursor', 'pointer')
						.style("pointer-events", "all")
						.on('contextmenu', d3.contextMenu(projectMenu,wonderingAreaMenu,threadMenu));
				
				  nodeEnter.append("circle")
			      .attr("r", "11")
			      .style("fill", function(d) { 
			    	  if(focusedarea.length>0){
				    	  for(var i=0;i<focusedarea.length;i++){
				    		  if(focusedarea[i]==d.name){
				    			  return "green";
				    		  }
				    	  }
				      }
				    		var sorted_arr = threadname.slice().sort(); 
                        	var results = [];
							for (var i = 0; i < threadname.length - 1; i++) {
								if (sorted_arr[i + 1] == sorted_arr[i]) {
									results.push(sorted_arr[i]);
								}
							}
							if(results.indexOf(d.name) !== -1){
				    	  return "black"; 
				      	}
							else{
								return color;
							}
			    	
			      })
			      .attr('cursor', 'pointer')
				 .style("pointer-events", "all")
				 .on('contextmenu', d3.contextMenu(projectMenu,wonderingAreaMenu,threadMenu));
				  
			var images = nodeEnter.append("svg:image")
			        .attr("xlink:href", function(d){
			        			return d._children ? '../../images/plus-512.gif' :'../../images/minus-sign.png';	
			        		
			        	})
			        .attr("x",-13)
			        .attr("y",-12)
			        .attr("height", 25)
			        .attr("width", 25)
			        .attr('cursor', 'pointer')
			        .on('contextmenu', d3.contextMenu(projectMenu,wonderingAreaMenu,threadMenu))
			        .on('click',function(d){
			        	 if(d.parent != null && d.children == null){
			    		  
			    		  d3.select(this).attr("xlink:href", "../../images/minus-sign.png");
			    	  }
			    	  else{
			    		  d3.select(this).attr("xlink:href", "../../images/plus-512.gif");
			    	  }
			        	
			      })
					  .on('mouseover', tip.show)
				      .on('mouseout', tip.hide); 
				  
				  nodeEnter.append("text")
				      .attr("x", function(d) { return d.children || d._children ? -10 : 10; })
				      .attr("dy", function(d){
				    	  if(threadname.indexOf(d.name) !== -1){
				    		  return "-17px"
				    	  }
				    	  return "40px";
				      })
				      .attr("text-anchor", "middle")
				      .style("font-size","20px")
				      .attr('cursor', 'pointer')
				      .text(function(d) { 
				    		var sorted_arr = threadname.slice().sort(); 
                          	var results = [];
							for (var i = 0; i < threadname.length - 1; i++) {
								if (sorted_arr[i + 1] == sorted_arr[i]) {
									results.push(sorted_arr[i]);
								}
							}
							if(d.name == (null+'@#$'+null) ){
								return 'No thread yet';
							}
							if(results.indexOf(d.name) !== -1){
				    	  return d.name.split('@#$')[0].replace("\"","\\\""); 
				      	}
							else{
								return d.name.split('@#$')[0].replace("\"","\\\"");
							}
				      })
				      .style("fill-opacity", 1e-6)
				      .style("fill", function(d) {
				    		if(area_color.length>0){
				    			for(var n = 0; n < area_color.length; n++){
				    				var str = area_color[n];
				    				str = str.substring(0, str.indexOf('_'));
				    				if(str == d.name){
				    					var label_color = area_color[n].replace(d.name+"_","");
				    					return label_color;
				    				}
				    			}
				    			for(var n = 0; n < area_color.length; n++){
				    				var str = area_color[n];
				    				str = str.substring(0, str.indexOf('_'));
				    				if(str != d.name){
				    					var label_color = area_color[n].replace(d.name+"_","");
				    					return "#666666";
				    				}
				    			}
				    		}
				    		else{
				    			return "#666666";
				    		}
				    	
			    	  })
				      .style("text-weight","bold")
				      .on('contextmenu', d3.contextMenu(projectMenu,wonderingAreaMenu,threadMenu));
						  
			var nodeUpdate = node.transition()
				      .duration(duration)
				      .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

				  nodeUpdate.select("circle")
				      .attr("r", function(d) { return d._children ? 15 : 22 })
				      .style("fill", function(d) { 
				    	  if(focusedarea.length>0){
					    	  for(var i=0;i<focusedarea.length;i++){
					    		  if(focusedarea[i]==d.name){
					    			  return "green";
					    		  }
					    	  }
					    	  for(var i=0;i<focusedarea.length;i++){
					    		  if(focusedarea[i]!=d.name){
					    			  return color;
					    		  }
					    	  }
					      }
					      else{
					    	  return color;
					      }
				   });

				  nodeUpdate.select("text")
				      .style("fill-opacity", 1)
				      .style("text-weight","bold")
				      .style("fill", function(d) { 
				    	  if(area_color.length>0){
				    			for(var n = 0; n < area_color.length; n++){
				    				var str = area_color[n];
				    				str = str.substring(0, str.indexOf('_'));
				    				if(str == d.name){
				    					var label_color = area_color[n].replace(d.name+"_","");
				    					return label_color;
				    				}
				    			}
				    			for(var n = 0; n < area_color.length; n++){
				    				var str = area_color[n];
				    				str = str.substring(0, str.indexOf('_'));
				    				if(str != d.name){
				    					var label_color = area_color[n].replace(d.name+"_","");
				    					return "#666666";
				    				}
				    			}
				    		}
				    		else{
				    			return "#666666";
				    		}
				      });
			var nodeExit = node.exit().transition()
				      .duration(duration)
				      .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
				      .remove();

				  nodeExit.select("circle")
				      .attr("r", 1e-4);

				  nodeExit.select("text")
				      .style("fill-opacity", 1e-4);

			var link = svg.selectAll("path.link")
				      .data(links, function(d) { return d.target.id; });
				  
			link.enter().insert("path", "g")
				      .attr("class", "link")
				      .attr("fill","none")
				      .style("opacity", ".1")
				      .attr("stroke", function(d) {
				    	  if(area_color.length>0){
				    			for(var n = 0; n < area_color.length; n++){
				    				var str = area_color[n];
				    				str = str.substring(0, str.indexOf('_'));
				    				if(str == d.target.name){
				    					var label_color = area_color[n].replace(d.target.name+"_","");
				    					return label_color;
				    				}
				    			}
				    			for(var n = 0; n < area_color.length; n++){
				    				var str = area_color[n];
				    				str = str.substring(0, str.indexOf('_'));
				    				if(str != d.target.name){
				    					var label_color = area_color[n].replace(d.target.name+"_","");
				    					return "#666666";
				    				}
				    			}
				    	  }
				    	  else{
				    		  return "#666666";
				    	  }
				      })
				      .attr("stroke-width",function(d){
				    	  if(area_size.length>0){
				    			for(var n = 0; n < area_size.length; n++){
				    				var str = area_size[n];
				    				str = str.substring(0, str.indexOf('_'));
				    				if(str == (d.source.name.split('@#$')[0]+"/"+d.target.name.split('@#$')[0])){
				    					var stroke_size = area_size[n].replace(d.source.name.split('@#$')[0]+"/"+d.target.name.split('@#$')[0]+"_","");
				    					if(stroke_size>7 && stroke_size<160){
				    					return stroke_size/7;
				    					}
				    					else if(stroke_size>=160){
				    						return 24;
				    					}
				    					else{
				    						return 2
				    					}
				    				}
				    			}
				    			for(var n = 0; n < area_size.length; n++){
				    				var str = area_size[n];
				    				str = str.substring(0, str.indexOf('_'));
				    				if(str != (d.source.name.split('@#$')[0]+"/"+d.target.name.split('@#$')[0])){
				    					return 2; 
				    				}
				    			}
				    		}
				    	  return 2;
				      })
				      .attr("d", function(d) {
				        var o = {x: source.x0, y: source.y0};
				        return diagonal({source: o, target: o});
				      })
				      .style("pointer-events", "all")
				      .on('mouseover', tip.show)
				      .on('mouseout', tip.hide);

			link.transition()
				      .duration(duration)
				      .attr("d", diagonal);
			link.exit().transition()
				      .duration(duration)
				      .attr("d", function(d) {
				        var o = {x: source.x, y: source.y};
				        return diagonal({source: o, target: o});
				      })
				      .remove();
			nodes.forEach(function(d) {
				    d.x0 = d.x;
				    d.y0 = d.y;
				  });
				}

			function click(d) {if(d._children == null){
				d3.select(this).attr("xlink:href", "../../images/plus-512.gif");
				update(d);
				}
				if(d.name!=(null+'@#$'+null)){
				if (d.children ) {
				    d._children = d.children;
				    d.children = null;
				    if(threadname.length>0){
				    	if(threadname.indexOf(d.name) !== -1){
					    	 var tname=d.name.split('@#$')[0];
							 var tid=d.name.split('@#$')[1];
							 tip.hide();
								d3.select("svg").remove();
								callAjaxfunc(function() {
								});   
							 window.open("../../thread/thread.jsp?localdb="+localdb+"&community_id="+community_id+"&project_id="+project_id+"&thread_id="+tid);
						
						}
					}
				} 
				  else {
				    d.children = d._children;
				    d._children = null;
				    if(threadname.length>0){
				    	if(threadname.indexOf(d.name) !== -1){
						    	 var tname=d.name.split('@#$')[0];
								 var tid=d.name.split('@#$')[1];
								 tip.hide();
									d3.select("svg").remove();
									callAjaxfunc(function() {
									});   
								 window.open("../../thread/thread.jsp?localdb="+localdb+"&community_id="+community_id+"&project_id="+project_id+"&thread_id="+tid);
										
				}
				}
				}
				}
				  
				update(d);
				}
		}
		
		

		
		function ideaThreadRestore(t_id){
			var jsonData = {
					"database" :localdb ,
					"token" : token,
					"tid" : parseInt(t_id)
					};
				$.ajax({
					url :  "/WSG/idea_thread/deleted/restore",
					type : "POST",
					data : JSON.stringify(jsonData),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						location.reload();
					}
				});
		}
		
		function wonderingAreaRestore(w_id){
			var jsonData = {
					"database" :localdb ,
					"token" : token,
					"wid" : parseInt(w_id)
					};
				$.ajax({
					url :  "/WSG/wondering_area/deleted/restore",
					type : "POST",
					data : JSON.stringify(jsonData),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						location.reload();
					}
				});
		}
			
		function add_thread_click(wondering_area_id,wondering_area) {
			$("#wondering_area").html("");
			// get all wonderng area
			initWondering_area_in_Add_thread(wondering_area_id,wondering_area)
			$("#add_thread_modal").modal("open");
			
		}
		function add_wf_click(id) {
			$("#wf_name").val("");
			
			var userdata = {
					"database" : localdb,
					"token" : token,
					"projectid" : project_id
				};
			$.ajax({
				url :  "/WSG/project/thread/get",
				type : "POST",
				data : JSON.stringify(userdata),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					var json = $.parseJSON(data.obj);
					if(null!=json){
						$("#thread_checkboxes").html(" ");
						for (var i = 0; i < json.length; i++) {
							
							var p = '<p><input type="checkbox" data-id="'+json[i].thread_id+'" id="t'+json[i].thread_id+'" /><label for="t'+json[i].thread_id+'">'+json[i].threadfocus+'</label></p>';
							$("#thread_checkboxes").append(p);
							
						}
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
						$('#add_field_modal').modal("open");
					}
		function showAreaInfo(areaid){
			// get thread info 
			var projectdata = {
					"database" :localdb ,
					"token" : token,
					"wid" :areaid,
				};
				$.ajax({
							url :  "/WSG/wondering_area/info/get",
							type : "POST",
							data : JSON.stringify(projectdata),
							dataType : "json",
							success : function(data, textStatus,jqXHR) {
								var json = $.parseJSON(data.obj);
								if(null!=json){
									$("#area_info_modal").modal("open");
									$('p').remove();
									$("#area_id").val(areaid);
									$("#wa_name").val(json[0].name);
									$("#wa_name").text(json[0].name);
									 $("#overarching_questions").val(json[0].overarching_questions);
									 $("#whyimportant").val(json[0].why_important);
									 $("#area_message").val(json[0].message);
									 $("#wf_keywords").val(json[0].keywords);
									 var words=[];
									 if(json[0].keywords !== null){
										 var kword=json[0].keywords.split(',')
											for(var i in kword){
												if(kword[i]!=""){
													words.push({tag:kword[i]})
												}
												
											}
									 }
									 $.ajax({
											url :  "/WSG/focus_members/get",
											type : "POST",
											data : JSON.stringify(projectdata),
											dataType : "json",
											success : function(data, textStatus,jqXHR) {
												var json1 = $.parseJSON(data.obj);
												console.log(json);
												if(json1!=null){
													$('#focus_members').append('<p style="font-size:24px;font-weight:bold">List of focus group member(s) : </p>');
													for(var m = 0;m< json1.length;m++){
													$('#focus_members').append('\n<p>'+json1[m].last_name+" "+json1[m].first_name+'</p>\n');
													}
												}
											}
								}) 
									
									$('.chips-placeholder').material_chip({
										placeholder : 'Enter a keyword',
										secondaryPlaceholder : '+Keyword',
									});
									if(words!=[]){
										 $('.chips-placeholder').material_chip({
											  data:words
										  });
									}
									 Materialize.updateTextFields();
								}
							}
				})
			
		}
		
		function addMyFocus(area,wid,my_focus){
			var jsonData = {
					"database" :localdb ,
					"token" : token,
					"area" : area,
					"wid" : wid,
					"my_focus" : my_focus.replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
					"author_id" : id,
					"project_id" : project_id
				};
			
		$.ajax({
			url :  "/WSG/wondering_area/check/get",
			type : "POST",
			data : JSON.stringify(jsonData),
			dataType : "json",
			success : function(data, textStatus,jqXHR) {
				if(data.code=="failure"){
					$.ajax({
						url :  "/WSG/wondering_area/focus/add",
						type : "POST",
						data : JSON.stringify(jsonData),
						dataType : "json",
						success : function(data, textStatus,jqXHR) {
							location.reload();
						},
						error : function(jqXHR, textStatus,	errorThrown) {
						}
					});
				}
				else{
					$.ajax({
						url :  "/WSG/wondering_area/focus/update",
						type : "POST",
						data : JSON.stringify(jsonData),
						dataType : "json",
						success : function(data, textStatus,jqXHR) {
							location.reload();
						},
						error : function(jqXHR, textStatus, errorThrown) {
						}
					});
				}
				
			},
			error : function(jqXHR, textStatus,
					errorThrown) {
			}
		});
		}
		
		function initWondering_area(){
			var userdata = {
					"database" : localdb,
					"token" : token,
					"pid" : project_id,
					"authorid" :id,
				};
			$.ajax({
				url :  "/WSG/wondering_area/get/byprojectid",
				type : "POST",
				data : JSON.stringify(userdata),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					var json = $.parseJSON(data.obj);
					if(null!=json){
						for (var i = 0; i < json.length; i++) {
							wondering_area_id.push(json[i].id);
							wondering_area_name.push(json[i].name);
							
							p = $("<p/>");
							p.append('<input type="checkbox" name="mwf_chkbox" class="mwf_1234" data-id="'+json[i].id+'" id="mwf'+json[i].id+'" /><label for="mwf'+json[i].id+'">'+json[i].name+'</label>');
							$("#wbox").append(p);
						}
					}
					//s.refresh();
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
		}
		
		
		function initWondering_area_in_Add_thread(wondering_area_id,wondering_area){
			///wondering_area/get
			var userdata = {
				"database" : localdb,
				"token" : token,
				"pid" : project_id
			};
			$.ajax({
				url :  "/WSG/wondering_area/get/byprojectid",
				type : "POST",
				data : JSON.stringify(userdata),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					var json = $.parseJSON(data.obj);
					if(null!=json){
						$("#wf_title").text(" ");
						for (var i = 0; i < json.length; i++) {
							
							if(json[i].name==wondering_area && json[i].id==wondering_area_id){
								var p = '<p><input type="checkbox" checked="checked" disabled="disabled" data-id="'+json[i].id+'" id="wf'+json[i].id+'" /><label for="wf'+json[i].id+'">'+json[i].name+'</label></p>';
								$("#wf_title").append(p);
							}
							else{
							var p = '<p><input type="checkbox" data-id="'+json[i].id+'" id="wf'+json[i].id+'" /><label for="wf'+json[i].id+'">'+json[i].name+'</label></p>';
							$("#wf_title").append(p);
							}
						}
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
		}
		
		function initThread(){
			var projectdata = {
					"database" :localdb ,
					"token" : token,
					"projectid":project_id
				};

				$.ajax({
							url :  "/WSG/project/thread/get",
							type : "POST",
							data : JSON.stringify(projectdata),
							dataType : "json",
							success : function(data, textStatus, jqXHR) {	
								var json = $.parseJSON(data.obj);
								if(null!=json){
									$('#thread_checkboxes').html(" ");
								
									
									
									for (var i = 0; i < json.length; i++) {
										p = $("<p/>");
										p.append('<input type="checkbox" id="mthread'+json[i].id+'" /><label for="mthread'+json[i].id+'">'+json[i].threadfocus+'</label>');
										$("#tbox").append(p);
										
									}
									
									//s.refresh();

									var linkdata = {
											"database" :localdb ,
											"token" : token,
											"pid":project_id
									};

									$.ajax({
												url :  "/WSG/wondering_area/thread/get/byprojectid",
												type : "POST",
												data : JSON.stringify(linkdata),
												dataType : "json",
												success : function(data, textStatus, jqXHR) {
													var json = $.parseJSON(data.obj);
													
												},
												error : function(jqXHR, textStatus,
														errorThrown) {
													console.log(jqXHR.responseText);
												}
											});
								}
								
							},
							error : function(jqXHR, textStatus, errorThrown) {
								//console.log(jqXHR.responseText);
							}
						});
		}
		
		
		
		
		$(document).ready(function() {
			d3.select(window)
			  .on("resize", function() {
				  tip.hide();
				  d3.selectAll("svg").remove()
					drawTree(projectData1); 
			  });
			
			
			$(document).on(
					'click',
					'.wf-button',
					function() {
						$('#field_click_modal').modal("open");
						//console.log($(this).text());
						$('#click_modal_field_name').text(
								$(this).text());
					});
			$(document).on(
					'click',
					'.thread_button',
					function() {
						$('#thread_click_modal').modal("open");
						//console.log($(this).parent().text());
						$('#click_modal_thread_name').text(
								$(this).parent().text());
					});
							$("#add_wf").click(	function() {$("#wf_name").val("");
												$.ajax({
															type : "GET",
															url : "thread.json",
															dataType : "json",
															success : function(data) {
																$.each(data.thread,
																				function(
																						i,
																						item) {
																					$(
																							"#thread_checkboxes")
																							.append(
																									'<p><input type="checkbox" id="'+i+'" /> <label for="'+i+'">'
																											+ item.name
																											+ '</label></p>');
																				})
															}

														})
												$('#add_field_modal').modal("open");
											});
							
				  			
							
							// add wondering area
							$("#wf_finish").click(function() {
								if($("#wf_name").val()!=""){
												var keywords = $('#area_keywords').material_chip('data')
												var keyword = "";
												for(var i in keywords){
													keyword=keyword+keywords[i].tag+","
												}
												var wfdata = {
													};

													wfdata = {
															"database" : localdb,
															"token" : token,
															"wname" : $("#wf_name").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
															"logo" : ($(".materialboxed").attr("src")=="")?"":$(".materialboxed").attr("src"),
															"keywords" : keyword,
															"wstatus" : "accepted",
															"overarchingquestions" : $("#questions").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
															"whyimportant" : $("#why_important").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
															"authorid" :id,
															"wcreatetime":new Date(),
															"message" : $("#message").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
															"project_id":project_id
														};
													
												
												
												$.ajax({
													url :  "/WSG/wondering_area/add",
													type : "POST",
													data : JSON.stringify(wfdata),
													dataType : "json",
													success : function(data,textStatus,jqXHR) {
														if(data.code=="success"){
															  if($.trim(data.desc)!=$.trim("No data aviliable.")){
																	var wid=data.obj[0]["GENERATED_KEY"];
																	// add wid with thread
																	$('#thread_checkboxes input:checked').each(function(e) {
																		var threadid=$(this).data("id");
																		var json = {
																				"database" :localdb ,
																				"token" : token,
																				"threadid" : threadid,
																				"areaid" : wid
																			};

																		$.ajax({
																			url :  "/WSG/thread/wondering/add",
																			type : "POST",
																			data : JSON.stringify(json),
																			dataType : "json",
																			success : function(data, textStatus, jqXHR) {
																				
																			}
																			})
																		
																	})
																	
																	//add wid with project
																	var json = {
																			"database" :localdb ,
																			"token" : token,
																			"pid" : parseInt(project_id),
																			"areaid" : parseInt(wid)
																		};

																	$.ajax({
																		url :  "/WSG/project/wondering/add",
																		type : "POST",
																		data : JSON.stringify(json),
																		dataType : "json",
																		success : function(data, textStatus, jqXHR) {
																			
																		}
																		})
															  	}
															  }
														location.reload();
															}															
														});
							}
								else{
									 Materialize.toast('Please enter wondering area name!', 3000); 
								}
											});

							$("#wf_done").click(function() {
							});
							
							
							$("#color_label_finish").click(function(){
								var selectedWonderingArea = $('#wonderingAreaText').val();
								var selectedColor = $('#selectedColor').val();
								var wid = $('#wonderingAreaId').val();
								var json = {
										"database" :localdb ,
										"token" : token,
										"area" : selectedWonderingArea,
										"wid" : parseInt(wid),
										"color_label" : selectedColor,
										"author_id" : id,
										"project_id" : project_id
									};
								
							$.ajax({
								url :  "/WSG/wondering_area/check/get",
								type : "POST",
								data : JSON.stringify(json),
								dataType : "json",
								success : function(data, textStatus,jqXHR) {
									if(data.code=="failure"){
										$.ajax({
											url :  "/WSG/wondering_area/color_label/add",
											type : "POST",
											data : JSON.stringify(json),
											dataType : "json",
											success : function(data, textStatus,jqXHR) {
												location.reload();
											},
											error : function(jqXHR, textStatus, errorThrown) {
											}
										});
									}
									else{
										$.ajax({
											url :  "/WSG/wondering_area/color_label/update",
											type : "POST",
											data : JSON.stringify(json),
											dataType : "json",
											success : function(data, textStatus,jqXHR) {
												location.reload();
											},
											error : function(jqXHR, textStatus,
													errorThrown) {
											}
										});
									}
									
								},
								error : function(jqXHR, textStatus,	errorThrown) {
								}
							});
								
							});
							
							
							$("#thread_color_label_finish").click(function(){
								var t_color = $('#t_color').val();
								var tid = $('#t_id').val();
								var json = {
										"database" :localdb ,
										"token" : token,
										"tid" : parseInt(tid),
										"color_label" : t_color,
										"author_id" : id,
										"project_id" : project_id
									};
								
							$.ajax({
								url :  "/WSG/thread/check/get",
								type : "POST",
								data : JSON.stringify(json),
								dataType : "json",
								success : function(data, textStatus,jqXHR) {
									if(data.code=="failure"){
										$.ajax({
											url :  "/WSG/thread/color_label/add",
											type : "POST",
											data : JSON.stringify(json),
											dataType : "json",
											success : function(data, textStatus,jqXHR) {
												location.reload();
											},
											error : function(jqXHR, textStatus, errorThrown) {
											}
										});
									}
									else{
										$.ajax({
											url :  "/WSG/thread/color_label/update",
											type : "POST",
											data : JSON.stringify(json),
											dataType : "json",
											success : function(data, textStatus,jqXHR) {
												location.reload();
											},
											error : function(jqXHR, textStatus,
													errorThrown) {
											}
										});
									}
									
								},
								error : function(jqXHR, textStatus,	errorThrown) {
								}
							});
								
							});
							
							
							
							// add thread to project
							$("#add_thread").click(function() {
								$("#wondering_area").html("");
								// get all wonderng area
								initWondering_area_in_Add_thread()
								$("#add_thread_modal").modal("open");
							});

						});
		
		
		
		
		

function generateColorWheel(name){
		    var bCanPreview = true; // can preview

		    // create canvas and context objects
		    var canvas = document.getElementById('picker');
		    var ctx = canvas.getContext('2d');

		    // drawing active image
		    var image = new Image();
		    image.onload = function () {
		        ctx.drawImage(image, 0, 0, image.width, image.height); // draw the image on the canvas
		    }

		    // select desired colorwheel
		    var imageSrc = '../../images/colorwheel1.png';
		    
		    image.src = imageSrc;

		    $('#picker').mousemove(function(e) { // mouse move handler
		        if (bCanPreview) {
		            // get coordinates of current position
		            var canvasOffset = $(canvas).offset();
		            var canvasX = Math.floor(e.pageX - canvasOffset.left);
		            var canvasY = Math.floor(e.pageY - canvasOffset.top);

		            // get current pixel
		            var imageData = ctx.getImageData(canvasX, canvasY, 1, 1);
		            var pixel = imageData.data;

		            // update preview color
		            var pixelColor = "rgb("+pixel[0]+", "+pixel[1]+", "+pixel[2]+")";
					
		            // update controls
		            var dColor = pixel[2] + 256 * pixel[1] + 65536 * pixel[0];
		            $('#hexVal').val('#' + ('0000' + dColor.toString(16)).substr(-6));
		            nodeColor='#' + ('0000' + dColor.toString(16)).substr(-6);
		            
		        }
		    });
		    $('#picker').click(function(e) { // click event handler
		        bCanPreview = !bCanPreview;
		        var canvasOffset = $(canvas).offset();
	            var canvasX = Math.floor(e.pageX - canvasOffset.left);
	            var canvasY = Math.floor(e.pageY - canvasOffset.top);

	            // get current pixel
	            var imageData = ctx.getImageData(canvasX, canvasY, 1, 1);
	            var pixel = imageData.data;

		        var dColor = pixel[2] + 256 * pixel[1] + 65536 * pixel[0];
		        nodeColor='#' + ('0000' + dColor.toString(16)).substr(-6);
		        $('#wonderingArea').css({'color':nodeColor})
		        $('#selectedColor').val(nodeColor);
		        
		    }); 
		    $('.preview').click(function(e) { // preview click
		       
		        bCanPreview = true;
		    });
		    
		};
					
		function generateColorWheelThread(name){
		    var bCanPreview = true; // can preview

		    // create canvas and context objects
		    var canvas = document.getElementById('picker_thread');
		    var ctx = canvas.getContext('2d');

		    // drawing active image
		    var image = new Image();
		    image.onload = function () {
		        ctx.drawImage(image, 0, 0, image.width, image.height); // draw the image on the canvas
		    }

		    // select desired colorwheel
		    var imageSrc = '../../images/colorwheel1.png';
		    
		    image.src = imageSrc;

		    $('#picker_thread').mousemove(function(e) { // mouse move handler
		        if (bCanPreview) {
		            // get coordinates of current position
		            var canvasOffset = $(canvas).offset();
		            var canvasX = Math.floor(e.pageX - canvasOffset.left);
		            var canvasY = Math.floor(e.pageY - canvasOffset.top);

		            // get current pixel
		            var imageData = ctx.getImageData(canvasX, canvasY, 1, 1);
		            var pixel = imageData.data;

		            // update preview color
		            var pixelColor = "rgb("+pixel[0]+", "+pixel[1]+", "+pixel[2]+")";
		            /* $('.preview').css('backgroundColor', pixelColor); */
					
		            // update controls
		            var dColor = pixel[2] + 256 * pixel[1] + 65536 * pixel[0];
		            $('#hexVal').val('#' + ('0000' + dColor.toString(16)).substr(-6));
		            nodeColor='#' + ('0000' + dColor.toString(16)).substr(-6);
		            
		        }
		    });
		    $('#picker_thread').click(function(e) { // click event handler
		        bCanPreview = !bCanPreview;
		        var canvasOffset = $(canvas).offset();
	            var canvasX = Math.floor(e.pageX - canvasOffset.left);
	            var canvasY = Math.floor(e.pageY - canvasOffset.top);

	            // get current pixel
	            var imageData = ctx.getImageData(canvasX, canvasY, 1, 1);
	            var pixel = imageData.data;

		        var dColor = pixel[2] + 256 * pixel[1] + 65536 * pixel[0];
		        nodeColor='#' + ('0000' + dColor.toString(16)).substr(-6);
		        $('#t_heading').css({'color':nodeColor})
		        $('#t_color').val(nodeColor);
		        
		    }); 
		    $('.preview').click(function(e) { // preview click
		       
		        bCanPreview = true;
		    });
		    
		};
		getDataForTree();
	
		function getDataForTree(){
		callAjaxfunc(function() {
		});
	}
	
	function callAjaxfunc(callback){
		d3.selectAll("svg").remove();
		var projectdata = {
				"database" : localdb,
				"token" : token,
				"project_id" : project_id
			};
			$.ajax({
				url :  "/WSG/project/wondering_area/thread/get", //get the data for tree visualization
				type : "POST",
				data : JSON.stringify(projectdata),
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					var json = $.parseJSON(data.obj);
					var unique_area_id = [];
					if(null!=json){
						for(var j = 0; j < json.length;j++){
								threadname.push(json[j].thread_name+"@#$"+json[j].thread_id); // store the data in arrays
								wonderingarea.push(json[j].wondering_area+"@#$"+json[j].wondering_area_id);
								projecttitle.push(json[j].project_title+"@#$"+json[j].project_id);
								overarching_questions.push(json[j].wondering_area+"@#$"+json[j].overarching_questions);
								unique_area_id.push(json[j].wondering_area_id);
			
						}
					}
					
					
	  				$.each(unique_area_id, function(i, el){
	  				    if($.inArray(el, area_id) === -1) area_id.push(el);
	  				});
	  				
					var nest = d3.nest()  //nesting the data for the visualization
				    	.key(function(json) {
				            	return json.project_title +"@#$" +json.project_id;
				        })
				        .key(function(json) {
				        		 return json.wondering_area +"@#$" +json.wondering_area_id;
				        })
				        .key(function(json) {
				            return json.thread_name +"@#$" +json.thread_id;
				        })
				        .entries(json);
					
					
					var nest1 = JSON.stringify(nest);
					projectData1 = nest1.slice(1, -1);
					 
					var regex = new RegExp("key", 'g');
					projectData1 = projectData1.replace(regex, 'name'); //replacing "key" with "name"
					 
					var regex1 = new RegExp("values", 'g');
					projectData1 = projectData1.replace(regex1, 'children'); //replacing "values" with "children"
					
				},
					
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
				
			}).done(function(){ // executes this part only if the async method has been successfully executed
				var getAreaColor = {
						"database" : localdb,
						"token" : token,
						"project_id" : project_id,
						"author_id" : id
					};
					$.ajax({
						url :  "/WSG/color_label/get", //get the data for wondering area label color
						type : "POST",
						data : JSON.stringify(getAreaColor),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							var json = $.parseJSON(data.obj);
							if(json!=null){
								for(var m = 0; m < json.length; m++){
									if(json[m].color_label!=null){
										area_color.push(json[m].wondering_area+"@#$"+json[m].wondering_area_id +"_" +json[m].color_label);
									}
									else{
										
									}
								}
							}
							
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}
						
					});
					$.ajax({
						url :  "/WSG/thread/color_label/get", // get the data for idea thread color label
						type : "POST",
						data : JSON.stringify(getAreaColor),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							var json = $.parseJSON(data.obj);
							if(json!=null){
								for(var m = 0; m < json.length; m++){
									if(json[m].color_label!=null){
										area_color.push(json[m].thread_name+"@#$"+json[m].thread_id+"_" +json[m].color_label);
									}
									else{
										
									}
								}
							}
							
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}
						
					});
					var json = {
		  					"database" :localdb ,
		  					"token" : token,
		  					"project_id" : project_id,
		  					"author_id" : id
		  				};
		  		$.ajax({
		  			url :  "/WSG/wondering_area/area/focus/get", //gets the list of focused wondering area for current user
		  			type : "POST",
		  			data : JSON.stringify(json),
		  			dataType : "json",
		  			success : function(data, textStatus,jqXHR) {
		  				var json1 = $.parseJSON(data.obj);
		  				if(data.code!=="failure"){
		  					for(var i = 0 ; i < json1.length ; i++){
		  						if(json1[i].my_focus=='yes'){
		  							focusedarea.push(json1[i].wondering_area+'@#$'+json1[i].wondering_area_id);
		  				}
		  					}
		  				}
		  			},
		  			error : function(jqXHR, textStatus, errorThrown) {
		  			}
		  		});
					
		  		$.ajax({
		  			url :  "/WSG/project/note/count/get",
		  			type : "POST",
		  			data : JSON.stringify(json),
		  			dataType : "json",
		  			success : function(data, textStatus,jqXHR) {
		  				var json1 = $.parseJSON(data.obj);
		  				for(var i = 0 ; i < json1.length ; i++){
		  					area_size.push(json1[i].project_title+"/"+json1[i].wondering_area+"_"+json1[i].size);
		  				}
		  				for(var i = 0 ; i < area_id.length ; i++){
		  					getAreaThreadSize(area_id[i]);
							}
		  				
		  			},
		  			error : function(jqXHR, textStatus, errorThrown) {
		  			}
		  		});
		  		var getFocusGroupMemebers = {
		  				"database" :localdb ,
	  					"token" : token,
	  					"project_id" : project_id
	  					}
		  		$.ajax({
					url :  "/WSG/focus_members/get/all/byprojectid", //gets the list of all the focued group members
					type : "POST",
					data : JSON.stringify(getFocusGroupMemebers),
					dataType : "json",
					success : function(data, textStatus,jqXHR) {
						var json1 = $.parseJSON(data.obj);
						if(json1!=null){
							console.log(json1);
							for(var m = 0; m < json1.length;m++){
								all_focused_group_memebers.push(json1[m].wondering_area_id+"@#$"+json1[m].first_name+" "+json1[m].last_name);
							}
							
						}
					}
		}) 
		  		setTimeout(function() { drawTree(projectData1); },600);
			});
	}
	
			
			$("#idea_thread_list").click(function(){
				$("#deleted_wonderingarea_ideathread_list_content").empty().html("");
				
				var jsonData = {
						"database" :localdb ,
						"token" : token,
						"pid" : parseInt(project_id)
						};
					$.ajax({
						url :  "/WSG/idea_thread/deleted/get",
						type : "POST",
						data : JSON.stringify(jsonData),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							var json = $.parseJSON(data.obj);
							console.log(data);
							if(json!=null){
								var html ="";
								
								html = html+"<table><tr><td><b>Idea thread </b></td><td><b>Wondering area</b></td><td><b>Restore</b></td></tr>"
								for(var  i=0; i< json.length;i++){
									html=html+"<tr><td>"+json[i].threadfocus+"</td><td>"+json[i].name+"</td><td><div onclick=\"ideaThreadRestore('"+json[i].id+"')\" class='btn'>Restore</div>"
								  		+"</tr>";	
								}
								html=html + "</table>";
								$("#deleted_wonderingarea_ideathread_list_content").append(html);
								
							}
							else{
								Materialize.toast("No deleted idea thread found in this project.",3000);
							}
						}
					})
			});
			
			$("#wondering_area_list").click(function(){
				$("#deleted_wonderingarea_ideathread_list_content").empty().html("");
				
				var jsonData = {
						"database" :localdb ,
						"token" : token,
						"pid" : parseInt(project_id)
						};
					$.ajax({
						url :  "/WSG/wondering_area/deleted/get",
						type : "POST",
						data : JSON.stringify(jsonData),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							var json = $.parseJSON(data.obj);
							console.log(data);
							if(json!=null){
								var html ="";
								
								html = html+"<table><tr><td><b>Wondering area</b></td><td><b>Overarching questions</b></td><td><b>Why important?</b></td><td><b>Restore</b></td></tr>"
								for(var  i=0; i< json.length;i++){
									html=html+"<tr><td>"+json[i].name+"</td><td>"+json[i].overarching_questions+"</td><td>"+json[i].why_important+"</td><td><div onclick=\"wonderingAreaRestore('"+json[i].id+"')\" class='btn'>Restore</div>"
								  		+"</tr>";	
								}
								html=html + "</table>";
								$("#deleted_wonderingarea_ideathread_list_content").append(html);
								
							}
							else{
								Materialize.toast("No deleted wondering area found in this project.",3000);
							}
						}
					})
			});
			
		
			
			
			
			

function enterActivity(){
	     	window.location.href = "activity_rader.jsp?projectid="+project_id+"&crossdb="+localdb+"&community_id="+community_id+"&community_name="+community_name;
	 }
		
		
	 function validateURL(){
		 if(null==localdb|| null ==community_id ||null==project_id){
			 setTimeout(function(){ 
					Materialize.toast('Invalid URL', 4000)
					 window.history.back();
				}, 3000);
		 }
	 }
	 
	 

		// get community info 
		function get_community_info(){
			
			if(null!=community_id){
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
							community_id=getUrlParameter("community_id")
							localdb=json[0].localdb
							community_name=json[0].community_name
						}else{
							
							console.log("do not find this community")
						}
						get_project_info()
					},
					error : function(jqXHR, textStatus, errorThrown) {
						setTimeout(function(){ 
							Materialize.toast('Invalid URL', 4000)
							 window.history.back();
						}, 3000);
					}
				});
			}else{
				setTimeout(function(){ 
					Materialize.toast('Invalid URL', 4000)
					 window.history.back();
				}, 3000);
			}
			
		}
		
		// get project info
		
		function get_project_info(){
			
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
							if(isCrossProject){
								$("#page_title").html('<a href="../../dashboard.jsp">[CROSS COMMUNITY]'+community_name+'</a>-><a href="../openedit.jsp?community_id='+community_id+'&localdb='+localdb+'">'+json[0].title+'  Dashboard</a>')
							}else{
								$("#page_title").html('<a href="../../dashboard.jsp">'+community_name+'</a>-><a href="../openedit.jsp?community_id='+community_id+'&localdb='+localdb+'">'+json[0].title+'  Dashboard</a>')
							}
							initProjectGoal(json[0].goal)
					
						}else{
									console.log("do not find this project")
						}
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
		
		
		
		$("#deleted_wonderingarea_ideathread_list").click(function(){
			$("#deleted_wonderingarea_ideathread_list_modal").modal('open');
			$("#deleted_wonderingarea_ideathread_list_content").empty().html("");
			
			var jsonData = {
					"database" :localdb ,
					"token" : token,
					"pid" : parseInt(project_id)
					};
				$.ajax({
					url :  "/WSG/wondering_area/deleted/get",
					type : "POST",
					data : JSON.stringify(jsonData),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						var json = $.parseJSON(data.obj);
						console.log(data);
						if(json!=null){
							var html ="";
							
							html = html+"<table><tr><td><b>Wondering area</b></td><td><b>Overarching questions</b></td><td><b>Why important?</b></td><td><b>Restore</b></td></tr>"
							for(var  i=0; i< json.length;i++){
								html=html+"<tr><td>"+json[i].name+"</td><td>"+json[i].overarching_questions+"</td><td>"+json[i].why_important+"</td><td><div onclick=\"wonderingAreaRestore('"+json[i].id+"')\" class='btn'>Restore</div>"
							  		+"</tr>";	
							}
							html=html + "</table>";
							$("#deleted_wonderingarea_ideathread_list_content").append(html);
							
						}
						else{
							Materialize.toast("No deleted wondering area found in this project.",3000);
						}
					}
				})
		});
		
		
		$(document).on('change', 'input[type="checkbox"]', function(e){

			
			if(!$(this).prop('checked')){
				var userdata = {
						"database" : localdb,
						"token" : token,
						"wid" : $(this).attr('id').replace("mwf", "")
					};
				$.ajax({
					url : "/WSG/thread_id/get/bywondering_area",
					type : "POST",
					data : JSON.stringify(userdata),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						var json = $.parseJSON(data.obj);
						if(null!=json){
							for(var m=0; m<json.length;m++){
								$("#mthread"+json[m].thread_id).prop('checked', false);
							}
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log(jqXHR.responseText);
					}
				});
			}
			else{
				
				var userdata = {
						"database" : localdb,
						"token" : token,
						"wid" : $(this).attr('id').replace("mwf", "")
					};
				$.ajax({
					url : "/WSG/thread_id/get/bywondering_area",
					type : "POST",
					data : JSON.stringify(userdata),
					dataType : "json",
					success : function(data, textStatus, jqXHR) {
						var json = $.parseJSON(data.obj);
						if(null!=json){
							for(var m=0; m<json.length;m++){
								$("#mthread"+json[m].thread_id).prop('checked', true);
							}
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log(jqXHR.responseText);
					}
				});
				
			}
	    });
		
		
		$("#area_edit_btn").click(function(){
			
			if($("#area_edit_btn").data("mode")=="edit"){
				if(project_role!="3"){ 
					// if current user is not the manager, then the user no able to change the name of wondering area
					$("#wa_name").prop("disabled",true);
				}
				
				$("#area_info_modal .modal-content").removeAttr("style");
				$("#area_edit_btn").html("Save")
				$("#area_edit_btn").data("mode","save");
			}else{
				var keywords = $('#wf_keywords').material_chip('data')
				var keyword = "";
				for(var i in keywords){
					keyword=keyword+keywords[i].tag+","
				}
				var areaInfo = {
						"database" :localdb,
						"token" : token,
						"wname" : $("#wa_name").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
						"area" : $("#wa_name").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
						"overarchingquestions":$("#overarching_questions").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
						"modifytime":new Date(),
						"whyimportant": $("#whyimportant").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'") ,
						"keywords":keyword.replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
						"message":$("#area_message").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
						"wid": $("#area_id").val()
				}
					$.ajax({
								url :  "/WSG/wondering_area/update",
								type : "POST",
								data : JSON.stringify(areaInfo),
								dataType : "json",
								success : function(data, textStatus,jqXHR) {
								
									location.reload(true);								
									}
								})
				
			}
			
			
		})
		
		
		
		
		$("#mapping_finish").click(function(){
			var tboxchecked = [];
			var tboxcheckedtxt = [];
			var wboxchecked = [];
			var wboxcheckedtxt = [];
			var selected_wondering_area_id = "";
			
			if($("#tbox p input").is(':checked')){
				$('#tbox p input').each(function() {
				    if($(this).is(':checked')){
				    	tboxcheckedtxt.push($($($(this).parent()).children()[1]).text());
				    	tboxchecked.push($(this).attr('id').replace("mthread", ""));
				    	console.log($(this).attr('id').replace("mthread", ""));
				    	tboxcheckedtxt.sort();
				    }
				});
				var tbox_checked_str = tboxchecked.join();
				
				var tbox_checked_str_txt = tboxcheckedtxt.join();
				
				
				
				
				if(tbox_checked_str.lenght!=""){
					$.ajax({
			            url: '../../SET_MAPPING_FOCUS',
			            type: 'POST',
			            data: {mappingthreadid : tbox_checked_str, mappingthreadidtxt : tbox_checked_str_txt},
			            success: function (response) {
			            	window.open("../../thread/mapping.jsp?localdb="+localdb+"&token="+token+"&community_name="+community_name+"&community_id="+community_id+"&project_id="+project_id);
			            }
			        });	
				}
				else{
						 Materialize.toast('Please select wondering area(s) or thread(s)!', 3000);
				} 
			}
			
			
			
			
		});
		
		
		$("#thread_lda").click(function(){
			$("#lda").val("true")
			$("#thread_lda").hide()
			window.open("http://web-tccl.arcc.albany.edu:8080/ITM-Showcase/?db="+localdb+"&uid="+id);
			
		})
		
		
		
			$("#thread_finish").click(function() {
			
				// get project view
				// if it has project view then do not need to check the thread view. 
				// if it does not have project view information , then still need to check the thread viwe information
								
			 	var jsondata = {
							"database" :localdb,
							"token" : token,
							"pid":project_id
			 		}
			 		
			 		$.ajax({
						url :  "/WSG/project/view/getbyId",
						type : "POST",
						data : JSON.stringify(jsondata),
						dataType : "json",
						success : function(data, textStatus, jqXHR) {
							window.findProjectView = false; 
							window.projectView ="-1";
							if(data.code ="success"){
								 if($.trim(data.desc)!=$.trim("No data aviliable.")){
									 // find the project view
									 window.findProjectView=true;
									 var json = $.parseJSON(data.obj);
									 window.projectView =json[0].kf_view_id;
								 }
							}
							
							//  get selected views
							var checked = false;
						    var selected_views =[];
							$("#iFrame").contents().find('#new-note-select-views input:checked').each(function(){
										checked=true;
										selected_views.push($(this).attr('value'))
									})
									
							if(!window.findProjectView){
								// if does not find project view, then need to check whether the view was selected or not
								if(!checked){
									Materialize.toast("please select a view ",3000)
									return
								}
							}

							if($("#thread_name").val()!=""){
								var keywords = $('#thread_keywords').material_chip('data')
								var keyword = "";
								for(var i in keywords){
									keyword=keyword+keywords[i].tag+","
								}
								var threadInfo = {
									"thread_focus":$("#thread_name").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
									"authorid":id,
									"createtime":new Date(),
									"resource":tinyMCE.activeEditor.getContent().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
									"keywords":keyword.replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
									"database" : localdb,
									"token" : token
								}
								$.ajax({
									url : "/WSG/thread/add",
									type : "POST",
									data : JSON.stringify(threadInfo),
									dataType : "json",
									success : function(data,textStatus,jqXHR) {
										if(data.code=="success"){
											 if($.trim(data.desc)!=$.trim("No data aviliable.")){
													var tid=data.obj[0]["GENERATED_KEY"];
													
													addWonderingAreaProject(tid)
													for(var i in selected_views){
														addThreadView(tid,selected_views[i]);
													}
													if(window.findProjectView){
														addThreadView(tid,window.projectView);
													}
												}
											 Materialize.toast("A new thread has been created",3000)
											}
										
										 reload()
										
									 }
									})
							}
							else{
								 Materialize.toast('Please enter thread name!', 3000);
							}
							
							
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}
					})
				
			
			});
		
	function addWonderingAreaProject(tid){
			
			$('#wf_title input:checked').each(function(e) {
			var wid=$(this).data("id");
			var wname=$(this).val(); 
			var thread_w_json = {
			"database" :localdb ,
			"token" : token,
			"threadid" : tid,
			"areaid" : wid
			};

			$.ajax({
				url : "/WSG/thread/wondering/add",
				type : "POST",
				data : JSON.stringify(thread_w_json),
				dataType : "json",
			})
		})
		
		 threadProject(tid)
		}
		
	

	
	
	
	
	
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
			    url: 'https://itm.arcc.albany.edu/IFS/uploadFile',
			    data: fd,
               processData: false,
               cache: false,
               contentType:false,
			    success: function (data) {
			      // do something
			      var json = "https://itm.arcc.albany.edu/IFS/resources/data/"+$.trim((data.obj).split("@")[2])
			    	$("#img").html("")
			    	var html ='<img class="materialboxed" width="250" src="'+json+'">'
			    	$("#img").html(html)
			    }
			  });
	 }
	 
	 
	 
	 
	 function viewReminder(id){
			var projectdata = {
					"database" :localdb ,
					"token" : token,
					"rid" : id
				};
				$.ajax({
							url :  "/WSG/reminder/get",
							type : "POST",
							data : JSON.stringify(projectdata),
							dataType : "json",
							success : function(data, textStatus,
									jqXHR) {
								if(data.code=="success"){
									var json = $.parseJSON(data.obj);
									$("#reminder-title").html("Reminder Title:  "+json[0].title)
									$("#reminder-content").html("Content:  "+json[0].content)
									$("#view_reminder").modal('open');
									 }
							}})
		}
		
		
		
		$("#btn_add_reminder").click(function(){
			if($("#input-reminder-title").val()==""||$("#input-reminder-content").val()==""){
				$.notify('Title and content is required . ', 'warn');
			}else{
				var projectdata = {
						"database" :localdb ,
						"token" : token,
						"pid" : project_id,
						"title":$("#input-reminder-title").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
						"content":$("#input-reminder-content").val().replace(/"/g,"\\\"").replace(/'/g,"\\\'"),
						"ctime":new Date()
					};
					$.ajax({
								url :  "/WSG/reminder/add",
								type : "POST",
								data : JSON.stringify(projectdata),
								dataType : "json",
								success : function(data, textStatus,
										jqXHR) {
									if(data.code=="success"){
										initTeacherReminder();
										 }
								}})
								
			}
		})
		
		
		
		
		
		
		$("#btn-add-teacher-reminder").click(function(){
			$("#input-reminder-title").html("")
			$("#input-reminder-content").html("")
			$("#add_reminder").modal('open');
		})
		
		
							function initTeacherReminder(){
									var projectdata = {
											"database" :localdb ,
											"token" : token,
											"pid" : project_id
										};
										$.ajax({
													url :  "/WSG/reminder/get/byprojectid",
													type : "POST",
													data : JSON.stringify(projectdata),
													dataType : "json",
													success : function(data, textStatus,
															jqXHR) {
														 $("#reminder-list").html(""); 
														if(data.code=="success"){
															
															  if($.trim(data.desc)!=$.trim("No data aviliable.")){
																  var json = $.parseJSON(data.obj);
																  for(var i in json){
																	  var html ="<tr style='cursor:pointer;'onclick=\"viewReminder('"+json[i].id+"')\">"
																		  html=html+"<td>"+json[i].title+"</td>"
																		  +"<td>"+(json[i].create_time).substring(0,10)+"</td>"
																	  		+"</tr>"
																	  		$("#reminder-list").append(html); 
																  }
																  
															  }
															 }
													}})
													
													
								}
		
		$("#enterCrossProject").click(function(){
			 window.open("../../thread/cross_project_sharing.jsp?localdb="+localdb+"&community_id="+community_id+"&projectid="+project_id+"&threadid=id");
		})
							   $('select').material_select();
								function init(){
									if(isCrossProject||project_role==0){
										$("#enterCrossProject").hide()
										$("#area_edit_btn").hide()
										$("#thread_edit_btn").hide()
										$("#thread_del_btn").hide()
										$("#area_delete_btn").hide()
									}
									initProjectGoal()
									initTeacherReminder()
									get_community_info()
								}
								init()
								function initProjectGoal(goal){
									$("#project_goal").html(goal)
								}
							
								$(".button-collapse").sideNav();
								$("#show_slide").click(function() {
									$('.button-collapse').sideNav('show');
								});

								$('.collection').delegate('a', 'click', function() {
									window.location.href = "../thread/open.html";
								});


								function initBuddyProject(){
									
									var json = {
											"database" :'itm3' ,
											"token" : token,
											"pid":project_id,
											"cid":community_id
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
														  $("#number_of_buddy_project").empty().html(json.length)
														   var html =""
														  for(var i in json){
															 
															   html += "<div style='padding-left:10px;'>"+json[i].project_title+"</div>";
														  }
															$("#list_buddy_project").html(html);
														  
													  	}
													  initSuperTalkList(json)
													  }		
												},
												error : function(jqXHR, textStatus,
														errorThrown) {
													console.log(jqXHR.responseText);
												}
											});
									
									
								}
								
								initBuddyProject()
								
	 function initSuperTalkList(buddy_project_list){
	var buddy_project =buddy_project_list		
	var json = {
			 "database" :"super_talk",
			 "token" : super_token.toString(),
	 }
	 $.ajax({
			url :  "/WSG/supertalk/get/all",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus,
					jqXHR) {
				
				 if(data.code=="success"){
					 var json = $.parseJSON(data.obj);
					 if(json==$.trim("No data aviliable.")){
						// $("#cross_project_list").empty().html("");
					 }
					 var number_of_supertalk = 0;
					 for(var i in json){
						 var flag = true;
						 for(var j in buddy_project){
							 if(json[i].community_id==buddy_project[j].from_community_id&&json[i].project_id==buddy_project[j].from_project_id){
								 flag=true;
								 break;
							 }
							 if(json[i].community_id==buddy_project[j].to_community_id&&json[i].project_id==buddy_project[j].to_project_id){
								 flag=true;
								 break;
							 }
							 if(json[i].community_id==community_id&&json[i].project_id==project_id){
								 flag=true;
								 break;
							 }
							}
							 if(flag&&json[i].status=="accepted"){
								 number_of_supertalk+=1
								 initSingleSuperTalk(json[i].question,json[i].id,json[i].author)
								 getSuperTalkJOTBySuperTalkId(json[i].id)
							 }
					 }
					 $("#number_super_talks").html(number_of_supertalk)
					 
				 }else{
					 //$("#cross_project_list").empty().html("");
				 }
			}})
			
}
								
								function sleepFor( sleepDuration ){
								    var now = new Date().getTime();
								    while(new Date().getTime() < now + sleepDuration){ /* do nothing */ } 
								}
								
								
								function initSingleSuperTalk(topic, id,author){
									var json = {
											 "database" :"super_talk",
											 "token" : super_token,
											 "sid" : id
									 }
									 $.ajax({
											url :  "/WSG/supertalk/get/numberofnote",
											type : "POST",
											data : JSON.stringify(json),
											dataType : "json",
											success : function(data, textStatus,
													jqXHR) {
												 if(data.code=="success"){
													 var json = $.parseJSON(data.obj);
													 var test ='<div   style=\'padding-left:10px;\'>'
															+'<span>'+topic+'</span>'
															+'<span>&nbsp;&nbsp;['+json[0]['count(*)']+']</span>'
															+'</div>';
													 $('#list_super_talk').append(test);
												 }
											}
									 })
								}
								
						var number_of_super_talk = 0;
			
								function getSuperTalkJOTBySuperTalkId(id){
									var json = {
											 "database" :"super_talk",
											 "token" : super_token,
											 "sid" : id
									 }
									 $.ajax({
											url :  "/WSG/supertalk/jot/get/byid",
											type : "POST",
											data : JSON.stringify(json),
											dataType : "json",
											success : function(data, textStatus,
													jqXHR) {
												 if(data.code=="success"){
													 var json = $.parseJSON(data.obj);
													 number_of_super_talk+=json.length
													  $("#number_of_jot").html(number_of_super_talk)
												 }
											}
									 })
								}
							
	$(".side-nav").find(".blue-grey").removeClass('blue-grey')
	$(".side-nav").find(".active").removeClass('active')
	$(".side-nav").find(".show").removeClass('show')

	$(".in-work-space").addClass("active blue-grey lighten-2 ")
	$(".in-work-space-body").addClass("show")
	$(".in-work").addClass("active")
	
	
	var current_request_count = 0;
	function reload(){
		console.log("done");
		setTimeout(location.reload.bind(location), 2000); 
	}
	
	
	var requestArray=[]
	
	function addThreadNote(tid,reqArray){
		// add thread note 
		
		var json = {
				"database" :localdb ,
				"token" : token,
				"authorid":id
			};
		$.ajax({
			url : "/WSG/tmp_thread/get",
			type : "POST",
			data : JSON.stringify(json),
			dataType : "json",
			success : function(data, textStatus,
					jqXHR) {
				 if(data.code=="success"){
					 var json = $.parseJSON(data.obj);
					 if(json!=null){
						
						 for(var i in json){
							 var postdata = {
									 "database" :localdb,
									 "token" : token,
									 "projectid":project_id,
									 "threadid":tid,
									 "cid":community_id,
									 "noteid":json[i].note_id,
									 "ctime":new Date()
							 }
							 var followRequest = $.ajax({
									url :  "/WSG/thread/note/add",
									type : "POST",
									data : JSON.stringify(postdata),
									dataType : "json",
									success : function(data, textStatus,
											jqXHR) {
										 if(data.code=="success"){
											
										 }
									}})
									
									reqArray.push(followRequest)
						 }
						
						 $.when.apply(null,requestArray).then( 
								 reload()
								 )
					 }
				 }
			}
			})
			
			
			
	}
	

	
	
	function threadProject(tid){
		// add thread into project
			var json = {
			"database" :localdb ,
			"token" : token,
			"threadid" : tid,
			"projectid" : project_id,
			"authorid":id
		};
	$.ajax({
		url : "/WSG/project/thread/add",
		type : "POST",
		data : JSON.stringify(json),
		dataType : "json",
		})
		if($("#lda").val()=="true"){
			addThreadNote(tid,requestArray)
		}
		 
	}
	

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
		