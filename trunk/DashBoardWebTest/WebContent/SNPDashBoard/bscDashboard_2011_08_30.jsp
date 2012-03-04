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
 

<!-- ----------------  My Custom          ------------------------- -->
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/kajax.js"></script>
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
 
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrbalancescorecard/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrbalancescorecard/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrbalancescorecard/util.js"></script>
 
<!-- Use for call JQuery treetable  -->
<script type="text/javascript">
jQuery(document).ready(function($) {
	$.facebox.settings.closeImage=_path+'/chartLib/images/closelabel.png';
	$("#targetAllSparkline").facebox();
	listYear();
});
/*  -----------------  Use JQuery to Create Tree ------------------------*/
function getParentLoop(parentID){
	  if ($("#"+parentID)){
		  var classValues= $("#"+parentID).attr("class");
		  if(classValues!=null && classValues!='undefined' && classValues.length>0){
			 if(classValues.indexOf("child-of-")!=-1){
				 var classArray= classValues.split(" ");
				 if(classArray!=null && classArray.length>0){
					 var nextParentId="";
					 for(var i=0;i<classArray.length;i++){
						 if(classArray[i].indexOf("child-of-")!=-1){
							var nextParentId= classArray[i].split("child-of-")[1];							 
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
 var treePerspectiveArray=[];
 var treeKPIArray=[];
 var myValuesArray=[{
		 id:"",
		 myValues:[],
		 trendChartValues:[],
		 colors:[]
 }];
 var _path='<%=request.getContextPath()%>';
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
		    	//	alert("fn.toggleBranch="+myValuesArray[i].myValues)
			    	$("#sparklines"+myValuesArray[i].id).sparkline(myValuesArray[i].myValues,{
				    	type: 'bullet',
				    	performanceColor:'blue',
				    	//targetColor:'red',
				    	targetColor:'blue',
				    	width:"auto" ,
				    	height:'auto',
				    	targetWidth:3,
				    	//rangeColors:['#D3DAFE','#A8B6FF','#7F94FF']
				    	//rangeColors:['green','yellow','red']
				    	rangeColors:myValuesArray[i].colors
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
function loadmetergraph(ivalue ,iFrameID)
{
	var objFrame=document.getElementById(iFrameID);
	objFrame.src=  ivalue;
}
  
  function showKPIDetail(kpiKey,dateKey){ 
	  //alert(kpiKey+","+dateKey)
	  var pk={ 
	  	kpiKey:kpiKey,
	   	dateKey:dateKey
		}; 
	BalanceScorecardAjax.getKPIDetail(pk,{
		callback:function(data_KPIDetail){ 
			//alert(data_KPIDetail)
		  if(data_KPIDetail!=null){			  
			  var bscKPIDetail=""+
			  	" <table width=\"700\" height=\"300\" border=\"0\" align=\"center\" style=\"text-decoration:none; background-color:	#e6e6fa\" class=\"popup\"> "+
			  	" <tr> "+
			    "    <td width=\"140\" colspan=\"1\" class=\"tdpopup\">KPI Name </td><td>"+data_KPIDetail.kpiName+"</td> "+
			    " </tr>  "+
			  	" <tr> "+
			  	" 	<td>Objective </td> <td>"+data_KPIDetail.objective+"</td> "+
			  	" </tr> "+
			  	" <tr> "+
			  	" 	<td>Formula</td><td>"+data_KPIDetail.formulaDesc+"</td> "+ 
			  	" </tr> "+
			  	" <tr> "+
			  	"    <td>Definition </td><td>"+data_KPIDetail.kpiDesc+"</td> "+
			  	" </tr> "+
			  	" <tr> "+
			  	"    <td>Unit of measure</td><td>"+data_KPIDetail.uom+"</td> "+
			  	" </tr> "+
			  	" <tr> "+
			  	" 	<td>Source of information <br>/ Data collector</td><td>"+data_KPIDetail.dataSource+"</td> "+
			  	" </tr>  "+
			  	" <tr> "+
			  	" 	<td>Target range</td><td>"+data_KPIDetail.targetRangeDesc+"</td> "+
			  	" </tr> "+
			  	" <tr> "+
			  	" 	<td>  Last revise</td><td>"+data_KPIDetail.lastRevisedDT+"</td> "+
			  	" </tr> "+
			  " </table>"; 	
			  $("#bscKPIDetail").html(bscKPIDetail);
			  $.facebox.settings.closeImage=_path+'/chartLib/images/closelabel.png';
			//  jQuery.facebox({ ajax: _path+"/SNPDashBoard/bscKPIDetail.jsp?kpiKey="+kpiKey+"&dateKey="+dateKey});
			 
			jQuery.facebox({ div:'#bscKPIDetail'});
			 
			/* 
			$('#facebox').css({
				  top:    getPageScroll()[1] + (getPageHeight() / 10),
				  left:   ($(window).width() - $('#facebox').width()) / 2
				}).show()
				*/
		 } 
		}
	});
	 
	   
	 
   }
  function showKPIBarChart(perspectiveKey,kpiKey,dateKey,accumulatedFlag){  
		var bscOwnerVal=$('select[id="bscOwner"]').val();//$('#bscOwner'); 
	   var yearVal =$('select[id="bscYear"]').val();// $("#bscYear");
	   var monthNameVal =$('select[id="bscMonth"]').val();// $("#bscMonth");	 
	  loadmetergraph('mixChart.jsp?bscOwner='+bscOwnerVal+'&bscYear='+yearVal+'&bscMonth='+monthNameVal+'&perspectiveKey='+perspectiveKey+'&kpiKey='+kpiKey+'&dateKey='+dateKey+'&accumulatedFlag='+accumulatedFlag,"ifrmgr_"+perspectiveKey);
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
				$('#bscYearElement').html(str);
			}
		});	
	
	}
   function clearTargetElement(){
	   $('.targetAllElement').html("");
	   clearAllPerspectiveArray();
   }
   function clearAllPerspectiveArray(){
     for(var i =0;i<treePerspectiveArray.length;i++){
	   		   $("#row_perspective_"+treePerspectiveArray[i]).css("display","none"); 
	   }
   }
   function listOwnerResult(){
	   var yearVal =$('select[id="bscYear"]').val();// $("#bscYear").val();
	   var monthNameVal = $('select[id="bscMonth"]').val() ;//$("#bscMonth").;
	  // alert(monthNameVal)
	  //document.getElementById("targetAllSparkline").innerHTML="";
	   clearTargetElement();
	   
	   var str="";
	   BalanceScorecardAjax.listOwnerResult(yearVal,monthNameVal,{
			callback:function(data_listOwnerResult){
				//alert(data_listOwnerResult)
				str=str+"<select name=\"bscOwner\" id=\"bscOwner\" onchange=\"clearTargetElement()\">";
				str=str+"<option value=\"0\">-- Select Owner --</option>";
				if(data_listOwnerResult!=null && data_listOwnerResult.length>0){ 
					for(var i=0;i<data_listOwnerResult.length;i++){
						str=str+"<option value=\""+data_listOwnerResult[i].kpiOwnerKey+"\">"+data_listOwnerResult[i].kpiOwnerName+"</option>";
					}
				} 
				str=str+"</select>";
				$('#bscOwnerElement').html(str);				
			}
		});
   }
   function returnTogaugeMeter(rowid){
	   var bscOwnerVal=$('select[id="bscOwner"]').val();//$('#bscOwner'); 
	   var yearVal =$('select[id="bscYear"]').val();// $("#bscYear");
	   var monthNameVal = $('select[id="bscMonth"]').val();//$("#bscMonth");   
	   
	  BalanceScorecardAjax.getKPIListAndChartLevel0(yearVal,monthNameVal,bscOwnerVal,rowid,{
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
 					kpiWeight=$().number_format(kpiresultthresholdDTOs[0].kpiOwnerWeighting!=null?kpiresultthresholdDTOs[0].kpiOwnerWeighting:0, {precision: 0,decimalSeparator: '.'});
 					weight=$().number_format(kpiresultthresholdDTOs[0].perspectiveWeighting!=null?kpiresultthresholdDTOs[0].perspectiveWeighting:0, {precision: 0,decimalSeparator: '.'});
 					freq=kpiresultthresholdDTOs[0].frequency;
 					target=kpiresultthresholdDTOs[0].targetValue;
 					//actual=kpiresultthresholdDTOs[0].percentActualVsTarget;
 					//actual=kpiresultthresholdDTOs[0].percentActualVsTarget;
	 					actual=kpiresultthresholdDTOs[0].actualValue;	 	
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
				var threshold_color=[];
				var threshold_value=[];
 				for(var j=0;j<kpiresultthresholdDTOs.length;j++){
 					threshold_color[j]=kpiresultthresholdDTOs[j].id.colorCode;
					threshold_value[j]=$().number_format(kpiresultthresholdDTOs[j].endThreshold!=null?kpiresultthresholdDTOs[j].endThreshold:0, {precision: 0,decimalSeparator: '.'});
					if(kpiresultthresholdDTOs[j].id.colorCode=='red'){
						endthreshold_red=$().number_format(kpiresultthresholdDTOs[j].endThreshold!=null?kpiresultthresholdDTOs[j].endThreshold:0, {precision: 0,decimalSeparator: '.'});
						beginthreshold_red=$().number_format(kpiresultthresholdDTOs[j].beginThreshold, {precision: 0,decimalSeparator: '.'});
						myValues=myValues+","+endthreshold_red;
					}else if(kpiresultthresholdDTOs[j].id.colorCode=='yellow'){
						endthreshold_yellow=$().number_format(kpiresultthresholdDTOs[j].endThreshold!=null?kpiresultthresholdDTOs[j].endThreshold:0, {precision: 0,decimalSeparator: '.'});
						beginthreshold_yellow=$().number_format(kpiresultthresholdDTOs[j].beginThreshold!=null?kpiresultthresholdDTOs[j].beginThreshold:0, {precision: 0,decimalSeparator: '.'});
						myValues=","+endthreshold_yellow+myValues;
					}else if(kpiresultthresholdDTOs[j].id.colorCode=='green'){
						endthreshold_green=$().number_format(kpiresultthresholdDTOs[j].endThreshold!=null?kpiresultthresholdDTOs[j].endThreshold:0, {precision: 0,decimalSeparator: '.'});
						beginthreshold_green=$().number_format(kpiresultthresholdDTOs[j].beginThreshold!=null?kpiresultthresholdDTOs[j].beginThreshold:0, {precision: 0,decimalSeparator: '.'});
						myValues=","+endthreshold_green+myValues;
					}
 					actualValue=kpiresultthresholdDTOs[j].actualValue;
					targetValue=kpiresultthresholdDTOs[j].targetValue;	
					percentActualVsTargettargetValue=kpiresultthresholdDTOs[j].percentActualVsTarget;
				
				}
		} 	 
 	  loadmetergraph('meterChart.jsp?gvalue='+percentActualVsTargettargetValue,"ifrmgr_"+rowid);
 	 }
	});   
}  
   function viewKPI(){ 
	   var bscOwnerVal=$('select[id="bscOwner"]').val();//$('#bscOwner'); 
	   var yearVal =$('select[id="bscYear"]').val();// $("#bscYear");
	   var monthNameVal =$('select[id="bscMonth"]').val();// $("#bscMonth"); 
	   //alert(bscOwnerVal)
	    BalanceScorecardAjax.getKPIOverall(yearVal,monthNameVal,bscOwnerVal,{
			callback:function(data_KPIOverall){ 
				var actualValue;
				var targetValue;
				var endthreshold_red;
				var endthreshold_yellow;
				var endthreshold_green;
				var threshold_color=[];
				var threshold_value=[];
				var percentActualVsTargettargetValue=0;
				if(data_KPIOverall!=null && data_KPIOverall.length==3){
					for(var i=0;i<data_KPIOverall.length;i++){
						threshold_color[i]=data_KPIOverall[i].colorCode;
						threshold_value[i]=$().number_format(data_KPIOverall[i].endThreshold!=null?data_KPIOverall[i].endThreshold:0, {precision: 0,decimalSeparator: '.'});
						if(data_KPIOverall[i].colorCode=='red'){
							endthreshold_red=$().number_format(data_KPIOverall[i].endThreshold!=null?data_KPIOverall[i].endThreshold:0, {precision: 0,decimalSeparator: '.'});
						}else if(data_KPIOverall[i].colorCode=='yellow'){
							endthreshold_yellow=$().number_format(data_KPIOverall[i].endThreshold!=null?data_KPIOverall[i].endThreshold:0, {precision: 0,decimalSeparator: '.'});
						}else if(data_KPIOverall[i].colorCode=='green'){
							endthreshold_green=$().number_format(data_KPIOverall[i].endThreshold!=null?data_KPIOverall[i].endThreshold:0, {precision: 0,decimalSeparator: '.'});
						}
						percentActualVsTargettargetValue=$().number_format(data_KPIOverall[i].percentActualVsTarget!=null?data_KPIOverall[i].percentActualVsTarget:0, {precision: 0,decimalSeparator: '.'});
						actualValue=data_KPIOverall[i].actualValue;
						targetValue=data_KPIOverall[i].targetValue;						
					}
					//var myvalues = [targetValue,actualValue,endthreshold_green,endthreshold_yellow,endthreshold_red];
					var myvalues = [targetValue,actualValue,threshold_value[2],threshold_value[1],threshold_value[0]];
					//alert(myvalues)
					$('.targetAllElement').sparkline(myvalues, {
				    	type: 'bullet',
				    	performanceColor:'blue',
				    	//targetColor:'red',
				    	targetColor:'blue',
				    	width:"auto" ,
				    	height:'auto',
				    	targetWidth:3,
				    	//rangeColors:['#D3DAFE','#A8B6FF','#7F94FF']
				    	//rangeColors:['green','yellow','red']
				    	rangeColors:[threshold_color[2],threshold_color[1],threshold_color[0]]				    	
				    	});
					 var overAllElementId= document.getElementById('targetAllSparkline');//.innerHTML=str;
					  overAllElementId.title=percentActualVsTargettargetValue+"%";
					  overAllElementId.href=_path+"/SNPDashBoard/PopupBullet.jsp?bscOwner="+bscOwnerVal+"&bscYear="+yearVal+"&bscMonth="+monthNameVal;
				} 
			}
		}); 
	    
	    var str2="<table width=\"100%\"    border=\"0\">";
	    BalanceScorecardAjax.getPerspective(bscOwnerVal,yearVal,monthNameVal,{
	 			callback:function(data_Perspective){
	 				treePerspectiveArray=[]; // clear perspective
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
	 						// <div id="FinancialTable" style="height:350px;overflow:auto;"></div> 
	 					    "<div id=\"tree_perspective_"+data_Perspective[i].perspectiveKey+"\" style=\"height:350px;overflow:auto;\">"+
	 						/*
	 					    "<iframe  id = \"ifrmgr_tree_perspective_"+data_Perspective[i].perspectiveKey+"\"" +
 							" style=\"width:100%;height:350px;overflow:auto;\""+
 							"src=\"\"" +
 							"marginwidth=\"0\" marginheight=\"0\" "+
 							"vspace=\"0\" hspace=\"0\" frameborder=\"0\" "+ 
 							"align=\"middle\" scrolling=\"no\">"+
 						    "</iframe>" +
 						    */
	 						"</div>"+
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
	 					treePerspectiveArray.push(data_Perspective[i].perspectiveKey);
	 				 }
	 				 str2=str2+"</table>";
	 				$('#perspectiveElement').html(str2);
	 				
	 				
	 			}
	 		});
	     
	 
   } 
</script>
<!-- Main Function area   -->
<script language="javascript">
var detailKPI_ID_Array=[];
function showhidebsc(rowid ){ 
	//alert(rowid)
	var row = document.getElementById("row_perspective_"+rowid); 
	var treeTable=$("#tree_perspective_"+rowid); 
	//var aoe =document.getElementById("ifrmgr_tree_perspective_"+rowid);
	//var mFrame=$("#gaugeDiv_"+rowid); 
	if (row.style.display == 'none') 
	{	 
		var haveIDPerspective=false;
		var indexPerspective=0; 
		   var bscOwnerVal=$('select[id="bscOwner"]').val();//$('#bscOwner'); 
		   var yearVal = $('select[id="bscYear"]').val();//$("#bscYear");
		   var monthNameVal =$('select[id="bscMonth"]').val();// $("#bscMonth"); 
		   // 
		   for(var i =0;i<treePerspectiveArray.length;i++){ 
		   	   if(treePerspectiveArray[i]!=rowid){ 
		   		 //  $("#row_perspective_"+treePerspectiveArray[i]).css("display","none"); 
			   }
		   }
		   
		   row.style.display=''; 
		   var str="<table  width=\"100%\" height=\"20\" class=\"bscTreegrid_"+rowid+"\" border=\"0\"><thead>"+
		    "	<tr height=\"5\" align=\"center\">"+
			"		<td width=\"43%\" class=\"tdsubheader\">KPI</td>"+
			"		<td width=\"20px\" class=\"tdsubheader\"></td>	"+
			"		<td width=\"6%\" class=\"tdsubheader\">O. Weight</td>"+
			"		<td width=\"6%\" class=\"tdsubheader\">P. Weight</td>"+		
			"		<td width=\"4%\" class=\"tdsubheader\">Freq</td>	"+	
			"		<td width=\"7%\" class=\"tdsubheader\">Target</td> "+
			"		<td width=\"7%\" class=\"tdsubheader\">Actual</td>	"+	
			"		<td width=\"10%\" class=\"tdsubheader\">Target</td>	"+
			"		<td width=\"10%\" class=\"tdsubheader\">Trend</td>"+
			"		<td width=\"12%\"	class=\"tdsubheader\" >Last Updated</td>"+
			"	</tr></thead><tbody>"; 
			BalanceScorecardAjax.getKPIListAndChartRecursive(yearVal,monthNameVal,bscOwnerVal,rowid,{
	 			callback:function(data_KPIListLevel0){
	 				//alert(data_KPIListLevel0.length)
	 				for(var i=0;i<data_KPIListLevel0.length;i++){
	 				var kpiresultthresholdDTOs = data_KPIListLevel0[i].kpiresultthresholdDTOs;
	 				var childOf=data_KPIListLevel0[i].childOf!=null?"class=\"child-of-"+rowid+"_node_"+data_KPIListLevel0[i].childOf+"\"":"";
	 				var trendChartLevel0=data_KPIListLevel0[i].trendChart;
	 				var kpiWeight=0;
	 				var weight='';
	 				var freq ;
	 				var target ;
	 				var actual 	;
	 				//Target 	Trend 	
	 				var lastUpdated;
	 				if(kpiresultthresholdDTOs!=null && kpiresultthresholdDTOs.length>0){	 
	 				//	alert(i+",kpiOwnerWeighting=>"+kpiresultthresholdDTOs[0].kpiOwnerWeighting+","+kpiresultthresholdDTOs[0].perspectiveWeighting)
	 					kpiWeight=$().number_format(kpiresultthresholdDTOs[0].kpiOwnerWeighting!=null?kpiresultthresholdDTOs[0].kpiOwnerWeighting:0, {precision: 0,decimalSeparator: '.'});//kpiresultthresholdDTOs[0].kpiOwnerWeighting;
	 					weight=$().number_format(kpiresultthresholdDTOs[0].perspectiveWeighting!=null?kpiresultthresholdDTOs[0].perspectiveWeighting:0, {precision: 0,decimalSeparator: '.'});//kpiresultthresholdDTOs[0].perspectiveWeighting;
	 					freq=kpiresultthresholdDTOs[0].frequency!=null?kpiresultthresholdDTOs[0].frequency:"";
	 					target=kpiresultthresholdDTOs[0].targetValue;
	 					//actual=kpiresultthresholdDTOs[0].percentActualVsTarget;
	 					actual=kpiresultthresholdDTOs[0].actualValue;	 					
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
					var threshold_color=[];
					var threshold_value=[];
					var colors=[];
					
	 				for(var j=0;j<kpiresultthresholdDTOs.length;j++){
	 					threshold_color[j]=kpiresultthresholdDTOs[j].id.colorCode;
						threshold_value[j]=$().number_format(kpiresultthresholdDTOs[j].endThreshold!=null?kpiresultthresholdDTOs[j].endThreshold:0, {precision: 0,decimalSeparator: '.'});
						//alert("xx="+kpiresultthresholdDTOs[j].endThreshold);
						if(kpiresultthresholdDTOs[j].id.colorCode=='red'){
							//alert("red="+kpiresultthresholdDTOs[j].endThreshold+","+kpiresultthresholdDTOs[j].beginThreshold)
							endthreshold_red=$().number_format(kpiresultthresholdDTOs[j].endThreshold!=null?kpiresultthresholdDTOs[j].endThreshold:0, {precision: 0,decimalSeparator: '.'});
							beginthreshold_red=$().number_format(kpiresultthresholdDTOs[j].beginThreshold!=null?kpiresultthresholdDTOs[j].beginThreshold:0, {precision: 0,decimalSeparator: '.'});
							myValues=myValues+","+endthreshold_red; 
						}else if(kpiresultthresholdDTOs[j].id.colorCode=='yellow'){
							//alert("yellow="+kpiresultthresholdDTOs[j].endThreshold+","+kpiresultthresholdDTOs[j].beginThreshold)
							endthreshold_yellow=$().number_format(kpiresultthresholdDTOs[j].endThreshold!=null?kpiresultthresholdDTOs[j].endThreshold:0, {precision: 0,decimalSeparator: '.'});
							beginthreshold_yellow=$().number_format(kpiresultthresholdDTOs[j].beginThreshold!=null?kpiresultthresholdDTOs[j].beginThreshold:0, {precision: 0,decimalSeparator: '.'});
							myValues=","+endthreshold_yellow+myValues; 
						}else if(kpiresultthresholdDTOs[j].id.colorCode=='green'){
							//alert("yellow="+kpiresultthresholdDTOs[j].endThreshold+","+kpiresultthresholdDTOs[j].beginThreshold)
							endthreshold_green=$().number_format(kpiresultthresholdDTOs[j].endThreshold!=null?kpiresultthresholdDTOs[j].endThreshold:0, {precision: 0,decimalSeparator: '.'});
							beginthreshold_green=$().number_format(kpiresultthresholdDTOs[j].beginThreshold!=null?kpiresultthresholdDTOs[j].beginThreshold:0, {precision: 0,decimalSeparator: '.'});
							myValues=","+endthreshold_green+myValues; 
						}
	 					actualValue=kpiresultthresholdDTOs[j].actualValue;
						targetValue=kpiresultthresholdDTOs[j].targetValue;	
						percentActualVsTargettargetValue=kpiresultthresholdDTOs[j].percentActualVsTarget;
						kpiKey=kpiresultthresholdDTOs[j].id.kpiKey;
						dateKey=kpiresultthresholdDTOs[j].id.dateKey;
						accumulatedFlag=kpiresultthresholdDTOs[j].accumulatedFlag;
					}
					//myValues=targetValue+","+actualValue+myValues;
					myValues = targetValue+","+actualValue+","+threshold_value[2]+","+threshold_value[1]+","+threshold_value[0];					
					//alert(i+"==>"+myValues)
					var color_size=threshold_color.length;
					for(var k=0;k<color_size;k++){
						colors[k]=threshold_color[(color_size-1)-k];
					}
					//alert(colors)
					var sparkId="_"+rowid+"_"+data_KPIListLevel0[i].kpiKey;
					var trendChartValue=""+trendChartLevel0.jan+","+trendChartLevel0.feb+","+
										""+trendChartLevel0.mar+","+trendChartLevel0.apr+","+
										""+trendChartLevel0.may+","+trendChartLevel0.jun+","+
										""+trendChartLevel0.jul+","+trendChartLevel0.aug+","+
										""+trendChartLevel0.sep+","+trendChartLevel0.oct+","+
										""+trendChartLevel0.nov+","+trendChartLevel0.dec+"";
									//	class=\"parent collapsed\"	
							str=str+"<tr  height=\"5\" id=\""+rowid+"_node_"+data_KPIListLevel0[i].kpiKey+"\" "+childOf+">"+
	 							"<td width=\"43%\" style=\"padding-left: 20px;\" >"+ 
							"<a style=\"cursor: pointer;\" onclick=\"showKPIBarChart('"+rowid+"','"+data_KPIListLevel0[i].kpiKey+"','"+data_KPIListLevel0[i].dateKey+"','"+accumulatedFlag+"')\">"+data_KPIListLevel0[i].kpiName+"</a></td>"+
							"<td width=\"20px\"  align=\"right\">"+  
							"<a style=\"cursor: pointer;\" id=\"KPIDetail_"+kpiKey+"\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('"+data_KPIListLevel0[i].kpiKey+"','"+data_KPIListLevel0[i].dateKey+"')\">"+
							"<img src=\""+_path+"/chartLib/images/question_shield.ico\" width=\"20px\" BORDER =\"0\"/></a>"+					
							"	</td>"+
				    		"<td width=\"6%\"  align=\"center\">"+kpiWeight+"%</td>"+	
							"<td width=\"6%\"  align=\"center\">"+weight+"%</td>			<td width=\"4%\" align=\"center\">"+freq+"</td>"+		
							"<td width=\"7%\"  align=\"center\">"+target+"</td>		<td width=\"7%\" align=\"center\">"+actual+"</td>"+		
							"<td width=\"7%\"  align=\"center\"><div   id=\"sparklines"+sparkId+"\" title=\""+percentActualVsTargettargetValue+"%\">"+myValues+"</div></td>"+		
						//	"<td width=\"7%\"  align=\"center\"><div   class=\"sparklines\" title=\""+percentActualVsTargettargetValue+"%\">"+myValues+"</div></td>"+
							"<td width=\"7%\"  align=\"center\"><div id=\"trendLine"+sparkId+"\" LineColor=\"red\" >"+trendChartValue+"</div></td>"+
						//	"<td width=\"7%\"  align=\"center\"><div class=\"trendLine\" LineColor=\"red\" >"+trendChartValue+"</div></td>"+
							"<td width=\"12%\" align=\"center\">"+lastUpdated+"</td>"+
					 		"</tr>";
							myValuesArray[i]={id:sparkId,myValues:myValues.split(","),trendChartValues:trendChartValue.split(","),colors:colors};					 		 
	 				} 
	 				str=str+"</tbody></table>"; 
	 				//alert("str")
					//treeTable.innerHTML=str; 
	 				treeTable.html(str);
					//aoe.src="bscProcess.jsp?year="+yearVal+"&month="+monthNameVal+"&bscOwner="+bscOwnerVal+"&rowid="+rowid;
					///var xx= ajaxdata("bscProcess.jsp?year="+yearVal+"&month="+monthNameVal+"&bscOwner="+bscOwnerVal+"&rowid="+rowid);
					//alert(xx);
					//alert("xxxx");
					//treeTable.innerHTML =xx;
					//initProcess();
					//$(".bscTreegrid_"+rowid).treeTable();
				 	for(var i=0;i<myValuesArray.length;i++){ 
				 		//alert("valuess=#sparklines"+myValuesArray[i].id);
				 		 $("#sparklines"+myValuesArray[i].id).sparkline(myValuesArray[i].myValues, {
				 			type: 'bullet',
					    	performanceColor:'blue',
					    	//targetColor:'red',
					    	targetColor:'blue',
					    	width:"auto" ,
					    	height:'auto',
					    	targetWidth:3,
					    	//rangeColors:['#D3DAFE','#A8B6FF','#7F94FF']
					    	//rangeColors:['green','yellow','red']
					    	rangeColors:myValuesArray[i].colors
				 		 } ); 
				 		$("#trendLine"+myValuesArray[i].id).sparkline(myValuesArray[i].trendChartValues, {barColor: 'red'}); 
					} 
				 	$(".bscTreegrid_"+rowid).treeTable();
				 	/*
				 	targetValue	actualValue
				 	endthreshold_green
				 	endthreshold_green
				 	endthreshold_green
				 	*/
				 	loadmetergraph('meterChart.jsp?gvalue='+percentActualVsTargettargetValue+'&target='+targetValue+'&actual='+actualValue+'&red='+endthreshold_red+'&yellow='+endthreshold_yellow+'&green='+endthreshold_green,"ifrmgr_"+rowid);
				 //loadmetergraph('meterChart.jsp?gvalue='+percentActualVsTargettargetValue,"ifrmgr_"+rowid); 
	 			} 
		  });  
	}
	else
	{		row.style.display='none';
			treeTable.html("");
	}
} 
</script>
<!-- -------------------------------------------------------------------- --> 

<body>
 
<Table width="100%" border="0" height="50" charset="utf-8"> 
		<tr	id="r4">
			<td colspan="2" align="left" class="tdmainheader"> 
				<div align="center"> S&P Balanced Scorecard </div>
			</td>
		</tr>
		 <tr>
		    <td colspan="2">
		    <div id="bscKPIDetail" style="display:none;"></div>
		    </td>
		  </tr>
<!-- ----------------  Condition Combobox ----------------- -->
		<tr>
			<td colspan="2" align="left" class="tdcondition">
				<form method="post" action="<%=request.getContextPath()%>/SNPDashBoard/bscDashboard.jsp?viewKPI=1">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year : <span id="bscYearElement"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month :
				<select name="bscMonth" id="bscMonth" onchange="listOwnerResult()" >
					<option value="0">-- Select Month --</option>
					<option value="1">January</option>
					<option value="2">February</option>
					<option value="3">March</option>
					<option value="4">April</option>
					<option value="5">May</option>
					<option value="6">June</option>
					<option value="7">July</option>
					<option value="8">August</option>
					<option value="9">September</option>
					<option value="10">October</option>
					<option value="11">November</option>
					<option value="12">December</option>
				</select> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Owner : <span id="bscOwnerElement">
				<select name="bscOwner" id="bscOwner" onchange="clearTargetElement()">
					<option value="0">-- Select Owner --</option>
				</select>
				</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value=" View KPI " onclick="viewKPI()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a id="targetAllSparkline" rev="iframe|420">
				 <span class="targetAllElement" style="cursor: pointer;"></span>
				</a> 
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
		   
	</Table> 
</body>
</html>