<html>
<%@ page contentType="text/html; charset=UTF-8" %>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet"/>	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<!-------------------------  About Popup (#facebox) ------------------------->
	<!-- ---------------   Lib for Facebox       ----------------------- -->
    <link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.facebox.css" media="screen" rel="stylesheet"/> 
    <script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/facebox.js"></script>
	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.onLoad.css" media="screen" rel="stylesheet"/> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.onLoad.js"></script>
	 <!-- 
	DWR
	-->
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/util.js"></script>

	<script type="text/javascript"> 
	var _path='<%=request.getContextPath()%>';
	/* {
		  "graphset" : [
		  {
		    "type" : "bar",
		    "series" : [
		     {
		        "values" : [11,26,7,44,11,28,42,26,13]
		     }] 
		  }]
		} */
		

//---------------------------------------------
   var sumByPop='<%=request.getParameter("sb")%>';
    var tabPop='<%=request.getParameter("tab")%>';
    var year='<%=request.getParameter("y")%>';
    var m='<%=request.getParameter("m")%>'; 
    var topic='<%=request.getParameter("topic")%>'; 
    function addCommas(nStr)
    {
    	nStr += '';
    	x = nStr.split('.');
    	x1 = x[0];
    	x2 = x.length > 1 ? '.' + x[1] : '';
    	var rgx = /(\d+)(\d{3})/;
    	while (rgx.test(x1)) {
    		x1 = x1.replace(rgx, '$1' + ',' + '$2');
    	}
    	return x1 + x2;
    }
    function callPopup1(){
    	$("#display_group").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>"); 
    	BalanceScorecardAjax.getPopup1(year,m,tabPop,sumByPop,{
    		callback:function(data_ajax){
    			var seriesList=[];
    			var labelsList=[];
    			var offset=110;
    			if(data_ajax!=null && data_ajax.length>0){
    				var barGroup = {
    						"graphset" : [
    						{
    							"type" : "bar",
    							"stacked": true,
    							"background-color":"#FFFFFF",
    							"chart":{
    								"margin":"30 20 120 80"
    							},
    							"legend" : {
    								"background-color": "#FFFFFF",
    								"border-width": "2px",
    								"border-color": "#4C77B6",
    								"layout": "x6",
    								/* "x": 40,
    								"y": 265,
    								"width": 900 */
    								 "x": 50,
    								 "y": 240,
    									"width": 900
    							},
    							"labels" : [],
    							"plot":{
    								"decimals":2,
    		    					"decimals-separator":".",
    		    					"thousands-separator":",",
    								"tooltip-text":"%t:%v",
    								"thousands-separator":",",
    								"bars-space-left":"30%",
    								"bars-space-right":"30%"
    							},
    							"scale-x":{
    								"values":[],
    								"guide":{
    									"line-width": 1,
    									"alpha": 1
    								},
    								"tick":{
    									"line-width": 3
    								},
    								"item":{
    									"font-color":"#000000"
    								}
    							},
    							"scale-y":{
    								"format":"%v",
    								"min-value":0,
    								"decimals":0,
    								"thousands-separator":",",
    								"guide":{
    									"line-width": 1,
    									"alpha": 1
    								},
    								"tick":{
    									"line-width": 3
    								},
    								"item":{
    									"font-color":"#000000"
    								}
    							},
    							"series" : []
    						}
    					]
    				};	
    			
    				var groups=[];
    				
    				var group_size=data_ajax.length;
    				for(var i=0;i<group_size;i++){ 
    					groups[i]=data_ajax[i].groupName;
    					var sum=0;  
    					if(data_ajax[i].financialPopup1DTO!=null && data_ajax[i].financialPopup1DTO.length>0){ 
    						var subGroups=data_ajax[i].financialPopup1DTO;
    						var subGroup_size=subGroups.length; 
    						for(var j=0;j<subGroup_size;j++){
    							var color=(Math.floor(Math.random()*16777215).toString(16)); 
    							var values_list=new Array(group_size); 
    							values_list[i]=subGroups[j].thisActual;
    							sum=sum+parseFloat(subGroups[j].thisActual);
    							var subValue={
    								"values" : values_list,
    								"background-color":"#"+color, 
    								"text" : subGroups[j].subCategory
    							}; 
    							seriesList.push(subValue); 
    						}
    					}
    					var label_value={
    						"text" : addCommas(Number(sum).toFixed(2)),
    						"x" : offset,
    						"y" : 0,
    						"background-color":"blue",
    						"thousands-separator":",",
    						"color": "white",
    						"border-width":1, 
    						"border-color":"blue",
    						"bold": true
    					}
    					offset=offset+130;
    					labelsList.push(label_value);  
    				} 
    				barGroup.graphset[0].series=seriesList;
    				var label={
    					"text" : "พันบาท",
    					"bold":true,
    					"x": "15",
    					"y": "0"
    				}
    				labelsList.push(label)
    				barGroup.graphset[0].labels=labelsList; 
    				barGroup.graphset[0]["scale-x"].values=groups;
    				 
    			} 
    			var label="";
    			switch (topic) {
    			case "0":
    				label="ยอดขาย";
    				break; 
    			case "1":
    				label="กำไรขั้นต้น";
    				break; 
    			default:
    				break;
    			}
    			 $("#label_group").html("<font size=\"3\">"+label+"</font>");
    			 $("#display_group").html(""+
    			"<table width=\"100%\">"+
                "<tr><th align=\"center\"><font size=\"2\"></font></th></tr>"+
                "<tr><td align=\"center\" id=\"gGroup\"></td></tr>"+
            "</table>");
    			zingchart.render({
    				id : 'gGroup', 
    				 width : 1000,
    				height : 330,
    				data : barGroup
    			});
    		}
    	});
    }  
function callPopup2(){
	$("#display_group").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>"); 
	BalanceScorecardAjax.getPopup2(year,m,tabPop,sumByPop,{
		callback:function(data_ajax){
			//alert(data_ajax)
			var seriesList=[];
			var labelsList=[];
			var offset=110;
			if(data_ajax!=null && data_ajax.length>0){
				var barGroup = {
						"graphset" : [
						{
							"type" : "bar",
							"stacked": true,
							"background-color":"#FFFFFF",
							"chart":{
								"margin":"30 20 120 80"
							},
							"legend" : {
								"background-color": "#FFFFFF",
								"border-width": "2px",
								"border-color": "#4C77B6",
								"layout": "x6",
								/* "x": 40,
								"y": 265,
								"width": 900 */
								 "x": 50,
								 "y": 240,
									"width": 900
							},
							"labels" : [],
							"plot":{
								"decimals":2,
		    					"decimals-separator":".",
		    					"thousands-separator":",",
								"tooltip-text":"%t:%v",
								"thousands-separator":",",
								"bars-space-left":"30%",
								"bars-space-right":"30%"
							},
							"scale-x":{
								"values":[],
								"guide":{
									"line-width": 1,
									"alpha": 1
								},
								"tick":{
									"line-width": 3
								},
								"item":{
									"font-color":"#000000"
								}
							},
							"scale-y":{
								"format":"%v",
								"min-value":0,
								"decimals":0,
								"thousands-separator":",",
								"guide":{
									"line-width": 1,
									"alpha": 1
								},
								"tick":{
									"line-width": 3
								},
								"item":{
									"font-color":"#000000"
								}
							},
							"series" : []
						}
					]
				};	
			
				var groups=[];
				
				var group_size=data_ajax.length;
				for(var i=0;i<group_size;i++){ 
					groups[i]=data_ajax[i].groupName;
					var sum=0;  
					if(data_ajax[i].financialPopup1DTO!=null && data_ajax[i].financialPopup1DTO.length>0){ 
						var subGroups=data_ajax[i].financialPopup1DTO;
						var subGroup_size=subGroups.length; 
						for(var j=0;j<subGroup_size;j++){
							var color=(Math.floor(Math.random()*16777215).toString(16)); 
							var values_list=new Array(group_size); 
							values_list[i]=subGroups[j].thisActual;
							sum=sum+parseFloat(subGroups[j].thisActual);
							var subValue={
								"values" : values_list,
							//	"background-color":"#"+color, 
								"text" : subGroups[j].subCategory
							}; 
							seriesList.push(subValue); 
						}
					}
					var label_value={
						"text" : addCommas(Number(sum).toFixed(2)),
						"x" : offset,
						"y" : 0,
						"background-color":"blue",
						"thousands-separator":",",
						"color": "white",
						"border-width":1, 
						"border-color":"blue",
						"bold": true
					}
					offset=offset+130;
					labelsList.push(label_value);  
				} 
				barGroup.graphset[0].series=seriesList;
				var label={
					"text" : "พันบาท",
					"bold":true,
					"x": "15",
					"y": "0"
				}
				labelsList.push(label)
				barGroup.graphset[0].labels=labelsList; 
				barGroup.graphset[0]["scale-x"].values=groups;
				 
			} 
			var label="";
			switch (topic) {
			case "0":
				label="ยอดขาย";
				break; 
			case "1":
				label="กำไรขั้นต้น";
				break; 
			default:
				break;
			}
			 $("#label_group").html("<font size=\"3\">"+label+"</font>");
			 $("#display_group").html(""+
			"<table width=\"100%\">"+
            "<tr><th align=\"center\"><font size=\"2\"></font></th></tr>"+
            "<tr><td align=\"center\" id=\"gGroup\"></td></tr>"+
        "</table>");
		if(data_ajax!=null && data_ajax.length>0){
			zingchart.render({
				id : 'gGroup', 
				 width : 1000,
				height : 330,
				data : barGroup
			});
		}else{
			$("#display_group").html(" No Data ");
		}
		}
	});
}    	
	$(document).ready(function() {
		    if(topic=='0'){
		    	callPopup1();
		    }else if(topic=='1'){ 
		    	callPopup2();
		    }
			
		});
   
	</script>

	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
	</style>

<body>

<table width="1000" height="300" border="1" align="center" style="text-decoration:none;">
    <tr>
        <th align="center" colspan="2"  height="30" >
        <div id="label_group"></div>
          <%--out.print(request.getParameter("topic"));--%>
        </th>
     </tr>
     <tr>
         <td colspan="2" align="center">
         <div id="display_group">
            
         </div>
             
         </td>
     </tr> 
</table> 
</body>
</html>