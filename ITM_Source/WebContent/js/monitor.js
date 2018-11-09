/*
 * obj={
    "uid":obj.uid,
	"time":new Date(),
	"className":obj.className,
	"domain":obj.domain,
	"fn":obj.fn,
	"msg":obj.msg
	"pose":obj.pose,
	}
 * 
 * */


function sendMessageToMonitor(obj,id){

	//insert into monitor (uuid,time,domain,messge,className,functionName,cid,data,pose) value
	//("@uuid","@timestamp","@domain","@message","@className","@functionName","@cid","@data","@pose")
	var userdata = {
			"database":"itm3",
			"token":"123456",
			"uuid":id,
			"mtime":JSON.stringify(new Date()),
			"className":obj.className,
			"domain":obj.domain,
			"function":obj.fn, 
			"pose":obj.pose,
			"message":JSON.stringify(obj.msg).replace(/"/g, "'")
		};
	$.ajax({
		url : "/WSG/monitor/msg/add",
		type : "POST",
		data : JSON.stringify(userdata),
		dataType : "json",
		success : function(data, textStatus, jqXHR) {
			console.log("monitoring")
		},
		error : function(jqXHR, textStatus, errorThrown) {

		}
	});
}