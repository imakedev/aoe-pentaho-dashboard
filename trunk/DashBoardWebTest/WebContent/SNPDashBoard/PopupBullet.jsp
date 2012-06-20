<html>
<%@ page contentType="text/html; charset=UTF-8" %>

 
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/zingchart-html5beta-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/license.js"></script>
 

<!-- ----------------  My Custom          ------------------------- -->
<%--
<script type="text/javascript" src="/chartLib/js/kajax.js"></script>
--%>
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/customchart.css" rel="stylesheet"/> 

<!-- ---------------   TreeTable & Sparkline ----------------------- -->
<link	type="text/css"	href="<%=request.getContextPath()%>/chartLib/css/jquery.treeTable.css" rel="stylesheet"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.treeTable.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script> 

<!-- ---------------   Lib for Facebox       ----------------------- -->
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.facebox.css" media="screen" rel="stylesheet"/> 
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/facebox.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.dateFormat-1.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.number_format.js"></script>
<%--
<script type="text/javascript"
        	src=">/dwrbalancescorecard/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src=">/dwrbalancescorecard/engine.js"></script> 
	<script type="text/javascript"
        	src=">/dwrbalancescorecard/util.js"></script> 
        	 --%>
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/util.js"></script> 
        	 
 
<script type="text/javascript">
//---------------------------------------------
 var bscOwnerPopup='<%=request.getParameter("bscOwner")%>';//document.getElementById(''); 
 var yearPopup ='<%=request.getParameter("bscYear")%>';// document.getElementById("");
 var monthNamePopup = '<%=request.getParameter("bscMonth")%>';//document.getElementById("");
 var bscOwnerText = '<%=request.getParameter("bscOwnerText")%>';//document.getElementById(""); 
	$(document).ready(function() {
		  
		  //  BalanceScorecardAjax.getKPIOverallPopup(yearPopup,monthNamePopup,bscOwnerPopup,{
			  BalanceScorecardAjax.getKPIOverallPopup(yearPopup,monthNamePopup,bscOwnerPopup,{
				callback:function(data_KPI){
				//	alert(data_KPI.length)
					//document.getElementById('bscOwnerElement').innerHTML=str;	
					var actualValue="2";
				//	var targetValue="3";
					var endthreshold_red= "";
					var endthreshold_yellow= "";
					var endthreshold_green= "";
					var beginthreshold_red;
					var beginthreshold_yellow;
					var beginthreshold_green;
					//var percentActualVsTarget="";
					var percentActualVsTargettargetValue=0;
					//var gaugeDiv_overAll_head= "";
					var endthreshold_red_color= "";
					var endthreshold_yellow_color= "";
					var endthreshold_green_color= "";
				if(data_KPI!=null && data_KPI.length==2){
				var	data_KPIOverall=data_KPI[0];
				var	data_KPIOverall_score=data_KPI[1];
				if(data_KPIOverall_score!=null){
					actualValue=data_KPIOverall_score[0].systemScore;
					percentActualVsTargettargetValue=data_KPIOverall_score[0].percentActualVsTarget;
				}
					if(data_KPIOverall!=null && data_KPIOverall.length==3){ 
					
					 
						for(var i=0;i<data_KPIOverall.length;i++){
							/* overAll.setSystemScore(obj[0] != null ? obj[0] + "" : "");
							overAll.setBeginThreshold(obj[1] != null ? obj[1] + "" : "");
							overAll.setEndThreshold(obj[2] != null ? obj[2] + "" : "");
							overAll.setSystemColorCode(obj[3] != null ? obj[3] + "" : "");  */
							//if(data_KPIOverall[i].systemColorCode=='#FF0000'){
							if(i==0){
								endthreshold_red=$().number_format(data_KPIOverall[i].endThreshold, {precision: 0,decimalSeparator: '.'});
								beginthreshold_red=$().number_format(data_KPIOverall[i].beginThreshold, {precision: 0,decimalSeparator: '.'});
								endthreshold_red_color=data_KPIOverall[i].systemColorCode;
								//endthreshold_red=30;
								//beginthreshold_red=0;
							}
							//else if(data_KPIOverall[i].systemColorCode=='#FFFF00'){
							else if(i==1){
								endthreshold_yellow=$().number_format(data_KPIOverall[i].endThreshold, {precision: 0,decimalSeparator: '.'});
								beginthreshold_yellow=$().number_format(data_KPIOverall[i].beginThreshold, {precision: 0,decimalSeparator: '.'});
								endthreshold_yellow_color=data_KPIOverall[i].systemColorCode;
								//endthreshold_yellow=65;
								//beginthreshold_yellow=31;
							}
							//else if(data_KPIOverall[i].systemColorCode=='#00FF00'){
							else if(i==2){ 							
								endthreshold_green=$().number_format(data_KPIOverall[i].endThreshold, {precision: 0,decimalSeparator: '.'});
								beginthreshold_green=$().number_format(data_KPIOverall[i].beginThreshold, {precision: 0,decimalSeparator: '.'});
								endthreshold_green_color=data_KPIOverall[i].systemColorCode;
							}
						//	actualValue=data_KPIOverall[i].actualValue;
						//	targetValue=data_KPIOverall[i].targetValue;		
						//	percentActualVsTargettargetValue=$().number_format(data_KPIOverall[i].percentActualVsTarget, {precision: 0,decimalSeparator: '.'});
							//percentActualVsTargettargetValue=65;
							//gaugeDiv_overAll_head=data_KPIOverall[i].kpiOwnerName;
						}
					 
						if(!(endthreshold_green!=null && endthreshold_green!='0.00')){
							endthreshold_green=100;	
						}
						//alert(bscOwnerText)
						//alert(endthreshold_red+","+endthreshold_yellow+","+endthreshold_green+","+actualValue+","+percentActualVsTargettargetValue)
						document.getElementById('gaugeDiv_overAll_head').innerHTML=bscOwnerText;
						var jsonCircle = {
							      "graphset":[
							         {
							            "type":"gauge",
							            "border-width":0,
							            "plotarea":{
							               "margin":"20 0 0 0"
							            },
							            "background-color":"#CCCCCC #CCCCCC;",
							            "fill-type":"radial",
							            "scale":{
							   			"values": [
							   			//	"Ratio : Percent(%)"
							   			//	"Percent(%)"
							   			//	"Performance"
							   			     "% Actual Value vs Target"
							   				],
							               "item":{
							                  "font-color":"white",
							                  "font-family":"helvetica",
							                  "text-align":"center",
							                  "font-size":11,
							                  "bold":true,
							                  "background-color":"000000",
							   			   "padding": "2",
							                  "offset-y":-20,
							                  "offset-x":0
							               }
							            },
							   		 "scale-r":{
							             //  "values":"0:120:12",
							             //  "values":"0:"+endthreshold_green+":"+(endthreshold_green/10)+"",
							               "values":"0:"+endthreshold_green+":"+(10)+"",
							              // "values":"0:100:10",
							             
							   			"size": 150,
							               "aperture":270, //270
							   			"offset-start": "15",
							   			"offset-end": "15",
							               "max-items":20,
							               "ref-angle":-90,
							               "background-color":"#CCCCCC #666666",
							   			"fill-type": "radial",
							               "border-color":"#CCCC99",
							               "border-width":"4",
							               "item":{
							                  "padding":"1 1",
							                  "font-color":"black",
							                  "font-size":12,
							                  "font-family":"helvetica",
							                  "text-align":"center",
							                  "bold":true
							                  //,
							   			  /*  "rules": [
							   					{
							   				//	"rule": "%i >= 11",
							   					"rule": "%i >= 13",
							   					"visible": false
							   					}
							   			   ] */
							               },
							               "tick":{
							                  "visible": false,
							   			   "placement": "inner",
							                  "line-color":"orange",
							                  "line-width":2
							               },
							   			"center" : {
							   	            	"size" : 10,
							   	            	//"size" : 12,
							   	            	"background-color" : "#bbbbbb #000000",
							   	            	"border-color" : "#cccccc",
							   	            	"border-width" : "1",
							   	            	"fill-type" : "radial",
							   	            	"fill-offset-x" : -5,
							   	            	"fill-offset-y" : -5
							   	            },
							               "ring":{
							                  "size":17,
							                  "alpha":-1,
							                  "border-width":2,
							                  "border-color":"black",
							   			   "rules": [
							   					{
							   					"rule": "%v <="+endthreshold_red+"",
							   					"background-color": endthreshold_red_color
							   					},
							   				 	{
							   					"rule": "%v >= "+endthreshold_red+" && %v <= "+endthreshold_yellow+"",
							   					"background-color": endthreshold_yellow_color
							   					},  
							   					
							   					  {
							   					"rule": "%v >= "+endthreshold_yellow+" && %v <= "+endthreshold_green+"",
							   					"background-color": endthreshold_green_color
							   					}, 
							   					{
							   					"rule": "%v >= 1000",
							   					"background-color": "0",
							   					"border-color": "0"
							   					}							   				
							   			   ]
							               }
							            },
							            "plot":{
							              "csize":"10",
							           //    "csize":"12",
							   			"tooltip-text": "%t: %v",
							   			"border-color": "#f00",
							   			"border-width": 1
							            }
							            ,
							            "tooltip":{
							            "border-radius": 10,							            
							   		//	"border-radius": 12,
							   			"border-color": "black",
							   			"border-width": "2",
							   			"font-color": "black",
							   			"font-weight": "bold",
							   			"padding": "10",
							   			"rules": [
							   					{
							   					"rule": "%v <=100",
							   					"background-color": "lightgreen"
							   					},
							   					{
							   					"rule": "%v >= 0 && %v <= "+endthreshold_red+"",
							   					"background-color": endthreshold_red_color
							   					},
							   					 {
							   					"rule": "%v >= "+endthreshold_red+" && %v <= "+endthreshold_yellow+"",
							   					"background-color": endthreshold_yellow_color
							   					},
							   					{
							   					"rule": "%v >= "+endthreshold_yellow+" && %v <= "+endthreshold_green+"",
							   					"background-color": endthreshold_green_color
							   					}
							   					,
							   					{
							   					"rule": "%v >= 400",
							   					"background-color": "-1",
							   					"background-color": "orange",
							   					"border-color": "-1"
							   					}
							   			   ]
							            },
							            "series":[
							               {
							                  "values":[""+percentActualVsTargettargetValue+""], 
							   			   "size": "120",
							                  "text":"Score",
							   			   "background-color": "blue",
							   			  "tooltip-text" : "%t: "+actualValue+""  // กำหนดเพื่อให้แสดงค่าเวลาเอาเมาส์ไปชี้ที่ Chart ค่ะ
							   				//"alpha": 1,
							   				//"data-rpm": ["%"]
							   				}
							               /*,
							               {
							                  "values":[""+targetValue+""],
							   			   "size": "120",
							                  "text":"Value",
							   			   "background-color": "green"
							   				//"alpha": 1,
							   				//"data-rpm": ["%"]
							   				}
							               */
							   			
							            ]
							         }
							      ]
							   };
						 var gaugeDiv= "gaugeDiv_overAll"; 
						 zingchart.render({
				 				id 				: gaugeDiv,
				 				data 		    : jsonCircle,
				 				width	 		: 450,
				 				height 			: 350
				 				
				 			});
					} 
				}
				}
			}); 
			 
		});
	  		
</script>

<body>
<%-- 
<div align="center">
<font size="3"><b>Overall :<span id="gaugeDiv_overAll_head"> </span></b></font></div>
<br>
 background-color:	#e6e6fa class="popup" --%>
<table width="700" height="300" border="1" align="center"  style="text-decoration:none;" >
	<tr><td align="center"><div align="center">
<font size="3"><b>Overall :<span id="gaugeDiv_overAll_head"> </span></b></font></div>
</td></tr>
	<tr><td align="center"><span id="gaugeDiv_overAll"></span></td></tr>
</table>
</body>
</html>