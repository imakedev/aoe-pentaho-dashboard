<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Operation Dashboard Page</title>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart_op/zingchart-html5-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart_op/license.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart_op/zingchart-html5-patterns-min.js"></script> 
	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet" />	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.min.js"></script>
<!--  DWR -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwrfinancedashboard/interface/BalanceScorecardAjax.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwrfinancedashboard/engine.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwrfinancedashboard/util.js"></script>
	<script type="text/javascript">
	var positionGrowths_key=["V-20","V-10-20","V-01-10","V1","V_01_10","V_10_20","V_20"];
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,"");
	} 
	function checkNULL(strValue){ 
		return (strValue!=null)?strValue:"";
	}
	function testProc(){ 
		BalanceScorecardAjax
				.callPROC("{call  proc_op_tab_summary_MTD_YTD('MTD','2011-01-01')}",{
					callback : function(data) {
						 if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
							//	alert(data[i][0]);
								//mySelect.add(new Option(data[i], data[i]));
							}
						}  
					}
				});
	}
	function render_chart(id,width,height,data){
		zingchart.render({
			id 			: id,
			width 		: width,
			height 		: height,
			data 		: data
		});
	}
	function map_part1(){     
		var str="<table bordercolor=\"#000000\" frame=\"box\" rules=\"all\" width=100%>"
			+"<tr bgcolor=\"#CD853F\">"
				+"<th rowspan=2 align=center><font color=\"#FFFFFF\">ภาค</font></th>" 
				+"<th align=center colspan=2><font color=\"#FFFFFF\">ยอดขาย</font></th>"
				+"<th rowspan=2><font color=\"#FFFFFF\">%Growth</font></th>"
			+"</tr>"
			+"<tr bgcolor=\"#CD853F\">"
			+"<th align=center><font color=\"#FFFFFF\">Dec 53</font></th>"
			+"<th align=center><font color=\"#FFFFFF\">Dec 54</font></th>" 
			+"</tr>"; 
			var sumBy=$('select[name="SumBy"]').val();
			var year=$('select[name="Year"]').val();
			var month=$('select[name="Month"]').val(); 
			// call proc_op_tab_map_region_growth('MTD','2011-01-01');
			var proc_str="{call  proc_op_tab_map_region_growth('"+sumBy+"','"+year+"-"+month+"-01')}"; 
			BalanceScorecardAjax 
			.callPROC(proc_str,{
				callback : function(data) {
					//alert(data.length )
					if (data != null && data.length > 0) {
						//alert("in to this")
						for ( var i = 0; i < data.length; i++) {  
							str=str+"<tr>"+
									"	<td align=center>"+checkNULL(data[i][0])+"</td>"+
									"	<td align=center>"+ checkNULL(data[i][1])+"</td>"+
									"	<td align=center>"+ checkNULL(data[i][2])+"</td>"+
									"	<td align=center>"+ checkNULL(data[i][3])+"</td>"+
									"</tr>";  
						}
						str=str+"</table> ";
						  
					}else{
						str=str+"</table> ";  
					} 
					$("#map_part1_table").html(str);
					
				 }
			});
	}
	function map_part2(){   
		// not have lat long
	}
	function detail_part3_box2(){ //Discount
		//$("#summary_part3_"+tab+"_table").html("");
		$("#g8").html("");
		var sumBy=$('select[name="SumBy"]').val();
		var year=$('select[name="Year"]').val();
		var month=$('select[name="Month"]').val(); 
		var division=$('select[name="Division"]').val();
		var section=$('select[name="Section"]').val();
		var zone=$('select[name="Zone"]').val(); 
		var major=$('select[name="Major"]').val(); 
		 //call proc_op_tab_detail_discount('MTD','2011-01-01','N/A','N/A','NA','')
		var proc_str="{call proc_op_tab_detail_discount('"+sumBy+"','"+year+"-"+month+"-01','"+division+"','"+section+"','"+zone+"','"+major+"')}";
		//var scale_x_values=[];
		var series_values_1=new Array();
		var series_values_2=new Array();
		var series_values_3=new Array();
		  
		BalanceScorecardAjax
		.callPROC(proc_str,{
			callback : function(data) {
				//alert("xx="+data);
				 if (data != null && data.length > 0) {
					for ( var i = 0; i < data.length; i++) {
						//scale_x_values.push(checkNULL(data[i][0]));
						 // "values" : [11,,],
						series_values_1=[checkNULL(data[i][1]),"",""];
						
						//"values" : [,42,],
						series_values_2=["",checkNULL(data[i][0]),""];
						
						//"values" : [,,23],
						series_values_3=["","",checkNULL(data[i][3])];
					}
					//alert("positionGrowths_value="+positionGrowths_value)
					var barDiscount_data = {
				"graphset":[
				{
				    "background-color":"#FFFFFF",
				    "type" : "bar",
					"stacked" : true,
					"chart" : {
						"margin" : "10 50 30 50"
					},
					"scale-x" : {
						"values":["Last Year","This Year","Plan"],
						"guide":{
				    		"line-width": 1,
				    		"alpha": 1
				    	},
						"tick":{
							"line-width": 3
						}
				     },
				    "scale-y" : {
						"min-value": 0,
						"format" : "%v",
						"thousands-separator":",",
						"guide":{
							"line-width": 1,
							"alpha": 1
						},
						"tick":{
							"line-width": 3
						}
				     },
					"plot":{
						"bars-space-left":"30%",
						"bars-space-right":"30%",
						"bar-width":"25px",
					},
				    "series" : [
				     {
				        "values" : series_values_1,
						 "background-color" : "#66CC00", 
						 "text" : "Last Year"
				     },
				     {
				        "values" : series_values_2,
						 "background-color" : "#EEEE00",
						 "text" : "This Year"
				     },
				     {
				        "values" :series_values_3,
						 "background-color" : "#696969",
						 "text" : "Plan"
				     }] 
				  }]
				};
					// var jsonStr = JSON.stringify(summary_part3_bar1);
					  //alert(jsonStr)
					  //var options = '{"data": ' + jsonStr + '}';
					 // zingchart.exec('g_'+tab, 'setdata', options); 
					 render_chart('g8',450,235,barDiscount_data); 
						 }else{ 
							 $("#g8").html("Not have Data");
						 }
				 }  
		});
		

	} 
	function detail_part3_box1(){

		
		//$("#summary_part3_"+tab+"_table").html("");
		$("#g7").html("");
		var sumBy=$('select[name="SumBy"]').val();
		var year=$('select[name="Year"]').val();
		var month=$('select[name="Month"]').val(); 
		var division=$('select[name="Division"]').val();
		var section=$('select[name="Section"]').val();
		var zone=$('select[name="Zone"]').val(); 
		var major=$('select[name="Major"]').val(); 
		//call proc_op_tab_detail_sales_by_sales_type('MTD','2011-01-01','N/A','N/A','NA','')
		var proc_str="{call proc_op_tab_detail_sales_by_sales_type('"+sumBy+"','"+year+"-"+month+"-01','"+division+"'"
				+",'"+section+"','"+zone+"','"+major+"')}";
		var scale_x_values=[];
		var series_values_1=[];
		var series_values_2=[];
		var series_values_3=[];
		  
		BalanceScorecardAjax
		.callPROC(proc_str,{
			callback : function(data) {
				//alert("xx="+data);
				 if (data != null && data.length > 0) {
					for ( var i = 0; i < data.length; i++) {
						//["THU", "FRI", "SAT", "SUN", "MON", "TUE", "WED"]
						scale_x_values.push(checkNULL(data[i][0]));
						series_values_1.push(checkNULL(data[i][1]));
						series_values_2.push(checkNULL(data[i][2]));
						 
					}
					//alert("positionGrowths_value="+positionGrowths_value)
							var stackedSales_data = {
				"graphset":[
				    {
				        "type":"bar",
						"stacked": true,
				        "background-color":"#FFFFFF",
				        "chart" : {
						"margin" : "10 105 30 50"
					},
					 "legend":{
						"background-color": "#FFFFFF",
						"border-width": "2px",
						"border-color": "#4C77B6",
						"layout":"x1",
						"x" : 410,
						"y" : 40,
						"item":{
							"font-color":"#000000"
						}
				    },
					"scale-x" : {
						//"values":["THU", "FRI", "SAT", "SUN", "MON", "TUE", "WED"],
						"values":scale_x_values,
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
				    "scale-y" : {
						"min-value": 0,
						"format" : "%v",
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
				     "scale-y-2":{ 
						"format":"%v%",     
				            "guide":{
				    			"line-width": 0,
				    			"alpha": 1
				    		},
							"tick":{
								"line-width": 3
							},
				            "item":{
				                "font-color":"#000000"
				            }
				    },
					"plot":{
						"bars-space-left":"25%",
						"bars-space-right":"25%",
						"bar-width":"25px"
					},
				    "series" : [
				     {
				        "values" : [25707.8,26524.6,26372.3,25273.8,23980.6,25652.4,26943,26367.4],
				       // "values" : [],
						"text" : "Eat In"
						//"background-color" : "#1E90FF"
				     },
				     {
				        "values" : [6944.6,6747.2,7020.5,6987.7,6772.4,6680.1,6897.1],
						"text" : "Take Away"
						//"background-color" : "#A020F0"
				     },
					 {
				        "values" : [3445.4,3423.8,3392.6,3399.1,3399.1,3369.5,3393.7],
						"text" : "HOD"
						//"background-color" : "#8bb934"
				     },
					 {
				         "values" : [1600.7,1523.6,1561.2,1578.7,1661.9,1688,1613.5],
						 "text" : "PINTO"
						 //"background-color" : "#FF4500"
				     },
				     {
				         "values" : [2600.7,2523.6,2561.2,2578.7,2661.9,2688,2613.5],
						 "text" : "WholeSales"
						 //"background-color" : "#4169E1"
				     }] 
				  }]
				};
					// var jsonStr = JSON.stringify(summary_part3_bar1);
					  //alert(jsonStr)
					  //var options = '{"data": ' + jsonStr + '}';
					 // zingchart.exec('g_'+tab, 'setdata', options); 
					 render_chart('g7',510,235,stackedSales_data); 
						 }else{ 
							 $("#g7").html("Not have Data");
						 }
				 }  
		});

	}
	function detail_part4_box2(tab){
		// tab   sales_sqm_day sales_staff_day seat_turn_day
		$("#g_"+tab).html("");
		var sumBy=$('select[name="SumBy"]').val();
		var year=$('select[name="Year"]').val();
		var month=$('select[name="Month"]').val(); 
		var division=$('select[name="Division"]').val();
		var section=$('select[name="Section"]').val();
		var zone=$('select[name="Zone"]').val(); 
		var major=$('select[name="Major"]').val(); 
		 //call proc_op_tab_detail_seat_turn_day('MTD','2011-01-01','N/A','N/A','NA','')
		var proc_str="{call proc_op_tab_detail_"+tab+"('"+sumBy+"','"+year+"-"+month+"-01','"+division+"','"+section+"','"+zone+"','"+major+"')}";
		//var scale_x_values=[];
		var series_values_1=new Array();
		var series_values_2=new Array();
		var series_values_3=new Array();
		  
		BalanceScorecardAjax
		.callPROC(proc_str,{
			callback : function(data) {
				//alert("xx="+data);
				 if (data != null && data.length > 0) {
					for ( var i = 0; i < data.length; i++) {
						//scale_x_values.push(checkNULL(data[i][0]));
						 // "values" : [11,,],
						series_values_1=[checkNULL(data[i][1]),"",""];
						
						//"values" : [,42,],
						series_values_2=["",checkNULL(data[i][0]),""];
						
						//"values" : [,,23],
						series_values_3=["","",checkNULL(data[i][3])];
					}
					//alert("positionGrowths_value="+positionGrowths_value)
					
var barSales2_data = {
  "graphset" : [
  {
	"background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","%Growth"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : series_values_1,
		"background-color":"#66CC00",
		"text":"MTD ปีที่แล้ว"
     },
     {
        "values" : series_values_2,
		"background-color":"#EEEE00",
		"text":"MTD ปีนี้"
     },
     {
        "values" : series_values_3,
		"background-color":"#696969",
		"text":"%Growth",
        "scales":"scale-x,scale-y-2"
     }] 
  }]
};

var barSales3_data = {
  "graphset" : [
  {
	"background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","%Growth"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : series_values_1,
		"background-color":"#66CC00",
		"text":"MTD ปีที่แล้ว"
     },
     {
        "values" : series_values_2,
		"background-color":"#EEEE00",
		"text":"MTD ปีนี้"
     },
     {
        "values" : series_values_3,
		"background-color":"#696969",
		"text":"%Growth",
        "scales":"scale-x,scale-y-2"
     }] 
  }]
};

var barSeat_data = {
  "graphset" : [
  {
	"background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","%Growth"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : series_values_1,
		"background-color":"#66CC00",
		"text":"MTD ปีที่แล้ว"
     },
     {
        "values" : series_values_1,
		"background-color":"#EEEE00",
		"text":"MTD ปีนี้"
     },
     {
        "values" : series_values_3,
		"background-color":"#696969",
		"text":"%Growth",
        "scales":"scale-x,scale-y-2"
     }] 
  }]
};

					// var jsonStr = JSON.stringify(summary_part3_bar1);
					  //alert(jsonStr)
					  //var options = '{"data": ' + jsonStr + '}';
					 // zingchart.exec('g_'+tab, 'setdata', options); 
					 // sales_sqm_day sales_staff_day seat_turn_day
					 //barSales2_data barSales3_data barSeat_data
					 var bar_data={};
					 if(tab=='sales_sqm_day')
						 bar_data=barSales2_data;
					 else if(tab=='sales_staff_day')
						 bar_data=barSales3_data;
					 else if(tab=='seat_turn_day')
						 bar_data=barSeat_data;
					 
					 render_chart('g_'+tab,400,235,bar_data); 
						 }else{ 
							 $("#g_"+tab).html("Not have Data");
						 }
				 }  
		});
	}
	function detail_part4_box1(tab){
		 // tab ==> average_check, customer_day,average_sales_bill
		//$("#summary_part3_"+tab+"_table").html("");
		
		//alert(tab)
		$("#g_"+tab).html("");
		var sumBy=$('select[name="SumBy"]').val();
		var year=$('select[name="Year"]').val();
		var month=$('select[name="Month"]').val(); 
		var division=$('select[name="Division"]').val();
		var section=$('select[name="Section"]').val();
		var zone=$('select[name="Zone"]').val(); 
		var major=$('select[name="Major"]').val(); 
		 //call proc_op_tab_detail_average_sales_bill('MTD','2011-01-01','N/A','N/A','NA','')
		var proc_str="{call proc_op_tab_detail_"+tab+"('"+sumBy+"','"+year+"-"+month+"-01','"+division+"','"+section+"','"+zone+"','"+major+"')}";
		//var scale_x_values=[];
		var series_values_1=new Array();
		var series_values_2=new Array();
		var series_values_3=new Array();
		  
		BalanceScorecardAjax
		.callPROC(proc_str,{
			callback : function(data) {
				//alert("xx="+data);
				 if (data != null && data.length > 0) {
					for ( var i = 0; i < data.length; i++) {
						//scale_x_values.push(checkNULL(data[i][0]));
						 // "values" : [11,,],
						series_values_1=[checkNULL(data[i][1]),"",""];
						
						//"values" : [,42,],
						series_values_2=["",checkNULL(data[i][0]),""];
						
						//"values" : [,,23],
						series_values_3=["","",checkNULL(data[i][3])];
					}
					//alert("positionGrowths_value="+positionGrowths_value)
					var barAvg_data = {
				  "graphset" : [
				  {
					"background-color":"#FFFFFF",
				    "type" : "bar",
					"stacked" : true,
					"chart" : {
						"margin" : "10 50 30 50"
					},
					"scale-x" : {
						"values":["Last Year","This Year","%Growth"],
						"guide":{
				    		"line-width": 1,
				    		"alpha": 1
				    	},
						"tick":{
							"line-width": 3
						}
				     },
				    "scale-y" : {
						"min-value": 0,
						"format" : "%v",
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
					"plot":{
						"bars-space-left":"30%",
						"bars-space-right":"30%",
						"bar-width":"25px",
					},
				    "series" : [
				     {
				        "values" :series_values_1,
						"background-color" : "#66CC00",
						"text":"MTD ปีที่แล้ว"
				     },
				     {
				        "values" : series_values_2,
						"background-color" : "#EEEE00",
						"text":"MTD ปีนี้"
				     },
				     {
				        "values" : series_values_3,
						"background-color" : "#696969",
						"text":"%Growth",
				        "scales":"scale-x,scale-y-2"
				     }] 
				  }]
				};
					
				var barCust_data = {
				  "graphset" : [
				  {
					"background-color":"#FFFFFF",
				    "type" : "bar",
					"stacked" : true,
					"chart" : {
						"margin" : "10 50 30 50"
					},
					"scale-x" : {
						"values":["Last Year","This Year","%Growth"],
						"guide":{
				    		"line-width": 1,
				    		"alpha": 1
				    	},
						"tick":{
							"line-width": 3
						}
				     },
				    "scale-y" : {
						"min-value": 0,
						"format" : "%v",
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
					"plot":{
						"bars-space-left":"30%",
						"bars-space-right":"30%",
						"bar-width":"25px",
					},
				    "series" : [
				     {
				        "values" : series_values_1,
						"background-color":"#66CC00",
						"text":"MTD ปีที่แล้ว"
				     },
				     {
				        "values" : series_values_2,
						"background-color":"#EEEE00",
						"text":"MTD ปีนี้"
				     },
				     {
				        "values" : series_values_3,
						"background-color":"#696969",
						"text":"%Growth",
				        "scales":"scale-x,scale-y-2"
				     }] 
				  }]
				};
				
				var barAvgs_data = {
				  "graphset" : [
				  {
					"background-color":"#FFFFFF",
				    "type" : "bar",
					"stacked" : true,
					"chart" : {
						"margin" : "10 50 30 50"
					},
					"scale-x" : {
						"values":["Last Year","This Year","%Growth"],
						"guide":{
				    		"line-width": 1,
				    		"alpha": 1
				    	},
						"tick":{
							"line-width": 3
						}
				     },
				    "scale-y" : {
						"min-value": 0,
						"format" : "%v",
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
					"plot":{
						"bars-space-left":"30%",
						"bars-space-right":"30%",
						"bar-width":"25px",
					},
				    "series" : [
				     {
				        "values" : series_values_1,
						"background-color":"#66CC00",
						"text":"MTD ปีที่แล้ว"
				     },
				     {
				        "values" : series_values_2,
						"background-color":"#EEEE00",
						"text":"MTD ปีนี้"
				     },
				     {
				        "values" : series_values_3,
						"background-color":"#696969",
						"text":"%Growth",
				        "scales":"scale-x,scale-y-2"
				     }] 
				  }]
				};
					// var jsonStr = JSON.stringify(summary_part3_bar1);
					  //alert(jsonStr)
					  //var options = '{"data": ' + jsonStr + '}';
					 // zingchart.exec('g_'+tab, 'setdata', options); 
					 var bar_data={};
					 if(tab=='average_check')
						 bar_data=barAvg_data;
					 else if(tab=='customer_day')
						 bar_data=barCust_data;
					 else if(tab=='average_sales_bill')
						 bar_data=barAvgs_data;
					 
					 render_chart('g_'+tab,400,235,bar_data); 
						 }else{ 
							 $("#g_"+tab).html("Not have Data");
						 }
				 }  
		});
	}
	function detail_part5_box2_load(){
		var detail_part5_box2_order=$("select[name=detail_part5_box2_order]").val();
		var detail_part5_box2_noOfShow=$("#detail_part5_box2_noOfShow").val();
		detail_part5_box2(detail_part5_box2_order,detail_part5_box2_noOfShow);
	}
	function detail_part5_box1_load(){
		var detail_part5_box1_order=$("select[name=detail_part5_box1_order]").val();
		var detail_part5_box1_noOfShow=$("#detail_part5_box1_noOfShow").val();
		detail_part5_box1(detail_part5_box1_order,detail_part5_box1_noOfShow);
	}
	function detail_part5_box2(order_by,noOfShow){ 
		 var str="<div class=\"top\">"
				+"<select name=\"detail_part5_box2_order\">"
				+"<option value=\"DESC\">ยอดขายสูงสุด</option>"
				+"<option value=\"ASC\">ยอดขายต่ำสุด</option>"
				+"</select>"
				+"<input type=\"text\" id=\"detail_part5_box2_noOfShow\" value=\"10\" size=\"1\">"
				+"<input type=\"button\" name=\"ok\" value=\" OK \" onclick=\"detail_part5_box2_load()\"/>"
				+"</div>"
				+"<br>"
				+"<table width=\"500\" align=\"center\" bordercolor=\"#000000\" frame=\"box\" rules=\"all\" bgcolor=\"#FFFFFF\">"
				+"<tr bgcolor=\"#CD853F\">"
				+"<th width=200><font color=\"#FFFFFF\">Product</font></th>"
				+"<th><font color=\"#FFFFFF\">ยอดขาย</font></th>"
				+"<th><font color=\"#FFFFFF\">เป้าหมาย</font></th>"
				+"<th><font color=\"#FFFFFF\">%เทียบเป้าหมาย</font></th>"
				+"<th><font color=\"#FFFFFF\">%เทียบยอดขายทั้งหมด</font></th>"
				+"</tr>";
				var sumBy=$('select[name="SumBy"]').val();
				var year=$('select[name="Year"]').val();
				var month=$('select[name="Month"]').val(); 
				var division=$('select[name="Division"]').val();
				var section=$('select[name="Section"]').val();
				var zone=$('select[name="Zone"]').val(); 
				var major=$('select[name="Major"]').val(); 
				//call proc_op_tab_detail_new_product('MTD','2011-01-01','N/A','N/A','NA','a','DESC','10')
		BalanceScorecardAjax 
				.callPROC("{call proc_op_tab_detail_new_product('"+sumBy+"','"+year+"-"+month+"-01',"
						+"'"+division+"','"+section+"','"+zone+"','"+major+"','"+order_by+"',"+noOfShow+")}",{
					callback : function(data) {
						//alert(data.length )
						if (data != null && data.length > 0) {
							//alert("in to this")
							for ( var i = 0; i < data.length; i++) { 
								str=str+"<tr>"+
										"	<td align=left>"+ checkNULL(data[i][0])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][1])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][2])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][3])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][4])+"</td>"+ 
										"</tr>"; 
							}
							
							str=str+"</table> ";
						}else
							str=str+"</table> "; 
						//	alert(str)
						
						$("#detail_part5_box2_table").html(str);
						$("select[name=detail_part5_box2_order]").val(order_by);
						$("#detail_part5_box2_noOfShow").val(noOfShow);
					}
				});	
	}
	function detail_part5_box1(order_by,noOfShow){ 
	
		 var str="<div class=\"top\">"
					+"<select name=\"detail_part5_box1_order\">"
					+"<option value=\"DESC\">ยอดขายสูงสุด</option>"
					+"<option value=\"ASC\">ยอดขายต่ำสุด</option>"
					+"</select>"
					+"<input type=\"text\" id=\"detail_part5_box1_noOfShow\" value=\"10\" size=\"1\">"
					+"<input type=\"button\" name=\"ok\" value=\" OK \" onclick=\"detail_part5_box1_load()\"/>"
					+"</div>"
					+"<br>"
					+"<table width=\"500\" align=\"center\" bordercolor=\"#000000\" frame=\"box\" rules=\"all\">"
					+"<tr bgcolor=\"#CD853F\">"
					+"<th width=200><font color=\"#FFFFFF\">Product</font></th>"
					+"<th><font color=\"#FFFFFF\">ยอดขายปีนี้</font></th>"
					+"<th><font color=\"#FFFFFF\">ยอดขายปีที่แล้ว</font></th>"
					+"<th><font color=\"#FFFFFF\">%เทียบปีที่แล้ว</font></th>"
					+"<th><font color=\"#FFFFFF\">%เทียบยอดขายทั้งหมด</font></th>"
					+"</tr>";
					var sumBy=$('select[name="SumBy"]').val();
					var year=$('select[name="Year"]').val();
					var month=$('select[name="Month"]').val(); 
					var division=$('select[name="Division"]').val();
					var section=$('select[name="Section"]').val();
					var zone=$('select[name="Zone"]').val(); 
					var major=$('select[name="Major"]').val(); 
					//call proc_op_tab_detail_selling_product('MTD','2011-01-01','N/A','N/A','NA','','DESC','10')
			BalanceScorecardAjax 
					.callPROC("{call proc_op_tab_detail_selling_product('"+sumBy+"','"+year+"-"+month+"-01',"
							+"'"+division+"','"+section+"','"+zone+"','"+major+"','"+order_by+"',"+noOfShow+")}",{
						callback : function(data) {
							//alert(data.length )
							if (data != null && data.length > 0) {
								//alert("in to this")
								for ( var i = 0; i < data.length; i++) { 
									str=str+"<tr>"+
											"	<td align=left>"+ checkNULL(data[i][0])+"</td>"+
											"	<td align=right>"+ checkNULL(data[i][1])+"</td>"+
											"	<td align=right>"+ checkNULL(data[i][2])+"</td>"+
											"	<td align=right>"+ checkNULL(data[i][3])+"</td>"+
											"	<td align=right>"+ checkNULL(data[i][4])+"</td>"+ 
											"</tr>"; 
								}
								
								str=str+"</table> ";
							}else
								str=str+"</table> "; 
							//	alert(str)
							
							$("#detail_part5_box1_table").html(str);
							$("select[name=detail_part5_box1_order]").val(order_by);
							$("#detail_part5_box1_noOfShow").val(noOfShow);
						}
					});	
	}
	function detail_part2(){   
		var sumBy=$('select[name="SumBy"]').val();
	 
		/* var str="<table width=300 bordercolor=\"#000000\" frame=\"box\" rules=\"all\">"
				+"<tr bgcolor=\"#CD853F\">"
					+"<th colspan=\"4\"><font color=\"#FFFFFF\">Change</font></th>" 
				+"</tr>"
				+"<tr bgcolor=\"#CD853F\">"
				+"<th width=\"100\"></th>"
				+"<th><font color=\"#FFFFFF\">MB</font></th>"
				+"<th><font color=\"#FFFFFF\">vs.LY</font></th>"
				+"<th><font color=\"#FFFFFF\">vs.Plan</font></th>"
				+"</tr>"; */
		//alert(str)
				//var sumBy=$('select[name="SumBy"]').val();
				var year=$('select[name="Year"]').val();
				var month=$('select[name="Month"]').val();
				var division=$('select[name="Division"]').val();
				var section=$('select[name="Section"]').val();
				var zone=$('select[name="Zone"]').val(); 
				var major=$('select[name="Major"]').val(); 
				
				var proc_str="{call  proc_op_tab_detail_"+tab+"_by_category('"+sumBy+"','"+year+"-"+month+"-01','"+division+"'"
						+",'"+section+"','"+zone+"','"+major+"')}";
				var json_series=[]; 
				//alert(proc_str);
		BalanceScorecardAjax 
				.callPROC(proc_str,{
					callback : function(data) {
						//alert(data.length )
						if (data != null && data.length > 0) {
							//alert("in to this")
							for ( var i = 0; i < data.length; i++) { 
								/* str=str+"<tr>"+
										"	<td align=left>"+checkNULL(data[i][0])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][1])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][3])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][2])+"</td>"+
										"</tr>";  */
								/* var values_array=[];
								     values_array.push(checkNULL(data[i][1]));
								var json_value={
								         	"values" : values_array,
										 	"text" : checkNULL(data[i][0]),
								 		 	"tooltip-text" : "%t: "+checkNULL(data[i][1])
								     	};
								json_series.push(json_value); */
							}
							//str=str+"</table> ";
							   
						//	alert(title)
							var margin=(sumBy=="YTD")?"\"10 155 30 70\"":"\"10 155 30 50\"";
							var scale_x=(sumBy=="YTD")?["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]:
								["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
							var MTD_value=[
								            {
								                "type":"bar",
								                "values":[2783,3674,2455,2565,4853,5622,4673,3879,4689,4214,6492,5116,5549,6077,4715,6921,3777,4390,5759,7247,9776,9629,9908,8311,8829,8348,8856,7675,7133,6332,9060],
								                "border-width":1,
												"stacked":0,
												"background-color" : "#66CC00",
												"border-color":"#66CC00",
								                "text":"Actual 09"
								            },
								            {
								                "type":"bar",
								                "values":[1872,2784,2251,1234,2356,3452,3754,4331,4521,5942,3562,4362,5674,5975,6842,6124,6743,7920,8940,7842,8592,9053,9583,9905,8032,9024,9371,9717,9044,9402,8495],
								                "text":"Actual 10",
												"stacked":0,
												"background-color" : "#EEEE00",
												"border-color":"#EEEE00",
								                "border-width":1
								            },
								            {
								                "type":"bar",
								                "values":[1872,2784,2251,1234,2356,3452,3754,4331,4521,5942,3562,4362,5674,5975,6842,6124,6743,7920,8940,7842,8592,9053,9583,9905,8032,9024,9371,9717,9044,9402,8495],
								                "text":"Target",
												"stacked":0,
												"background-color" : "#696969",
												"border-color":"#696969",
								                "border-width":1
								            },
											{
								                "type":"line",
								                "values":[21,31,41,47,47,54,54,54,56,56,57,57,57,57,57,58,58,58,58,58,59,59,59,60,60,62,63,63,65,67,67],
								                "text":"%Actaul/<br>Target",
								                "scales":"scale-x,scale-y-2",
								                "stacked":0,
												"line-color" : "#FF6600",
								                "marker":{
								                    "size":3
								                },
								                "tooltip-text":"%v%"
								            },
								            {
								                "type":"line",
								                "values":[20,21,24,29,30,31,32,34,35,35,36,40,40,40,42,45,46,48,50,50,52,56,57,57,58,58,60,62,62,64,65],
								                "text":"%Growth",
								                "scales":"scale-x,scale-y-2",
								                "stacked":"0",
												"line-color" : "#3860BB",
								                "marker":{
								                    "size":3
								                },
								                "tooltip-text":"%v%"
								            }];
							var YTD_value=[
								            {
								                "type":"bar",
								                "values":[1048726,1917776,1962904,2008033,1653161,1518290,2143418,2188546,1633675,2278803,3323932,2769060],
								                "border-width":1,
												"stacked":0,
												"background-color" : "#66CC00",
												"border-color":"#66CC00",
								                "text":"Actual YTD 09"
								            },
								            {
								                "type":"bar",
								                "values":[1148726,1517776,1762904,2438033,2053161,1718290,1843418,1488546,2633675,1978803,2323932,2669060],
								                "text":"Actual YTD 10",
												"stacked":0,
												"background-color" : "#EEEE00",
												"border-color":"#EEEE00",
								                "border-width":1
								            },
											{
								                "type":"bar",
								                "values":[1184478,1524298,1553528,1754042,1798656,1879170,2014555,2088913,2359684,2473785,2669427,2704812],
								                "text":"Target YTD",
												"stacked":0,
												"background-color" : "#696969",
												"border-color":"#696969",
								                "border-width":1
								            },
								            {
								                "type":"line",
								                "values":[42,47,48,48,48,50,51,52,52,58,67,67],
								                "text":"%Actaul YTD/<br>Target YTD",
								                "scales":"scale-x,scale-y-2",
								                "stacked":0,
												"line-color" : "#FF6600",
								                "marker":{
								                    "size":3
								                },
								                "tooltip-text":"%v%"
								            },
											{
								                "type":"line",
								                "values":[50,52,56,57,57,58,58,60,62,62,64,65],
								                "text":"%Growth YTD",
								                "scales":"scale-x,scale-y-2",
								                "stacked":"0",
												"line-color" : "#3860BB",
								                "marker":{
								                    "size":3
								                },
								                "tooltip-text":"%v%"
								            }];
							
							var series_values=(sumBy=="YTD")?YTD_value:MTD_value;
							var mixed_data = {
									"graphset":[
									    {
											"background-color":"#FFFFFF",
									        "type":"mixed",
									        "chart":{
												"margin":margin
									        },
											"legend":{
									            "margin":"40 10 20 755",
									            "layout":"5x",
									            "border-width": "2px",
												"border-color": "#4C77B6",
									            "item":{
									                "font-color":"#000000"
									            }
									        },
									        "scale-x":{
									            "values":scale_x,
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
									            "min-value": 0,
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
									        "scale-y-2":{
												"min-value": 0,
									            "format":"%v%",     
									            "guide":{
									    			"line-width": 0,
									    			"alpha": 1
									    		},
												"tick":{
													"line-width": 3
												},
									            "item":{
									                "font-color":"#000000"
									            }
									        }, 
									        "series":series_values
									        }]
									    }; 
									     
							//render_chart('g6',870,350,mixed_data);
							$("#g_"+tab).html("Not have Data");
						}else{
							str=str+"</table> "; 
							$("#g_"+tab).html("Not have Data");
						} 
						$("#detail_part1_"+tab+"_table").html(str);
						
					 }
				});
	}
	function detail_part1(tab){
		// tab is net_sales , cost   
		var str="<table width=300 bordercolor=\"#000000\" frame=\"box\" rules=\"all\">"
				+"<tr bgcolor=\"#CD853F\">"
					+"<th colspan=\"4\"><font color=\"#FFFFFF\">Change</font></th>" 
				+"</tr>"
				+"<tr bgcolor=\"#CD853F\">"
				+"<th width=\"100\"></th>"
				+"<th><font color=\"#FFFFFF\">MB</font></th>"
				+"<th><font color=\"#FFFFFF\">vs.LY</font></th>"
				+"<th><font color=\"#FFFFFF\">vs.Plan</font></th>"
				+"</tr>";
		//alert(str)
				var sumBy=$('select[name="SumBy"]').val();
				var year=$('select[name="Year"]').val();
				var month=$('select[name="Month"]').val();
				var division=$('select[name="Division"]').val();
				var section=$('select[name="Section"]').val();
				var zone=$('select[name="Zone"]').val(); 
				var major=$('select[name="Major"]').val(); 
				
				var proc_str="{call  proc_op_tab_detail_"+tab+"_by_category('"+sumBy+"','"+year+"-"+month+"-01','"+division+"'"
						+",'"+section+"','"+zone+"','"+major+"')}";
				var json_series=[]; 
				//alert(proc_str);
		BalanceScorecardAjax 
				.callPROC(proc_str,{
					callback : function(data) {
						//alert(data.length )
						if (data != null && data.length > 0) {
							//alert("in to this")
							for ( var i = 0; i < data.length; i++) { 
								str=str+"<tr>"+
										"	<td align=left>"+checkNULL(data[i][0])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][1])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][3])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][2])+"</td>"+
										"</tr>"; 
								var values_array=[];
								     values_array.push(checkNULL(data[i][1]));
								var json_value={
								         	"values" : values_array,
										 	"text" : checkNULL(data[i][0]),
								 		 	"tooltip-text" : "%t: "+checkNULL(data[i][1])
								     	};
								json_series.push(json_value);
							}
							str=str+"</table> ";
							 
							var title=(tab=="net_sales")?"Net Sales by Category":"Cost by Category";  
						//	alert(title)
							 
							var pie_data = {
									  "graphset" : [
									  {
										"title":{
											"text": title,
											"background-color":"#FFFFFF",
											"color": "#000000",
										},
										"background-color":"#FFFFFF",
									    "type" : "pie",
										"chart":{
											"margin":"35 0 65 0"
									    },
										"legend":{
											"background-color": "#FFFFFF",
											"border-width": "2px",
											"border-color": "#4C77B6",
											"layout":"2x",
											"width":230,
											"x":0,
											"y":210
										},	
										"scale" : {
											"size-factor" : 1.0
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
										},
									    "series" : json_value
									  }]
									};  
							render_chart('g_'+tab,235,270,pie_data);
							 
						}else{
							str=str+"</table> "; 
							$("#g_"+tab).html("Not have Data");
						} 
						$("#detail_part1_"+tab+"_table").html(str);
						
					 }
				});
	}
	function summary_part2_tab2(order_by){
		 var order_by=$("select[id=summary_part2_tab2_arrange_element]").val();
		 var render_id= "summary_part2_tab2_element";
		 var noOfShow=$("#summary_part2_tab2_noOfShow_element").val(); 
		 var str="<table  bordercolor=\"#000000\" frame=\"box\" rules=\"all\">"+
					"<tr bgcolor=\"#CD853F\">"+
						"<th width=\"50\"><font color=\"#FFFFFF\">#</font></th>"+
						"<th width=\"150\"><font color=\"#FFFFFF\">สาขา</font></th>"+
						"<th width=\"70\"><font color=\"#FFFFFF\">ยอดขาย</font></th>"+
						"<th width=\"100\"><font color=\"#FFFFFF\">Last ยอดขาย</font></th>"+
						"<th width=\"100\"><font color=\"#FFFFFF\">Diff ยอดขาย</font></th>"+
						"<th width=\"70\"><font color=\"#FFFFFF\">% Growth</font></th>"+
					"</tr>";
					var sumBy=$('select[name="SumBy"]').val();
					var year=$('select[name="Year"]').val();
					var month=$('select[name="Month"]').val(); 
					BalanceScorecardAjax 
					.callPROC("{call proc_op_tab_summary_sales_growth('"+sumBy+"','"+year+"-"+month+"-01','"+order_by+"',"+noOfShow+")}",{
						callback : function(data) {
							//alert(data.length )
							if (data != null && data.length > 0) {
								//alert("in to this")
								for ( var i = 0; i < data.length; i++) { 
									str=str+"<tr>"+
											"	<td align=center>"+(i+1)+"</td>"+
											"	<td align=left>"+ data[i][0]+"</td>"+
											"	<td align=right>"+ checkNULL(data[i][1])+"</td>"+
											"	<td align=right>"+ checkNULL(data[i][2])+"</td>"+
											"	<td align=right>"+ checkNULL(data[i][3])+"</td>"+
											"	<td align=right>"+ checkNULL(data[i][4])+"</td>"+ 
											"</tr>"; 
								}
								
								str=str+"</table> ";
							}else
								str=str+"</table> "; 
							//	alert(str)
							
							$("#"+render_id).html(str);
						}
					});			  
	}
	function summary_part2_tab1(order_by){
		//call proc_op_tab_summary_profit('MTD','N/A','N/A','NA','2011-01-01','DESC',10) 
	    var render_id= (order_by=='DESC')?"Summary_Profit_max_element":"Summary_Profit_min_element";
		var noOfShow=(order_by=='DESC')?$("#Summary_Profit_noOfShow_max_element").val():$("#Summary_Profit_noOfShow_min_element").val();
		var str="<p></p><table width=500 bordercolor=\"#000000\" frame=\"box\" rules=\"all\">"
				+"<tr bgcolor=\"#CD853F\">"
					+"<th><font color=\"#FFFFFF\">#</font></th>"
					+"<th><font color=\"#FFFFFF\">สาขา</font></th>"
					+"<th><font color=\"#FFFFFF\">กำไร (บาท)</font></th>"
					+"<th><font color=\"#FFFFFF\">% GP</font></th>"
				+"</tr>";
				var sumBy=$('select[name="SumBy"]').val();
				var year=$('select[name="Year"]').val();
				var month=$('select[name="Month"]').val();
				var division=$('select[name="Division"]').val();
				var section=$('select[name="Section"]').val();
				var zone=$('select[name="Zone"]').val(); 
				BalanceScorecardAjax 
				.callPROC("{call proc_op_tab_summary_profit('"+sumBy+"','"+division+"','"+section+"','"+zone+"','"+year+"-"+month+"-01','"+order_by+"',"+noOfShow+")}",{
					callback : function(data) {
						//alert(data.length )
						if (data != null && data.length > 0) {
							//alert("in to this")
							for ( var i = 0; i < data.length; i++) { 
								str=str+"<tr>"+
										"	<td align=center>"+(i+1)+"</td>"+
										"	<td align=left>"+ checkNULL(data[i][0])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][1])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][2])+"</td>"+
										"</tr>";
							}
							str=str+"</table> ";
						}else
							str=str+"</table> "; 
						//	alert(str)
						
						$("#"+render_id).html(str);
					}
				});
		 
	}
	/* function summary_part3(type){
		
	} */
	function summary_part3_table(tab,positionsGrowth){
		var header_str=(tab=="sales")?"ยอดขาย":"EBIT";
	   // var proc_tab=(tab=="sales")?"ยอดขาย":"EBIT";
		//call proc_op_tab_summary_profit('MTD','N/A','N/A','NA','2011-01-01','DESC',10) 
	  /*   var render_id= (order_by=='DESC')?"Summary_Profit_max_element":"Summary_Profit_min_element";
		var noOfShow=(order_by=='DESC')?$("#Summary_Profit_noOfShow_max_element").val():$("#Summary_Profit_noOfShow_min_element").val();
		 */ 
		var str="<table width=\"100%\" bordercolor=\"#000000\" frame=\"box\" rules=\"all\">"
				+"<tr bgcolor=\"#CD853F\">"
				+"  <th width=20px><font color=\"#FFFFFF\">#</font></th>"
				+"  <th width=80px><font color=\"#FFFFFF\">สาขา</font></th>"
				+"  <th width=150px><font color=\"#FFFFFF\">"+header_str+"</font></th>"
				+"  <th width=150px><font color=\"#FFFFFF\">Last ยอดขาย</font></th>"
				+"  <th width=150px><font color=\"#FFFFFF\">Diff ยอดขาย</font></th>"
				+"  <th width=70px><font color=\"#FFFFFF\">% Growth</font></th>"
				+"</tr>";
				var sumBy=$('select[name="SumBy"]').val();
				var year=$('select[name="Year"]').val();
				var month=$('select[name="Month"]').val();
				/* var division=$('select[name="Division"]').val();
				var section=$('select[name="Section"]').val();
				var zone=$('select[name="Zone"]').val();  */
				BalanceScorecardAjax 
				.callPROC("{call proc_op_tab_summary_"+tab+"_day_table('"+sumBy+"','"+year+"-"+month+"-01','"+positionsGrowth+"')}",{
					callback : function(data) {
						//alert(data.length )
						if (data != null && data.length > 0) {
							//alert("in to this")
							for ( var i = 0; i < data.length; i++) { 
								str=str+"<tr>"+
										"	<td align=center>"+(i+1)+"</td>"+
										"	<td align=left>"+ checkNULL(data[i][1])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][2])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][3])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][4])+"</td>"+
										"	<td align=right>"+ checkNULL(data[i][5])+"</td>"+ 										
										"</tr>";
							}
							str=str+"</table> ";
						}else
							str=str+"</table> "; 
						//	alert(str) 
						$("#summary_part3_"+tab+"_table").html(str);
					}
				});
	}
	function summary_part4_tab2(){
		 // table width=\"350\" 
		var str="<table width=\"500px\"   bordercolor=\"#000000\" frame=\"box\" rules=\"all\">"
			+"<tr bgcolor=\"#CD853F\"><th width=\"100%\"colspan=3><font color=\"#FFFFFF\">Change</font></th></tr>"
			+"<tr bgcolor=\"#CD853F\">"
			+"  <th width=\"33%\"><font color=\"#FFFFFF\">MB</font></th>"
			+"  <th width=\"33%\"><font color=\"#FFFFFF\">vs.LY</font></th>" 
			+"  <th width=\"33%\"><font color=\"#FFFFFF\">vs.Plan</font></th>" 
			+"</tr>"; 
		 $("#gPG").html("");
		 $("#summary_part4_table").html("");
			var sumBy=$('select[name="SumBy"]').val();
			var year=$('select[name="Year"]').val();
			var month=$('select[name="Month"]').val();  
			var proc_str="{call proc_op_tab_summary_net_sales_by_product_group('"+sumBy+"','"+year+"-"+month+"-01')}";
			var scale_x_values=[];
			var series_values_1=[];
			var series_values_2=[];
			var series_values_3=[];
			  
			BalanceScorecardAjax
			.callPROC(proc_str,{
				callback : function(data) { 
					//alert("xx="+data);
					 if (data != null && data.length > 0) {
						for ( var i = 0; i < data.length; i++) {
							scale_x_values.push(checkNULL(data[i][0]));
							series_values_1.push(checkNULL(data[i][1]));
							series_values_2.push(checkNULL(data[i][2]));
							series_values_3.push(checkNULL(data[i][3]));
							str=str+"<tr>"+ 
							"	<td align=center>"+ checkNULL(data[i][1])+"</td>"+
							"	<td align=center>"+ checkNULL(data[i][2])+"</td>"+
							"	<td align=center>"+ checkNULL(data[i][3])+"</td>"+ 									
							"</tr>";
						}
						str=str+"</table> ";
						//alert("positionGrowths_value="+positionGrowths_value)
						var mixedSalesPG_data = {
	"graphset":[
    {
        "background-color":"#FFFFFF",
        "type":"hbar",
        "title":{
                "visible":false,
            "text":""
        },
        "chart":{
            "margin":"10 20 40 120"
        },
        "legend":{
                "visible":false
        },
        "tooltip":{
            "text-align":"center"
        }, 
        "scale-x":{
            //"values":["Total","Outsource Products<br>& Others","Packaged Products","Bakery","Food","Beverage"],
            "values":scale_x_values,
			"guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "min-value": 0,
			"format" : "%v",
			"thousands-separator":",",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "plot":{
            "animate":1,
            "tooltip-text":"%v"
        }, 
        "series":[
            {
              //  "values":[1167.9,47.6,126.3,564,320,107.2],
                "values":series_values_1,
                "text":"Goals"
            }]
        }]
    };

						// var jsonStr = JSON.stringify(summary_part3_bar1);
						  //alert(jsonStr)
						  //var options = '{"data": ' + jsonStr + '}';
						 // zingchart.exec('g_'+tab, 'setdata', options); 
						 render_chart('gPG',600,270,mixedSalesPG_data); 
							 }else{ 
								 str=str+"</table> "; 
									//	alert(str) 
								$("#summary_part4_table").html(str);
								 $("#gPG").html("Not have Data");
							 }
					 }  
			});
		 
	}
	function summary_part4_tab1(){
		//$("#summary_part3_"+tab+"_table").html("");
		$("#g3").html("");
		var sumBy=$('select[name="SumBy"]').val();
		var year=$('select[name="Year"]').val();
		var month=$('select[name="Month"]').val(); 
		 
		var proc_str="{call proc_op_tab_summary_net_sales_by_branch_status('"+sumBy+"','"+year+"-"+month+"-01')}";
		var scale_x_values=[];
		var series_values_1=[];
		var series_values_2=[];
		var series_values_3=[];
		  
		BalanceScorecardAjax
		.callPROC(proc_str,{
			callback : function(data) {
				//alert("xx="+data);
				 if (data != null && data.length > 0) {
					for ( var i = 0; i < data.length; i++) {
						scale_x_values.push(checkNULL(data[i][0]));
						series_values_1.push(checkNULL(data[i][1]));
						series_values_2.push(checkNULL(data[i][2]));
						series_values_3.push(checkNULL(data[i][3]));
						 
					}
					//alert("positionGrowths_value="+positionGrowths_value)
					var mixedNetSales_data = {
				"graphset":[
				    {
						"background-color":"#FFFFFF",
				        "type":"mixed",
				        "chart":{
							"margin":"10 205 30 100"
				        },
						"legend":{
				            "margin":"60 10 20 670",
				            "layout":"x1",
				            "border-width": "2px",
							"border-color": "#4C77B6",
				            "item":{
				                "font-color":"#000000"
				            }
				        },
						"plot":{
							"bars-space-left":"25%",
							"bars-space-right":"25%",
							"bar-width":"25px"
						},
				        "scale-x":{
				            //"values":["Same","New","Change"],
				            "values":scale_x_values,
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
				            "min-value": 0,
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
				        "scale-y-2":{
							"min-value": 0,
				            "format":"%v%",     
				            "guide":{
				    			"line-width": 0,
				    			"alpha": 1
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
								//"values":[62,61,58],
								 "values":series_values_1,
								"border-width":1,
								"stacked":0,
								"background-color" : "#66CC00",
								"border-color":"#66CC00",
				                "text":"ยอดขาย Last"
				            },
				            {
				                "type":"bar",
								//"values":[63,82,74],
								 "values":series_values_2,
								"text":"ยอดขาย",
								"stacked":0,
								"background-color" : "#EEEE00",
								"border-color":"#EEEE00",
				                "border-width":1
				            },
				            {
				                "type":"line",
				               // "values":[1.61,34.43,29.59],
				                "values":series_values_3,
				                "text":"%Growth",
				                "scales":"scale-x,scale-y-2",
				                "stacked":"0",
								"line-color" : "#00BFFF",
				                "marker":{
				                    "size":3,
									"background-color" : "#00BFFF",
									"border-color":"#00BFFF"
				                },
				                "tooltip-text":"%v%"
				            }]
				        }]
				    };
					// var jsonStr = JSON.stringify(summary_part3_bar1);
					  //alert(jsonStr)
					  //var options = '{"data": ' + jsonStr + '}';
					 // zingchart.exec('g_'+tab, 'setdata', options); 
					 render_chart('g3',800,250,mixedNetSales_data); 
						 }else{ 
							 $("#g3").html("Not have Data");
						 }
				 }  
		});
	 
		
	}
	function summary_part3(tab){
		//call proc_op_tab_summary_sales_day_of_branch('MTD','2011-01-01'); -->
		//call proc_op_tab_summary_sales_day_change_in_sales('MTD','2011-01-01'); -->
	$("#summary_part3_"+tab+"_table").html("");
	var sumBy=$('select[name="SumBy"]').val();
	var year=$('select[name="Year"]').val();
	var month=$('select[name="Month"]').val(); 
	var type=$("select[name=summary_part3_"+tab+"_salesday_element]").val();
	// alert("type="+type);
	var proc_str=(type=='1')?"{call  proc_op_tab_summary_"+tab+"_day_of_branch('"+sumBy+"','"+year+"-"+month+"-01')}":
		"{call  proc_op_tab_summary_"+tab+"_day_change_in_sales('"+sumBy+"','"+year+"-"+month+"-01')}";
	//var positionGrowths_key=["V-20","V-10-20","V-01-10","V1","V_01_10","V_10_20","V_20"];
	var positionGrowths_value=["0","0","0","0","0","0","0"];
	var haveData=false;
	//alert("proc="+proc_str)
	BalanceScorecardAjax
	.callPROC(proc_str,{
		callback : function(data) {
			//alert("xx="+data);
			 if (data != null && data.length > 0) {
				for ( var i = 0; i < data.length; i++) {
					if(data[i][0]!=null){
						for(var j=0;j<positionGrowths_key.length;j++){
							if(data[i][0]==positionGrowths_key[j]){
								positionGrowths_value[j]=data[i][1];
								haveData=true;
								break;
							}
						}
					} 
				}
				//alert("positionGrowths_value="+positionGrowths_value)
				var summary_part3_bar1 = {
						"graphset":[
					    {
					        "type":"bar",
					        "background-color":"#FFFFFF",
							"plotarea":{
					            "border-width":"0px",
					            "margin":"10 30 70 70"
					        },
					        "plot":{
					            "bars-space-left":"25%",
					            "bar-width":"25px"
					        },
					        "scale-y":{
					            "values":"-30:30:10",
					            "format":"%v",
					            "guide":{
					    			"line-width": 1,
					    			"alpha": 1
					    		},
								"tick":{
									"line-width": 3
								}
					        },
					        "tooltip":{
					            "border-radius":"15",
					            "alpha":0.7
					        },
					        "scale-x":{
								"tick":{
									"line-width": 3
								},
					            "max-items":9,
					            "item":{
					                "font-family":"Calibri",
					                "font-size":"13",
					                "offset-y":"20px",
					                "font-angle":300,
					                "offset-x":"-20px"
					            },
					            "values":["- >20%","- 10-20%","- 1-10%","+/- 1%","+ 1-10%","+ 10-20%","+ >20%"],
					            "guide":{
					    			"line-width": 1,
					    			"alpha": 1,
					                "rules":[
					                    {
					                        "rule":"%i == 0",
					                        "line-width":"0px"
					                    }]
					                },
					                "items-overlap":true
							},
							"series":[
								{
									"text":"",
					                "tooltip-text":"%v%",
					               // "values":[-7,-4,-15,6,33,15,6],
					                 "values":positionGrowths_value,
					                "border-width":"2px",
					                "rules":[
					                    {
					                        "rule":"%v >= 1",
					                        "background-color":"#009933",
					                        "border-color":"#009933"
					                    },
					                    {
					                        "rule":"%v < 1",
					                        "background-color":"#ff0000",
					                        "border-color":"#ff0000"
									}]
								}]
							}]
					    };
				// var jsonStr = JSON.stringify(summary_part3_bar1);
				  //alert(jsonStr)
				  //var options = '{"data": ' + jsonStr + '}';
				 // zingchart.exec('g_'+tab, 'setdata', options); 
				 render_chart('g_'+tab,500,250,summary_part3_bar1);
				/*  alert(scale_x_values);
				 alert(series_1_values);
				 alert(series_2_values);
				 alert(series_3_values); */
				  
					 }else{
						 
						 $("#g_"+tab).html("Not have Data");
					 }
			 }  
	});
	//alert("positionGrowths_key="+positionGrowths_key+"\npositionGrowths_value="+positionGrowths_value);
		

	var summary_part3_bar2 = {
	"graphset":[
    {
        "type":"bar",
        "background-color":"#FFFFFF",
		"plotarea":{
            "border-width":"0px",
            "margin":"10 30 70 70"
        },
        "plot":{
            "bars-space-left":"25%",
            "bar-width":"25px"
        },
        "scale-y":{
            "values":"-30:30:10",
            "format":"%v",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "tooltip":{
            "border-radius":"15",
            "alpha":0.7
        },
        "scale-x":{
			"tick":{
				"line-width": 3,
			},
            "max-items":9,
            "item":{
                "font-family":"Calibri",
                "font-size":"13",
                "offset-y":"20px",
                "font-angle":300,
                "offset-x":"-20px"
            },
            "values":["- >20%","- 10-20%","- 1-10%","+/- 1%","+ 1-10%","+ 10-20%","+ >20%"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1,
                "rules":[
                    {
                        "rule":"%i == 0",
                        "line-width":"0px"
                    }]
                },
                "items-overlap":true
		},
		"series":[
			{
				"text":"",
				"tooltip-text":"%v",
				//"values":[-14,-2,-4,1,6,15,46],
				  "values":positionGrowths_value,
				"border-width":"2px",
				"rules":[
					{
						"rule":"%v >= 1",
						"background-color":"#009933",
						"border-color":"#009933"
					},
					{
						"rule":"%v < 1",
						"background-color":"#ff0000",
						"border-color":"#ff0000"
				}]
			}]
		}]
	 };
	}
	function listCriteria(){
		/* listYears();
		listDivision();
		listSection();
		listArea();
		listBranch(); */
		var procs=["{call proc_op_listYears()}","{call  proc_op_listDivisions(null)}","{call  proc_op_listSections(null)}"
		           ,"{call proc_op_listAreas(null)}","{call  proc_op_listBranch(null)}"];
		BalanceScorecardAjax
		// .listDivisions({
		.listCriteria(procs,{
			callback : function(data) {
				//alert(data.length);
				 if (data != null && data.length > 0) {
					 listYears(data[0]);
					 listDivision(data[1]);
					 listSection(data[2]);
					 listArea(data[3]);
					 listBranch(data[4]);
					/* for ( var i = 0; i < data.length; i++) { 
						division_str=division_str+" <option value=\""+data[i]+"\">"+data[i]+"</option>";
					}
					division_str=division_str+"</select> "; */
				}
				// initOperations();
				 //else
					//division_str=division_str+"</select> "; 
				//$("#Division_element").html(division_str); */
			}
		});
	}
		
	 function selectGroup(){
		  alert($("select[name=detail_part2_select_2_element]").val())
	 }
	 function setSalesTrendSelectProductGroup(productgroup){
		//	var sumBy=$('select[name="SumBy"]').val();
			var year=$('select[name="Year"]').val();
			var month=$('select[name="Month"]').val();  
		 //call proc_op_tab_detail_sales_trend_productgroup('9999-12-31','\'Y10\',\'Y11\'')
		 var proc="{call proc_op_tab_detail_sales_trend_productgroup('"+year+"-"+month+"-01','"+productgroup+"')}";
	    	var str="<select name=\"detail_part2_select_2_element\" MULTIPLE size=\"6\"  style=\"width:150px;\">"; 
	    	BalanceScorecardAjax
			.callPROC(proc,{
				callback : function(data) {
					 if (data != null && data.length > 0) {
						for ( var i = 0; i < data.length; i++) {
							str=str+" <option value=\""+data[i][0]+"\">&nbsp;"+data[i][1]+"</option>";
						}
						str=str+"</select> ";
					 }else
						 str=str+"</select> "; 
					$("#detail_part2_select_2").html(str);
				}
			});
	 }
    function setSalesTrendSelect(){ 
    	//call proc_op_tab_detail_sales_trend_categoryname('2011-01-01')   
		// var sumBy=$('select[name="SumBy"]').val();
	var year=$('select[name="Year"]').val();
	var month=$('select[name="Month"]').val(); 
    	var proc="{call proc_op_tab_detail_sales_trend_categoryname('"+year+"-"+month+"-01')}";
    	var str="<select name=\"detail_part2_select_1_element\" MULTIPLE size=\"3\"  style=\"width:150px;\">"; 
    	BalanceScorecardAjax
		.callPROC(proc,{
			callback : function(data) {
				 if (data != null && data.length > 0) {
					for ( var i = 0; i < data.length; i++) {
						str=str+" <option value=\""+data[i][0]+"\">&nbsp;"+data[i][1]+"</option>";
					}
					str=str+"</select> ";
				 }else
					 str=str+"</select> "; 
				$("#detail_part2_select_1").html(str);
			}
		});
    }
	function initOperations(){
		/*
	 
		alert($('select[name="Year"]').val()+",Division="+$('select[name="Division"]').val()
				+",Section="+$('select[name="Section"]').val()+",Zone="+$('select[name="Zone"]').val()
				+",Major="+$('select[name="Major"]').val()); 
		*/
		var scale_x_values=[];
		var series_1_values=[];
		var series_2_values=[];
		var series_3_values=[];
		var sumBy=$('select[name="SumBy"]').val();
		var year=$('select[name="Year"]').val();
		var month=$('select[name="Month"]').val();
		var proc_str="{call  proc_op_tab_summary_MTD_YTD('"+sumBy+"','"+year+"-"+month+"-01')}";
		if($('select[name="Division"]').val()!='ALL' && $('select[name="Section"]').val()!='ALL'){
			proc_str="{call proc_op_tab_summary_section('"+sumBy+"','"+year+"-"+month+"-01','"+$('select[name="Division"]').val()+"','"+$('select[name="Section"]').val()+"')}";
		}else if($('select[name="Division"]').val()!='ALL' && $('select[name="Section"]').val()=='ALL'){ 
			proc_str="{call proc_op_tab_summary_division('"+sumBy+"','"+year+"-"+month+"-01','"+$('select[name="Division"]').val()+"')}";
		} 
		$("#chart_sales").html("");
		BalanceScorecardAjax
		.callPROC(proc_str,{
			callback : function(data) {
				 if (data != null && data.length > 0) {
					for ( var i = 0; i < data.length; i++) {
						scale_x_values.push(data[i][0]);
						series_1_values.push((data[i][1]!=null)?data[i][1]:"0");
						series_2_values.push((data[i][2]!=null)?data[i][2]:"0");
						series_3_values.push((data[i][3]!=null)?data[i][3]:"0"); 
					}
					// render
					var barSales = {
				"graphset":[
			    {
					"background-color":"#FFFFFF",
			        "type":"bar",
			        "legend" : {
						"background-color": "#FFFFFF",
			    		"border-width": "2px",
						"border-color": "#4C77B6",
						//"x": 570,
						"x": 830,
						"y": 70
					},
					"chart" : {
						"margin" : "20 150 40 100"
					},
					"plot":{
			            "bars-space-left":"20%",
						"bars-space-right":"20%",
			            "bar-width":"25px"
			        },
					"scale-x":{
			           // "values":["ฝ่ายปฏิบัติการสาขา S&P","ฝ่ายปฏิบัติการ Specialty"],
			            "values":scale_x_values,
			            "guide":{
			    			"line-width": 1,
			    			"alpha": 1
			    		},
						"tick":{
							"line-width": 3
						}
					},
			        "scale-y":{
			            "guide":{
			    			"line-width": 1,
			    			"alpha": 1
			    		},
						"tick":{
							"line-color": "#8B8B7A"
						}
			        },
			        "tooltip":{
			            "border-radius":"15",
			            "font-color":"#000000",
			            "alpha":0.7
			        },
					"series" : [
					 {
						//"values" : [11,26],
						 "values":series_1_values,
						 "background-color" : "#66CC00",
						 "text" : "ยอดขาย Last"
					 },
					 {
						//"values" : [42,13],
						 "values":series_2_values,
						 "background-color" : "#EEEE00",
						 "text" : "ยอดขาย"
					 },
					 {
						//"values" : [23,24],
						 "values":series_3_values,
						 "background-color" : "#696969",
						 "text" : "เป้าหมาย"
					 }] 
				  }]
				};
		 //  var jsonStr = JSON.stringify(barSales);
		  //alert(jsonStr)
		 // var options = '{"data": ' + jsonStr + '}';
		  // zingchart.exec('chart_sales', 'setdata', options);
		 render_chart('chart_sales',950,250,barSales);
		/*  alert(scale_x_values);
		 alert(series_1_values);
		 alert(series_2_values);
		 alert(series_3_values); */
			 }else{
				 $("#chart_sales").html("Not have Data");
			 }
			}
		});
		summary_part2_tab1("DESC");
		summary_part2_tab1("ASC");
		summary_part2_tab2();
		summary_part3("sales");
		summary_part3('ebit');
		summary_part4_tab1();
		summary_part4_tab2();
		detail_part1("net_sales");
		detail_part1("cost");
		setSalesTrendSelect();
		//detail_part2();
		detail_part3_box1();
		detail_part3_box2();
		detail_part4_box1("average_check"); //average_check, customer_day,average_sales_bill
		detail_part4_box1("customer_day");
		detail_part4_box1("average_sales_bill");
		detail_part4_box2("sales_sqm_day"); // sales_sqm_day sales_staff_day seat_turn_day
		detail_part4_box2("sales_staff_day");
		detail_part4_box2("seat_turn_day");
		detail_part5_box1("DESC","10");
		detail_part5_box2("DESC","10");
		map_part1();
		map_part2();
		$("#tabs").show();
	}
	function listYears(data){  
	var year_str="<select name=\"Year\" onChange=\"getYear(this.value);\">"; 
	if (data != null && data.length > 0) {
		for ( var i = 0; i < data.length; i++) { 
			year_str=year_str+" <option value=\""+data[i]+"\">"+data[i]+"</option>";
		}
		year_str=year_str+"</select> ";
	}else
		year_str=year_str+"</select> "; 
	$("#Year_element").html(year_str);
		/* BalanceScorecardAjax
		.listYears({
			callback : function(data) {
				if (data != null && data.length > 0) {
					for ( var i = 0; i < data.length; i++) { 
						year_str=year_str+" <option value=\""+data[i]+"\">"+data[i]+"</option>";
					}
					year_str=year_str+"</select> ";
				}else
					year_str=year_str+"</select> "; 
				$("#Year_element").html(year_str);
			}
		}); */
	}
	function listDivision(data) {
		var division_str="<select name=\"Division\" onChange=\"getDivision(this.value);\">"; 
		division_str=division_str+" <option value=\"ALL\">ALL</option>";
		if (data != null && data.length > 0) {
			for ( var i = 0; i < data.length; i++) { 
				division_str=division_str+" <option value=\""+data[i]+"\">"+data[i]+"</option>";
			}
			division_str=division_str+"</select> ";
		}else
			division_str=division_str+"</select> "; 
		$("#Division_element").html(division_str);
		//var mySelect = document.getElementById('Division'); 
		/* BalanceScorecardAjax
				// .listDivisions({
				.callPROC("{call  proc_op_listDivisions(null)}",{
					callback : function(data) {
						//alert(data)
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) { 
								division_str=division_str+" <option value=\""+data[i]+"\">"+data[i]+"</option>";
							}
							division_str=division_str+"</select> ";
						}else
							division_str=division_str+"</select> "; 
						$("#Division_element").html(division_str);
					}
				}); */
	}

	function listSection(data) {
		var section_str="<select name=\"Section\" onChange=\"getSection(this.value);\">";
		section_str=section_str+" <option value=\"ALL\">ALL</option>";
		if (data != null && data.length > 0) {
			for ( var i = 0; i < data.length; i++) {
				section_str=section_str+" <option value=\""+data[i]+"\">"+data[i]+"</option>"; 
			}
			section_str=section_str+"</select> ";
		}else
			section_str=section_str+"</select> "; 
		$("#Section_element").html(section_str);
		//var mySelect = document.getElementById('Section'); 
		/* BalanceScorecardAjax
				//.listSections({
				.callPROC("{call  proc_op_listSections(null)}",{					
					callback : function(data) {
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								section_str=section_str+" <option value=\""+data[i]+"\">"+data[i]+"</option>"; 
							}
							section_str=section_str+"</select> ";
						}else
							section_str=section_str+"</select> "; 
						$("#Section_element").html(section_str);
					 } 
				}); */
	}

	function listArea(data) { 
		//var mySelect = document.getElementById('Area');
		var area_str="<select name=\"Zone\" onChange=\"getZone(this.value);\">";
		area_str=area_str+" <option value=\"ALL\">ALL</option>";
		if (data != null && data.length > 0) {
			for ( var i = 0; i < data.length; i++) {
				area_str=area_str+" <option value=\""+data[i]+"\">"+data[i]+"</option>"; 
			}
			area_str=area_str+"</select> ";
		}else
			area_str=area_str+"</select> "; 
		$("#Zone_element").html(area_str);
		/* BalanceScorecardAjax
				//.listAreas({
				.callPROC("{call proc_op_listAreas(null)}",{	
					callback : function(data) {
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								area_str=area_str+" <option value=\""+data[i]+"\">"+data[i]+"</option>"; 
							}
							area_str=area_str+"</select> ";
						}else
							area_str=area_str+"</select> "; 
						$("#Zone_element").html(area_str);
					 }
				}); */
	}

	function listBranch(data) {
		
		var branch_str="<select name=\"Major\" onChange=\"getMajor(this.value);\">";
		branch_str=branch_str+" <option value=\"ALL\">ALL</option>"; 
		if (data != null && data.length > 0) {
			for ( var i = 0; i < data.length; i++) {
				branch_str=branch_str+" <option value=\""+data[i][1]+"\">"+data[i][0]+"</option>"; 
			}
			branch_str=branch_str+"</select> ";
		}else
			branch_str=branch_str+"</select> "; 
		$("#Major_element").html(branch_str);
		//var mySelect = document.getElementById('Branch');
		/* BalanceScorecardAjax
				//.listBranch({
				.callPROC("{call  proc_op_listBranch(null)}",{	
					callback : function(data) {
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								branch_str=branch_str+" <option value=\""+data[i][1]+"\">"+data[i][0]+"</option>"; 
							}
							branch_str=branch_str+"</select> ";
						}else
							branch_str=branch_str+"</select> "; 
						$("#Major_element").html(branch_str);
					 }
				}); */
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
		#tabs { top:80px; left:5px; }
	</style>
 


</head>

<body>
<!--+++++++++++++++++++++++++ Parameter +++++++++++++++++++++++++-->
	<!--          Drop Down List YEAR              -->
	<div style="position:absolute; left:45px; top:20px;"><font size="3"> ปี:</font>
	    <span id="Year_element"></span> 
	</div>
	<!--          Drop Down List MONTH              -->
	<div style="position:absolute; left:150px; top:20px;"><font size="3"> เดือน:</font>
		<select name="Month" onChange="getMonth(this.value);">
			<option value="01">Jan</option>
			<option value="02">Feb</option>
			<option value="03">Mar</option>
			<option value="04">Apr</option>
			<option value="05">May</option>
			<option value="06">Jun</option>
			<option value="07">Jul</option>
			<option value="08">Aug</option>
			<option value="09">Sep</option>
			<option value="10">Oct</option>
			<option value="11">Nov</option>
			<option value="12">Dec</option> 
		</select> 
	</div>
	<!--          Drop Down List SUMMARY BY            -->
	<div style="position:absolute; left:270px; top:20px;"><font size="3"> สรุปตาม : </font>
		<select name="SumBy" onChange="getSumBy(this.value);">
			<option value="MTD">MTD</option>
			<option value="YTD">YTD</option> 
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:20px; top:50px;"><font size="3"> ฝ่าย : </font>
	    <span id="Division_element"></span>
	     
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:300px; top:50px;"><font size="3"> ส่วน : </font>
	   <span id="Section_element"></span>
	  
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:600px; top:50px;"><font size="3"> เขต : </font>
	  <span id="Zone_element"></span>
	 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:710px; top:50px;"><font size="3"> สาขา : </font>
		<span id="Major_element"></span>
		 
	</div>

	<div style="position:absolute; left:1070px; top:50px;">
		<!-- <input type="button" value=" OK " onClick="goUrl()"/> -->
		<input type="button" value=" OK " onClick="initOperations()"/>
		
	</div>
<!--+++++++++++++++++++++++++ End Parameter +++++++++++++++++++++++++-->

<!--+++++++++++++++++++++++++ +++++++++++++++++++++++++-->
<div id="tabs" style="position:absolute; height=500px;" bordercolor="#FFFFFF" border="5">
	<ul>
		<li><a href="#tabs-t1">Summary</a></li>
		<li><a href="#tabs-t2">Detail</a></li>
		<li><a href="#tabs-t3">Map</a></li>
	</ul>

<!--+++++++++++++++++++++++++ Tab Summary +++++++++++++++++++++++++-->
	<table id="tabs-t1">
	<tr><td>
	
		<table id="tabs-t1r1" width=1060>
			<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">ยอดขาย (ล้านบาท)</font></th></tr>
			<tr><td align="center"><div id="chart_sales"></div></td></tr><!-- Chart -->
		</table>
	<!----------------- Row 2 -------------------->
		<table id="tabs-t1r2" width=1060>
		<tr><td>
			<ul>
				<li><a href="#tabs-t1r2_1">กำไร</a></li>
				<li><a href="#tabs-t1r2_2">Sales Growth</a></li>
			</ul>

			<table id="tabs-t1r2_1">
			<tr>
				<td width="50%">กำไรมากสุด : <input type=text id="Summary_Profit_noOfShow_max_element" value=10><input type="button" name="ok" value=" OK " onclick="summary_part2_tab1('DESC')"/></td>
				<td width="50%">กำไรน้อยสุด : <input type=text id="Summary_Profit_noOfShow_min_element" value=10><input type="button" name="ok" value=" OK " onclick="summary_part2_tab1('ASC')"/></td>
			</tr>
			<tr>
			<td valign="top">
			<span id="Summary_Profit_max_element"></span>
			<!-- 
			<p></p>
				<table width=500 bordercolor="#000000" frame="box" rules="all">
				<tr bgcolor="#CD853F">
					<th><font color="#FFFFFF">#</font></th>
					<th><font color="#FFFFFF">สาขา</font></th>
					<th><font color="#FFFFFF">กำไร (บาท)</font></th>
					<th><font color="#FFFFFF">% GP</font></th>
				</tr>
				<tr>
					<td align=center>1</td>
					<td align=center>โลตัส บางใหญ่</td>
					<td align=right>500,000</td>
					<td align=right>10</td>
				</tr>
				<tr>
					<td align=center>2</td>
					<td align=center>โลตัส รังสิต</td>
					<td align=right>400,000</td>
					<td align=right>9</td>
				</tr>
				<tr>
					<td align=center>3</td>
					<td align=center>อาคารสินธร</td>
					<td align=right>300,000</td>
					<td align=right>9</td>
				</tr>
				<tr>
					<td align=center>4</td>
					<td align=center>โลตัส ประชาชื่น</td>
					<td align=right>200,000</td>
					<td align=right>8</td>
				</tr>
				<tr>
					<td align=center>5</td>
					<td align=center>โลตัสบางกะปิ</td>
					<td align=right>100,000</td>
					<td align=right>8</td>
				</tr>
				<tr>
					<td align=center>6</td>
					<td align=center>โลตัสบางนา</td>
					<td align=right>100,000</td>
					<td align=right>8</td>
				</tr>
				<tr>
					<td align=center>7</td>
					<td align=center>โลตัสสระบุรี</td>
					<td align=right>100,000</td>
					<td align=right>7</td>
				</tr>
				<tr>
					<td align=center>8</td>
					<td align=center>โลตัสลาดพร้าว</td>
					<td align=right>100,000</td>
					<td align=right>7</td>
				</tr>
				<tr>
					<td align=center>9</td>
					<td align=center>โลตัสรามอินทรา</td>
					<td align=right>100,000</td>
					<td align=right>6</td>
				</tr>
				<tr>
					<td align=center>10</td>
					<td align=center>โลตัสสาธร</td>
					<td align=right>100,000</td>
					<td align=right>6</td>
				</tr>
				</table>
				 -->
			</td>

			<td valign="top">
			<span id="Summary_Profit_min_element"></span>
			<!--
			<p></p>
				<table width=500 bordercolor="#000000" frame="box" rules="all">
				<tr  bgcolor="#CD853F">
					<th><font color="#FFFFFF">#</font></th>
					<th><font color="#FFFFFF">สาขา</font></th>
					<th><font color="#FFFFFF">กำไร (บาท)</font></th>
					<th><font color="#FFFFFF">% GP</font></th>
				</tr>
				<tr>
					<td align=center>1</td>
					<td align=center>ปิยรมย์ พาร์ค</td>
					<td align=right>95,000</td>
					<td align=right>5.5</td>
				</tr>
				<tr>
					<td align=center>2</td>
					<td align=center>บิ๊กซี รังสิต</td>
					<td align=right>90,000</td>
					<td align=right>5</td>
				</tr>
				<tr>
					<td align=center>3</td>
					<td align=center>รพ.เซ็นต์หลุยส์</td>
					<td align=right>85,000</td>
					<td align=right>4.5</td>
				</tr>
				<tr>
					<td align=center>4</td>
					<td align=center>รพ.เพชรเวช</td>
					<td align=right>80,000</td>
					<td align=right>4</td>
				</tr>
				<tr>
					<td align=center>5</td>
					<td align=center>เซ็นทรัลรัตนาธิเบศร์</td>
					<td align=right>75,000</td>
					<td align=right>3.5</td>
				</tr>
				<tr>
					<td align=center>6</td>
					<td align=center>เซ็นทรัลพระราม3</td>
					<td align=right>70,000</td>
					<td align=right>3</td>
				</tr>
				<tr>
					<td align=center>7</td>
					<td align=center>เฉลิมกรุง</td>
					<td align=right>65,000</td>
					<td align=right>2.5</td>
				</tr>
				<tr>
					<td align=center>8</td>
					<td align=center>เจริญนคร</td>
					<td align=right>60,000</td>
					<td align=right>2</td>
				</tr>
				<tr>
					<td align=center>9</td>
					<td align=center>คาร์ฟูร์ บางใหญ่</td>
					<td align=right>55,000</td>
					<td align=right>1.5</td>
				</tr>
				<tr>
					<td align=center>10</td>
					<td align=center>แกรนด์คาแนล</td>
					<td align=right>50,000</td>
					<td align=right>1</td>
				</tr>				
				</table>
				  -->
			</td>

			</tr>
			</table>

			<table id="tabs-t1r2_2">
			<tr><td width="1048"> 
				<select id="summary_part2_tab2_arrange_element">
					<option value="DESC">ยอดขายสูงสุด</option>
					<option value="ASC">ยอดขายต่ำสุด</option>
				</select>
				<input type=text value=10 id="summary_part2_tab2_noOfShow_element">
				<input type="button" name="ok" value=" OK " onclick="summary_part2_tab2()"/>
				<p></p>
			</td></tr>

			<tr><td align="center" valign="top"> 
			  <span id="summary_part2_tab2_element"></span>
			   <!-- 
				<table bordercolor="#000000" frame="box" rules="all">
				<tr bgcolor="#CD853F">
					<th width="50"><font color="#FFFFFF">#</font></th>
					<th width="150"><font color="#FFFFFF">สาขา</font></th>
					<th width="70"><font color="#FFFFFF">ยอดขาย</font></th>
					<th width="100"><font color="#FFFFFF">Last ยอดขาย</font></th>
					<th width="100"><font color="#FFFFFF">Diff ยอดขาย</font></th>
					<th width="70"><font color="#FFFFFF">% Growth</font></th>
				</tr>
				<tr>
					<td align=center>1</td>
					<td align=center>โลตัส บางใหญ่</td>
					<td align=center>500,000</td>
					<td align=center>600,000</td>
					<td align=center>100,000</td>
					<td align=center>10</td>
				</tr>
				<tr>
					<td align=center>2</td>
					<td align=center>วงศ์สว่าง</td>
					<td align=center>400,000</td>
					<td align=center>450,000</td>
					<td align=center>50,000</td>
					<td align=center>9</td>
				</tr>
				<tr>
					<td align=center>3</td>
					<td align=center>อาคารสินธร</td>
					<td align=center>300,000</td>
					<td align=center>320,000</td>
					<td align=center>20,000</td>
					<td align=center>9</td>
				</tr>
				<tr>
					<td align=center>4</td>
					<td align=center>โลตัส ประชาชื่น</td>
					<td align=center>200,000</td>
					<td align=center>210,000</td>
					<td align=center>10,000</td>
					<td align=center>7</td>
				</tr>
				<tr>
					<td align=center>5</td>
					<td align=center>โลตัสบางกะปิ</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>6</td>
				</tr>
				<tr>
					<td align=center>6</td>
					<td align=center>โลตัสสระบุรี</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>5</td>
				</tr>
				<tr>
					<td align=center>7</td>
					<td align=center>โลตัสลำลูกกา</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>5</td>
				</tr>
				<tr>
					<td align=center>8</td>
					<td align=center>โลตัสฟอร์จูน</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>4</td>
				</tr>
				<tr>
					<td align=center>9</td>
					<td align=center>โลตัสรามอินทรา</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>3</td>
				</tr>
				<tr>
					<td align=center>10</td>
					<td align=center>โลตัสภูเก็ต</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>3</td>
				</tr>
				</table>
				 -->
			</td></tr>
			</table>
		</td></tr>
		</table>

	<!---------------------------- Row 3 ------------------------>
	<table id="tabs-t1r3" width=1060>
		<tr><td>
			<ul>
				<li><a href="#tabs-t1r3_1">Sales/Day</a></li>
				<li><a href="#tabs-t1r3_2">EBIT/Day</a></li>
			</ul>

			<table id="tabs-t1r3_1">
			<tr><td colspan="2">
				<select name="summary_part3_sales_salesday_element">
					<option value="1"># of branch</option>
					<option value="2">% Change in Sales</option>
				</select>
				<input type="button" name="ok" value=" OK " onclick="summary_part3('sales')"/>
			</td></tr>
			<tr valign="top">
				<td>
					<span id="g_sales"></span>
				</td><!-- Chart -->
				<td>
				<span id="summary_part3_sales_table"></span>
				 
				</td><!-- Table of detail -->
			</tr>
			</table>

			<table id="tabs-t1r3_2">
			<tr><td colspan="2"> 
				<select name="summary_part3_ebit_salesday_element">
					<option value="1"># of branch</option>
					<option value="2">% Change in Sales</option>
				</select>
				<input type="button" name="ok" value=" OK " onclick="summary_part3('ebit')"/>
			</td></tr>
			<tr valign="top">
				<td>
					 <span id="g_ebit"></span> 
				</td><!-- Chart -->
				<td>
				<span id="summary_part3_ebit_table"></span>
				  
				</td><!-- Table of detail -->
			</tr>
			</table>

		</td></tr>
	</table>

	<!---------------------------- Row 4 ------------------------>
	<table id="tabs-t1r4" width=1060 border="0">
		<tr><td align="center">
			<ul>
				<li><a href="#tabs-t1r4_1">Net Sales By Branch Status</a></li>
				<li><a href="#tabs-t1r4_2">Net Sales By Product Group</a></li>
			</ul>

			<table id="tabs-t1r4_1" width="100%">
				<tr><td>
				<span id="g3"></span>
				</td></tr>
			</table>

			<table id="tabs-t1r4_2" width="100%" border="0">
				<tr valign="top">
					<td align="center" width="50%">
						<span id="gPG"></span>
					</td>
					<td valign="top" align="center" width="50%" colspan="3">
					   <span id="summary_part4_table"></span>
					   
					</td>
				</tr>
			</table>
		</td></tr>
	</table>

<!-- -->
	</td></tr>
	</table>
<!--+++++++++++++++++++++++++ Tab Detail +++++++++++++++++++++++++-->
	<table id="tabs-t2">
	<tr><td>

		<table width=1060>
		<tr> 
			<td id="tabs-t2r1c2" colspan="2" width="1060">
				<ul>
					<li><a href="#tabs-t2r1c2_1"> Net Sales </a></li>
					<li><a href="#tabs-t2r1c2_2"> Cost </a></li>
				 </ul>

				 <table id="tabs-t2r1c2_1">
					<tr>
						<td>
							<span id="g_net_sales"></span>
						</td>
						<td valign="top">
							<span id="detail_part1_net_sales_table"></span> 
						</td>
					</tr>
				 </table>

				 <table id="tabs-t2r1c2_2">
					<tr>
						<td>
							<span id="g_cost"></span>
						</td>
						<td valign="top">
							<span id="detail_part1_cost_table"></span> 
						 </td>
					</tr>
				 </table>

			</td>
		</tr>
		</table>

		<table id="tabs-t2r2" width="1060">
			<tr bgcolor="#8B4513">
				<th colspan="2"><font color="#FFE742" size="3"> Sales Trend </font></th>
			</tr>
			<tr>
				<td width="150" valign="top"><table id="param1" width="100%">
					<tr bgcolor="#CD853F"><th><font color="#FFFFFF">หมวดสินค้า</font></tr>
					<tr><td>
					<span id="detail_part2_select_1"></span>
					<!--  
					<select name="param" MULTIPLE size="3"  style="width:150px;">
						<option value="1">&nbsp;เบเกอรี่</option>
						<option value="2">&nbsp;อาหาร</option>
						<option value="3">&nbsp;เครื่องดื่ม</option>
					</select>
					-->
					</td></tr>
					<tr><td align="right"><input type="submit" name="ok" value=" OK " onclick="selectGroup()"/></td></tr>
					<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มสินค้า</font></tr>
					<tr><td>
					<span id="detail_part2_select_2"></span>
					<!-- 
					<select name="param" MULTIPLE size="6"  style="width:150px;">
						<option value="1">&nbsp;เค้ก</option>
						<option value="2">&nbsp;คุ๊กกี้</option>
						<option value="3">&nbsp;ขนมปัง</option>
						<option value="4">&nbsp;อาหารไทย</option>
						<option value="5">&nbsp;อาหารชุด</option>
						<option value="6">&nbsp;อาหารญี่ปุ่น</option>
						<option value="7">&nbsp;บลูคัพ</option>
						<option value="8">&nbsp;เบียร์</option>
						<option value="9">&nbsp;ไอศครีม</option>
					</select>
					-->
					</td></tr> 

					<tr><td align="right"><input type="submit" name="ok" value=" OK " onclick="detail_part2()"/></td></tr>
				</table></td>
				
				<td id="chart1"><div id="g6"></div></td>
			</tr>
		</table>

		<table width="1060">
		<tr valign="top">
			<td id="tabs-t2r3c1">
				<table width="520">
					<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Sales by Sales Type</font></th></tr>
					<tr><td>
						<span  id="g7"></span>
					</td></tr>
				</table>
			</td>
			
			<td id="tabs-t2r3c2">
				<table width="520">
					<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Discount</font></th></tr>
					<tr><td align="center">
						<span id="g8"></span>
					</td></tr>
				</table>
			</td>
		</tr>
		</table>

		<table width="1060">
		<tr>
			<td id="tabs-t2r4c1" width="530">
			<ul>
				<li><a href="#tabsG-1"> Average Check </a></li>
				<li><a href="#tabsG-2"> Customers/Day </a></li>
				<li><a href="#tabsG-3"> Average Sales/Bill </a></li>
			</ul>

			<div id="tabsG-1"><div align="center" id="g_average_check"></div></div>
			<div id="tabsG-2"><div align="center" id="g_customer_day"></div></div>
			<div id="tabsG-3"><div align="center" id="g_average_sales_bill"></div></div>
			</td>

			<td id="tabs-t2r4c2" width="530">
			<ul>
				<li><a href="#tabsGET-1"> Sales/Sqm/Day </a></li>
				<li><a href="#tabsGET-2"> Sales/Staff/Day </a></li>
				<li><a href="#tabsGET-3"> Seat Turn/Day </a></li>
			</ul>
			<div id="tabsGET-1"><div align="center" id="g_sales_sqm_day"></div></div>
			<div id="tabsGET-2"><div align="center" id="g_sales_staff_day"></div></div>
			<div id="tabsGET-3"><div align="center" id="g_seat_turn_day"></div></div>
			</td>
		</tr>
		</table>

		<table width="1060">
		<tr>
			<td id="tabs-t2r5c1"><table width="520">
				<tr bgcolor="#8B4513"><th><font color="#FFE742">Selling Product</font></th></tr>
				<tr><td>
				 <span id="detail_part5_box1_table"></span>
				  <!-- 
					<div class="top">
						<select name="s">
							<option value="DESC">ยอดขายสูงสุด</option>
							<option value="ASC">ยอดขายต่ำสุด</option>
						</select>
						 <input type="text" id="detail_part5_box1_noOfShow" value="10" size="1">
						 <input type="submit" name="ok" value=" OK "/>
					</div>
					<br>
					<table width="500" align="center" bordercolor="#000000" frame="box" rules="all">
					<tr bgcolor="#CD853F">
						<th width=200><font color="#FFFFFF">Product</font></th>
						<th><font color="#FFFFFF">ยอดขายปีนี้</font></th>
						<th><font color="#FFFFFF">ยอดขายปีที่แล้ว</font></th>
						<th><font color="#FFFFFF">%เทียบปีที่แล้ว</font></th>
						<th><font color="#FFFFFF">%เทียบยอดขายทั้งหมด</font></th>
					</tr>
					<tr>
						<td>เกี๊ยวกุ้งเซี่ยงไฮ้ </td>
						<td align="right">2,374,691</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">11.90%</td>
					</tr>
					<tr>
						<td>ไก่ย่างโอชา</td>
						<td align="right">2,124,000</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">10.20%</td>
					</tr>
					<tr>
						<td>หมี่กรอบ</td>
						<td align="right">1,950,321</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">9.50%</td>
					</tr>
					<tr>
						<td>ยำไส้กรอกแฟรงเฟอร์เตอร์</td>
						<td align="right">1,912,000</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">9.10%</td>
					</tr>
					<tr>
						<td>ขนมจีบไข่กุ้ง</td>
						<td align="right">1,374,691</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">7.82%</td>
					</tr>
					<tr>
						<td>แกงส้มชะอมกุ้งสด</td>
						<td align="right">1,091,100</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">5.03%</td>
					</tr>
					<tr>
						<td>ต้มยำกุ้งแม่น้ำ</td>
						<td align="right">974,691</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">3.97%</td>
					</tr>
					<tr>
						<td>น้ำพริกปูผักจิ้ม-แซลมอนแดดเดียว</td>
						<td align="right">923,125</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">3.36%</td>
					</tr>
					<tr>
						<td>ซี่โครงหมูทอดกระเทียมพริกไทย</td>
						<td align="right">874,411</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">2.45%</td>
					</tr>
					<tr>
						<td>กุ้งแม่น้ำทอดกระเทียมพริกไทย</td>
						<td align="right">795,691</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">2.00%</td>
					</tr>
					</table>
					 -->
				</td></tr>
			</table></td>

			<td id="tabs-t2r5c2"><table width="520">
				<tr bgcolor="#8B4513"><th><font color="#FFE742">New Product</font></th></tr>
				<tr><td>
				<span id="detail_part5_box2_table"></span>
				<!-- 
				<div class="top">
					<select name="s">
						<option value="DESC">ยอดขายสูงสุด</option>
						<option value="ASC">ยอดขายต่ำสุด</option>
					</select>
					 <input type="text" id="detail_part5_box2_noOfShow" value="10" size="1">
					 <input type="submit" name="ok" value=" OK "/>
				</div>
				<br>
				<table width="500" align="center" bordercolor="#000000" frame="box" rules="all" bgcolor="#FFFFFF">
				<tr bgcolor="#CD853F">
					<th width=200><font color="#FFFFFF">Product</font></th>
					<th><font color="#FFFFFF">ยอดขาย</font></th>
					<th><font color="#FFFFFF">เป้าหมาย</font></th>
					<th><font color="#FFFFFF">%เทียบเป้าหมาย</font></th>
					<th><font color="#FFFFFF">%เทียบยอดขายทั้งหมด</font></th>
				</tr>
				<tr>
					<td>เกี๊ยวกุ้งเซี่ยงไฮ้ </td>
					<td align="right">2,374,691</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">11.90%</td>
				</tr>
				<tr>
					<td>ไก่ย่างโอชา</td>
					<td align="right">2,124,000</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">10.20%</td>
				</tr>
				<tr>
					<td>หมี่กรอบ</td>
					<td align="right">1,950,321</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">9.50%</td>
				</tr>
				<tr>
					<td>ยำไส้กรอกแฟรงเฟอร์เตอร์</td>
					<td align="right">1,912,000</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">9.10%</td>
				</tr>
				<tr>
					<td>ขนมจีบไข่กุ้ง</td>
					<td align="right">1,374,691</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">7.82%</td>
				</tr>
				<tr>
					<td>แกงส้มชะอมกุ้งสด</td>
					<td align="right">1,091,100</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">5.03%</td>
				</tr>
				<tr>
					<td>ต้มยำกุ้งแม่น้ำ</td>
					<td align="right">974,691</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">3.97%</td>
				</tr>
				<tr>
					<td>น้ำพริกปูผักจิ้ม-แซลมอนแดดเดียว</td>
					<td align="right">923,125</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">3.36%</td>
				</tr>
				<tr>
					<td>ซี่โครงหมูทอดกระเทียมพริกไทย</td>
					<td align="right">874,411</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">2.45%</td>
				</tr>
				<tr>
					<td>กุ้งแม่น้ำทอดกระเทียมพริกไทย</td>
					<td align="right">795,691</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">2.00%</td>
				</tr>
				</table>
				 -->
				</td></tr>
			</table></td>
		</tr>
		</table>

	</td></tr>
	</table>

<!--+++++++++++++++++++++++++ Tab Map +++++++++++++++++++++++++-->
	<table id="tabs-t3">
	<tr><td>
		<table id="tabs-t3r1">
		<tr><td>
			<table width=1060 align=center border=0>
			<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">Region Growth</font></th></tr>
			<tr>
				<td width=400 align=center><img src='<%=request.getContextPath()%>/Dashboard/images/thailand.png'></td>
				<td  valign=middle>
				<span id="map_part1_table"></span> 
			</td></tr>

			<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">Google Map</font></th></tr>
			<tr><td colspan="2" align="center"><br><img src='<%=request.getContextPath()%>/Dashboard/images/SnPGoogleMap.jpg'></td></tr>
			</table>

		</td></tr>
		</table>

	</td></tr>
	</table>

</div>
	 
<script type="text/javascript">

	
 
	$(document).ready(function() {
		/*
		zingchart.render({
			id 			: 'chart_sales',
			width 		: 700,
			height 		: 250,
			data 		: barSales1
		});
		*/
		//render_chart('chart_sales',950,250,barSales1); 
		/*
		zingchart.render({
			id 			: 'g1',
			width 		: 500,
			height 		: 250,
			data 		: bar1
		});
		zingchart.render({
			id 			: 'g2',
			width 		: 500,
			height 		: 250,
			data 		: bar2
		});
		*/
		//render_chart('g1',500,250,bar1); 
		//render_chart('g2',500,250,bar2); 
		/*
		zingchart.render({
			id 			: 'g3',
			width 		: 800,
			height 		: 250,
			data 		: mixedNetSales
		});
		
		zingchart.render({
			id 			: 'gPG',
			width 		: 600,
			height 		: 270,
			data 		: mixedSalesPG
		});
		*/
//----------------------------------------------------------------------------------
		/*
		zingchart.render({
			id 			: 'g4',
			width 		: 235,
			height 		: 270,
			data 		: pieNet
		});
		 
		
		zingchart.render({
			id 			: 'g6',
			width 		: 870,
			height 		: 350,
			data 		: mixedMTD
		});
		*/
		/*
		zingchart.render({
			id 			: 'g7',
			width 		: 510,
			height 		: 235,
			data 		: stackedSales
		});
		*/
		/*
		zingchart.render({
			id 			: 'g8',
			width 		: 450,
			height 		: 235,
			data 		: barDiscount
		});
		*/
		/*
		zingchart.render({
			id 			: 'g9',
			width 		: 400,
			height 		: 235,
			data 		: barAvg
		});
		zingchart.render({
			id 			: 'g10',
			width 		: 400,
			height 		: 235,
			data 		: barCust
		});
		zingchart.render({
			id 			: 'g11',
			width 		: 400,
			height 		: 235,
			data 		: barAvgs
		});
		*/
		/*
		zingchart.render({
			id 			: 'g12',
			width 		: 400,
			height 		: 235,
			data 		: barSales2
		});
		zingchart.render({
			id 			: 'g13',
			width 		: 400,
			height 		: 235,
			data 		: barSales3
		});
		zingchart.render({
			id 			: 'g14',
			width 		: 400,
			height 		: 235,
			data 		: barSeat
		});
		*/
		 zingchart.node_click = function(node){
			   // alert("xx="+xx)
			  // id [The ID of chart] , graphid [The ID of graph] , plotindex [The index of the plot]
			  // nodeindex [The index of the node] , key [The node's key] , value [The value of the node]
			  // text [The text that would display in the tooltip for the node]
				//var text_node=node["text"];
				//var text_arr=text_node.split(": ");
				//alert(node["id"]+",text_node="+text_node+",plotindex="+node["plotindex"]+",nodeindex="+node["nodeindex"]+",key="+node["key"])
				if(node["id"].indexOf("g_")!=-1){
					//alert(positionGrowths_key[node["nodeindex"]]) 
					//alert(node["id"].split("g_"))
					summary_part3_table(node["id"].split("g_")[1],positionGrowths_key[node["nodeindex"]])
				}
				/* if(text_arr[1]!='0'){
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
				} */
			};
			
			//$("#tabs").slideUp();
			// Tabs
			$("#tabs").tabs();
			$("#tabs-t1r1").tabs();
			$("#tabs-t1r2").tabs();
			$("#tabs-t1r3").tabs();
			$("#tabs-t1r4").tabs();

		//	$("#tabs-t2r1c1").tabs();
			$("#tabs-t2r1c2").tabs();
			$("#tabs-t2r2").tabs();
				$("#param1").tabs();
				$("#chart1").tabs();
			$("#tabs-t2r3c1").tabs();
			$("#tabs-t2r3c2").tabs();
			$("#tabs-t2r4c1").tabs();
			$("#tabs-t2r4c2").tabs();
			$("#tabs-t2r5c1").tabs();
			$("#tabs-t2r5c2").tabs();

			$("#tabs-t3r1").tabs();
			$("#tabs-t3r2").tabs();
			

			//hover states on the static widgets
			$('#dialog_link, ul#icons li').hover(
				function() { $(this).addClass('ui-state-hover'); }, 
				function() { $(this).removeClass('ui-state-hover'); }
			);
			listCriteria();
			$("#tabs").hide();
	});
	  
	//listYears();
	//listDivision();
	//listSection();
	//listArea();
	//listBranch();  
	//testProc();
	
	 
</script>
</body>
</html>