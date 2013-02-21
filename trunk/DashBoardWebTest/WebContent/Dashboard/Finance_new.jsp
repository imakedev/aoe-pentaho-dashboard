<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Finance Dashboard Page</title>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<!--
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5-min.js"></script>
	-->
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
	var yearG='<%=request.getParameter("y")%>';
	var monthG='<%=request.getParameter("m")%>';
	var sumByG='<%=request.getParameter("sb")%>'; 
	var urlG="FinanceYTD_new";
	var monthKeyG=["1","2","3","4","5","6","7","8","9","10","11","12"];
	var monthNameG=["January","February","March","April","May","June","July","August","September","October","November","December"];
	var shortmonthNameG=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
	var tabsG=["Restaurant","Bakery","Specialty","Trading","Caterman","Other"];
	var gTypeG=["ยอดขาย","กำไรขั้นต้น","กำไรจากการดำเนินการ","EBITDA"];
	var gTypeG2=["ยอดขาย","กำไรขั้นต้น","กำไรจากการดำเนินการ","กำไรสุทธิ"];
	var loadedG=[];
	//var gTypeValueG=["ยอดขาย","กำไรขั้นต้น","กำไรจากการดำเนินการ","กำไรสุทธิ"];
	var gTypeIdG=["gSales","gProfit_1","gProfit_2","gProfit_3"];
	jQuery(document).ready(function($) {
		/*
		function removeLicene(){
		$("#g2-map").next().remove();
		setTimeout(function(){
			removeLicene();
		},0);
		
		}
		setTimeout(function(){
			removeLicene();
		},5000);
		*/
			/*START JQUERY MANAGE EBITDA*/
			//alert("jquery");
			//alert($("#tabs-t1r3_1").length);
			/*END JQUERY MANAGE EBITDA*/

			// Tabs
			$("#tabs-ratio").tabs();
			$("#tabs-table2").tabs();
			$("#tabs-t1r3").tabs();
			//hover states on the static widgets
			$('#dialog_link, ul#icons li').hover(
				function() { $(this).addClass('ui-state-hover'); }, 
				function() { $(this).removeClass('ui-state-hover'); }
			);
			 initChart();
			 zingchart.node_click = function(node){
			   // alert("xx="+xx)
			  
				var text_node=node["text"];
				var text_arr=text_node.split(": ");
				if(text_arr[1]!='0'){
					var isTab=false;
					var text_value="";
					for(var i=0;i<tabsG.length;i++){
						if(tabsG[i]==text_arr[0] || text_arr[0]=='Shop'){
							//alert(text_arr[0]) 
							text_value=text_arr[0];
							isTab=true;
						    break;
						}
					}
					if(isTab)
					  renderBarOfChart(text_value);
				}
			};
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
			// $("a[href^=#]").click(function(event){ 
			/* $('#target').click(function() {
				  alert('Handler for .click() called.');
			});
			<li><a href="#tabs-t1r3_1">Restaurant</a></li>
			<li><a href="#tabs-t1r3_2">Bakery</a></li>
			<li><a href="#tabs-t1r3_3">Specialty</a></li>
			<li><a href="#tabs-t1r3_4">Trading</a></li>
			<li><a href="#tabs-t1r3_5">Caterman</a></li>
			<li><a href="#tabs-t1r3_6">Other</a></li> */
		});
		function loadmetergraph(ivalue ,iFrameID)
		{
			 //alert("jquery");
			 
			var objFrame=document.getElementById(iFrameID);
			objFrame.src=  ivalue;
		}
	//	© Copyright 2009-2011 ZingChart
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
	function renderBarOfChart(tabType){
		
		  // alert("tabType="+tabType)  
		   $("#back_bt").css("display","none");
		   $("#sales_growth").html("%Sales Growth");
		  // $("#g4").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
		  if(false){
		   BalanceScorecardAjax.getBarOfPile( $("#financeYear").val(),  $("#financeMonth").val(), tabType, $("#SumBy").val(),{
 				callback:function(data){
 				
 					if(data!=null && data.length>0){
 						/*
 						var bar03 = 
						{
						"graphset" : [
							{
								"type" : "mixed",
								"background-color":"#FFFFFF",
								"chart" : {
									"margin" : "20 20 30 50"
								},
								"stacked":"1",
								"plot":{
									"bars-space-left":"25%",
									"bars-space-right":"25%",
									"bar-width":"25px",
									"decimals":2,
			    					"decimals-separator":".",
			    					"thousands-separator":","
								}, 
								"scale-x" : {
									//"values" : ["Last Period Actual","Actual","Budget"],
									"values" : ["Last Period Actual","Actual","Budget"],
									"guide":{
					    				"line-width": 1,
					    				"alpha": 1
					    			},
									"tick":{
										"line-width": 3
									}
								},
								"scale-y" : {
									"min-value":0,
									"decimals":2,
									"format":"%v%",
									"guide":{
					    				"line-width": 1,
					    				"alpha": 1
					    			},
									"tick":{
										"line-width": 3
									}
								},
								"series" : [    
								]
							}
						]
					};
 						*/
 						
 						var bar03 = 
 						{
 						"graphset" : [
 							{
 								"type" : "bar",
 								"background-color":"#FFFFFF",
 								"chart" : {
 									"margin" : "20 130 50 150"
 								},
 								"stacked" : true,
 								"plot":{
 									"bars-space-left":"30%",
 									"bars-space-right":"30%",
 									"bar-width":"25px",
 									"decimals":2,
			    					"decimals-separator":".",
			    					"thousands-separator":","
 								},
 								"scale-x" : {
 									"values" : ["Last Period Actual","Actual","Budget"],
 									"guide":{
 					    				"line-width": 1,
 					    				"alpha": 1
 					    			},
 									"tick":{
 										"line-width": 3
 									}
 								},
 								"scale-y" : {
 									"format" : "%v%",
 									"decimals":0,
 									"guide":{
 					    				"line-width": 1,
 					    				"alpha": 1
 					    			},
 									"tick":{
 										"line-width": 3
 									}
 								},
 								"series" : []
 							}
 						]
 					}; 
 						
 						var lastPeriodActual=0;
 						var thisActual=parseFloat(data[0].thisActual.replace(/,/g,""));
 						var lastActual=parseFloat(data[0].lastActual.replace(/,/g,""));
 						var twoLastActual=parseFloat(data[0].twoLastActual.replace(/,/g,""));
 						var thisBudget=parseFloat(data[0].thisBudget.replace(/,/g,""));
 						var lastBudget=parseFloat(data[0].lastBudget.replace(/,/g,""));
 						//alert(lastActual)
 						if(twoLastActual!=null && twoLastActual!=0)
							lastPeriodActual=((lastActual-twoLastActual)/twoLastActual)*100;
						var  actual=0;
						if(lastActual!=null && lastActual!=0)
							actual=((thisActual-lastActual)/lastActual)*100;
						var  budget=0;
						if(lastBudget!=null && lastBudget!=0)
							budget=((thisBudget-lastBudget)/lastBudget)*100; 
 						/* if(data[0].twoLastActual!=null && data[0].twoLastActual.length>0)
 							lastPeriodActual=((Number(data[0].lastActual).toFixed(2)-Number(data[0].twoLastActual).toFixed(2))/Number(data[0].twoLastActual).toFixed(2))*100;
 						var  actual=0;
 						if(data[0].lastActual!=null && data[0].lastActual.length>0)
 							actual=((Number(data[0].thisActual).toFixed(2)-Number(data[0].lastActual).toFixed(2))/Number(data[0].lastActual).toFixed(2))*100;
 						var  budget=0;
 						if(data[0].lastBudget!=null && data[0].lastBudget.length>0)
 							budget=((Number(data[0].thisBudget).toFixed(2)-Number(data[0].lastBudget).toFixed(2))/Number(data[0].lastBudget).toFixed(2))*100; */ 
 						 	//alert("xx"+actual)  
 						 	//{"type":"bar","values":[32.88,29.85,32.88],"background-color":"goldenrod","text":"ต้นทุนขาย"}
 						var val0={ 
 								"type":"bar",
									"values" :  [lastPeriodActual,,],
									"text" : "Last Period Actual",
									"background-color":"#66CC00"
								};
 						var val1={ 
 								"type":"bar",
									"values" : [,actual,],
									"text" : "Actual",
									"background-color":"#EEEE00"
								};
 						var val2={ 
 								"type":"bar",
									"values" : [,,budget],
									"text" : "Budget",
									"background-color":"#696969"
								};
 						var series=[val0,val1,val2];
 						/* bar03.graphset[0].series[0].values= [lastPeriodActual,,]; 
 						bar03.graphset[0].series[1].values= [,actual,];
 						bar03.graphset[0].series[2].values= [,,budget]; 
 						 */
 						bar03.graphset[0].series=series;
 						$("#g4").html("");  
 						 zingchart.render({
 							id : 'g4',
 							width : 600,
 							height : 300,
 							data : bar03
 						}); 
 						// zingchart.exec('g4', 'setdata', series);
 					}else{
 						//alert("null value")
 						/* bar03.graphset[0].series[0].values= [,,]; 
 						bar03.graphset[0].series[1].values= [,,];
 						bar03.graphset[0].series[2].values= [,,];  */
 					}
 					
 					
 			}
		   }); 
	    }		    
		   var label_sales="";
			var display_bt="none";
			if(tabType!=null){  
				display_bt="";
				label_sales=" : "+tabType;
			}else{ 
			}
			$("#back_bt").css("display",display_bt);
			$("#sales_growth").html("%Sales Growth"+label_sales);
		   loadmetergraph('barChart.jsp?sumBy='+$("#SumBy").val()+'&bscYear='+$("#financeYear").val()+'&bscMonth='+$("#financeMonth").val()+'&tabType='+tabType,"ifrmgr_barchart");
	}
	 function initChart(){
	        var now = new Date();
	        var now_year=now.getFullYear();
	        var now_month=now.getMonth();
	       // yearG=now_year;
	       // monthG=(now_month+1)+"";
	        if(!(yearG!=null && yearG!='null'))
			    yearG=now_year;
		    if(!(monthG!=null && monthG!='null'))
			    monthG=(now_month+1)+"";
		    if(!(sumByG!=null && sumByG!='null'))
		    	sumByG=$("#SumBy").val();
		    $("#SumBy").val(sumByG);
	        sumByG=$("#SumBy").val();
	       //alert(sumByG);
	        listMonths();
	        listYears(); 
	      //  initBarChart();
	      
     } 
	 function initBarChart(){
		 
		 var bar03_init = 
			{
			"graphset" : [
				{
					"type" : "bar",
					"background-color":"#FFFFFF",
					"chart" : {
						"margin" : "20 130 50 150"
					},
					"stacked" : true,
					"plot":{
						"bars-space-left":"30%",
						"bars-space-right":"30%",
						"bar-width":"25px",
						"decimals":2,
 					"decimals-separator":".",
 					"thousands-separator":","
					},
					"scale-x" : {
						"values" : ["Last Period Actual","Actual","Budget"],
						"guide":{
		    				"line-width": 1,
		    				"alpha": 1
		    			},
						"tick":{
							"line-width": 3
						}
					},
					"scale-y" : {
						"format" : "%v%",
						"decimals":0,
						"guide":{
		    				"line-width": 1,
		    				"alpha": 1
		    			},
						"tick":{
							"line-width": 3
						}
					},
					"series" : []
				}
			]
		}; 
		 zingchart.render({
				id : 'g4',
				width : 600,
				height : 300,
				data : bar03_init
			});
	 }
     function render_financialIndication(year,month,sumby,company){  
 		

		
		

 		 var str="<table id=table-data1 width=220px>"+
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
 		if(true){
 		BalanceScorecardAjax.getFinancialIndication(year,month,company,{
 				callback:function(data){
 					
			
			
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
 	}
     function render_zingchart(id,data,width,height){ 
 		//alert("id="+id)
		zingchart.exec(id, 'destroy');
 		zingchart.render({
 			id : id,
 			//output	: 'svg',
 			width 	: width,
 			height 	: height,
 			data : data
 		});
		
		
		//alert($("#gProfit_3-graph-id0-scale-x-item-0-t").length);
		//$("#gProfit_3-graph-id0-scale-x-item-0-t").html("EBITDA");
		//alert($("#gProfit_3").length);
		//alert($("#g2").length);	
 		  
 	}
     function listYears(){
 		var str="<font size=\"3\"> ปี: </font>";		
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
 				goUrl();
 				//renderBarOfChart(null);
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
     function goUrl()
		{
     	var sumby=$("#SumBy").val();
 		var year=$("#financeYear").val();
 		var month=$("#financeMonth").val();
 		
 		if(!(sumby=='6' || sumby=='7')){
 			loadedG=[0];
 			 render_financialIndication(year,month,sumby,'00100'); //for test
     	   for(var i=0;i<gTypeG2.length;i++){
     		  // alert(gTypeIdG[i])
     		   render_gtype_data(year,month,gTypeIdG[i],gTypeG2[i],i,sumby,null);
 	       }  			
 			 render_mix_data("g2",year,month,sumby,null); 
 			 render_pile(year,month,sumby);
 			 renderBarOfChart(null);
 			 /*  for(var i=0;i<tabsG.length;i++){                    
 	     	       render_gtab_data(year,month,tabsG[i],sumby);
 	     	        render_mix_data("g"+tabsG[i],year,month,sumby,tabsG[i]); 
 	          } */
 			 render_gtab_data(year,month,tabsG[0],sumby);
 	   	    render_mix_data("g"+tabsG[0],year,month,sumby,tabsG[0]);
 		}else{
 			//alert("go Url")
 			location.href = _path+"/Dashboard/"+urlG+".jsp?y="+year+"&m="+month+"&sb="+sumby+"&init=1";
 		}
	}
     function clickBytab(index){
    		var sumby=$("#SumBy").val();
     		var year=$("#financeYear").val();
     		var month=$("#financeMonth").val();
        render_gtab_data(year,month,tabsG[index],sumby);
   	    render_mix_data("g"+tabsG[index],year,month,sumby,tabsG[index]); 
     }
     function parseDouble(value){
     	  if(typeof value == "string") {
     	    value = value.match(/^-?\d*/)[0];
     	  }

     	  return !isNaN(parseInt(value)) ? value * 1 : NaN;
     	}
     function render_pile(year,month,sumby){
     	var pie_data="" ;
     	 $("#g3").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
     	BalanceScorecardAjax.getPile(year,month,sumby,{
     		   // (ค่า Period ปัจจุบัน – ค่า Period ก่อนหน้า)/ค่า Period ก่อนหน้า)*100
     		/*    สูตรการคิด % Growth คือ 
((ค่า Period ปัจจุบัน – ค่า Period ก่อนหน้า)/ค่า Period ก่อนหน้า)*100

สูตรการคิด PieChartRatio คือ ThisPeriodActual ของแต่ละธุรกิจ/ ThisPeriodActual ของทุกธุรกิจ เช่น ratio ของ restaurant คือ 110/690 */
     		   //((lastActual-twoLastActual)/twoLastActual)*100
					callback:function(data){
						 pie_data = 
				     	{
				     	"graphset" : [
				     	{
				     		"id" : "pileId",	
				     		"type" : "pie",
				     		"background-color":"#FFFFFF",
				     		"chart" : {
				     		//	"margin" : "20 0 45 0",
				     			"margin":"20 0 100 0",
				     			"padding-top":"0px"
				     		},
				     		"legend" : {
				     			"background-color": "#FFFFFF",
				         		"border-width": "2px",
				     			"border-color": "#4C77B6",
				     			"layout": "2x",				     			
				     			"x": 10,
				     			//"y": 265,
				     			"y": 270,
				     		//	"x": 7,
				     		//	"y": 250,
				     			"margin":"10 0 400 0",
				     			"width": 400
				     		},
				     		"scale" : {
				     			"size-factor" : 0.8
				     		},
				     		"tooltip" : {
				     			"padding" : "6",
				     			"border-radius" : "6"
				     		},
				     		"plot" : {
				     			"ref-angle" : 0,
				     			"decimals":2,
		    					"decimals-separator":".",
		    					"thousands-separator":",",
				     			"value-box" : {
				     				 "type" : "all",
				     				"placement" : "in",
				     				"text" : "%v%",
				     				   "text-align" : "center",
						     		      "placement" : "out", 
						     		      "offset-r": "2px"
				     			} 
				     			//"url" : "/Dashboard/Finance.jsp?bar3=1"
				     		},
				     		"series" : [
				     		            /*
				     		{
				     			"text": "Restaurant",
				     			"values" : [17.42],
				     			"tooltip-text" : "%t: 273,950"
				     		},
				     		{
				     			"text": "Bakery Shop",
				     			"values" : [21.49],
				     			"tooltip-text" : "%t: 312,060"
				     		},
				     		{
				     			"text": "Specialty",
				     			"values": [15.35],
				     			"tooltip-text" : "%t: 259,923"
				     		},
				     		{
				     			"text": "Trading",
				     			"values": [22.75],
				     			"tooltip-text" : "%t: 365,034"
				     		},
				     		{
				     			"text": "Caterman",
				     			"values": [12.67],
				     			"tooltip-text" : "%t: 212,355"
				     		},
				     		{
				     			"text": "Other",
				     			"values": [10.32],
				     			"tooltip-text" : "%t: 152,716"
				     		}
				     		*/
				     		] 
				     	}]
				     }; 
							
						if(data!=null && data.length>0){
						
							var sum=0;
                         for(var i=0;i<data.length;i++){
							
                        	 var thisActual=data[i].thisActual.replace(/,/g,"");
                        	/*  alert("data[i].thisActual="+data[i].thisActual)
                         	sum=sum+Number(data[i].thisActual); */
                         	sum=sum+parseFloat(thisActual);
                        //	alert("data[i].thisActual="+thisActual)
                         }
                       //  alert("sum="+sum)
                      var seriesValues=[];
                      //alert(data.length)
                    //  alert("sum="+sum)
                         for(var i=0;i<data.length;i++){
							
                         	if(sum!=0){
							
                         		var thisActual=data[i].thisActual.replace(/,/g,"");
                         	//	pie_data.graphset[0].series[i]["tooltip-text"]= "%t: "+Number(thisActual).toFixed(2);
                         		/* pie_data.graphset[0].series[i]["tooltip-text"]= "%t: "+data[i].thisActual;
                         	    pie_data.graphset[0].series[i].values=[(parseFloat(thisActual) /sum)*100]; 
                         	   pie_data.graphset[0].series[i].text=data[i].revenueGroupDesc;
                         	  */
                         //	  alert("thisActual="+thisActual+",%="+(parseFloat(thisActual)/sum)*100);
                         	// getRevenueGroupDesc
                         	 var seriesValue={
  				     			"text": data[i].revenueGroupDesc,
  				     			"values": [(parseFloat(thisActual)/sum)*100],
  				     			"tooltip-text" : "%t: "+data[i].thisActual
  				     		};
                         	//alert(data[i].thisActual);
                         	//alert(data[i].revenueGroupDesc)
                         	seriesValues.push(seriesValue);
							
                         	 //  alert((parseFloat(thisActual)/sum)*100)
                         	    //alert((Number(thisActual)/sum).toFixed(2)*100);
                         	}else{
								/*
								 pie_data.graphset[0].series[i]["tooltip-text"]= "%t: 0";
								 pie_data.graphset[0].series[i].values=[0];
								*/
                         	}
                         } 
                         pie_data.graphset[0].series=seriesValues;
                   
                         $("#g3").html("");
                       render_zingchart("g3",pie_data,420,320);
                       // render_zingchart("g3",pie_data,420,400);
                        // render_zingchart("g3",pie_data,420,300);
						}else{
							$("#g3").html("");
						
						}

					}
     	 });
    }
     function render_mix_data(id,year,month,sumby,orgTyp){ 
     	$("#"+id).html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
  		 $("#"+id+"_legend").html("");  
  		BalanceScorecardAjax.getFD1_2_4_percent(year,month,sumby,orgTyp,{
					callback:function(data){	 
						if(data!=null && data.length==3){ 
							var bar02_data = 
							{
							"graphset" : [
								{
									"type" : "mixed",
									"background-color":"#FFFFFF",
									"chart" : {
										"margin" : "20 20 30 50"
									},
									"stacked":"1",
									"plot":{
										"bars-space-left":"25%",
										"bars-space-right":"25%",
										"bar-width":"25px",
										"decimals":2,
				    					"decimals-separator":".",
				    					"thousands-separator":","
									}, 
									"scale-x" : {
										//"values" : ["Last Period Actual","Actual","Budget"],
										"values" : ["Last Period","Actual","Budget"],
										"guide":{
						    				"line-width": 1,
						    				"alpha": 1
						    			},
										"tick":{
											"line-width": 3
										}
									},
									"scale-y" : {
										"min-value":0,
										"decimals":0,
										"thousands-separator":",",
										"format":"%v%",
										"guide":{
						    				"line-width": 1,
						    				"alpha": 1
						    			},
										"tick":{
											"line-width": 3
										}
									},
									"series" : [
                                     {   "type":"bar",
                                    	 "values":[54.27,43.74,54.27],
                                    	 "background-color":"deepskyblue","text":"ค่าใช้จ่ายการขายและบริหาร"},
								     {"type":"bar","values":[32.88,29.85,32.88],"background-color":"goldenrod","text":"ต้นทุนขาย"}
									]
								}
							]
						};
						var percent1=[];
						var percent2=[];
						$("#"+id).html(""); 

		    	  	/*
					$("#"+id+"_legend").html("<a href=\""+_path+"/Dashboard/FinancePopupPer.jsp?topic=%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย\" rel=\"facebox\">"+
		     				"<img src=\""+_path+"//Dashboard/images/Popup.jpg\" border=\"0\"/> <font color=\"blue\" size=\"1\">Drill Down</font>"+
  					"</a>"); 
					*/

  			    var tabParam=orgTyp!=null?("&tab="+orgTyp):"";
  			  
  			    $("#"+id+"_legend").html("<a onclick=showPopup(\""+_path+"/Dashboard/FinancePopupPer_new.jsp?y="+year+"&m="+month+"&sb="+sumby+tabParam+"\") rel=\"facebox\">"+
	     				"<img src=\""+_path+"//Dashboard/images/Popup.jpg\" border=\"0\"/> <font color=\"blue\" size=\"1\" style=\"cursor: pointer;\">Drill Down</font>"+
		    "</a>");
					  // จากนั้น นำ (ต้นทุน[1]/ ยอดขาย [0])*100  
		            // จากนั้น นำ (ค่าใช้จ่าย[2]/ ยอดขาย [0])*100 
						for(var k=1;k<3;k++){
							var LastAct_percent;//sumLastYearActualMONTHLY
	 						var ThisAct_percent;// sumThisYearActualMonthly 
	 						var Target_percent;//sumThisYearBudgetMONTHLY 
							if(data[0].sumLastYearActualMONTHLY!=null && data[0].sumLastYearActualMONTHLY.length>0){ 
								if(parseDouble(data[0].sumLastYearActualMONTHLY)==0){
									LastAct_percent=0; //alert(" eq :0");
								}else{
									LastAct_percent=(parseDouble(data[k].sumLastYearActualMONTHLY)/(parseDouble(data[0].sumLastYearActualMONTHLY)))*100;
								} 
							}else{
								LastAct_percent=0;
							}
						  if(data[0].sumThisYearActualMonthly!=null && data[0].sumThisYearActualMonthly.length>0){ 
							if(parseDouble(data[0].sumThisYearActualMonthly)==0){
								ThisAct_percent=0; //alert(" eq :0");
							}else{
								ThisAct_percent=(parseDouble(data[k].sumThisYearActualMonthly)/(parseDouble(data[0].sumThisYearActualMonthly)))*100;
							} 
						}else{
							ThisAct_percent=0;
						}
						 if(data[0].sumThisYearBudgetMONTHLY!=null && data[0].sumThisYearBudgetMONTHLY.length>0){ 
							if(parseDouble(data[0].sumThisYearBudgetMONTHLY)==0){
								Target_percent=0; //alert(" eq :0");
							}else{
								Target_percent=(parseDouble(data[k].sumThisYearBudgetMONTHLY)/(parseDouble(data[0].sumThisYearBudgetMONTHLY)))*100;
							} 
						}else{
							Target_percent=0;
						}
						if(k==1){
							percent1.push(LastAct_percent);
							percent1.push(ThisAct_percent);
							percent1.push(Target_percent);
						 }else{
							percent2.push(LastAct_percent);
							percent2.push(ThisAct_percent);
							percent2.push(Target_percent);
						}
						}
					//	percent1=[54.27,43.74,54.27];
					//	percent2=[32.88,29.85,32.88];
						//percent1=[2,-2.4475524475524475,0];
						//percent2=[3,-23.076923076923077,0];
					//-22.991071428571427,-23.076923076923077,0,percent2=-2.622767857142857,-2.4475524475524475,0
					  //alert("percent1="+percent1+",percent2="+percent2)
							bar02_data.graphset[0].series[0].values=percent1;
						    bar02_data.graphset[0].series[1].values=percent2;
						render_zingchart(id,bar02_data,290,229);
						}
					}
			 });
     }
     function render_gtab_data(year,month,tabs_name,sumby){
     	 for(var i=0;i<gTypeG.length;i++){
   		   render_gtype_data(year,month,gTypeIdG[i]+"_"+tabs_name,gTypeG[i],i,sumby,tabs_name); 
   	   }
     }
     function render_gtype_data(year,month,graph_id,graph_label,graphIndex,sumby,orgType){
     	 $("#"+graph_id).html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
 		 $("#"+graph_id+"_legend").html(""); 
 		     var scale_x=[]
 		     var LastAct= [];//sumLastYearActualMONTHLY
				var ThisAct = [];// sumThisYearActualMonthly "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53,3032309.54,3574088.40,3979020.08,4399473.14,4967272.82";
				var Target =[];// sumThisYearBudgetMONTHLY  "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58,3041428.29,3571298.86,3955662.91,4354784.30,4953878.04";
				BalanceScorecardAjax.getFD1_2_4(year,month,graphIndex,sumby,orgType,{
					callback:function(data){
						
						// alert($("#gProfit_3-main").length);
						console.log(data);
						if(data!=null && data.length>0){

							//alert("jquery");

							var mix_data = {
				    				"graphset" : [
				    				{
				    					"type" : "mixed",
				    					"background-color":"#FFFFFF",
				    					"chart":{
				    						"margin":"25 25 35 50"
				    					},

				    					"labels" : [
				    						{
				    							//"text" : "2.31%",
													//"text" : "-2.31%",
				    							"hook" : "node:plot=1,index=0",
				    							//"background-color":"red",
				    							"color": "black",
				    							"border-width":1, 
				    							"border-color":"red",
				    							//"bold": true,
												
				    						},
				    						
				    						{
				    							"text" : "ล้าน (บาท)",
				    							"bold":true,
				    							"x": "15",
				    							"y": "20"
				    						}
				    					],
				    					"plot":{
				    						"tooltip-text":"%v",
				    						"bars-space-left":"15%",
				    						"bars-space-right":"15%",
				    						"decimals":2,
				    						"decimals-separator":".",
				    						"thousands-separator":","
				    					},
				    					"scale-x":{
				    						"values":[],//["ยอดขาย"],
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
				    						"min-value" : 0,
				    						"decimals":0,
				    						"thousands-separator":",",
				    				//		"format":"%v%",
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
				    					"series" : [
				    						{
				    							"type" : "bar",
				    							"values" : [],//["390"],
				    							"text":"Actual",
				    							"background-color":"#66CC00"
				    						},
				    						{
				    							"type" : "bar",
				    							"values" : [],//["350"],
				    							"text":"Last Period Actual",
				    							"background-color":"#EEEE00"
				    						},
				    						{
				    							"type" : "bar",
				    							"values" : [],//["400"],
				    							"text": "Budget",
				    							"background-color":"#696969"
												
				    						}
											
				    					]
				    				}
				    			]
				    		};	
						var percentGrowthMONTHLY="";    
        				var percentVarianceMONTHLY="";  
							for(var i=0;i<data.length;i++){
								LastAct.push((data[i].sumLastYearActualMONTHLY!=null && data[i].sumLastYearActualMONTHLY.length>0)?data[i].sumLastYearActualMONTHLY:"0.00");
								ThisAct.push((data[i].sumThisYearActualMonthly!=null && data[i].sumThisYearActualMonthly.length>0)?data[i].sumThisYearActualMonthly:"0.00");
								Target.push((data[i].sumThisYearBudgetMONTHLY!=null && data[i].sumThisYearBudgetMONTHLY.length>0)?data[i].sumThisYearBudgetMONTHLY:"0.00");
								percentGrowthMONTHLY=data[i].percentGrowthMONTHLY;
								percentVarianceMONTHLY=data[i].percentVarianceMONTHLY;
							} 
							$("#"+graph_id).html("");
							//gSales_Restaurant
							if(!(graph_id.indexOf('gSales')!=-1 || graph_id.indexOf("gProfit_1")!=-1))
								$("#"+graph_id+"_legend").html("");
				            else {
				            	/*  $("#"+id+"_legend").html("<a onclick=showPopup(\""+_path+"/Dashboard/FinancePopupPer_new.jsp?topic=%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย&sb="+sumby+tabParam+"\") rel=\"facebox\">"+
				 	     				"<img src=\""+_path+"//Dashboard/images/Popup.jpg\" border=\"0\"/> <font color=\"blue\" size=\"1\">Drill Down</font>"+
				 		    "</a>"); */ 
				 		   var tabParam=orgType!=null?("&tab="+orgType):"";
				    		   $("#"+graph_id+"_legend").html("<a onclick=showPopup(\""+_path+"/Dashboard/FinancePopup_new.jsp?topic="+graphIndex+"&y="+year+"&m="+month+"&sb="+sumby+tabParam+"\") rel=\"facebox\">"+
				     				"<img src=\""+_path+"//Dashboard/images/Popup.jpg\" border=\"0\"/> <font color=\"blue\" size=\"1\" style=\"cursor: pointer;\">Drill Down</font>"+
		     			    "</a>");   
						    }
						 
				
				    		scale_x.push(graph_label);
            				mix_data.graphset[0].labels[0].text=percentGrowthMONTHLY;    
            				mix_data.graphset[0].labels[1].text=percentVarianceMONTHLY;    
				    		mix_data.graphset[0].series[0].values=LastAct;
				    		mix_data.graphset[0].series[1].values=ThisAct;
				    		mix_data.graphset[0].series[2].values=Target;
				    		//mix_data.graphset[0].scale-x.values=scale_x;
				    		mix_data.graphset[0]["scale-x"].values=scale_x;
						//	alert("xx="+percentVarianceMONTHLY) ;
							render_zingchart(graph_id,mix_data,190,230);
						}
						else {
							$("#"+graph_id).html("");
							$("#"+graph_id+"_legend").html("");
						} 
					}
			 });
     }
     function showPopup(div){
    	// alert(div)
    	 //jQuery.facebox({ div:'#bscKPIDetail'});
    	 //$.facebox.settings.closeImage=_path+'/chartLib/images/closelabel.png';
		
		 $.facebox.settings.closeImage=_path+'/chartLib/images/closelabel.png';
		 jQuery.facebox({ ajax: div});
     }
     
	</script>
	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
		.demoHeaders { margin-top: 2em; }
		#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
		#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
		ul#icons {margin: 0; padding: 0;}
		ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
		ul#icons span.ui-icon {float: left; margin: 0 4px;}

		#tabs { position:absolute; width:1325px; top:60px; left:5px; height:1200px; }
		#tabs-ratio { position:absolute; left:3px; top:45px; width:100px; }
		#tabs-ratio1 { position:absolute; left:3px; top:45px; width:100px; }
	</style>	 
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
			<option value="6" selected="selected">YTD</option>
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
	  </td>
	</tr>
  </table>
</td>

<td>
  <table id=tabs-table2 width=800px style="position:absolute; left:242px; top:45px;" bordercolor="#000000" frame="box" rules="all">

  <tr><td><table width="100%">
  <tr bgcolor="#8B4513">
  <td>
	<div align=center><font color="#FFE742" size="3"><b>บริษัทเอส แอนด์ พี ซินดิเคท จำกัด (มหาชน)</b></font></div>
  </td>
  </tr>

  <tr><td><table bordercolor="#CCCCCC" frame="box" rules="all">
  <tr>
	  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
	  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
	  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>
  </tr>
  <!-- Chart -->
  <tr>
	<td valign="middle" align="center" style="width: 190px">
		 <div id="gSales"></div>
	    <div id="gSales_legend"></div>
	</td>
	<td valign="middle" style="width: 570px"><table><tr>
		<td align="center"  style="width: 190px">
			<div id="gProfit_1"></div>
	        <div id="gProfit_1_legend"></div>
		</td>
		<td align="center"  style="width: 190px">
			<div id="gProfit_2"></div>
	        <div id="gProfit_2_legend"></div>
		</td>
		<td align="center"  style="width: 190px">
			<div id="gProfit_3"></div>
	        <div id="gProfit_3_legend"></div>
		</td>
	</tr></table></td>
	<td valign="middle" align="center"  style="width: 290px">
		<div id="g2"></div>
	        <div id="g2_legend"></div>
	</td>
  </tr>

  <!-- img Legend -->
  <tr>
	<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
	<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
</tr> 
  </table></td></tr>
  </table></td></tr>

  <tr><td valign="top" align="center"><table>
  <tr bgcolor="#8B4513">
  <td>
	<div align=center><font color="#FFE742" size="3"><b>สัดส่วน แยกตามประเภทธุรกิจ</b></font></div>
  </td>
  </tr>
  <tr><td valign="top" align="center"><table width=1070 bordercolor="#8B4513" frame="box" rules="all">
  <tr>
	  <td bgcolor="#CD853F"><font size="3" color="#FFFFFF"><div align=center>Sales</div></font></td>
	  <td bgcolor="#CD853F"><font size="3" color="#FFFFFF"><div align=center id="sales_growth">%Sales Growth</div></font></td>
  </tr>
  <tr>
	<td valign="top" align="center" height="420px">
	
	<div id="g3"  style="width: 420px;height: 420px"></div>
	<%--
	<div id="g3"  style="width: 500px"></div>
	 --%>
	</td>
	<td valign="middle">
		<!--------------------------- Print Button BACK --------------------------->
		<div id="back_bt"><input type="button" name="back" value=" BACK " onclick="renderBarOfChart(null);"/></div>
		<div id="g4" style="width: 600px" align="center">
		<iframe  id ="ifrmgr_barchart" width=450 height=350 src="" marginwidth="0" marginheight="0" 
				vspace="0" hspace="0" frameborder="0"  align="middle" scrolling="no">
	 						</iframe>
		</div>
	</td>
  </tr>
  </table></td></tr>
  </table></td></tr>

  </table>
</td></tr>
</table>
<!-- -->
<div style=" position:absolute; top:850px; left:242px;">
<table id="tabs-t1r3">
  <tr height=350><td valign="top" width=1070>
	<ul>
		<li><a href="#tabs-t1r3_1">Restaurant</a></li>
		<li><a href="#tabs-t1r3_2">Bakery</a></li>
		<li><a href="#tabs-t1r3_3">Specialty</a></li>
		<li><a href="#tabs-t1r3_4">Trading</a></li>
		<li><a href="#tabs-t1r3_5">Caterman</a></li>
		<li><a href="#tabs-t1r3_6">Other</a></li>
	</ul>
	<!-- Reataurant -->
	<table id="tabs-t1r3_1" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>
	  </tr>
	  <!-- Chart -->
	  <tr width=600>
		  <td valign="middle" align="center"  style="width: 190px">
		 
	        <div id="gSales_Restaurant"></div>
	       <div id="gSales_Restaurant_legend"></div>
		</td>
		<td valign="middle"  style="width: 570px"><table><tr>
			<td align="center"  style="width: 190px"> 
	             <div id="gProfit_1_Restaurant"></div>
	             <div id="gProfit_1_Restaurant_legend"></div>
			</td>
			<td align="center"  style="width: 190px"> 
	             <div id="gProfit_2_Restaurant"></div>
	             <div id="gProfit_2_Restaurant_legend"></div>
			</td>
			<td align="center"  style="width: 190px"> 
	             <div id="gProfit_3_Restaurant"></div>
	 	         <div id="gProfit_3_Restaurant_legend"></div>
			</td>
		</tr></table></td>
		<td valign="middle" align="center"  style="width: 290px">
			<div id="gRestaurant"></div>
			 <div id="gRestaurant_legend"></div>
		</td>
	  </tr>
	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr> 
	</table>
	</td></tr></table>
	<!-- Bakery -->
	<table id="tabs-t1r3_2" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>
	  </tr>
	  <!-- Chart -->
	  <tr width=600>
				<td valign="middle" align="center"  style="width: 190px"> 
			<div id="gSales_Bakery"></div>
	 	    <div id="gSales_Bakery_legend"></div>
		</td>
		<td valign="middle"  style="width: 570px"><table><tr>
			<td align="center"  style="width: 190px"> 
	            <div id="gProfit_1_Bakery"></div>
	 	        <div id="gProfit_1_Bakery_legend"></div>
			</td>
			<td align="center"  style="width: 190px">
	            <div id="gProfit_2_Bakery"></div>
	 	        <div id="gProfit_2_Bakery_legend"></div>
			</td>
			<td align="center"  style="width: 190px">
			    <div id="gProfit_3_Bakery"></div>
	 	        <div id="gProfit_3_Bakery_legend"></div>
			</td>
		</tr></table></td>
		<td valign="middle" align="center"  style="width: 290px">
		    <div id="gBakery"></div>
			 <div id="gBakery_legend"></div>
		</td>
	  </tr>
	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Specialty -->
	<table id="tabs-t1r3_3" height="350">
	<tr><td>
	<table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>
	  </tr>
	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center"  style="width: 190px">  
	        <div id="gSales_Specialty"></div>
	 	    <div id="gSales_Specialty_legend"></div>
		</td>
		<td valign="middle"  style="width: 570px"><table><tr>
			<td align="center"  style="width: 190px"> 
	            <div id="gProfit_1_Specialty"></div>
	 	        <div id="gProfit_1_Specialty_legend"></div>
			</td>
			<td align="center"  style="width: 190px">  
	            <div id="gProfit_2_Specialty"></div>
	 	        <div id="gProfit_2_Specialty_legend"></div>
			</td>
			<td align="center" style="width: 190px"> 
	            <div id="gProfit_3_Specialty"></div>
	 	        <div id="gProfit_3_Specialty_legend"></div>
			</td>
		</tr></table></td>
		<td valign="middle" align="center"  style="width: 290px">
		    <div id="gSpecialty"></div>
			 <div id="gSpecialty_legend"></div>
		</td>
	  </tr>
	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Trading -->
	<table id="tabs-t1r3_4" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>
	  </tr>
	  <!-- Chart -->
	  <tr width=600>
				<td valign="middle" align="center"  style="width: 190px">  
	        <div id="gSales_Trading"></div>
	 	    <div id="gSales_Trading_legend"></div>
		</td>
		<td valign="middle"  style="width: 570px"><table><tr>
			<td align="center"  style="width: 190px"> 
	        <div id="gProfit_1_Trading"></div>
	 	    <div id="gProfit_1_Trading_legend"></div>
			</td>
			<td align="center"  style="width: 190px"> 
	        <div id="gProfit_2_Trading"></div>
	 	    <div id="gProfit_2_Trading_legend"></div>
			</td>
			<td align="center"  style="width: 190px"> 
	            <div id="gProfit_3_Trading"></div>
	 	        <div id="gProfit_3_Trading_legend"></div>
			</td>
		</tr></table></td>
		<td valign="middle" align="center"  style="width: 290px">
		 <div id="gTrading"></div>
			 <div id="gTrading_legend"></div>
		</td>
	  </tr>
	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>
	
	<!-- Caterman -->
	<table id="tabs-t1r3_5" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>
	  <!-- Chart -->
	  <tr width=600>
				<td valign="middle" align="center"  style="width: 190px">
	 	         <div id="gSales_Caterman"></div>
	 	    <div id="gSales_Caterman_legend"></div>
		</td>
		<td valign="middle"  style="width: 570px"><table><tr>
			<td align="center"  style="width: 190px">  
			 <div id="gProfit_1_Caterman"></div>
	 	        <div id="gProfit_1_Caterman_legend"></div>
			</td>
			<td align="center"  style="width: 190px">  
			    <div id="gProfit_2_Caterman"></div>
	 	        <div id="gProfit_2_Caterman_legend"></div>
			</td>
			<td align="center"  style="width: 190px">  
			    <div id="gProfit_3_Caterman"></div>
	 	        <div id="gProfit_3_Caterman_legend"></div>
			</td>
		</tr></table></td>
		<td valign="middle" align="center"  style="width: 290px">
		<div id="gCaterman"></div>
			 <div id="gCaterman_legend"></div>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Other -->
	<table id="tabs-t1r3_6" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>
	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center"  style="width: 190px"> 
	            <div id="gSales_Other"></div>
	 	        <div id="gSales_Other_legend"></div> 
				
		</td>
		<td valign="middle"  style="width: 570px"><table><tr>
			<td align="center"  style="width: 190px">  
			   <div id="gProfit_1_Other"></div>
	 	        <div id="gProfit_1_Other_legend"></div>
			</td>
			<td align="center"  style="width: 190px">  
			   <div id="gProfit_2_Other"></div>
	 	        <div id="gProfit_2_Other_legend"></div>
			</td>
			<td align="center"  style="width: 190px"> 
			   <div id="gProfit_3_Other"></div>
	 	        <div id="gProfit_3_Other_legend"></div>
			</td>
		</tr></table></td>
		<td valign="middle" align="center"  style="width: 290px">
		<div id="gOther"></div>
			 <div id="gOther_legend"></div>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

<!-- END -->
  </td></tr>
  </table></div>

</div>
</body>
</html>
