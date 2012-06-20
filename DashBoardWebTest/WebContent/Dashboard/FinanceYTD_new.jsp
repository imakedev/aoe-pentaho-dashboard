<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Finance Dashboard Page</title>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-1.7.1.min.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet"/>	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<!-------------------------  About Popup (#facebox) ------------------------->
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
	/* var y = request.getParameter("y"); // Value of Year Parameter.
	var months = request.getParameter("m"); // Value of Month Parameter.
	var sb = request.getParameter("sb"); // Value of Summary By Parameter. */
	var yearG='<%=request.getParameter("y")%>';
	var monthG='<%=request.getParameter("m")%>';
	var sumByG='<%=request.getParameter("sb")%>';
	var initG='<%=request.getParameter("init")%>';
	var urlG="Finance_new";
	var monthKeyG=["1","2","3","4","5","6","7","8","9","10","11","12"];
	var monthNameG=["January","February","March","April","May","June","July","August","September","October","November","December"];
	var shortmonthNameG=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
	var tabsG=["Restaurant","Bakery","Specialty","Trading","Caterman","Other"];
	var loadedG=[];
   $(document).ready(function() {
			// Tabs
			$("#tabs-table2").tabs();
			//hover states on the static widgets
			$('#dialog_link, ul#icons li').hover(
				function() { $(this).addClass('ui-state-hover'); }, 
				function() { $(this).removeClass('ui-state-hover'); }
			);
			initChart();
			 
		});
   function checkLoaded(int_check){
		var haveIndex=false;
		for(var i=0;i<loadedG.length;i++){
			if(loadedG[i]==int_check){
				haveIndex=true;
				break;
			} 
		}
		return haveIndex;
	}
   function initChart(){
		var now = new Date();
		var now_year=now.getFullYear();
		var now_month=now.getMonth();
		//if(yearG!=null )
		//	alert(yearG=='null')
	    if(!(yearG!=null && yearG!='null'))
		    yearG=now_year;
	    if(!(monthG!=null && monthG!='null'))
		    monthG=(now_month+1)+"";
	    if(!(sumByG!=null && sumByG!='null'))
	    	sumByG=$("#SumBy").val();
	    $("#SumBy").val(sumByG);
	   // alert(sumByG);
	    var sumby=$("#SumBy").val();		
		listMonths();
		listYears(); 
	}
	 function goUrl()
		{ 
		var sumby=$("#SumBy").val();
		var year=$("#financeYear").val();
		var month=$("#financeMonth").val(); 
		
		if(sumby=='6' || sumby=='7'){
			loadedG=[0];
			 $("#snp_element").html("<table id=tabs-table2 style=\"position:absolute; left:242px; top:45px;\" bordercolor=\"#000000\" frame=\"box\" rules=\"all\">"+
			  "<tr><td align=center>"+
				"	<table width=1074>"+
				"		<tr bgcolor=\"#8B4513\">"+
				"			<td colspan=\"2\"><div align=center><font color=\"#FFE742\" size=\"3\"><b>บริษัท เอส แอนด์ พี ซินดิเคท จำกัด (มหาชน)</b></font></div></td>"+
				"		</tr>"+
				"		<tr>"+
				"			<td colspan=\"2\"><div align=center><font size=\"3\">ยอดขาย</font></div></td>"+
				"		</tr>"+
				"		<tr>"+
				"			<td align=\"center\"><div id=\"g1\"></div></td>"+
				"			<td align=left width=\"150\"><div id=\"g1_legend\"></div></td>"+
				"		</tr>"+
				"	</table>"+
			  "</td></tr>"+
			  "</table>");
			 $("#snp_element2").html("<table id=\"tabs-t1r3\"> "+
					 " <tr height=300><td valign=\"top\" width=1065> "+
					"	<ul>"+
					"		<li><a href=\"#tabs-t1r3_1\">Restaurant</a></li>"+
					"		<li><a href=\"#tabs-t1r3_2\">Bakery</a></li>"+
					"		<li><a href=\"#tabs-t1r3_3\">Specialty</a></li>"+
					"		<li><a href=\"#tabs-t1r3_4\">Trading</a></li>"+
					"		<li><a href=\"#tabs-t1r3_5\">Caterman</a></li>"+
					"		<li><a href=\"#tabs-t1r3_6\">Other</a></li>"+
					"	</ul>"+
					"	<table id=\"tabs-t1r3_1\">"+
					"		<tr>"+
					"			<td colspan=\"2\"><div align=center><font size=\"3\">ยอดขาย</font></div></td>"+
					"		</tr>"+
					"		<tr>"+
					"			<td align=\"center\"><div id=\"Restaurant_tab\"></div></td>"+
					"			<td align=left width=\"150\"><div id=\"Restaurant_legend\"></div></td>"+
					"		</tr>"+
					"	</table>"+
					"	<table id=\"tabs-t1r3_2\">"+
					"		<tr>"+
					"			<td colspan=\"2\"><div align=center><font size=\"3\">ยอดขาย</font></div></td>"+
					"		</tr>"+
					"		<tr>"+
					"			<td align=center><div id=\"Bakery_tab\"></div></td>"+
					"			<td align=left width=\"150\"><div id=\"Bakery_legend\"></div></td>"+
					"		</tr>"+
					"	</table>"+
					"	<table id=\"tabs-t1r3_3\">"+
					"		<tr>"+
					"			<td colspan=\"2\"><div align=center><font size=\"3\">ยอดขาย</font></div></td>"+
					"		</tr>"+
					"		<tr>"+
					"			<td align=center><div id=\"Specialty_tab\"></div></td>"+
					"			<td align=left width=\"150\"><div id=\"Specialty_legend\"></div></td>"+
					"		</tr>"+
					"	</table>"+
					"	<table id=\"tabs-t1r3_4\">"+
					"		<tr>"+
					"			<td colspan=\"2\"><div align=center><font size=\"3\">ยอดขาย</font></div></td>"+
					"		</tr>"+
					"		<tr>"+
					"			<td align=center><div id=\"Trading_tab\"></div></td>"+
					"			<td align=left width=\"150\"><div id=\"Trading_legend\"></div></td>"+
					"		</tr>"+
					"	</table>"+
					"	<table id=\"tabs-t1r3_5\">"+
					"		<tr>"+
					"			<td colspan=\"2\"><div align=center><font size=\"3\">ยอดขาย</font></div></td>"+
					"		</tr>"+
					"		<tr>"+
					"			<td align=center><div id=\"Caterman_tab\"></div></td>"+
					"			<td align=left width=\"150\"><div id=\"Caterman_legend\"></div></td>"+
					"		</tr>"+
					"	</table>"+
					"	<table id=\"tabs-t1r3_6\">"+
					"		<tr>"+
					"			<td colspan=\"2\"><div align=center><font size=\"3\">ยอดขาย</font></div></td>"+
					"		</tr>"+
					"		<tr>"+
					"			<td align=center><div id=\"Other_tab\"></div></td>"+
					"			<td align=left width=\"150\"><div id=\"Other_legend\"></div></td>"+
					"		</tr>"+
					"	</table>"+
					 " </td></tr>"+
					  "</table>");
			 $("a[href^=#tabs-t1r3_]").click(function() {
				    //alert(index + ': ' + $(this).text());
				    var index=$(this).attr("href").split("_")[1];
				   // alert($(this)+",index="+index); 
				    var _int_index=(parseInt(index)-1);
				    if(!checkLoaded(_int_index)){
				    	clickBytab(_int_index);
					    loadedG.push(_int_index);
					  }
				}); 
			 $("#tabs-t1r3").tabs();
			var LastAct= [];// sumLastYearActualMONTHLY "349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44,2308829.78,2677581.22,3138353.13,3527905.41,3889966.29,4397887.58";
			var ThisAct = [];// sumThisYearActualMonthly "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53,3032309.54,3574088.40,3979020.08,4399473.14,4967272.82";
			var Target =[];// sumThisYearBudgetMONTHLY  "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58,3041428.29,3571298.86,3955662.91,4354784.30,4953878.04";
			var perVariance =[];// percentVarianceMONTHLY  "-2.31,-3.43,-0.43,-0.98,-1.43,0.24,-0.60,-1.95,0.30,5.65,10.99,5.77";
			var perGrowth = [];// percentGrowthMONTHLY "12.79,30.48,41.68,48.14,58.97,73.68,86.36,105.75,123.33,127.28,143.40,155.19";
			$("#g1").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
			$("#g1_legend").html(""); 
			render_financialIndication(year,month,'00100');
			BalanceScorecardAjax.getFinancial_YTD_Monthly_Summary(year,month,sumby,{
					callback:function(data){
						if(data!=null && data.length>0){
							var g1_data = 
							{
							"graphset":[
								{
									"type":"mixed", 
									"background-color":"#FFFFFF",
									"stacked":"1",
									"chart":{
										"margin":"30 60 30 80"
									},
									"labels" : [
										{
											"text":"พันบาท",
											"bold":true,
											"font-size":12,
											"x": "60",
											"y": "0"
										}
									],
									"legend":{
										"background-color": "#FFFFFF",
										"border-width": "2px",
										"border-color": "#4C77B6",
										"margin":"70 0 0 885",
										"layout":"x1",
										"item":{
											"font-color":"#000000"
										}
									},
									"guide":{
										"shared":true
									},
									"tooltip":{
										"visible": false
									},
									"plot":{
										"format":"%v",
										"decimals":2,
										"decimals-separator":".",
										"thousands-separator":","
									},
									"scale-x":{
										"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"], 
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
									//"max-labels": 2,
									"scale-y":{
										"format":"%v",
										"decimals":0,
										"decimals-separator":".",
										"thousands-separator":",",
										"guide":{
											"line-width": 1,
											"alpha": 1
										},
										"tick":{
											"line-width": 3
										}
									},
									"scale-y-2":{
										"format" : "%v%",
										"decimals":0,
										"decimals-separator":".",
										"thousands-separator":",",
										"guide":{
											"line-width": 0,
											"alpha": 0
										},
										"tick":{
											"line-width": 3
										}
									}, 
									"series":[
										{
											"type":"bar",
											"values":[],
											"text":"ActualYTD 09",
											"background-color":"#66CC00",
											"stacked":0
										},
										{
											"type":"bar",
											"values":[],
											"text":"ActualYTD 10",
											"background-color":"#EEEE00",
											"stacked":0
										},
										{
											"type":"bar",
											"values":[],
											"text":"Budget",
											"background-color":"#696969",
											"stacked":0
										},
										{
											"type":"line",
											"values":[],
											"text":"%Variance YTD",
											"scales":"scale-x,scale-y-2",
											"stacked":0,
											"line-color": "#E46C0A",
											"aspect" : "spline",
											"marker":{
												"visible":false
											}
										},
										{
											"type":"line",
											"values":[],
											"text":"%GrowthYTD",
											"scales":"scale-x,scale-y-2",
											"line-color": "#4F81BD",
											"stacked":0,
											"aspect" : "spline",
											"marker":{
												"visible":false
											}
										}]			
									}]
								};
							var sumLastAct=0;
							var sumThisAct=0; 
							var sumTarget=0;
							var sumperVariance=0;
							var sumperperGrowth=0;
							for(var i=0;i<data.length;i++){
								if(sumby=='6'){
								   if(data[i].sumLastYearActualMONTHLY!=null && data[i].sumLastYearActualMONTHLY.length>0)
										sumLastAct=sumLastAct+Number(data[i].sumLastYearActualMONTHLY);
								   if(data[i].sumThisYearActualMonthly!=null && data[i].sumThisYearActualMonthly.length>0)
									   sumThisAct=sumThisAct+Number(data[i].sumThisYearActualMonthly);
								   if(data[i].sumThisYearBudgetMONTHLY!=null && data[i].sumThisYearBudgetMONTHLY.length>0)
									   sumTarget=sumTarget+Number(data[i].sumThisYearBudgetMONTHLY);
								   if(data[i].percentVarianceMONTHLY!=null && data[i].percentVarianceMONTHLY.length>0)
									   sumperVariance=sumperVariance+Number(data[i].percentVarianceMONTHLY);
								   if(data[i].percentGrowthMONTHLY!=null && data[i].percentGrowthMONTHLY.length>0)
									   sumperperGrowth=sumperperGrowth+Number(data[i].percentGrowthMONTHLY);
								}else{
									sumLastAct=0;
									sumThisAct=0; 
									sumTarget=0;
									sumperVariance=0;
									sumperperGrowth=0;
									if(data[i].sumLastYearActualMONTHLY!=null && data[i].sumLastYearActualMONTHLY.length>0)
										sumLastAct=Number(data[i].sumLastYearActualMONTHLY);
									if(data[i].sumThisYearActualMonthly!=null && data[i].sumThisYearActualMonthly.length>0)
										sumThisAct=Number(data[i].sumThisYearActualMonthly);
									if(data[i].sumThisYearBudgetMONTHLY!=null && data[i].sumThisYearBudgetMONTHLY.length>0)
									    sumTarget=Number(data[i].sumThisYearBudgetMONTHLY);
									if(data[i].percentVarianceMONTHLY!=null && data[i].percentVarianceMONTHLY.length>0)
									   sumperVariance=Number(data[i].percentVarianceMONTHLY);
									if(data[i].percentGrowthMONTHLY!=null && data[i].percentGrowthMONTHLY.length>0)
									   sumperperGrowth=Number(data[i].percentGrowthMONTHLY);
								}
								//alert(data[i].sumLastYearActualMONTHLY+",sum="+sumLastAct)
							//	LastAct.push((data[i].sumLastYearActualMONTHLY!=null && data[i].sumLastYearActualMONTHLY.length>0)?data[i].sumLastYearActualMONTHLY:"0.00");
								/* ThisAct.push((data[i].sumThisYearActualMonthly!=null && data[i].sumThisYearActualMonthly.length>0)?data[i].sumThisYearActualMonthly:"0.00");
								Target.push((data[i].sumThisYearBudgetMONTHLY!=null && data[i].sumThisYearBudgetMONTHLY.length>0)?data[i].sumThisYearBudgetMONTHLY:"0.00");
								perVariance.push((data[i].percentVarianceMONTHLY!=null && data[i].percentVarianceMONTHLY.length>0)?data[i].percentVarianceMONTHLY:"0.00");
								perGrowth.push((data[i].percentGrowthMONTHLY!=null && data[i].percentGrowthMONTHLY.length>0)?data[i].percentGrowthMONTHLY:"0.00"); */
								LastAct.push(sumLastAct);
								ThisAct.push(sumThisAct);
								Target.push(sumTarget);
								perVariance.push(sumperVariance);
								perGrowth.push(sumperperGrowth);
							}
							//alert(perVariance)
							g1_data.graphset[0].series[0].values=LastAct;
							g1_data.graphset[0].series[1].values=ThisAct;
							g1_data.graphset[0].series[2].values=Target;
							g1_data.graphset[0].series[3].values=perVariance;
							g1_data.graphset[0].series[4].values=perGrowth;
							$("#g1").html("");
							$("#g1_legend").html("<img src=\""+_path+"/Dashboard/images/legend_Y-M.jpg\"/>"); 
							render_zingchart('g1',g1_data);
						}else{
							$("#g1").html("");
							$("#g1_legend").html(""); 
						}
						//alert(data.length);
					}
			});
			// render tab
			/*  for(var j=0;j<tabsG.length;j++){ 
				 reder_tab_data(year,month,tabsG[j],sumby);  
			 }  */
			 reder_tab_data(year,month,tabsG[0],sumby);
		}else {
			//alert("goTo URL")  
			location.href = _path+"/Dashboard/"+urlG+".jsp?y="+year+"&m="+month+"&sb="+sumby
		}
	} 
	 
	  function clickBytab(index){
		  var sumby=$("#SumBy").val();
		var year=$("#financeYear").val();
		var month=$("#financeMonth").val(); 
   	  reder_tab_data(year,month,tabsG[index],sumby);  
   }
	function reder_tab_data(year,month,tab_id,sumby){
		 var LastAct_tab= [];
		 var ThisAct_tab = [];
		 var Target_tab =[];
		 var perVariance_tab =[];
		 var perGrowth_tab = [];
		 $("#"+tab_id+"_tab").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
		 $("#"+tab_id+"_legend").html("");  
		 BalanceScorecardAjax.getFinancial_YTD_Monthly_Tab(year,month,tab_id,sumby,{
				callback:function(data){ 
					//alert(data)
					if(data!=null && data.length>0){
						var tab_data = 
						{
						"graphset":[
							{
								"type":"mixed",
								"background-color":"#FFFFFF",
								"stacked":"1",
								"chart":{
									"margin":"30 60 30 80"
								},
								"labels" : [
									{
										"text":"พันบาท",
										"bold":true,
										"font-size":12,
										"x": "60",
										"y": "0"
									}
								],
								"legend":{
									"background-color": "#FFFFFF",
									"border-width": "2px",
									"border-color": "#4C77B6",
									"margin":"70 0 0 885",
									"layout":"x1",
									"item":{
										"font-color":"#000000"
									}
								},
								"guide":{
									"shared":true
								},
								"tooltip":{
									"visible": false
								},
								"plot":{
									"format":"%v",
									"decimals":2,
									"decimals-separator":".",
									"thousands-separator":","
								},
								"scale-x":{
									"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
									"decimals":0,
									"decimals-separator":".",
									"thousands-separator":",",
									"guide":{
										"line-width": 1,
										"alpha": 1
									},
									"tick":{
										"line-width": 3
									}
								},
								"scale-y-2":{
									"format" : "%v%",
									"decimals":0,
									"decimals-separator":".",
									"thousands-separator":",",
									"guide":{
										"line-width": 0,
										"alpha": 0
									},
									"tick":{
										"line-width": 3
									},
									"item":{
										"font-color":"#000000"
									}
								},
								"series":[
									{
										"type":"bar",
										"values":[],
										"text":"ActualYTD 09",
										"background-color":"#66CC00",
										"stacked":0
									},
									{
										"type":"bar",
										"values":[],
										"text":"ActualYTD 10",
										"background-color":"#EEEE00",
										"stacked":0
									},
									{
										"type":"bar",
										"values":[],
										"text":"Budget",
										"background-color":"#696969",
										"stacked":0
									},
									{
										"type":"line",
										"values":[],
										"text":"%Variance YTD",
										"scales":"scale-x,scale-y-2",
										"stacked":0,
										"line-color": "#E46C0A",
										"aspect" : "spline",
										"marker":{
											"visible":false
										}
									},
									{
										"type":"line",
										"values":[],
										"text":"%GrowthYTD",
										"scales":"scale-x,scale-y-2",
										"line-color": "#4F81BD",
										"stacked":0,
										"aspect" : "spline",
										"marker":{
											"visible":false
										}
									}]
								}]
							};
						var sumLastAct_tab=0;
						var sumThisAct_tab=0; 
						var sumTarget_tab=0;
						var sumperVariance_tab=0;
						var sumperperGrowth_tab=0;
						for(var i=0;i<data.length;i++){
							if(sumby=='6'){
							   if(data[i].sumLastYearActualMONTHLY!=null && data[i].sumLastYearActualMONTHLY.length>0)
								   sumLastAct_tab=sumLastAct_tab+Number(data[i].sumLastYearActualMONTHLY);
							   if(data[i].sumThisYearActualMonthly!=null && data[i].sumThisYearActualMonthly.length>0)
								   sumThisAct_tab=sumThisAct_tab+Number(data[i].sumThisYearActualMonthly);
							   if(data[i].sumThisYearBudgetMONTHLY!=null && data[i].sumThisYearBudgetMONTHLY.length>0)
								   sumTarget_tab=sumTarget_tab+Number(data[i].sumThisYearBudgetMONTHLY);
							   if(data[i].percentVarianceMONTHLY!=null && data[i].percentVarianceMONTHLY.length>0)
								   sumperVariance_tab=sumperVariance_tab+Number(data[i].percentVarianceMONTHLY);
							   if(data[i].percentGrowthMONTHLY!=null && data[i].percentGrowthMONTHLY.length>0)
								   sumperperGrowth_tab=sumperperGrowth_tab+Number(data[i].percentGrowthMONTHLY);
							}else{
								var sumLastAct_tab=0;
								var sumThisAct_tab=0; 
								var sumTarget_tab=0;
								var sumperVariance_tab=0;
								var sumperperGrowth_tab=0;
								if(data[i].sumLastYearActualMONTHLY!=null && data[i].sumLastYearActualMONTHLY.length>0)
								   sumLastAct_tab=Number(data[i].sumLastYearActualMONTHLY);
							    if(data[i].sumThisYearActualMonthly!=null && data[i].sumThisYearActualMonthly.length>0)
								   sumThisAct_tab=Number(data[i].sumThisYearActualMonthly);
								if(data[i].sumThisYearBudgetMONTHLY!=null && data[i].sumThisYearBudgetMONTHLY.length>0)
								   sumTarget_tab=Number(data[i].sumThisYearBudgetMONTHLY);
								if(data[i].percentVarianceMONTHLY!=null && data[i].percentVarianceMONTHLY.length>0)
								   sumperVariance_tab=Number(data[i].percentVarianceMONTHLY);
								if(data[i].percentGrowthMONTHLY!=null && data[i].percentGrowthMONTHLY.length>0)
								   sumperperGrowth_tab=Number(data[i].percentGrowthMONTHLY);
							}
							/* LastAct_tab.push((data[i].sumLastYearActualMONTHLY!=null && data[i].sumLastYearActualMONTHLY.length>0)?data[i].sumLastYearActualMONTHLY:"0.00");
							ThisAct_tab.push((data[i].sumThisYearActualMonthly!=null && data[i].sumThisYearActualMonthly.length>0)?data[i].sumThisYearActualMonthly:"0.00");
							Target_tab.push((data[i].sumThisYearBudgetMONTHLY!=null && data[i].sumThisYearBudgetMONTHLY.length>0)?data[i].sumThisYearBudgetMONTHLY:"0.00");
							perVariance_tab.push((data[i].percentVarianceMONTHLY!=null && data[i].percentVarianceMONTHLY.length>0)?data[i].percentVarianceMONTHLY:"0.00");
							perGrowth_tab.push((data[i].percentGrowthMONTHLY!=null && data[i].percentGrowthMONTHLY.length>0)?data[i].percentGrowthMONTHLY:"0.00"); */
							LastAct_tab.push(sumLastAct_tab);
							ThisAct_tab.push(sumThisAct_tab);
							Target_tab.push(sumTarget_tab);
							perVariance_tab.push(sumperVariance_tab);
							perGrowth_tab.push(sumperperGrowth_tab);
						}
						tab_data.graphset[0].series[0].values=LastAct_tab;
						tab_data.graphset[0].series[1].values=ThisAct_tab;
						tab_data.graphset[0].series[2].values=Target_tab;
						tab_data.graphset[0].series[3].values=perVariance_tab;
						tab_data.graphset[0].series[4].values=perGrowth_tab;
						$("#"+tab_id+"_tab").html("");
						$("#"+tab_id+"_legend").html("<img src=\""+_path+"/Dashboard/images/legend_Y-M.jpg\"/>"); 
						render_zingchart(tab_id+"_tab",tab_data);
					}else{
						$("#"+tab_id+"_tab").html("");
						$("#"+tab_id+"_legend").html(""); 
					}
				}
		 }); 
	}
	function render_financialIndication(year,month,company){  
		 var str="<table id=table-data1 width=100%>"+
		        "     <tr><th class=\"ui-state-default ui-corner-top ui-tabs-selected ui-state-active\" style=\"height:35px\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial Indicator&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp</th></tr>"+
		        "</table>"+		         
		        "<table id=table-data width=100%>"+
		        "    <tr>"+
			    "        <th bgcolor=#CD853F colspan=3><font color=\"#FFFFFF\">"+shortmonthNameG[parseInt(month)-1]+" "+year+" vs "+shortmonthNameG[parseInt(month)-1]+" "+(parseInt(year)-1)+"</font></th>"+
		        "    </tr>";
		  var str_loading=str+"<tr>"+
			    "        <th colspan=3><img src=\""+_path+"/Dashboard/images/loading.gif\"/></th>"+
		        "    </tr></table";
		    	$('#fnancial_indicator_Display').html(str_loading);
		 var financialIndicationDTO;
		 var trend;
		 BalanceScorecardAjax.getFinancialIndication(year,month,company,{
				callback:function(data){
					//alert(data)
					if(data!=null && data.length>0){
						for(var i=0;i<data.length;i++){
							str=str+"<tr><th colspan=3>"+data[i].ratioGroupName+"</th></tr>";
							financialIndicationDTO=data[i].financialIndicationDTO;
						//	alert(financialIndicationDTO)
							if(financialIndicationDTO!=null && financialIndicationDTO.length>0){								
								for(var j=0;j<financialIndicationDTO.length;j++){ 
									trend=financialIndicationDTO[j].trendFlag;
									if(financialIndicationDTO[j].trendFlag!=null){
										if(financialIndicationDTO[j].trendFlag=='I'){
											trend="<img src=images/up1.png>";
										}else if(financialIndicationDTO[j].trendFlag=='D'){
											trend="<img src=images/down1.png>";
										}else if(financialIndicationDTO[j].trendFlag=='S'){
										    trend="<img src=images/same.png>";
									    }
									} 
									str=str+"<tr><td>"+financialIndicationDTO[j].ratioName+"</td>"+
									        "<td>"+trend+"</td>"+
									        "<td align=\"right\">"+financialIndicationDTO[j].thisPeriodValue+"</td></tr>";
								}
							}
							
						}
					}
					str=str+"</table>"; 
					$('#fnancial_indicator_Display').html(str);
					//$("#tabs").tabs();
					$("#tabs-ratio").tabs();
					//$("#tabs-ratio1").tabs();
				}
			});
	}
	function render_zingchart(id,data){
		zingchart.render({
			id : id,
			width 	: 850,
			height 	: 270,
			data : data
		});
	}
	function listYears(){
		 var str="<font size=\"3\"> ปี: </font>";		
		//alert(yearG+","+monthG+","+sumByG);
		BalanceScorecardAjax.listYears({
			callback:function(data){
				str=str+"<select name=\"financeYear\" id=\"financeYear\" >";
				if(data!=null && data.length>0){					
						for(var i=0;i<data.length;i++){
							str=str+"<option value=\""+data[i]+"\" "+((yearG==data[i])?" selected=\"selected\"":"")+">"+data[i]+"</option>";
						} 
				} 
				str=str+"</select>";
				$('#financeYearElement').html(str);
				  if((initG!=null && initG!='null'))
					  goUrl();
				//goUrl();
			}
		});
		
	}
	function listMonths(){
		var str="<font size=\"3\"> เดือน: </font>";  
				str=str+"<select name=\"financeMonth\" id=\"financeMonth\" >"; 
				//alert(monthG)
				if(monthKeyG!=null && monthKeyG.length>0){					
						for(var i=0;i<monthKeyG.length;i++){
							str=str+"<option value=\""+monthKeyG[i]+"\" "+((monthG==monthKeyG[i])?" selected=\"selected\"":"")+">"+monthNameG[i]+"</option>";
						} 
				}
				/*
				if(shortmonthNameG!=null && shortmonthNameG.length>0){					
					for(var i=0;i<shortmonthNameG.length;i++){
						str=str+"<option value=\""+shortmonthNameG[i]+"\" "+((monthG==monthKeyG[i])?" selected=\"selected\"":"")+">"+monthNameG[i]+"</option>";
					} 
			    }*/
				str=str+"</select>";
				$('#financeMonthElement').html(str);
	}
	</script>
	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
		.demoHeaders { margin-top: 1em; }
		#dialog_link {padding: .1em 1em .1em 20px;text-decoration: none;position: relative;}
		#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;top: 50%;margin-top: -8px;}
		ul#icons {margin: 0; padding: 0;}
		ul#icons li {margin: 1px; position: relative; padding: 1px 0; cursor: pointer; float: left;  list-style: none;}
		ul#icons span.ui-icon {float: left; margin: 0 4px;}
		#tabs { position:absolute; width:1325px; top:60px; left:5px; height:750px; }
		#tabs-ratio { position:absolute; left:3px; top:45px; }
		#tabs-ratio1 { position:absolute; left:3px; top:45px; }
	</style>	
	<script type="text/javascript">
	var LastActV1 = "349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44,2308829.78,2677581.22,3138353.13,3527905.41,3889966.29,4397887.58";
	ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53,3032309.54,3574088.40,3979020.08,4399473.14,4967272.82";
	TargetV1 = "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58,3041428.29,3571298.86,3955662.91,4354784.30,4953878.04";
	perVarianceV1 = "-2.31,-3.43,-0.43,-0.98,-1.43,0.24,-0.60,-1.95,0.30,5.65,10.99,5.77";
	perGrowthV1 = "12.79,30.48,41.68,48.14,58.97,73.68,86.36,105.75,123.33,127.28,143.40,155.19";
	var chart01 = 
	{
	"graphset":[
		{
			"type":"mixed", 
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
			//	"values":["Jan","Feb"],
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
			//"max-labels": 2,
			"scale-y":{
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				}
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
				},
				"tick":{
					"line-width": 3
				}
			}, 
			"series":[
				{
					"type":"bar",
				//	"values":[349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44,2308829.78,2677581.22,3138353.13,3527905.41,3889966.29,4397887.58],
					"values":[349290.69,638730.14],
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
				//	"values":[393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53,3032309.54,3574088.40,3979020.08,4399473.14,4967272.82],
					"values":[393970.68,734613.19],
					"text":"ActualYTD 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
				//	"values":[403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58,3041428.29,3571298.86,3955662.91,4354784.30,4953878.04],
					"values":[403274.18,747775.45],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
				//	"values":[-2.31,-3.43,-0.43,-0.98,-1.43,0.24,-0.60,-1.95,0.30,5.65,10.99,5.77],
					"values":[-2.31,-3.43],
					"text":"%Variance YTD",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
				//	"values":[12.79,30.48,41.68,48.14,58.97,73.68,86.36,105.75,123.33,127.28,143.40,155.19],
					"values":[12.79,30.48],
					"text":"%GrowthYTD",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]			
			}]
		};
		
	</script>
    
</head>

<body bgcolor="#FFFFFF">
<!-- Parameter -->
	<!--          Drop Down List YEAR              -->
	<span id="financeYearElement" style="position:absolute; left:15px; top:10px;">
	</span> 
	<!--          Drop Down List MONTH              -->
	<span id="financeMonthElement" style="position:absolute; left:125px; top:10px;">
	</span>
	<!--          Drop Down List             -->
	<span style="position:absolute; left:300px; top:10px;"><font size="3"> สรุปตาม: </font>
		<select name="SumBy" id="SumBy">
			<option value="6">YTD</option>
			<option value="7">Monthly</option>
			<option value="1">YTD vs Last YTD</option>
			<option value="2">Quarter vs Last Quarter</option>
			<option value="3">Quarter vs Last Year same Quarter</option>
			<option value="4">Monthly vs Last Monthly</option>
			<option value="5">Monthly vs Last Year same Monthly</option>
		</select> 
	</span>
	<span style="position:absolute; left:650px; top:11px;">
		<input type="button" value=" OK " onClick="goUrl()"/></span>
<!-- End Parameter -->
<div id="tabs-1">
<table>
<tr>
<td>
  <table id=tabs-ratio width=220px>
	<tr>
	  <td><span id="fnancial_indicator_Display"></span>
		<!-- Table Data -->
	  </td>
	</tr>
  </table>
</td>

<td><div id="snp_element">
 </div>
</td>
</tr>
</table>

<div id="snp_element2" style=" position:absolute; top:380px; left:242px;">
  </div>
</div>
</body>
</html>