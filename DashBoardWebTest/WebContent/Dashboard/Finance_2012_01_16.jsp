<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Finance Dashboard Page</title>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

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
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/interface/FinanceDashboardAjax.js"></script>
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
	var tabsG=["Restaurant","Bakery","Specialty","Trading","Caterman","Other"];
	var gTypeG=["ยอดขาย","กำไรขั้นต้น","กำไรจากการดำเนินการ","กำไรสุทธิ"];
	var gTypeIdG=["gSales","gProfit_1","gProfit_2","gProfit_3"];
	jQuery(document).ready(function($) {
			// Tabs
			$("#tabs").tabs();
			$("#tabs-ratio").tabs();
			//$("#tabs-ratio1").tabs();
			$("#tabs-table2").tabs();
			//$("#tabs-table3").tabs();
			//$("#tabs-table4").tabs();
			//$("#tabs-table5").tabs();

			$("#tabs-t1r3").tabs();

			//$("#tabs-t2r3").tabs();
			
			//hover states on the static widgets
			$('#dialog_link, ul#icons li').hover(
				function() { $(this).addClass('ui-state-hover'); }, 
				function() { $(this).removeClass('ui-state-hover'); }
			);
			$('a[rel*=facebox]').facebox({
				loadingImage : '<%=request.getContextPath()%>/chartLib/images/loading.gif',
				closeImage   : '<%=request.getContextPath()%>/chartLib/images/closelabel.png'
			});
			 initChart();
		});
	   
/*
		jQuery(document).ready(function($) {
			$('a[rel*=facebox]').facebox({
				loadingImage : ' /chartLib/images/loading.gif',
				closeImage   : ' /chartLib/images/closelabel.png'
			})
		})
*/
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
	      
        } 
        function render_financialIndication(year,month,sumby,company){  
    		
    		 var str="<table id=table-data1 width=220px>"+
    		        "     <tr><th class=\"ui-state-default ui-corner-top ui-tabs-selected ui-state-active\" style=\"height:35px\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial Indicator&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp</th></tr>"+
    		        "</table>"+		         
    		        "<table id=table-data width=100%>"+
    		        "    <tr>"+
    			    "        <th bgcolor=#CD853F colspan=3><font color=\"#FFFFFF\">"+monthNameG[parseInt(month)-1]+" "+year+" vs "+monthNameG[parseInt(month)-1]+" "+(parseInt(year)-1)+"</font></th>"+
    		        "    </tr>";
    		 var financialIndicationDTO;
    		 var trend;
    		 FinanceDashboardAjax.getFinancialIndication(year,month,company,{
    				callback:function(data){
    					//alert(data)
    					if(data!=null && data.length>0){
    						for(var i=0;i<data.length;i++){
    							str=str+"<tr><th colspan=3>"+data[i].ratioGroupName+"</th></tr>";
    							financialIndicationDTO=data[i].financialIndicationDTO;
    						//	alert(financialIndicationDTO)
    							if(financialIndicationDTO!=null && financialIndicationDTO.length>0){								
    								for(var j=0;j<financialIndicationDTO.length;j++){ 
    									trend="";
    									if(financialIndicationDTO[j].trendFlag!=null){
    										if(financialIndicationDTO[j].trendFlag=='I'){
    											trend="<img src=images/up1.png>";
    										}if(financialIndicationDTO[j].trendFlag=='D'){
    											trend="<img src=images/down1.png>";
    										}
    									} 
    									str=str+"<tr><td>"+financialIndicationDTO[j].ratioName+"</td>"+
    									        "<td>"+trend+"</td>"+
    									        "<td>"+financialIndicationDTO[j].thisPeriodValue+"</td></tr>";
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
        function render_zingchart(id,data,width,height){ 
    		//alert("id="+id)
    		zingchart.render({
    			id : id,
    			//output	: 'svg',
    			width 	: width,
    			height 	: height,
    			data : data
    		});
    	}
        function listYears(){
    		var str="<font size=\"3\"> ปี: </font>";		
    		FinanceDashboardAjax.listYears({
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
    				str=str+"</select>";
    				$('#financeMonthElement').html(str); 
    	}
        function goUrl()
		{
        	var sumby=$("#SumBy").val();
    		var year=$("#financeYear").val();
    		var month=$("#financeMonth").val();
    		
    		if(!(sumby=='6' || sumby=='7')){

        	   for(var i=0;i<gTypeG.length;i++){
        		   render_gtype_data(year,month,gTypeIdG[i],gTypeG[i],i,sumby,null);
    	       } 
                for(var i=0;i<tabsG.length;i++){ 
        	        render_gtab_data(year,month,tabsG[i],sumby);
        	        render_mix_data("g"+tabsG[i],year,month,sumby,tabsG[i]); 
                }
    	 
    			 render_financialIndication(year,month,sumby,'1'); //for test
    			 render_mix_data("g2",year,month,sumby,null); 
    			 render_pile(year,month,sumby);
    		}else{
    			//alert("go Url")
    			location.href = _path+"/Dashboard/"+urlG+".jsp?y="+year+"&m="+month+"&sb="+sumby
    		}
        	 
			//location.href = urlP+'?y='+y+'&months='+months+'&sb='+sb+'&country=1&bar1=0&bar2=0&bar2F=0&bar3=0&bar3F=0&t1=0&t2=0';
		}
        function parseDouble(value){
        	  if(typeof value == "string") {
        	    value = value.match(/^-?\d*/)[0];
        	  }

        	  return !isNaN(parseInt(value)) ? value * 1 : NaN;
        	}
        function render_pile(year,month,sumby){
        	var pie_data = 
        	{
        	"graphset" : [
        	{
        		"type" : "pie",
        		"background-color":"#FFFFFF",
        		"chart" : {
        			"margin" : "0 0 45 0",
        			"padding-top":"0px"
        		},
        		"legend" : {
        			"background-color": "#FFFFFF",
            		"border-width": "2px",
        			"border-color": "#4C77B6",
        			"layout": "2x",
        			"x": 10,
        			"y": 265,
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
        			"value-box" : {
        				"placement" : "in",
        				"text" : "%v%"
        			}
        			//"url" : "/Dashboard/Finance.jsp?bar3=1"
        		},
        		"series" : [
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
        		] 
        	}]
        }; 
        	 $("#g3").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
        	 FinanceDashboardAjax.getPile(year,month,sumby,{
        		   // (ค่า Period ปัจจุบัน – ค่า Period ก่อนหน้า)/ค่า Period ก่อนหน้า)*100
        		/*    สูตรการคิด % Growth คือ 
((ค่า Period ปัจจุบัน – ค่า Period ก่อนหน้า)/ค่า Period ก่อนหน้า)*100

สูตรการคิด PieChartRatio คือ ThisPeriodActual ของแต่ละธุรกิจ/ ThisPeriodActual ของทุกธุรกิจ เช่น ratio ของ restaurant คือ 110/690 */
        		   //((lastActual-twoLastActual)/twoLastActual)*100
					callback:function(data){	 
						if(data!=null && data.length>0){
							var sum=0;
                            for(var i=0;i<data.length;i++){
                            	sum=sum+Number(data[i].thisActual);
                            }
                            for(var i=0;i<data.length;i++){
                            	if(sum!=0){
                            		pie_data.graphset[0].series[i]["tooltip-text"]= "%t: "+Number(data[i].thisActual).toFixed(2);
                            	    pie_data.graphset[0].series[i].values=[(Number(data[i].thisActual)/sum).toFixed(2)*100]; 
                            	}else{
                            		pie_data.graphset[0].series[i]["tooltip-text"]= "%t: 0";
                                    pie_data.graphset[0].series[i].values=[0];
                            	} 
                            } 
                            $("#g3").html("");
                            render_zingchart("g3",pie_data,420,320);
						}else{
							$("#g3").html("");
						}
					}
        	 });
       }
        function render_mix_data(id,year,month,sumby,orgTyp){ 
        	$("#"+id).html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
     		 $("#"+id+"_legend").html("");  
        	FinanceDashboardAjax.getFD1_2_4_percent(year,month,sumby,orgTyp,{
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
										"bar-width":"25px"
									}, 
									"scale-x" : {
										"values" : ["Last Year","Actual","Budget"],
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
                                        {"type":"bar","values":[54.27,43.74,54.27],"background-color":"deepskyblue","text":"ค่าใช้จ่ายการขายและบริหาร"},
										    {"type":"bar","values":[32.88,29.85,32.88],"background-color":"goldenrod","text":"ต้นทุนขาย"}
									]
								}
							]
						};
						var percent1=[];
						var percent2=[];
						$("#"+id).html("");
		    	/* 	$("#"+id+"_legend").html("<a href=\""+_path+"/Dashboard/FinancePopup.jsp?topic=%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย\" rel=\"facebox\">"+
		     				"<img src=\""+_path+"//Dashboard/images/Popup.jpg\" border=\"0\"/> <font color=\"blue\" size=\"1\">Drill Down</font>"+
     			    "</a>");   */
     			     	$("#"+id+"_legend").html("");  
					
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
        	 FinanceDashboardAjax.getFD1_2_4(year,month,graphIndex,sumby,orgType,{
					callback:function(data){	 
						if(data!=null && data.length>0){
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
				    							"text" : "-2.31%",
				    							"hook" : "node:plot=1,index=0",
				    							"background-color":"red",
				    							"color": "white",
				    							"border-width":5, 
				    							"border-color":"red",
				    							"bold": true
				    						},
				    						{
				    							"text" : "12.79%",
				    							"hook" : "node:plot=2,index=0",
				    							"background-color":"blue",
				    							"color": "white",
				    							"border-width":5, 
				    							"border-color":"blue",
				    							"bold": true
				    						},
				    						{
				    							"text" : "ล้าน (บาท)",
				    							"bold":true,
				    							"x": "15",
				    							"y": "0"
				    						}
				    					],
				    					"plot":{
				    						"tooltip-text":"%v",
				    						"bars-space-left":"15%",
				    						"bars-space-right":"15%"
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
				    						"format":"%v",
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
				    							"text":"Last Year",
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
						
							for(var i=0;i<data.length;i++){
								LastAct.push((data[i].sumLastYearActualMONTHLY!=null && data[i].sumLastYearActualMONTHLY.length>0)?data[i].sumLastYearActualMONTHLY:"0.00");
								ThisAct.push((data[i].sumThisYearActualMonthly!=null && data[i].sumThisYearActualMonthly.length>0)?data[i].sumThisYearActualMonthly:"0.00");
								Target.push((data[i].sumThisYearBudgetMONTHLY!=null && data[i].sumThisYearBudgetMONTHLY.length>0)?data[i].sumThisYearBudgetMONTHLY:"0.00");
							}
							$("#"+graph_id).html("");
				    		/* $("#"+graph_id+"_legend").html("<a href=\""+_path+"/Dashboard/FinancePopup.jsp?topic="+gTypeG[graphIndex]+"\" rel=\"facebox\">"+
				     				"<img src=\""+_path+"//Dashboard/images/Popup.jpg\" border=\"0\"/> <font color=\"blue\" size=\"1\">Drill Down</font>"+
		     			    "</a>");   */
		     			   $("#"+graph_id+"_legend").html("");  
				    		scale_x.push(graph_label);
				    		mix_data.graphset[0].series[0].values=LastAct;
				    		mix_data.graphset[0].series[1].values=ThisAct;
				    		mix_data.graphset[0].series[2].values=Target;
				    		//mix_data.graphset[0].scale-x.values=scale_x;
				    		mix_data.graphset[0]["scale-x"].values=scale_x;
							//alert("xx="+scale_x) 
							render_zingchart(graph_id,mix_data,190,230);
						}
						else {
							$("#"+graph_id).html("");
							$("#"+graph_id+"_legend").html("");
						} 
					}
 			 });
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
	<span id="financeYearElement" style="position:absolute; left:15px; top:20px;">
	</span> 
	<!--          Drop Down List MONTH              -->
	<span id="financeMonthElement" style="position:absolute; left:125px; top:20px;">
	</span>
	<!--          Drop Down List             -->
	<span style="position:absolute; left:300px; top:20px;"><font size="3"> สรุปตาม: </font>
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
	<span style="position:absolute; left:650px; top:21px;">
		<input type="button" value=" OK " onClick="goUrl()"/></span>
<!-- End Parameter -->

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">ในประเทศ</a></li>
		<%--
		<li><a href="#tabs-2">ต่างประเทศ</a></li>
		 --%>
	</ul>
<div id="tabs-1">
<table>
<tr>
<td>
  <table id=tabs-ratio width=220px>
	<tr>
	  <td><span id="fnancial_indicator_Display"></span>
		<!-- Table Data -->
		<%--
		<ul>
		  <li><a href="#tabs">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial Indicator&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp</a></li>
		</ul>

		<table id=table-data>
		  <tr>
			<th bgcolor=#CD853F colspan=3><font color="#FFFFFF"> </font></th>
		  </tr>

		  <!-- Data -->

		  <tr>
			<th colspan=3> Profitablity Ratio </th>
		  </tr>
		  <tr>
			<td>Gross Profit Margin </td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">44.94 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Net Profit Margin </font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">7.16 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">EBITDA Margin </font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">00</font></td>
		  </tr>
		  <tr>
			<td><font size="2">EBIT Margin </font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">00</font></td>
		  </tr>
		  <tr>
			<td><font size="2">Return on Equity</font></td>
			<td></td>
			<td><font size="2">00</font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Operating Efficiency</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Return on Assets</font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Return on Fixed Assets </font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Leverage Ratio</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Current Ratio</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Quick Ratio</font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Debt to Equity Ratio (Times)</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Turnover Ratio</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">A/R Day</font></td>
			<td> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">A/P Day</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Inventory Day</font></td>
			<td> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Growth Rates
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Sales and Service Income</font></td>
			<td> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Gross Profit</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Net Profit</font></td>
			<td><font size="2"><img src=images/down1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Total Assets</font></td>
			<td> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Per Share Data</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Book Value per Share (Bt.)</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Earnings per Share (Bt.)</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <!-- End Data -->
		</table>
             --%>
		<!-- End Table -->
	  </td>
	</tr>
  </table>
</td>

<td>
  <table id=tabs-table2 width=800px style="position:absolute; left:242px; top:45px;" bordercolor="#000000" frame="box" rules="all">

  <tr><td><table>
  <tr bgcolor="#8B4513">
  <td>
	<div align=center><font color="#FFE742" size="3"><b>บริษัทเอส แอน พี ซินดิเคท จำกัด (มหาชน)</b></font></div>
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
	<td valign="middle" align="center">
	   <%--
		<div id="gSales"></div>ddd
		<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		 --%>
		 <div id="gSales"></div>
	    <div id="gSales_legend"></div>
	</td>
	<td valign="middle"><table><tr>
		<td align="center">
		 <%--
		 <div id="gProfit_1"></div>
			<a href="Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
				<img src="Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			 --%>
			<div id="gProfit_1"></div>
	        <div id="gProfit_1_legend"></div>
		</td>
		<td align="center">
		 <%-- 
		  <div id="gProfit_2"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			--%>
			<div id="gProfit_2"></div>
	        <div id="gProfit_2_legend"></div>
		</td>
		<td align="center">
		  <%--
		    <div id="gProfit_3"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			 --%>
			<div id="gProfit_3"></div>
	        <div id="gProfit_3_legend"></div>
		</td>
	</tr></table></td>
	<td valign="middle" align="center">
	 <%--
		<div id="g2"></div>
		<a href="/Dashboard/FinancePopupPer.jsp?topic=%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย" rel="facebox">
			<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		 --%>
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
	  <td bgcolor="#CD853F"><font size="3" color="#FFFFFF"><div align=center>%Sales Growth salesP</div></font></td>
  </tr>

  <tr>
	<td valign="top" align="center"><div id="g3"></div></td>
	<td valign="top">
		<!--------------------------- Print Button BACK --------------------------->
		<div id="g4"></div>
	</td>
  </tr>
  </table></td></tr>
  </table></td></tr>

  </table>
</td></tr>
</table>

<!-- -->
<div style=" position:absolute; top:799px; left:242px;">
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
		  <td valign="middle" align="center">
		 
	        <div id="gSales_Restaurant"></div>
	       <div id="gSales_Restaurant_legend"></div>
		   <%--
			<div id="gSales1"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			 --%>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"> 
	             <div id="gProfit_1_Restaurant"></div>
	             <div id="gProfit_1_Restaurant_legend"></div>
			    <%-- 
			    <div id="gProfitRest1"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				--%>
			</td>
			<td align="center"> 
	             <div id="gProfit_2_Restaurant"></div>
	             <div id="gProfit_2_Restaurant_legend"></div>
	             <%--
			<div id="gProfitRest2"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
			<td align="center"> 
	             <div id="gProfit_3_Restaurant"></div>
	 	         <div id="gProfit_3_Restaurant_legend"></div>
	 	         <%-- 
			    <div id="gProfitRest3"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				--%>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gRestaurant"></div>
			 <div id="gRestaurant_legend"></div>
			 <%--
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			 --%>
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
				<td valign="middle" align="center"> 
			<div id="gSales_Bakery"></div>
	 	    <div id="gSales_Bakery_legend"></div>
			<%--
			<div id="gSales2"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			 --%>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"> 
	            <div id="gProfit_1_Bakery"></div>
	 	        <div id="gProfit_1_Bakery_legend"></div>
	 	        <%--
			  <div id="gProfit4"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
			<td align="center">
	            <div id="gProfit_2_Bakery"></div>
	 	        <div id="gProfit_2_Bakery_legend"></div>
	 	        <%-- 
			   <div id="gProfit5"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				--%>
			</td>
			<td align="center">
			    <div id="gProfit_3_Bakery"></div>
	 	        <div id="gProfit_3_Bakery_legend"></div>
	 	        <%--
			    <div id="gProfit6"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
		    <div id="gBakery"></div>
			 <div id="gBakery_legend"></div>
			 <%--
			<div id="gC2"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			 --%>
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
	<%--
	<tr>
	
	<td>&nbsp;&nbsp;Drill Down : 
		<select name="speciatly">
			<option value="1">สินค้า</option>
			<option value="2">ประเภทร้านค้า</option>
		</select>&nbsp;&nbsp;
		<input type="submit" name="ok" value=" OK "/>
	</td>
	
	 </tr>
 --%>
	<tr><td>
	<table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center">  
	        <div id="gSales_Specialty"></div>
	 	    <div id="gSales_Specialty_legend"></div>
	 	    <%--
			<div id="gSales3"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			 --%>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"> 
	            <div id="gProfit_1_Specialty"></div>
	 	        <div id="gProfit_1_Specialty_legend"></div>
			    <%--
			    <div id="gProfit7"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
			<td align="center">  
	            <div id="gProfit_2_Specialty"></div>
	 	        <div id="gProfit_2_Specialty_legend"></div>
	 	        <%--
			    <div id="gProfit8"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
			<td align="center"> 
	            <div id="gProfit_3_Specialty"></div>
	 	        <div id="gProfit_3_Specialty_legend"></div>
	 	        <%--
			    <div id="gProfit9"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
		    <div id="gSpecialty"></div>
			 <div id="gSpecialty_legend"></div>
			 <%--
			<div id="gC3"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			--%>
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
	<%--
	<tr>
	
	<td>&nbsp;&nbsp;Drill Down : 
		<select name="speciatly">
			<option value="1">สินค้า</option>
			<option value="2">ช่องทางการขาย</option>
		</select>&nbsp;&nbsp;
		<input type="submit" name="ok" value=" OK "/><p></p>
	</td>
	 </tr>
--%>
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
				<td valign="middle" align="center">  
	        <div id="gSales_Trading"></div>
	 	    <div id="gSales_Trading_legend"></div>
	 	    <%--
			<div id="gSales4"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			 --%>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"> 
	        <div id="gProfit_1_Trading"></div>
	 	    <div id="gProfit_1_Trading_legend"></div>
	 	     <%--
			  <div id="gProfit10"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
			<td align="center"> 
	        <div id="gProfit_2_Trading"></div>
	 	    <div id="gProfit_2_Trading_legend"></div>
	 	       <%--  
			    <div id="gProfit11"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				--%>
			</td>
			<td align="center"> 
	            <div id="gProfit_3_Trading"></div>
	 	        <div id="gProfit_3_Trading_legend"></div>
	 	        <%--
			    <div id="gProfit12"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				--%>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
		 <div id="gTrading"></div>
			 <div id="gTrading_legend"></div>
			 <%--
			<div id="gC4"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			--%>
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
				<td valign="middle" align="center">
	 	         <div id="gSales_Caterman"></div>
	 	    <div id="gSales_Caterman_legend"></div>
	 	        <%--
			<div id="gSales5"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			 --%>
		</td>
		<td valign="middle"><table><tr>
			<td align="center">  
			 <div id="gProfit_1_Caterman"></div>
	 	        <div id="gProfit_1_Caterman_legend"></div>
	 	        <%--
			<div id="gProfit13"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
			<td align="center">  
			    <div id="gProfit_2_Caterman"></div>
	 	        <div id="gProfit_2_Caterman_legend"></div>
	 	        <%--
			    <div id="gProfit14"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
			<td align="center">  
			    <div id="gProfit_3_Caterman"></div>
	 	        <div id="gProfit_3_Caterman_legend"></div>
	 	        <%--
			<div id="gProfit15"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
		<div id="gCaterman"></div>
			 <div id="gCaterman_legend"></div>
			 <%--
			<div id="gC5"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			--%>
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
		<td valign="middle" align="center"> 
	            <div id="gSales_Other"></div>
	 	        <div id="gSales_Other_legend"></div> 
	 	        <%--
		<div id="gSales6"></div>
		<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		 --%>
		</td>
		<td valign="middle"><table><tr>
			<td align="center">  
			   <div id="gProfit_1_Other"></div>
	 	        <div id="gProfit_1_Other_legend"></div>
	 	        <%--
	 	        <div id="gProfit16"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
			<td align="center">  
			   <div id="gProfit_2_Other"></div>
	 	        <div id="gProfit_2_Other_legend"></div>
	 	        <%--
			    <div id="gProfit17"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
			<td align="center"> 
			   <div id="gProfit_3_Other"></div>
	 	        <div id="gProfit_3_Other_legend"></div>
	 	        <%--
			   <div id="gProfit18"></div>
				<a href="/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
				 --%>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
		<div id="gOther"></div>
			 <div id="gOther_legend"></div>
			 <%--
			<div id="gC6"></div>
			<a href="/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
			--%>
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
</div>
<!-- Tab ต่างประเทศ -->
</body>
</html>

