<script>
function  noteRead(data_note_id){
	var notecountdata = {
			"database" :localdb,
			"token" : token,
			"noteid" : data_note_id,
			"authorid":id,
			"threadid": thread_id
	};
	
	if(isSupertalk){
		 notecountdata = {
					"database" :"super_talk",
					"token" : super_token,
					"noteid" : data_note_id,
					"authorid":id,
					"threadid": thread_id
			};
			
	}
	
	$.ajax({
		url :  "/WSG/note_view_record/add",
		type : "POST",
		data : JSON.stringify(notecountdata),
		dataType : "json",
		success : function(data, textStatus,jqXHR) {
			
			
		},
		error : function(jqXHR, textStatus,
				errorThrown) {
		}
	});
}
</script>