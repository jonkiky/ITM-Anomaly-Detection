<script>

$("#forward").click(function(){
	
	var note_open_id = $("#note_open_id").val();
	
	$("#buildon_list").html("");
	for(var item = 0; item < buildonfromtoid.length; item++){
		if(note_open_id == buildonfromtoid[item].split("@#$")[0]){
			buildontonoteid.push(buildonfromtoid[item].split("@#$")[1]);
			for(var m=0; m<realdatanoteidtitleauthor.length;m++){
				if(realdatanoteidtitleauthor[m].split("@#$")[0] == buildonfromtoid[item].split("@#$")[1]){
					for(var n=0; n<realdatanoteidcontent.length;n++){
						if(realdatanoteidcontent[n].split("@#$")[0]==buildonfromtoid[item].split("@#$")[1]){
							$("#buildon_list").append('<li> <div class="collapsible-header"><span style="font-size: 16px"><b>'+realdatanoteidtitleauthor[m].split("@#$")[1]+'</b></span></div> <div class="collapsible-body"><span style="font-size: 14px; padding:10px">'+realdatanoteidcontent[n].split("@#$")[1]+'</span></div></li>')
						}
					}
				}
				
			}
			
		}
		
	}
	$("#forward_modal").modal('open');
});

$("#backward").click(function(){
	var note_open_id = $("#note_open_id").val();
	$("#buildon_list").html("");
	for(var item = 0; item < buildonfromtoid.length; item++){
		if(note_open_id == buildonfromtoid[item].split("@#$")[1]){
			buildonfromnoteid.push(buildonfromtoid[item].split("@#$")[0]);
			for(var m=0; m<realdatanoteidtitleauthor.length;m++){
				if(realdatanoteidtitleauthor[m].split("@#$")[0] == buildonfromtoid[item].split("@#$")[0]){
					for(var n=0; n<realdatanoteidcontent.length;n++){
						if(realdatanoteidcontent[n].split("@#$")[0]==buildonfromtoid[item].split("@#$")[0]){
							$("#buildon_list").append('<li> <div class="collapsible-header"><span style="font-size: 16px"><b>'+realdatanoteidtitleauthor[m].split("@#$")[1]+'</b></span></div> <div class="collapsible-body"><span style="font-size: 14px; padding:10px"> '+realdatanoteidcontent[n].split("@#$")[1]+'</span></div></li>')
						}
					}
				}
			}
		}
		
	}
	$("#forward_modal").modal('open');
});

</script>