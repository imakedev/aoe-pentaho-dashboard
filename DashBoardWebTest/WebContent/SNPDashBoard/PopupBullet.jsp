<html>
<%@ page contentType="text/html; charset=UTF-8" %>


<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-1.6.1.min.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/zingchart-html5beta-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/license.js"></script>
 

<!------------------  My Custom          --------------------------->
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/kajax.js"></script>
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/customchart.css" rel="stylesheet"/> 

<!-----------------   TreeTable & Sparkline ------------------------->
<link	type="text/css"	href="<%=request.getContextPath()%>/chartLib/css/jquery.treeTable.css" rel="stylesheet"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.treeTable.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script> 

<!-----------------   Lib for Facebox       ------------------------->
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.facebox.css" media="screen" rel="stylesheet"/> 
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/facebox.js"></script> 

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.dateFormat-1.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.number_format.js"></script>
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/util.js"></script> 
        	
 
<script type="text/javascript">
function getParentLoop(parentID){
	 // var parentElement=document.getElementById(parentID);
	  if ($("#"+parentID)){
		  // do something here
		  var classValues= $("#"+parentID).attr("class");
		 // alert(classValues)
		  if(classValues!=null && classValues!='undefined' && classValues.length>0){
			 if(classValues.indexOf("child-of-")!=-1){
				 var classArray= classValues.split(" ");
			//	 alert(classArray.length);
				 if(classArray!=null && classArray.length>0){
					 var nextParentId="";
					 for(var i=0;i<classArray.length;i++){
						 if(classArray[i].indexOf("child-of-")!=-1){
							var nextParentId= classArray[i].split("child-of-")[1];							 
							//alert(nextParentId);
							break;
						 }
					 }
					 if(nextParentId.length>0)
					 	return getParentLoop(nextParentId)+" "+parentID; 
			  	} 
		  } 
		}
	}
 return parentID;
}
$.fn.toggleBranch = function() {
    if($(this).hasClass("collapsed")) {
    	var nodeId=$(this).attr("id");
    	var haveID=false;
    	var className=$(this).attr("class");
    	var kpi=nodeId.split("_node_")[1];
    	var perspectiveId=nodeId.split("_node_")[0];
    	var havePerspective=false;
    	var indexPerspective=0;
    	for(var i=0;i<treePerspectiveArray.length;i++){
    		if(treePerspectiveArray[i].id==perspectiveId){
    			indexPerspective=i;
    			havePerspective=true;
    			break;
    			
    		} 
    	}
    	if(havePerspective){
    		var kpis=treePerspectiveArray[indexPerspective].kpis;
    		for(var j=0;j<kpis.length;j++){
				if(kpis[j]==kpi){
					haveID=true;
	    			break;
				}
			}
    	}
			if(!haveID){
				// call ajax 
	    		//var kpiObj={id:}
	    	//	treePerspectiveArray[indexPerspective].kpis.push(kpi);
    var bscOwner=document.getElementById('bscOwner'); 
   var year = document.getElementById("bscYear");
   var monthName = document.getElementById("bscMonth"); 
	BalanceScorecardAjax.getKPIListAndChart(year.value,monthName.value,bscOwner.value,kpi,{
			callback:function(data_KPIList){ 
				 var str="";
				for(var i=0;i<data_KPIList.length;i++){
				var kpiresultthresholdDTOs = data_KPIList[i].kpiresultthresholdDTOs;
				var trendChart=data_KPIList[i].trendChart;
				var kpiWeight=0;
				var weight='';
				var freq ;
				var target ;
				var actual 	;
				//Target 	Trend 	
				var lastUpdated;
				if(kpiresultthresholdDTOs!=null && kpiresultthresholdDTOs.length>0){	
					kpiWeight=$().number_format(kpiresultthresholdDTOs[0].kpiOwnerWeighting, {precision: 0,decimalSeparator: '.'});//kpiresultthresholdDTOs[0].kpiOwnerWeighting;
					weight=$().number_format(kpiresultthresholdDTOs[0].perspectiveWeighting, {precision: 0,decimalSeparator: '.'});//kpiresultthresholdDTOs[0].perspectiveWeighting;
					freq=kpiresultthresholdDTOs[0].frequency;
					target=kpiresultthresholdDTOs[0].targetValue;
					actual=kpiresultthresholdDTOs[0].percentActualVsTarget;
					lastUpdated =(kpiresultthresholdDTOs[0].updatedDT!=null)?$.format.date(kpiresultthresholdDTOs[0].updatedDT, "dd/MM/yyyy"):"";
				}
				var actualValue;
			var targetValue;
			var endthreshold_red;
			var endthreshold_yellow;
			var endthreshold_green;
			var beginthreshold_red;
			var beginthreshold_yellow;
			var beginthreshold_green;
			var myValues="";
			var percentActualVsTarget="";
			var kpiKey;
			var dateKey;
			var accumulatedFlag;
				for(var j=0;j<kpiresultthresholdDTOs.length;j++){
				if(kpiresultthresholdDTOs[j].id.colorCode=='red'){
					endthreshold_red=$().number_format(kpiresultthresholdDTOs[j].endThreshold, {precision: 0,decimalSeparator: '.'});
					beginthreshold_red=$().number_format(kpiresultthresholdDTOs[j].beginThreshold, {precision: 0,decimalSeparator: '.'});
					myValues=myValues+","+endthreshold_red; 
				}else if(kpiresultthresholdDTOs[j].id.colorCode=='yellow'){
					endthreshold_yellow=$().number_format(kpiresultthresholdDTOs[j].endThreshold, {precision: 0,decimalSeparator: '.'});
					beginthreshold_yellow=$().number_format(kpiresultthresholdDTOs[j].beginThreshold, {precision: 0,decimalSeparator: '.'});
					myValues=","+endthreshold_yellow+myValues; 
				}else if(kpiresultthresholdDTOs[j].id.colorCode=='green'){
					endthreshold_green=$().number_format(kpiresultthresholdDTOs[j].endThreshold, {precision: 0,decimalSeparator: '.'});
					beginthreshold_green=$().number_format(kpiresultthresholdDTOs[j].beginThreshold, {precision: 0,decimalSeparator: '.'});
					myValues=","+endthreshold_green+myValues; 
				}
					actualValue=kpiresultthresholdDTOs[j].actualValue;
				targetValue=kpiresultthresholdDTOs[j].targetValue;	
				percentActualVsTargettargetValue=kpiresultthresholdDTOs[j].percentActualVsTarget;
				kpiKey=kpiresultthresholdDTOs[j].id.kpiKey;
				dateKey=kpiresultthresholdDTOs[j].id.dateKey;
				accumulatedFlag=kpiresultthresholdDTOs[j].accumulatedFlag;
			}
			//14.45,10.89
			myValues=targetValue+","+actualValue+myValues;
			 
			var trendChartValue=""+trendChart.jan+","+trendChart.feb+","+
								""+trendChart.mar+","+trendChart.apr+","+
								""+trendChart.may+","+trendChart.jun+","+
								""+trendChart.jul+","+trendChart.aug+","+
								""+trendChart.sep+","+trendChart.oct+","+
								""+trendChart.nov+","+trendChart.dec+"";
							//	class=\"parent collapsed\"	
							 
					str=str+"<tr  height=\"5\" id=\""+perspectiveId+"_node_"+data_KPIList[i].kpiKey+"\" class=\"child-of-"+nodeId+"\">"+
							"<td width=\"43%\" style=\"padding-left: 20px;\" >"+ 
					"<div style=\"cursor: pointer;\" onclick=\"showKPIBarChart('"+perspectiveId+"','"+data_KPIList[i].kpiKey+"','"+data_KPIList[i].dateKey+"','"+accumulatedFlag+"')\">"+data_KPIList[i].kpiName+"</div></td>"+
					"<td width=\"20px\"  align=\"right\">"+  
					"<a style=\"cursor: pointer;\" id=\"KPIDetail_"+kpiKey+"\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('"+data_KPIList[i].kpiKey+"','"+data_KPIList[i].dateKey+"')\">"+
					"<img src=\""+_path+"/chartLib/images/question_shield.ico\" width=\"20px\" BORDER =\"0\"/></a>"+					
					"	</td>"+
		    		"<td width=\"6%\"  align=\"center\">"+kpiWeight+"%</td>"+	
					"<td width=\"6%\"  align=\"center\">"+weight+"%</td>			<td width=\"4%\" align=\"center\">"+freq+"</td>"+		
					"<td width=\"7%\"  align=\"center\">"+target+"</td>		<td width=\"7%\" align=\"center\">"+actual+"</td>"+		
					//"<td width=\"7%\"  align=\"center\"><div   class=\"sparklines_"+perspectiveId+"_"+i+"\" title=\""+percentActualVsTargettargetValue+"%\">"+myValues+"</div></td>"+		
					"<td width=\"7%\"  align=\"center\"><div   class=\"sparklines\" title=\""+percentActualVsTargettargetValue+"%\">"+myValues+"</div></td>"+
					//"<td width=\"7%\"  align=\"center\"><div class=\"trendLine_"+perspectiveId+"_"+i+"\" LineColor=\"red\" >"+trendChartValue+"</div></td>"+
					"<td width=\"7%\"  align=\"center\"><div class=\"trendLine\" LineColor=\"red\" >"+trendChartValue+"</div></td>"+
					"<td width=\"12%\" align=\"center\">"+lastUpdated+"</td>"+
			 		"</tr>";
			 		 
					//<table class="bscTreegrid_1 treeTable" border="1" height="20" width="100%">	<tbody><tr class="initialized" align="center" height="5">		<td class="tdsubheader" width="43%">KPI</td>		<td class="tdsubheader" width="20px"></td>			<td class="tdsubheader" width="6%">KPI Weight</td>		<td class="tdsubheader" width="6%">Weight</td>		<td class="tdsubheader" width="4%">Freq</td>			<td class="tdsubheader" width="7%">Target</td> 		<td class="tdsubheader" width="7%">Actual</td>			<td class="tdsubheader" width="10%">Target</td>			<td class="tdsubheader" width="10%">Trend</td>		<td class="tdsubheader" width="12%">Last Updated</td>	</tr><tr id="1_node_1" class="parent collapsed initialized" height="5"><td style="padding-left: 20px;" width="43%"><span style="margin-left: -15px; padding-left: 15px;" class="expander"></span><div style="cursor: pointer;" onclick="showKPIBarChart('1','1','1097','Y')">Overall</div></td><td align="right" width="20px"><a style="cursor: pointer;" id="KPIDetail_1" rel="facebox" class="KPIDetail" onclick="showKPIDetail('1','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" border="0" width="20px"></a>	</td><td align="center" width="6%">0.80%</td><td align="center" width="6%">0.75%</td>			<td align="center" width="4%">M</td><td align="center" width="7%">14.45</td>		<td align="center" width="7%">75.36</td><td align="center" width="7%"><div class="sparklines_1_0" title="75.36%"><canvas height="19" width="64" style="display: inline-block; width: 64px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="7%"><div class="trendLine_1_0" linecolor="red"><canvas height="19" width="36" style="display: inline-block; width: 36px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="12%">10/06/2011</td></tr><tr  height="5" id="1_node_3" class="child-of-1_node_1"><td width="43%" style="padding-left: 20px;" ><div style="cursor: pointer;" onclick="showKPIBarChart('1','3','1097','Y')">Trading</div></td><td width="20px"  align="right"><a style="cursor: pointer;" id="KPIDetail_3" rel="facebox" class="KPIDetail" onclick="showKPIDetail('3','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" width="20px" BORDER ="0"/></a>	</td><td width="6%"  align="center">0.75%</td><td width="6%"  align="center">0.96%</td>			<td width="4%" align="center">Q</td><td width="7%"  align="center">18.8</td>		<td width="7%" align="center">98.94</td><td width="7%"  align="center"><div   class="sparklines_1_0" title="98.94%">18.8,18.6,100.00,70.00,40.00</div></td><td width="7%"  align="center"><div class="trendLine_1_0" LineColor="red" >18,0,0,0,0,0,0,0,0,0,0,0</div></td><td width="12%" align="center">10/06/2011</td></tr><tr  height="5" id="1_node_4" class="child-of-1_node_1"><td width="43%" style="padding-left: 20px;" ><div style="cursor: pointer;" onclick="showKPIBarChart('1','4','1097','N')">Specialty</div></td><td width="20px"  align="right"><a style="cursor: pointer;" id="KPIDetail_4" rel="facebox" class="KPIDetail" onclick="showKPIDetail('4','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" width="20px" BORDER ="0"/></a>	</td><td width="6%"  align="center">0.75%</td><td width="6%"  align="center">0.25%</td>			<td width="4%" align="center">M</td><td width="7%"  align="center">10.9</td>		<td width="7%" align="center">200.92</td><td width="7%"  align="center"><div   class="sparklines_1_1" title="200.92%">10.9,21.9,100.00,70.00,40.00</div></td><td width="7%"  align="center"><div class="trendLine_1_1" LineColor="red" >21,0,0,0,0,0,0,0,0,0,0,0</div></td><td width="12%" align="center">10/06/2011</td></tr></tbody></table>
				}
				if(!haveID){
		    		//var kpiObj={id:}
		    		//var perspectiveObj={id:rowid,kpis:[]};
		    		treePerspectiveArray[indexPerspective].kpis.push(kpi);
		    		//treePerspectiveArray[].push(perspectiveObj);
		    	}
				var tree_perspectiveElement= document.getElementById('tree_perspective_'+perspectiveId);
		 		
		 		var tableStr=tree_perspectiveElement.innerHTML;
		 		if(tableStr.length>0){
		 			//alert(tableStr.split("</tbody></table>")[0])
		 			tableStr=tableStr.split("</tbody></table>")[0];
				} 
		 		tableStr=tableStr+str+"</tbody></table>";
		 		tree_perspectiveElement.innerHTML=tableStr;
		 		//$(".bscTreegrid").treeTable(); 
		 		$('span').remove('.expander');
		 		$('tr[class*=initialized]').removeClass("initialized");
		 		//alert(tableStr);
		 		$(".bscTreegrid_"+perspectiveId).treeTable();
		 		//1_node_1
		 		
		 		//alert(document.getElementById('tree_perspective_'+perspectiveId).innerHTML)
		 		//var kpis=treePerspectiveArray[i].kpis;
				//str=str+"</table>"; 
			//	alert(str)
		//	treeTable.innerHTML=str;
		//	$(".bscTreegrid").treeTable();
	//	alert(str);
	//alert($(this).attr("class"));
	alert(className);
		 		/* var xx= getParentLoop($(this).attr("id"));
		        xx = $.trim(xx);  */
		        var xx =null;
		       // classValues.split
		     //  alert(xx)
		      // alert(xx.split(" ").length)
		       if(xx!=null && xx.length>0){
		    	   var elementSplits=xx.split(" ");
		    	   var split_size=elementSplits.length;
		    	   for(var i=0;i<split_size;i++){
		    		 //  alert(elementSplits[i])
		    		   $("#"+elementSplits[i]).expand();
		    	   }
		       }
		       
			$("#"+nodeId).expand();
			//for(var i=0;i<data_KPIListLevel0.length;i++){
				$('.sparklines').sparkline('html',{
			    	type: 'bullet',
			    	performanceColor:'blue',
			    	targetColor:'red',
			    	width:"auto" ,
			    	height:'auto',
			    	targetWidth:3,
			    	rangeColors:['#D3DAFE','#A8B6FF','#7F94FF']
			    	});
			//	$('.trendLine_'+perspectiveId+'_'+i+'').sparkline('html' , {barColor: 'red'}); 
				$('.trendLine').sparkline('html' , {barColor: 'red'});
			//}
		 		//$(this).expand();
	    	}
    	});
	
	}
			
    	
    			
    	/*
    	var treePerspective={
    			  perspectiveArray:[{ id:'',value:''}]
    	 } ;
    	*/
    	if(haveID)
      		$(this).expand();
    	alert("expand")
    } else {
    	alert("collapse")
    	 if($(this).hasClass("expanded")) {
		    	  $(this).removeClass("expanded").collapse();
		  }
    }
   // alert(" overid aoe Test "+treeKPIArray);
    return this;
};
//---------------------------------------------
 var bscOwnerPopup='<%=request.getParameter("bscOwner")%>';//document.getElementById(''); 
 var yearPopup ='<%=request.getParameter("bscYear")%>';// document.getElementById("");
 var monthNamePopup = '<%=request.getParameter("bscMonth")%>';//document.getElementById(""); 
	$(document).ready(function() {
		  
		    BalanceScorecardAjax.getKPIOverall(yearPopup,monthNamePopup,bscOwnerPopup,{
				callback:function(data_KPIOverall){
					// alert(data_KPIOverall)
					//document.getElementById('bscOwnerElement').innerHTML=str;	
					var actualValue;
					var targetValue;
					var endthreshold_red;
					var endthreshold_yellow;
					var endthreshold_green;
					var beginthreshold_red;
					var beginthreshold_yellow;
					var beginthreshold_green;
					var percentActualVsTarget="";
					var percentActualVsTargettargetValue=0;
					var gaugeDiv_overAll_head= "";
					if(data_KPIOverall!=null && data_KPIOverall.length==3){
						for(var i=0;i<data_KPIOverall.length;i++){
							if(data_KPIOverall[i].colorCode=='red'){
								endthreshold_red=$().number_format(data_KPIOverall[i].endThreshold, {precision: 0,decimalSeparator: '.'});
								beginthreshold_red=$().number_format(data_KPIOverall[i].beginThreshold, {precision: 0,decimalSeparator: '.'});
							}else if(data_KPIOverall[i].colorCode=='yellow'){
								endthreshold_yellow=$().number_format(data_KPIOverall[i].endThreshold, {precision: 0,decimalSeparator: '.'});
								beginthreshold_yellow=$().number_format(data_KPIOverall[i].beginThreshold, {precision: 0,decimalSeparator: '.'});
							}else if(data_KPIOverall[i].colorCode=='green'){
								endthreshold_green=$().number_format(data_KPIOverall[i].endThreshold, {precision: 0,decimalSeparator: '.'});
								beginthreshold_green=$().number_format(data_KPIOverall[i].beginThreshold, {precision: 0,decimalSeparator: '.'});
							}
							actualValue=data_KPIOverall[i].actualValue;
							targetValue=data_KPIOverall[i].targetValue;		
							percentActualVsTargettargetValue=$().number_format(data_KPIOverall[i].percentActualVsTarget, {precision: 0,decimalSeparator: '.'});
							gaugeDiv_overAll_head=data_KPIOverall[i].kpiOwnerName;
						}
						document.getElementById('gaugeDiv_overAll_head').innerHTML=gaugeDiv_overAll_head;
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
							   				"Ratio : Percent(%)"
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
							               "values":"0:100:10",
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
							                  "bold":true,
							   			   "rules": [
							   					{
							   					"rule": "%i >= 11",
							   					"visible": false
							   					}
							   			   ]
							               },
							               "tick":{
							                  "visible": false,
							   			   "placement": "inner",
							                  "line-color":"orange",
							                  "line-width":2
							               },
							   			"center" : {
							   	            	"size" : 10,
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
							   					"rule": "%v <=30",
							   					"background-color": "red"
							   					},
							   					{
							   					"rule": "%v >= 30 && %v <= 70",
							   					"background-color": "yellow"
							   					},
							   					{
							   					"rule": "%v >= 70 && %v <= 100",
							   					"background-color": "green"
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
							   			"tooltip-text": "%t: %v",
							   			"border-color": "#f00",
							   			"border-width": 1
							            },
							            "tooltip":{
							   			"border-radius": 10,
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
							   					"rule": "%v >= 0 && %v <= 30",
							   					"background-color": "red"
							   					},
							   					{
							   					"rule": "%v >= 30 && %v <= 70",
							   					"background-color": "yellow"
							   					},
							   					{
							   					"rule": "%v >= 70 && %v <= 100",
							   					"background-color": "green"
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
							                  "text":"Value",
							   			   "background-color": "blue"
							   				//"alpha": 1,
							   				//"data-rpm": ["%"]
							   				}
							   			
							            ]
							         }
							      ]
							   };
						 var gaugeDiv= "gaugeDiv_overAll"; 
						 /*
			 			 	var data_gauge = new google.visualization.DataTable();
			 			 data_gauge.addColumn('string', 'Label');
			 			   data_gauge.addColumn('number', 'Value');
			 			   data_gauge.addRows(1);
			 			   data_gauge.setValue(0, 0, '');
			 			   data_gauge.setValue(0, 1,parseFloat(percentActualVsTargettargetValue+"")); 
			 			   var chart_gauge = new google.visualization.Gauge(document.getElementById(gaugeDiv));
			 			   var options = {width: 400, height: 120, redFrom: beginthreshold_red, redTo: endthreshold_red, greenFrom: beginthreshold_green, greenTo: endthreshold_green,
			 			       yellowFrom:beginthreshold_yellow, yellowTo: endthreshold_yellow, minorTicks: 5};
			 			   chart_gauge.draw(data_gauge, options);	
			 			   */
						 zingchart.render({
				 				id 				: gaugeDiv,
				 				data 		    : jsonCircle,
				 				width	 		: 450,
				 				height 			: 350
				 				
				 			});
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
 --%>
<table width="700" height="300" border="1" align="center"  style="text-decoration:none; background-color:	#e6e6fa" class="popup">
	<tr><td align="center"><div align="center">
<font size="3"><b>Overall :<span id="gaugeDiv_overAll_head"> </span></b></font></div>
</td></tr>
	<tr><td align="center"><span id="gaugeDiv_overAll"></span></td></tr>
</table>
</body>
</html>