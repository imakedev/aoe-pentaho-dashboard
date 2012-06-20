<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> <title>Process treeview</title> </head>
<%@ page contentType="text/html; charset=UTF-8" %>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<META HTTP-EQUIV="EXPIRES" CONTENT="-1" />

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.treeTable.css" rel="stylesheet"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.treeTable.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script>
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
 <script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/interface/BalanceScorecardAjax.js"></script>
<script>
//var xx= ajaxdata("bscProcess.jsp?year="+year.value+"&month="+monthName.value+"&bscOwner="+bscOwner.value+"&rowid="+rowid);
var _rowId='<%=request.getParameter("rowid")%>';
var _year='<%=request.getParameter("year")%>';
var _month='<%=request.getParameter("month")%>';
var _bscOwner='<%=request.getParameter("bscOwner")%>';
var _path='<%=request.getContextPath()%>';
function initProcess(){
	 
	//var treeTable=document.getElementById("tree_perspective_"+_rowId);
	var treeTable=document.getElementById("tree_perspective_");
    alert(treeTable)
	var str="<table  width=\"100%\" height=\"20\" class=\"bscTreegrid_"+_rowId+"\" border=\"0\"><thead>"+
	"	<tr height=\"5\" align=\"center\">"+
	"		<td width=\"43%\" class=\"tdsubheader\">KPI</td>"+
	"		<td width=\"20px\" class=\"tdsubheader\"></td>	"+
	"		<td width=\"6%\" class=\"tdsubheader\">KPI Weight</td>"+
	"		<td width=\"6%\" class=\"tdsubheader\">P. Weight</td>"+		
	"		<td width=\"4%\" class=\"tdsubheader\">Freq</td>	"+	
	"		<td width=\"7%\" class=\"tdsubheader\">Target</td> "+
	"		<td width=\"7%\" class=\"tdsubheader\">Actual</td>	"+	
	"		<td width=\"10%\" class=\"tdsubheader\">Target</td>	"+
	"		<td width=\"10%\" class=\"tdsubheader\">Trend</td>"+
	"		<td width=\"12%\"	class=\"tdsubheader\" >Last Updated</td>"+
	"	</tr></thead><tbody>"; 
	BalanceScorecardAjax.getKPIListAndChartRecursive(_year,_month,_bscOwner,_rowId,{
			callback:function(data_KPIListLevel0){ 
				 var myValuesBscProcessArray=[{
					 id:"",
					 myValues:[],
					 trendChartValues:[],
					 colors:[]
			     }];
				for(var i=0;i<data_KPIListLevel0.length;i++){
				var kpiresultthresholdDTOs = data_KPIListLevel0[i].kpiresultthresholdDTOs;
				var childOf=data_KPIListLevel0[i].childOf!=null?"class=\"child-of-"+_rowId+"_node_"+data_KPIListLevel0[i].childOf+"\"":"";
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
				threshold_value[j]=$().number_format(kpiresultthresholdDTOs[j].endThreshold, {precision: 0,decimalSeparator: '.'});
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
			//myValues=targetValue+","+actualValue+myValues;
			myValues = targetValue+","+actualValue+","+threshold_value[2]+","+threshold_value[1]+","+threshold_value[0];
			//alert(myValues)
			var color_size=threshold_color.length;
			for(var k=0;k<color_size;k++){
				colors[k]=threshold_color[(color_size-1)-k];
			}
			//alert(colors)
			var sparkId="_"+_rowId+"_"+data_KPIListLevel0[i].kpiKey;
			var trendChartValue=""+trendChartLevel0.jan+","+trendChartLevel0.feb+","+
								""+trendChartLevel0.mar+","+trendChartLevel0.apr+","+
								""+trendChartLevel0.may+","+trendChartLevel0.jun+","+
								""+trendChartLevel0.jul+","+trendChartLevel0.aug+","+
								""+trendChartLevel0.sep+","+trendChartLevel0.oct+","+
								""+trendChartLevel0.nov+","+trendChartLevel0.dec+"";
							//	class=\"parent collapsed\"	
					str=str+"<tr  height=\"5\" id=\""+_rowId+"_node_"+data_KPIListLevel0[i].kpiKey+"\" "+childOf+">"+
							"<td width=\"43%\" style=\"padding-left: 20px;\" >"+ 
					"<a style=\"cursor: pointer;\" onclick=\"showKPIBarChart('"+_rowId+"','"+data_KPIListLevel0[i].kpiKey+"','"+data_KPIListLevel0[i].dateKey+"','"+accumulatedFlag+"')\">"+data_KPIListLevel0[i].kpiName+"</a></td>"+
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
			 		myValuesBscProcessArray[i]={id:sparkId,myValues:myValues.split(","),trendChartValues:trendChartValue.split(","),colors:colors};					 		 
				} 
				str=str+"</tbody></table>"; 
	    treeTable.innerHTML=str;
	    //alert(str)
		//	aoe.src="bscProcess.jsp?viewKPI=0&bscYear=1&bscMonth=1&bscOwner=1";
			$(".bscTreegrid_"+_rowId).treeTable();
		 	for(var i=0;i<myValuesBscProcessArray.length;i++){ 
		 		//alert("valuess="+myValuesBscProcessArray[i].myValues)
		 		 $("#sparklines"+myValuesBscProcessArray[i].id).sparkline(myValuesBscProcessArray[i].myValues, {
		 			type: 'bullet',
			    	performanceColor:'blue',
			    	//targetColor:'red',
			    	targetColor:'blue',
			    	width:"auto" ,
			    	height:'auto',
			    	targetWidth:3,
			    	//rangeColors:['#D3DAFE','#A8B6FF','#7F94FF']
			    	//rangeColors:['green','yellow','red']
			    	rangeColors:myValuesBscProcessArray[i].colors
		 		 } ); 
		 		$("#trendLine"+myValuesBscProcessArray[i].id).sparkline(myValuesBscProcessArray[i].trendChartValues, {barColor: 'red'}); 
			}
		 } 
	  });  		
}

</script>
<body> 
	<table id="ProcessTree" width="100%" height="20"  border="1"  >
  		<tr>
  		<td><div id="tree_perspective_"></div></td>
  		</tr>					
	</table>



 <script type="text/javascript">  
//jQuery(document).ready(function($) {
	//initProcess(); 
//});
</script> 
</body>
</html>