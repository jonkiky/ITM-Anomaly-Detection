<script>

function checkHighlight(allContent, data_note_id){
    var getHighlightedText = {
            'token':'<%=session.getAttribute("token")%>',
            'database':'<%=session.getAttribute("localdb")%>',
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

</script>