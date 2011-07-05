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
<script>
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
</script>
<body> 

<table width="700" height="300" border="1" align="center" style="text-decoration:none; background-color:	#e6e6fa" class="popup">

<%--
<table width="700" height="300" border="1" align="center"> 
--%>
	<tr>
      <td width="140" colspan="1" class="tdpopup">KPI Name </td><td><div id="data_KPIDetail_kpiName"></div></td>
	</tr> 
	<tr>
		<td>Objective </td> <td><div id="data_KPIDetail_objective"></div></td>
	</tr>
	<tr>
		<td>Formula</td><td><div id="data_KPIDetail_formulaDesc"></div></td> 
	</tr>
	<tr>
	   <td>Definition </td><td><div id="data_KPIDetail_kpiDesc"></div></td>
	</tr>
	<tr>
	   <td>Unit of measure</td><td><div id="data_KPIDetail_uom"></div></td>
	</tr>
	<tr>
		<td>Source of information <br>/ Data collector</td><td><div id="data_KPIDetail_dataSource"></div></td>
	</tr> 
	<tr>
		<td>Target range</td><td><div id="data_KPIDetail_targetRangeDesc"></div></td>
	</tr>
	<tr>
		<td>  Last revise</td><td><div id="data_KPIDetail_lastRevisedDT"></div></td>
	</tr>
</table>	
<script>
var kpiKeyDetail='<%=request.getParameter("kpiKey")%>';
var dateKeyDetail='<%=request.getParameter("dateKey")%>';
//alert(dateKeyDetail)
$(document).ready(function() {
	//function getKPIDetail(kpiKeyDetail,dateKeyDetail){
	   var pk={
			   kpiKey:kpiKeyDetail,
			   dateKey:dateKeyDetail
	   };
	//  alert(pk)
	   BalanceScorecardAjax.getKPIDetail(pk,{
			callback:function(data_KPIDetail){
				 //alert(data_KPIDetail)
				  //var str="<table width=\"700\" height=\"300\" border=\"1\" align=\"center\" style=\"text-decoration:none; background-color:	#e6e6fa\" class=\"popup\">";
				// alert(str+"xx")
				  if(data_KPIDetail!=null){
					  document.getElementById('data_KPIDetail_kpiName').innerHTML= data_KPIDetail.kpiName;
					  document.getElementById('data_KPIDetail_objective').innerHTML= data_KPIDetail.objective;
					  document.getElementById('data_KPIDetail_formulaDesc').innerHTML= data_KPIDetail.formulaDesc;
					  document.getElementById('data_KPIDetail_kpiDesc').innerHTML= data_KPIDetail.kpiDesc;
					  document.getElementById('data_KPIDetail_uom').innerHTML= data_KPIDetail.uom;
					  document.getElementById('data_KPIDetail_dataSource').innerHTML= data_KPIDetail.dataSource;
					  document.getElementById('data_KPIDetail_targetRangeDesc').innerHTML= data_KPIDetail.targetRangeDesc;
					  document.getElementById('data_KPIDetail_lastRevisedDT').innerHTML= data_KPIDetail.lastRevisedDT;
				  /*
					 	str=str+"<tr>"+
		   				"	<td width=\"140\" colspan=\"1\" class=\"tdpopup\">KPI Name </td><td>"+data_KPIDetail.kpiName+"</td>"+
		   				"</tr>"+		
		   				"<tr>"+
		   				"	<td>Objective </td> <td>"+data_KPIDetail.objective+"</td>"+
		   				"</tr>"+
						"<tr>"+
						"	<td>Formula</td><td>"+data_KPIDetail.formulaDesc+"</td>"+ 
						"</tr>"+
						"<tr>"+
						"   <td>Definition </td><td>"+data_KPIDetail.kpiDesc+"</td>"+
						"</tr>"+
						"<tr>"+
						"   <td>Unit of measure</td><td>"+data_KPIDetail.uom+"</td>"+
						"</tr>"+
						"<tr>"+
						"	<td>Source of information <br>/ Data collector</td><td>"+data_KPIDetail.dataSource+"</td>"+
						"</tr>"+ 
						"<tr>"+
						"	<td>Target range</td><td>"+data_KPIDetail.targetRangeDesc+"</td>"+
		   				"</tr>"+
					    "<tr>"+
		     			//"	<td>  Last revise</td><td>"+((data_KPIDetail.lastRevisedDT!=null)?$.format.date(data_KPIDetail.lastRevisedDT, "dd/MM/yyyy"):"")+"</td>"+
		     			"	<td>  Last revise</td><td>"+data_KPIDetail.lastRevisedDT+"</td>"+
					    "</tr>";
					    */
					   // str =
					
		   			
				 }
				// str=str+"</table>";
				// alert(str)
				// document.getElementById('kpiDetailResultElement').innerHTML=str; 
				  
			}
		});
	
});

</script>
<%--
<div id="kpiDetailResultElement"></div>
 --%>
</body>
</html>