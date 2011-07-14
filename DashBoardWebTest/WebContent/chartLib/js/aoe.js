$.fn.toggleBranch = function() {
    if($(this).hasClass("collapsed")) {
    	var nodeId=$(this).attr("id");
    	var haveID=false;
    	var className=$(this).attr("class");
    	var kpi=nodeId.split("_node_")[1];
    	var perspectiveId=nodeId.split("_node_")[0]; 
      	$(this).expand();
    	for(var i=0;i<myValuesArray.length;i++){
    		$("#sparklines"+myValuesArray[i].id).html("");
    		$("#trendLine"+myValuesArray[i].id).html("");
	    	$("#sparklines"+myValuesArray[i].id).sparkline(myValuesArray[i].myValues,{
		    	type: 'bullet',
		    	performanceColor:'blue',
		    	targetColor:'red',
		    	width:"auto" ,
		    	height:'auto',
		    	targetWidth:3,
		    	rangeColors:['#D3DAFE','#A8B6FF','#7F94FF']
		    	});
	    	$("#trendLine"+myValuesArray[i].id).sparkline(myValuesArray[i].trendChartValues, {barColor: 'red'});
    	} 
    } else { 
      if($(this).hasClass("expanded")) {
    	  $(this).removeClass("expanded").collapse();
      } 
    }
return this;
};