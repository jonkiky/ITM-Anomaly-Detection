<script>

	

function show_buildon_supertalk(){
	
	var projectdata = {
			"database" : localdb_info[0],
			"db" : localdb,
			"token" :  token,
			"authorid" :  id,
			"threadid" : thread_id,
			"projectid" : project_id
			
		};
		
		
				
	$.ajax({
		url : "/WSG/buildon/get/bythread/supertalk",
		type : "POST",
		data : JSON.stringify(projectdata),
		dataType : "json",
		success : function(data) {
			var json = $.parseJSON(data.obj);
			var final_buildon_trace = [];
			if(json!=null){
				for (var i = 0; i < json.length; i++) {
					
					var from_id = 0;
					var to_id = 0;
					
					for (var j = 0; j <= realdatanoteid.length; j++) {
						if (json[i].from_note_id == realdatanoteid[j])
							from_id = j
						if (json[i].to_note_id == realdatanoteid[j])
							to_id = j
					}
					
					var realdatatitle_to = '<--'+ realdatatitle_left[from_id];	
					buildonfromtoid.push(realdatanoteid[from_id]+"@#$"+realdatanoteid[to_id]);
					
					var x0=realdatatime_left[from_id];
					var date_x0 = new Date(x0); 
					var milliseconds_x0 = date_x0.getTime(); 
					
					var x1=realdatatime_left[to_id];
					var date_x1 = new Date(x1); 
					var milliseconds_x1 = date_x1.getTime(); 
					
					var y0 = realdataweight_left[from_id];
					var y1 = realdataweight_left[to_id]
					
					
					
					var max = 250;
			        var min = 190;
			        var green = Math.floor(Math.random() * (max - min + 1)) + min;
					var color = 'hsl(' + green + ', ' + 99 + '%, ' + 65 + '%)';
					
			var trace_lines = {
					x : [milliseconds_x1, milliseconds_x0],
					y : [y1, y0],
					type : 'line',
					text : [realdatatitle_to],
					mode: 'markers+lines+text',
					textposition : 'right',
					line: {
					    color: color,
					    width: 1
					  },
					  marker : {
							size : 8,
							color : color
						},
						textfont: {
							size: 10,
						    color: color
						 },
					 hoverinfo:'none'
			
				};
			
			
			final_buildon_trace.push(trace_lines);
				
				}
				Plotly.addTraces(TESTER, final_buildon_trace);
			}else{
				$('#showbuildon').attr('checked', true);
			}
			
		}
	});
	
	
	for( var i in localdb_info){
		var projectdata = {
				"database" : localdb_info[0],
				"db" : localdb_info[0],
				"token" :  token,
				"authorid" :  id,
				"threadid" : thread_id,
				"projectid" : project_id
				
			};
			
			
					
		$.ajax({
			url : "/WSG/buildon/get/bythread/supertalk",
			type : "POST",
			data : JSON.stringify(projectdata),
			dataType : "json",
			success : function(data) {
				var json = $.parseJSON(data.obj);
				var final_buildon_trace = [];
				if(json!=null){
					for (var i = 0; i < json.length; i++) {
						
						var from_id = 0;
						var to_id = 0;
						
						for (var j = 0; j <= realdatanoteid.length; j++) {
							if (json[i].from_note_id == realdatanoteid[j])
								from_id = j
							if (json[i].to_note_id == realdatanoteid[j])
								to_id = j
						}
						
						var realdatatitle_to = '<--'+ realdatatitle_left[from_id];	
						/* buildonallids.push(realdatanoteid[from_id]);
						buildonallids.push(realdatanoteid[to_id]);
						 */
						buildonfromtoid.push(realdatanoteid[from_id]+"@#$"+realdatanoteid[to_id]);
						
						var x0=realdatatime_left[from_id];
						var date_x0 = new Date(x0); 
						var milliseconds_x0 = date_x0.getTime(); 
						
						var x1=realdatatime_left[to_id];
						var date_x1 = new Date(x1); 
						var milliseconds_x1 = date_x1.getTime(); 
						
						var y0 = realdataweight_left[from_id];
						var y1 = realdataweight_left[to_id]
						
						
						
						var max = 250;
				        var min = 190;
				        var green = Math.floor(Math.random() * (max - min + 1)) + min;
						var color = 'hsl(' + green + ', ' + 99 + '%, ' + 65 + '%)';
						
				var trace_lines = {
						x : [milliseconds_x1, milliseconds_x0],
						y : [y1, y0],
						type : 'line',
						text : [realdatatitle_to],
						mode: 'markers+lines+text',
						textposition : 'right',
						line: {
						    color: color,
						    width: 1
						  },
						  marker : {
								size : 8,
								color : color
							},
							textfont: {
								size: 10,
							    color: color
							 },
						 hoverinfo:'none'
				
					};
				
				
				final_buildon_trace.push(trace_lines);
					
					}
					Plotly.addTraces(TESTER, final_buildon_trace);
				}else{
					$('#showbuildon').attr('checked', true);
				}
				
			}
		});
		
	}
	
	
}

</script>