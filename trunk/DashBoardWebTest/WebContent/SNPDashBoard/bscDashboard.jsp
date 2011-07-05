<!--
*********************************************************
*	EditDate	: April 2011							*
*	Project		: S&P BI Dashboard						*
*	Version		: Prototype Ver.001						*
*	Programmer	: Kriengkrai							*
*********************************************************
Integration Data
---------------------------------------------------------

---------------------------------------------------------
*********************************************************
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	<Title> S&P Dashboard </Title> </head>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<META HTTP-EQUIV="EXPIRES" CONTENT="-1" />
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
<%-- 
<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css"> 
<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
--%>
<%--
 <script type='text/javascript' src='https://ajax.googleapis.com/jsapi'></script>
--%>
<!--  DWR -->
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/util.js"></script>
 
<!-- Use for call JQuery treetable  -->
<script type="text/javascript">
	 

/* -----------------  Use JQuery to Create Tree ------------------------*/
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
 function checkTreePerspectiveArray(){
	 alert(treePerspectiveArray.length);
	 for(var i=0;i<treePerspectiveArray.length;i++){
 		alert(treePerspectiveArray[i].id)
 		var tree_perspectiveElement= document.getElementById('tree_perspective_'+treePerspectiveArray[i].id);
 		
 		var tableStr=tree_perspectiveElement.innerHTML;
 		if(tableStr.length>0)
 			alert(tableStr.split("</tbody></table>")[0])
 		var kpis=treePerspectiveArray[i].kpis;
		for(var j=0;j<kpis.length;j++){
			alert(kpis[j]) 
		}
 		}
}
 var treePerspectiveArray=[];
 var treeKPIArray=[];
 var _path='<%=request.getContextPath()%>';
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
	 		 		alert(tableStr)
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
	 		      var   xx = null;
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
function loadmetergraph(ivalue ,iFrameID)
{
	//alert("load")
	var objFrame=document.getElementById(iFrameID);
	objFrame.src=  ivalue;
}
  function showKPIDetail(kpiKey,dateKey){ 
	  $.facebox.settings.closeImage=_path+'/chartLib/images/closelabel.png';
	  jQuery.facebox({ ajax: _path+"/SNPDashBoard/bscKPIDetail.jsp?kpiKey="+kpiKey+"&dateKey="+dateKey}); 
   }
  function showKPIBarChart(perspectiveKey,kpiKey,dateKey,accumulatedFlag){ 
	  alert("perspectiveKey="+perspectiveKey+",kpiKey="+kpiKey+",dateKey="+dateKey+",accumulatedFlag="+accumulatedFlag);
	  //getKPIChart
	  //getTrendChart()
	  //(Integer year,String monthName,int KPIOwnerKey,Integer kpiKey){
		var bscOwner=document.getElementById('bscOwner'); 
	   var year = document.getElementById("bscYear");
	   var monthName = document.getElementById("bscMonth");
	 
	  loadmetergraph('mixChart.jsp?bscOwner='+bscOwner.value+'&bscYear='+year.value+'&bscMonth='+monthName.value+'&perspectiveKey='+perspectiveKey+'&kpiKey='+kpiKey+'&dateKey='+dateKey+'&accumulatedFlag='+accumulatedFlag,"ifrmgr_"+perspectiveKey);
	  
	  //$.facebox.settings.closeImage=_path+'/chartLib/images/closelabel.png';
	  //jQuery.facebox({ ajax: _path+"/SNPDashBoard/bscKPIDetail.jsp?kpiKey="+kpiKey+"&dateKey="+dateKey}); 
   }
  
	 // Ajax function
  function listYear(){
		var str="";
		BalanceScorecardAjax.listYear({
			callback:function(data){
				str=str+"<select name=\"bscYear\" id=\"bscYear\" onchange=\"listOwnerResult()\">";
				str=str+"<option value=\"0\">-- Select Year --</option>";
				if(data!=null && data.length>0){					
						for(var i=0;i<data.length;i++){
							str=str+"<option value=\""+data[i]+"\">"+data[i]+"</option>";
						} 
				} 
				str=str+"</select>";
				document.getElementById('bscYearElement').innerHTML=str;
			}
		});		 
	}
   function listOwnerResult(){
	   var year = document.getElementById("bscYear");
	   var monthName = document.getElementById("bscMonth");
	   var str="";
	   BalanceScorecardAjax.listOwnerResult(year.value,monthName.value,{
			callback:function(data_listOwnerResult){
				str=str+"<select name=\"bscOwner\" id=\"bscOwner\">";
				str=str+"<option value=\"0\">-- Select Owner --</option>";
				if(data_listOwnerResult!=null && data_listOwnerResult.length>0){ 
					for(var i=0;i<data_listOwnerResult.length;i++){
						str=str+"<option value=\""+data_listOwnerResult[i].kpiOwnerKey+"\">"+data_listOwnerResult[i].kpiOwnerName+"</option>";
					}
				} 
				str=str+"</select>";
				document.getElementById('bscOwnerElement').innerHTML=str;				
			}
		});
   }
   function returnTogaugeMeter(rowid){
	   var bscOwner=document.getElementById('bscOwner'); 
	   var year = document.getElementById("bscYear");
	   var monthName = document.getElementById("bscMonth");   
	   
	  BalanceScorecardAjax.getKPIListAndChartLevel0(year.value,monthName.value,bscOwner.value,rowid,{
 			callback:function(data_KPIListLevel0){ 
 				for(var i=0;i<data_KPIListLevel0.length;i++){
 				var kpiresultthresholdDTOs = data_KPIListLevel0[i].kpiresultthresholdDTOs;
 				var trendChartLevel0=data_KPIListLevel0[i].trendChart;
 				var kpiWeight=0;
 				var weight='';
 				var freq ;
 				var target ;
 				var actual 	;
 				//Target 	Trend 	
 				var lastUpdated;
 				if(kpiresultthresholdDTOs!=null && kpiresultthresholdDTOs.length>0){ 
 					kpiWeight=$().number_format(kpiresultthresholdDTOs[0].kpiOwnerWeighting, {precision: 0,decimalSeparator: '.'});
 					weight=$().number_format(kpiresultthresholdDTOs[0].perspectiveWeighting, {precision: 0,decimalSeparator: '.'});
 					freq=kpiresultthresholdDTOs[0].frequency;
 					target=kpiresultthresholdDTOs[0].targetValue;
 					actual=kpiresultthresholdDTOs[0].percentActualVsTarget;
 					lastUpdated =(kpiresultthresholdDTOs[0].updatedDT!=null)?$.format.date(kpiresultthresholdDTOs[0].updatedDT, "dd/MM/yyyy"):"";
 				}
				var myValues="";
 				 
				var actualValue;
				var targetValue;
				var endthreshold_red;
				var endthreshold_yellow;
				var endthreshold_green;
				var beginthreshold_red;
				var beginthreshold_yellow;
				var beginthreshold_green;
				var percentActualVsTarget="";
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
				
				}
		}
 				 var gaugeDiv= "gaugeDiv_"+rowid; 
 				 /*
 			 	var data_gauge = new google.visualization.DataTable();
 			 data_gauge.addColumn('string', 'Label');
 			   data_gauge.addColumn('number', 'Value');
 			   data_gauge.addRows(1);
 			   data_gauge.setValue(0, 0, '');
 			   data_gauge.setValue(0, 1, percentActualVsTargettargetValue); 
 			   var chart_gauge = new google.visualization.Gauge(document.getElementById(gaugeDiv));
 			   var options = {width: 400, height: 120, redFrom: beginthreshold_red, redTo: endthreshold_red, greenFrom: beginthreshold_green, greenTo: endthreshold_green,
 			       yellowFrom:beginthreshold_yellow, yellowTo: endthreshold_yellow, minorTicks: 5};
 			   chart_gauge.draw(data_gauge, options);	
 			   */
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
 			//  jsonCircle
 			/*
 			 zingchart.render({
 				id 				: gaugeDiv,
 				data 		    : jsonCircle,
 				width	 		: 450,
 				height 			: 350
 				
 			});
 			*/
 			 loadmetergraph('meterChart.jsp?gvalue='+percentActualVsTargettargetValue,"ifrmgr_"+rowid);
 	 }
	});   
}  
   function viewKPI(){
	   
	   var bscOwner=document.getElementById('bscOwner'); 
	   var year = document.getElementById("bscYear");
	   var monthName = document.getElementById("bscMonth"); 
	    BalanceScorecardAjax.getKPIOverall(year.value,monthName.value,bscOwner.value,{
			callback:function(data_KPIOverall){ 
				var actualValue;
				var targetValue;
				var endthreshold_red;
				var endthreshold_yellow;
				var endthreshold_green;
				if(data_KPIOverall!=null && data_KPIOverall.length==3){
					for(var i=0;i<data_KPIOverall.length;i++){
						if(data_KPIOverall[i].colorCode=='red'){
							endthreshold_red=$().number_format(data_KPIOverall[i].endThreshold, {precision: 0,decimalSeparator: '.'});
						}else if(data_KPIOverall[i].colorCode=='yellow'){
							endthreshold_yellow=$().number_format(data_KPIOverall[i].endThreshold, {precision: 0,decimalSeparator: '.'});
						}else if(data_KPIOverall[i].colorCode=='green'){
							endthreshold_green=$().number_format(data_KPIOverall[i].endThreshold, {precision: 0,decimalSeparator: '.'});
						}
						actualValue=data_KPIOverall[i].actualValue;
						targetValue=data_KPIOverall[i].targetValue;						
					}
					var myvalues = [targetValue,actualValue,endthreshold_green,endthreshold_yellow,endthreshold_red];
					$('.targetAllElement').sparkline(myvalues, {
				    	type: 'bullet',
				    	performanceColor:'blue',
				    	targetColor:'red',
				    	width:"auto" ,
				    	height:'auto',
				    	targetWidth:3,
				    	rangeColors:['#D3DAFE','#A8B6FF','#7F94FF']
				    	});
				} 
			}
		}); 
	    
	    var str2="<table width=\"100%\"       border=\"0\">";
	    BalanceScorecardAjax.getPerspective(bscOwner.value,year.value,monthName.value,{
	 			callback:function(data_Perspective){
	 				 for(var i=0;i<data_Perspective.length;i++){
	 					 var css_class="tdbscNameFin";
	 					 if(i%2==0)
	 						css_class="tdbscNameCus";
	 					 str2=str2+"<tr>"+
	 						"	<td colspan=\"1\"  class=\""+css_class+"\" align=\"left\">"+
	 						//"		<a href=\"javascript:showhidebsc('"+data_Perspective[i].perspectiveKey+"')\" class=\"bsc\">"+data_Perspective[i].perspectiveName+"</a>"+
	 						"		<div onclick=\"showhidebsc('"+data_Perspective[i].perspectiveKey+"')\" style=\"cursor: pointer;\" class=\"bsc\">"+data_Perspective[i].perspectiveName+"</div>"+
	 						"	</td>"+
	 						"	<td   class=\""+css_class+"\" align=\"center\" width=\"450\">"+ 
	 						"		<a style=\"cursor: pointer;\" onclick=\"returnTogaugeMeter(\'"+data_Perspective[i].perspectiveKey+"\')\" class=\"bsc\"> Return to Gauge Meter</a>"+
	 						"	</td>"+
	 						"</tr>"+
	 					    "<tr valign=\"top\" id=\"row_perspective_"+data_Perspective[i].perspectiveKey+"\" style=\"display: none;\">"+
	 						"	<td align=\"top\"   align=\"left\">"+	
	 						"<div id=\"tree_perspective_"+data_Perspective[i].perspectiveKey+"\"></div>"+
	 						"	</td>"+
	 						"	<td  align=\"center\" width=\"450\">"+	 		
	 						//"<div id=\"gaugeDiv_"+data_Perspective[i].perspectiveKey+"\" style=\"width: 50; height: 50\"></div>"+
	 						"<div id=\"gaugeDiv_"+data_Perspective[i].perspectiveKey+"\" style=\"width: 50; height: 50\">"+
	 						"<iframe  id = \"ifrmgr_"+data_Perspective[i].perspectiveKey+"\"" +
	 							"width=450 height=350 "+
	 							"src=\"\"" +
	 							"marginwidth=\"0\" marginheight=\"0\" "+
	 							"vspace=\"0\" hspace=\"0\" frameborder=\"0\" "+ 
	 							"align=\"middle\" scrolling=\"no\">"+
	 							"</iframe>" +
	 						"</div>"+
	 						"	</td>"+
	 						"</tr>"; 
	 				 }
	 				 str2=str2+"</table>";
	 				document.getElementById('perspectiveElement').innerHTML=str2;
	 				treePerspectiveArray=[]; // clear perspective
	 			}
	 		});
	     
	  var overAllElementId= document.getElementById('targetAllSparkline');//.innerHTML=str;
	  overAllElementId.href=_path+"/SNPDashBoard/PopupBullet.jsp?bscOwner="+bscOwner.value+"&bscYear="+year.value+"&bscMonth="+monthName.value;
	//  overAllElementId.rel="facebox";
	 // $("#targetAllSparkline").fancybox();
	 
	  
	  // document.getElementById('targetAllElement').innerHTML="50,38,60,40,20";
	 //  var myvalues = [50,38,60,40,20];
	//   var myvalues = [50,60,70];
      // $('.dynamicsparkline').sparkline(myvalues);
        /* The second argument gives options such as chart type */
   //     $('.dynamicbar').sparkline(myvalues, {type: 'bar', barColor: 'green'} )
     //  $('.targetAllElement').sparkline(myvalues, {type: 'bullet', targetColor: '#D3DAFE' , targetColor: 'red' , width:"60px" , targetWidth:"3" } );
         // $('.targetAllElement').sparkline(myvalues, {type: 'bullet', targetColor: 'yellow' , targetColor: 'red' ,targetColor: 'green', width:"60px" , targetWidth:"3" } );
        
	  // getPerspective();
   }
    
</script>
<!------------------------------------------------------------------------>


<body>
 
<Table width="100%" border="1" height="50" charset="utf-8"> 
		<tr	id="r4">
			<td colspan="2" align="left" class="tdmainheader"> 
				<div align="center"> S&P Balanced Scorecard </div>
			</td>
		</tr>
<!------------------  Condition Combobox ------------------->
		<tr>
			<td colspan="2" align="left" class="tdcondition">
				<form method="post" action="<%=request.getContextPath()%>/SNPDashBoard/bscDashboard.jsp?viewKPI=1">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year : <span id="bscYearElement"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month :
				<select name="bscMonth" id="bscMonth" onchange="listOwnerResult()" >
					<option value="0">-- Select Month --</option>
					<option value="Jan">January</option>
					<option value="Feb">February</option>
					<option value="Mar">March</option>
					<option value="Apr">April</option>
					<option value="May">May</option>
					<option value="Jun">June</option>
					<option value="Jul">July</option>
					<option value="Aug">August</option>
					<option value="Sep">September</option>
					<option value="Oct">October</option>
					<option value="Nov">November</option>
					<option value="Dec">December</option>
				</select> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Owner : <span id="bscOwnerElement">
				<select name="bscOwner" id="bscOwner" >
					<option value="0">-- Select Owner --</option>
				</select>
				</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value=" View KPI " onclick="viewKPI()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a id="targetAllSparkline"><span  class="targetAllElement"></span></a>
				 
				</form>
			  </td>
		  </tr> 
		  <tr>
		  <td colspan="2">
		 
		  </td>
		  </tr>
		  <tr>
		    <td colspan="2">
		    <span id="perspectiveElement"></span>
		    </td>
		  </tr>
		   <tr>
		    <td colspan="2">
		   <input type="button" name="check" value="check" onclick="checkTreePerspectiveArray()">
		    </td>
		  </tr>
	</Table> 

<!---------------------------------------Main Function area  -------------------------->
<script language="javascript">
var _path='<%=request.getContextPath()%>';
var detailKPI_ID_Array=[];
function showhidebsc(rowid ){ 
	var row = document.getElementById("row_perspective_"+rowid); 
	var treeTable=document.getElementById("tree_perspective_"+rowid); 
	var mFrame=document.getElementById("gaugeDiv_"+rowid);
	//alert(treeTable)
	//alert("aa")
	if (row.style.display == 'none')
	//if (row.style.display == 'block')
	{	 
		// if (mFrame != '/SNPDashBoard/meterChart.jsp?gvalue=95')
	//	{
			//loadmetergraph('meterChart.jsp?gvalue=95',"ifrmgr_"+rowid);	
		//}
		var haveIDPerspective=false;
		var indexPerspective=0;
    	for(var i=0;i<treePerspectiveArray.length;i++){
    		if(treePerspectiveArray[i].id==rowid){
    			indexPerspective=i;    		
    			haveIDPerspective=true;
    			break;
    		}
    			
    	}
    	
		   var bscOwner=document.getElementById('bscOwner'); 
		   var year = document.getElementById("bscYear");
		   var monthName = document.getElementById("bscMonth"); 
		   row.style.display=''; 
		   var str="<table  width=\"100%\" height=\"20\" class=\"bscTreegrid_"+rowid+"\" border=\"1\"><thead>"+
		    "	<tr height=\"5\" align=\"center\">"+
			"		<td width=\"43%\" class=\"tdsubheader\">KPI</td>"+
			"		<td width=\"20px\" class=\"tdsubheader\"></td>	"+
			"		<td width=\"6%\" class=\"tdsubheader\">KPI Weight</td>"+
			"		<td width=\"6%\" class=\"tdsubheader\">Weight</td>"+		
			"		<td width=\"4%\" class=\"tdsubheader\">Freq</td>	"+	
			"		<td width=\"7%\" class=\"tdsubheader\">Target</td> "+
			"		<td width=\"7%\" class=\"tdsubheader\">Actual</td>	"+	
			"		<td width=\"10%\" class=\"tdsubheader\">Target</td>	"+
			"		<td width=\"10%\" class=\"tdsubheader\">Trend</td>"+
			"		<td width=\"12%\"	class=\"tdsubheader\" >Last Updated</td>"+
			"	</tr></thead><tbody>";
			
		  BalanceScorecardAjax.getKPIListAndChartLevel0(year.value,monthName.value,bscOwner.value,rowid,{
	 			callback:function(data_KPIListLevel0){ 
	 				for(var i=0;i<data_KPIListLevel0.length;i++){
	 				var kpiresultthresholdDTOs = data_KPIListLevel0[i].kpiresultthresholdDTOs;
	 				var trendChartLevel0=data_KPIListLevel0[i].trendChart;
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
					 
					var trendChartValue=""+trendChartLevel0.jan+","+trendChartLevel0.feb+","+
										""+trendChartLevel0.mar+","+trendChartLevel0.apr+","+
										""+trendChartLevel0.may+","+trendChartLevel0.jun+","+
										""+trendChartLevel0.jul+","+trendChartLevel0.aug+","+
										""+trendChartLevel0.sep+","+trendChartLevel0.oct+","+
										""+trendChartLevel0.nov+","+trendChartLevel0.dec+"";
									//	class=\"parent collapsed\"	
							str=str+"<tr  height=\"5\" id=\""+rowid+"_node_"+data_KPIListLevel0[i].kpiKey+"\" class=\"parent collapsed\">"+
	 							"<td width=\"43%\" style=\"padding-left: 20px;\" >"+ 
							"<div style=\"cursor: pointer;\" onclick=\"showKPIBarChart('"+rowid+"','"+data_KPIListLevel0[i].kpiKey+"','"+data_KPIListLevel0[i].dateKey+"','"+accumulatedFlag+"')\">"+data_KPIListLevel0[i].kpiName+"</div></td>"+
							"<td width=\"20px\"  align=\"right\">"+  
							"<a style=\"cursor: pointer;\" id=\"KPIDetail_"+kpiKey+"\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('"+data_KPIListLevel0[i].kpiKey+"','"+data_KPIListLevel0[i].dateKey+"')\">"+
							"<img src=\""+_path+"/chartLib/images/question_shield.ico\" width=\"20px\" BORDER =\"0\"/></a>"+					
							"	</td>"+
				    		"<td width=\"6%\"  align=\"center\">"+kpiWeight+"%</td>"+	
							"<td width=\"6%\"  align=\"center\">"+weight+"%</td>			<td width=\"4%\" align=\"center\">"+freq+"</td>"+		
							"<td width=\"7%\"  align=\"center\">"+target+"</td>		<td width=\"7%\" align=\"center\">"+actual+"</td>"+		
						//	"<td width=\"7%\"  align=\"center\"><div   class=\"sparklines_"+rowid+"_"+i+"\" title=\""+percentActualVsTargettargetValue+"%\">"+myValues+"</div></td>"+		
							"<td width=\"7%\"  align=\"center\"><div   class=\"sparklines\" title=\""+percentActualVsTargettargetValue+"%\">"+myValues+"</div></td>"+
						//	"<td width=\"7%\"  align=\"center\"><div class=\"trendLine_"+rowid+"_"+i+"\" LineColor=\"red\" >"+trendChartValue+"</div></td>"+
							"<td width=\"7%\"  align=\"center\"><div class=\"trendLine\" LineColor=\"red\" >"+trendChartValue+"</div></td>"+
							"<td width=\"12%\" align=\"center\">"+lastUpdated+"</td>"+
					 		"</tr>";
					 		alert(myValues);
					 		 
	 				}
	 				var perspectiveObj={id:rowid,kpis:[]};
	 				if(!haveIDPerspective){
	 		    		//var kpiObj={id:} 
	 		    		treePerspectiveArray.push(perspectiveObj);
	 		    	}else{
	 		    		treePerspectiveArray[indexPerspective]=perspectiveObj;
	 		    	}
	 				str=str+"</tbody></table>"; 
	 			//	alert(str)
					treeTable.innerHTML=str;
					$(".bscTreegrid_"+rowid).treeTable();
					// $(this).removeClass("expanded").collapse();
				//	for(var i=0;i<data_KPIListLevel0.length;i++){
					//	$('.sparklines_'+rowid+'_'+i+'').sparkline('html',{
					$('.sparklines').sparkline('html',{
					    	type: 'bullet',
					    	performanceColor:'blue',
					    	targetColor:'red',
					    	width:"auto" ,
					    	height:'auto',
					    	targetWidth:3,
					    	rangeColors:['#D3DAFE','#A8B6FF','#7F94FF']
					    	});
				//for(var i=0;i<data_KPIListLevel0.length;i++){
				//		$('.trendLine_'+rowid+'_'+i+'').sparkline('html' , {barColor: 'red'}); 
						$('.trendLine').sparkline('html' , {barColor: 'red'});
						  var index_PKI_size=detailKPI_ID_Array.length;
						  var havedID=false;
						  for(var k =0;k<index_PKI_size;k++){
							//  if(detailKPI_ID_Array[k]=='KPIDetail_'+data_KPIListLevel0[i].kpiKey){
							//	  havedID=true;
							//	  break;
							// } 
						  }
						  if(!havedID){
							//  var kpidetail_lementId= document.getElementById('KPIDetail_'+data_KPIListLevel0[i].kpiKey);//.innerHTML=str;
							//	 kpidetail_lementId.href=_path+"/SNPDashBoard/bscKPIDetail.jsp?kpiKey="+data_KPIListLevel0[i].kpiKey+"&dateKey="+data_KPIListLevel0[i].dateKey
						 	 
							 // kpidetail_lementId.href=_path+"/SNPDashBoard/bscKPIDetail.jsp?kpiKey="+data_KPIListLevel0[i].kpiKey+"&dateKey="+data_KPIListLevel0[i].dateKey
							  //detailKPI_ID_Array.push('KPIDetail_'+data_KPIListLevel0[i].kpiKey);
							// $("#KPIDetail_"+data_KPIListLevel0[i].kpiKey).fancybox();
							//  alert("KPIDetail_"+data_KPIListLevel0[i].kpiKey);
							 // alert(detailKPI_ID_Array.length);
						  }
						  //$("#KPIDetail_"+data_KPIListLevel0[i].kpiKey).fancybox(); 
						  //$("a.KPIDetail").fancybox();  //$(".KPIDetail").fancybox();
						 
				//	}
					// set gauge
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
					loadmetergraph('meterChart.jsp?gvalue='+percentActualVsTargettargetValue,"ifrmgr_"+rowid);
					var gaugeDiv= "gaugeDiv_"+rowid;
				// var gauge = bindows.loadGaugeIntoDiv(""+_path+"/gauges/gauge.xml", gaugeDiv);
				/*
				  var data_gauge = new google.visualization.DataTable();
				  data_gauge.addColumn('string', 'Label');
			        data_gauge.addColumn('number', 'Value');
			        data_gauge.addRows(1);
			        data_gauge.setValue(0, 0, '');
			        data_gauge.setValue(0, 1, percentActualVsTargettargetValue); 
					
			        var chart_gauge = new google.visualization.Gauge(document.getElementById(gaugeDiv));
			        var options = {width: 400, height: 120, redFrom: beginthreshold_red, redTo: endthreshold_red, greenFrom: beginthreshold_green, greenTo: endthreshold_green,
			            yellowFrom:beginthreshold_yellow, yellowTo: endthreshold_yellow, minorTicks: 5};
			        chart_gauge.draw(data_gauge, options); 
			        */
			        /*
			        zingchart.render({
		 				id 				: gaugeDiv,
		 				data 		    : jsonCircle,
		 				width	 		: 450,
		 				height 			: 350
		 				
		 			});
			        */
	 			}
		  });  
	}
	else
	{		row.style.display='none';
			treeTable.innerHTML="";
	}
} 
</script> 

 

<script type="text/javascript"> 
//jQuery(document).ready(function($) {
 // $('a[rel*=facebox]').facebox({
 
//google.load('visualization', '1', {packages:['gauge']});
$.facebox.settings.closeImage=_path+'/chartLib/images/closelabel.png';
//$("#targetAllSparkline").fancybox();
$("#targetAllSparkline").facebox();
//$(".KPIDetail").fancybox();
//$("a.KPIDetail").fancybox();
listYear();
</script>

</body>
</html>