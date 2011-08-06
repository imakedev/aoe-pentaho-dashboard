<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Operation Dashboard Page</title>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

<link type="text/css"
	href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.min.js"></script>

<!-- Datepicker -->
<link href="<%=request.getContextPath()%>/chartLib/js/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/chartLib/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.min.js"></script>

<!--  DWR -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwroperationdashboard/interface/OperationDashboardAjax.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwroperationdashboard/engine.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwroperationdashboard/util.js"></script>

<script type="text/javascript">

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}

	function listDivision() {
		var mySelect = document.getElementById('Division');
		OperationDashboardAjax
				.listDivisions({
					callback : function(data) {
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								mySelect.add(new Option(data[i], data[i]));
							}
						}
					}
				});
	}

	function listSection() {
		var mySelect = document.getElementById('Section');
		OperationDashboardAjax
				.listSections({
					callback : function(data) {
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								mySelect.add(new Option(data[i], data[i]));
							}
						}
					}
				});
	}

	function listArea() {
		var mySelect = document.getElementById('Area');
		OperationDashboardAjax
				.listAreas({
					callback : function(data) {
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								mySelect.add(new Option(data[i], data[i]));
							}
						}
					}
				});
	}

	function listBranch() {
		var mySelect = document.getElementById('Branch');
		OperationDashboardAjax
				.listBranch({
					callback : function(data) {
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								mySelect.add(new Option(data[i].branchName, data[i].branchCode));
							}
						}
					}
				});
	}
	
	function getSummaryMTD(year, month) {
		var str = "";
		//alert("sad");
		OperationDashboardAjax
				.getSummaryMTD(year, month, {
					callback : function(data) {
						var division= new Array();
						var lastNetSalesAmt=new Array();
						var netSalesAmt=new Array();
						var salesTargetAmt=new Array();
						for(var i=0;i<data.length;i++) {
							division[i] = data[i].division;
							lastNetSalesAmt[i] = data[i].lastNetSalesAmt;
							netSalesAmt[i] = data[i].netSalesAmt;
							salesTargetAmt[i] = data[i].salesTargetAmt;
						}
						var barSales1 = {
								"graphset":[
							    {
									"background-color":"#FFFFFF",
							        "type":"bar",
							        "legend" : {
										"background-color": "#FFFFFF",
							    		"border-width": "2px",
										"border-color": "#4C77B6",
										"x": 570,
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
							            "values":division,
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
										"values" : lastNetSalesAmt,
										 "background-color" : "#66CC00",
								 /*"url": "<%//=request.getContextPath()%>/SNP/Finance/Operation_Bar1.jsp",
								 "target" : "_self",*/
										 "text" : "ยอดขาย Last"
									 },
									 {
										"values" : netSalesAmt,
										 "background-color" : "#EEEE00",
										 "text" : "ยอดขาย"
									 },
									 {
										"values" : salesTargetAmt,
										 "background-color" : "#696969",
										 "text" : "เป้าหมาย"
									 }] 
								  }]
								};
						
		zingchart.render({
			id 			: 'chart_sales',
			width 		: 700,
			height 		: 250,
			data 		: barSales1
		});
	}});
	}
	
	function getSummaryMTDDivision(division, year, month) {
		var str = "";
		//alert("sad");
		OperationDashboardAjax
				.getSummaryMTDDivision(division, year, month, {
					callback : function(data) {
						var division= new Array();
						var lastNetSalesAmt=new Array();
						var netSalesAmt=new Array();
						var salesTargetAmt=new Array();
						for(var i=0;i<data.length;i++) {
							division[i] = data[i].division;
							lastNetSalesAmt[i] = data[i].lastNetSalesAmt;
							netSalesAmt[i] = data[i].netSalesAmt;
							salesTargetAmt[i] = data[i].salesTargetAmt;
						}
						var barSales1 = {
								"graphset":[
							    {
									"background-color":"#FFFFFF",
							        "type":"bar",
							        "legend" : {
										"background-color": "#FFFFFF",
							    		"border-width": "2px",
										"border-color": "#4C77B6",
										"x": 570,
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
							            "values":division,
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
										"values" : lastNetSalesAmt,
										 "background-color" : "#66CC00",
								 /*"url": "<%//=request.getContextPath()%>/SNP/Finance/Operation_Bar1.jsp",
								 "target" : "_self",*/
										 "text" : "ยอดขาย Last"
									 },
									 {
										"values" : netSalesAmt,
										 "background-color" : "#EEEE00",
										 "text" : "ยอดขาย"
									 },
									 {
										"values" : salesTargetAmt,
										 "background-color" : "#696969",
										 "text" : "เป้าหมาย"
									 }] 
								  }]
								};
						
		zingchart.render({
			id 			: 'chart_sales',
			width 		: 700,
			height 		: 250,
			data 		: barSales1
		});
	}});
	}
	
	function getSummaryMTDDivisionSection(section, division, year, month) {
		var str = "";
		//alert("sad");
		OperationDashboardAjax
				.getSummaryMTDDivisionSection(section, division, year, month, {
					callback : function(data) {
						var division= new Array();
						var lastNetSalesAmt=new Array();
						var netSalesAmt=new Array();
						var salesTargetAmt=new Array();
						for(var i=0;i<data.length;i++) {
							division[i] = data[i].division;
							lastNetSalesAmt[i] = data[i].lastNetSalesAmt;
							netSalesAmt[i] = data[i].netSalesAmt;
							salesTargetAmt[i] = data[i].salesTargetAmt;
						}
						var barSales1 = {
								"graphset":[
							    {
									"background-color":"#FFFFFF",
							        "type":"bar",
							        "legend" : {
										"background-color": "#FFFFFF",
							    		"border-width": "2px",
										"border-color": "#4C77B6",
										"x": 570,
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
							            "values":division,
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
										"values" : lastNetSalesAmt,
										 "background-color" : "#66CC00",
								 /*"url": "<%//=request.getContextPath()%>/SNP/Finance/Operation_Bar1.jsp",
								 "target" : "_self",*/
										 "text" : "ยอดขาย Last"
									 },
									 {
										"values" : netSalesAmt,
										 "background-color" : "#EEEE00",
										 "text" : "ยอดขาย"
									 },
									 {
										"values" : salesTargetAmt,
										 "background-color" : "#696969",
										 "text" : "เป้าหมาย"
									 }] 
								  }]
								};
						
		zingchart.render({
			id 			: 'chart_sales',
			width 		: 700,
			height 		: 250,
			data 		: barSales1
		});
	}});
	}
	
	function getSalesTrend(year, month, branch, area, section, division) {
		//alert("getSalesTrend");
		var salesDate = new Array();
		var actualVSTarget = new Array();
		var growth = new Array();
		var netSalesLast = new Array();
		var target = new Array();
		OperationDashboardAjax.getSalesTrend(year, month, branch, area, section, division, {
			callback : function(data) {
				//alert(data);
				if(data != null) {
					for(var i=0;i<data.length;i++) {
						salesDate[i] = data[i].salesDate;
						actualVSTarget[i] = data[i].actualVSTarget;
						growth[i] = data[i].growth;
						netSalesLast[i] = data[i].netSalesLast;
						target[i] = data[i].target;
					}
					
					var mixedMTD = {
							"graphset":[
							    {
									"background-color":"#FFFFFF",
							        "type":"mixed",
							        "chart":{
										"margin":"10 155 30 50"
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
										"values": salesDate,
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
							                "values": netSalesLast,
							                "border-width":1,
											"stacked":0,
											"background-color" : "#66CC00",
											"border-color":"#66CC00",
							                "text":"Actual YTD 09"
							            },
							            {
							                "type":"bar",
							                "values": netSalesAmtThis,
							                "text":"Actual YTD 10",
											"stacked":0,
											"background-color" : "#EEEE00",
											"border-color":"#EEEE00",
							                "border-width":1
							            },
										{
							                "type":"bar",
							                "values":target,
							                "text":"Target YTD",
											"stacked":0,
											"background-color" : "#696969",
											"border-color":"#696969",
							                "border-width":1
							            },
							            {
							                "type":"line",
							                "values":actualVSTarget,
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
							                "values": growth,
							                "text":"%Growth YTD",
							                "scales":"scale-x,scale-y-2",
							                "stacked":"0",
											"line-color" : "#3860BB",
							                "marker":{
							                    "size":3
							                },
							                "tooltip-text":"%v%"
							            }]
							        }]
							    };
					
					zingchart.render({
						id : 'g6',
						width : 870,
						height : 350,
						data : mixedMTD
					});
				}
			}
		});
		
	}
	
	function getSalesGrowth(year, month, limit, order) {
		//alert("getSalesGrowth");
		OperationDashboardAjax.getSalesGrowth(year, month, limit, order, {
			callback : function(data) {
				if(data != null) {
					var str = '<table bordercolor="#000000" frame="box" rules="all"><tr bgcolor="#CD853F"><th width="50"><font color="#FFFFFF">#</font></th><th width="150"><font color="#FFFFFF">สาขา</font></th><th width="70"><font color="#FFFFFF">ยอดขาย</font></th><th width="100"><font color="#FFFFFF">Last ยอดขาย</font></th><th width="100"><font color="#FFFFFF">Diff ยอดขาย</font></th><th width="70"><font color="#FFFFFF">% Growth</font></th></tr>';
					for(var i=0;i<data.length;i++) {
						str += '<tr><td align=center>'+(i+1)+'</td><td align=center>'+data[i].branchName+'</td><td align=center>'+data[i].sales+'</td><td align=center>'+data[i].lastSales+'</td><td align=center>'+data[i].diff+'</td><td align=center>'+data[i].percentGrowth+'</td></tr>';
					}
					str += '</table>';
				}
				//alert(data.length);
				document.getElementById('saleGrowthTableDiv').innerHTML = str;
				document.getElementById('salePerDayTableDiv').innerHTML = str;
			}
		});
		//var str = '<table bordercolor="#000000" frame="box" rules="all"><tr bgcolor="#CD853F"><th width="50"><font color="#FFFFFF">#</font></th><th width="150"><font color="#FFFFFF">สาขา</font></th><th width="70"><font color="#FFFFFF">ยอดขาย</font></th><th width="100"><font color="#FFFFFF">Last ยอดขาย</font></th><th width="100"><font color="#FFFFFF">Diff ยอดขาย</font></th><th width="70"><font color="#FFFFFF">% Growth</font></th></tr><tr><td align=center>1</td><td align=center>โลตัส บางใหญ่</td><td align=center>500,000</td><td align=center>600,000</td><td align=center>100,000</td><td align=center>10</td></tr><tr><td align=center>2</td><td align=center>วงศ์สว่าง</td><td align=center>400,000</td><td align=center>450,000</td><td align=center>50,000</td><td align=center>9</td></tr><tr><td align=center>3</td><td align=center>อาคารสินธร</td><td align=center>300,000</td><td align=center>320,000</td><td align=center>20,000</td><td align=center>9</td></tr><tr><td align=center>4</td><td align=center>โลตัส ประชาชื่น</td><td align=center>200,000</td><td align=center>210,000</td><td align=center>10,000</td><td align=center>7</td></tr><tr><td align=center>5</td><td align=center>โลตัสบางกะปิ</td><td align=center>100,000</td><td align=center>100,000</td><td align=center>0</td><td align=center>6</td></tr><tr><td align=center>6</td><td align=center>โลตัสสระบุรี</td><td align=center>100,000</td><td align=center>100,000</td><td align=center>0</td><td align=center>5</td></tr><tr><td align=center>7</td><td align=center>โลตัสลำลูกกา</td><td align=center>100,000</td><td align=center>100,000</td><td align=center>0</td><td align=center>5</td></tr><tr><td align=center>8</td><td align=center>โลตัสฟอร์จูน</td><td align=center>100,000</td><td align=center>100,000</td><td align=center>0</td><td align=center>4</td></tr><tr><td align=center>9</td><td align=center>โลตัสรามอินทรา</td><td align=center>100,000</td><td align=center>100,000</td><td align=center>0</td><td align=center>3</td></tr><tr><td align=center>10</td><td align=center>โลตัสภูเก็ต</td><td align=center>100,000</td><td align=center>100,000</td><td align=center>0</td><td align=center>3</td></tr></table>';
		//document.getElementById('saleGrowthTableDiv').innerHTML = str;
	}
	
	function getSalesBySalesType(year, month, branch, area, section, division) {
		var dayOfWeek = new Array();
		var salesAmt = new Array();
		var saleType = new Array();
		OperationDashboardAjax.getSalesBySalesType(year, month, branch, area, section, division, {
			callback : function(data) {
				if(data != null) {
					for(var i=0;i<data.length;i++) {
						//growth_per[i] = i+1*10;
						dayOfWeek[i] = data[i].dayOfWeek;
						salesAmt[i] = data[i].salesAmt;
						saleType[i] = data[i].saleType;
					}
				}
				//alert(data.length);
			}
		});
		
		var stackedSales = {
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
	    				"values":["THU", "FRI", "SAT", "SUN", "MON", "TUE", "WED"],
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
		
		zingchart.render({
			id : 'g7',
			width : 510,
			height : 235,
			data : stackedSales
		});
	}
	
	function getSale_Day_PercentGrowth(year, month) {
		//alert("getSale_Day_PercentGrowth");
		var growth_per = new Array();
		OperationDashboardAjax.getSale_Day_PercentGrowth(year, month, {
			callback : function(data) {
				if(data != null) {
					for(var i=0;i<data.length;i++) {
						growth_per[i] = data[i].percentGrowth;
					}
					
					var bar1 = {
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
						            "max-items":10,
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
						                "values": growth_per,
										"url": "<%//=request.getContextPath()%>/Dashboard/Operation.jsp?y=<%//=y%>&months=<%//=months%>&sb=<%//=sb%>&div=<%//=div%>&sect=<%//=sect%>&zone=<%//=zone%>&maj=<%//=maj%>&b1=%v&b2=<%//=b2%>#tabs-t1r3_1",
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
						
						zingchart.render({
							id 			: 'g1',
							width 		: 500,
							height 		: 250,
							data 		: bar1
						});
				}
				//alert(data.length);
			}
		});
		
	}
	
	function getRegionGrowth(year, month) {
		OperationDashboardAjax.getRegionGrowth(year, month, {
			callback : function(data) {
				if(data != null) {
					var str = '<table bordercolor="#000000" frame="box" rules="all" width=100%><tr bgcolor="#CD853F"><th rowspan=2 align=center><font color="#FFFFFF">ภาค</font></th><th align=center colspan=2><font color="#FFFFFF">ยอดขาย</font></th><th rowspan=2><font color="#FFFFFF">%Growth</font></th></tr><tr bgcolor="#CD853F"><th align=center><font color="#FFFFFF">Dec 53</font></th><th align=center><font color="#FFFFFF">Dec 54</font></th></tr>';
					for(var i=0;i<data.length;i++) {
						str += '<tr><td align=center>'+data[i].region+'</td><td align=center>'+data[i].lastSalesAmt+'</td><td align=center>'+data[i].thisSalesAmt+'</td><td align=center>'+data[i].growth+'</td></tr>';
					}
					str += '</table>';
					document.getElementById('regionGrowthTableDiv').innerHTML = str;
				}
				//alert(data.length);
			}
		});
	}
	
	function getProductGroups(productCategory) {
		//alert(productCategory);
		OperationDashboardAjax.getProductGroups(productCategory, {
			callback : function(data) {
				if(data != null) {
					var str = '<select name="param" MULTIPLE size="6"  style="width:150px;">';
					for(var i=0;i<data.length;i++) {
						str += '<option value="'+data[i]+'">&nbsp;'+data[i]+'</option>';
					}
					str += '</select>';
					document.getElementById('productGroupDiv').innerHTML = str;
				}
				//alert(data.length);
			}
		});
	}

	function getProductCategories() {
		OperationDashboardAjax.getProductCategories({
			callback : function(data) {
				if(data != null) {
					var str = '<select name="param" size="3"  style="width:150px;" onchange="getProductGroups(this.options[this.selectedIndex].value)">';
					for(var i=0;i<data.length;i++) {
						str += '<option value="'+data[i]+'">&nbsp;'+data[i]+'</option>';
					}
				}
				//alert(data.length);
				str += '</select>';
				document.getElementById('categoryDiv').innerHTML = str;
			}
		});
	}
	
	function getNetSalesByProductGroup(year, month) {
		OperationDashboardAjax.getNetSalesByProductGroup(year, month, {
			callback : function(data) {
				//alert(data.length);
				var productGroup = new Array();
				var netSales = new Array();
				var str = '<table width="350" height="220" bordercolor="#000000" frame="box" rules="all"><tr bgcolor="#CD853F"><th colspan=3><font color="#FFFFFF">Change</font></th></tr><tr bgcolor="#CD853F"><th><font color="#FFFFFF">MB</font></th><th><font color="#FFFFFF">vs.LY</font></th><th><font color="#FFFFFF">vs.Plan</font></th></tr>';
				if(data != null) {
					for(var i=0;i<data.length;i++) {
						productGroup[i] = data[i].productGroup;
						netSales[i] = data[i].netSales;
						str += '<tr><td align=right>'+data[i].netSales+'</td><td align=right>'+data[i].vsly+'</td><td align=right><font color=red>'+data[i].vsplan+'</font></td></tr>';
					}
					str += '</table>';
					document.getElementById('netSalesProductGroupTableDiv').innerHTML = str;
					
					var mixedSalesPG = {
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
						            "values": productGroup,
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
						                "values": netSales,
						                "text":"Goals"
						            }]
						        }]
						    };
					
					zingchart.render({
						id 			: 'gPG',
						width 		: 600,
						height 		: 270,
						data 		: mixedSalesPG
					});
				}
			}
		});
	}
	
	function getNetSalesByBranchStatus(year, month) {
		var lastNetSales = new Array();
		var netSales = new Array();
		var percentGrowth = new Array();
		OperationDashboardAjax.getNetSalesByBranchStatus(year, month, {
			callback : function(data) {
				//alert(data.length);
				if(data != null) {
					for(var i=0;i<data.length;i++) {
						/*lastNetSales[i] = data[i].lastNetSales;
						netSales[i] = data[i].netSales;
						percentGrowth[i] = data[i].percentGrowth;*/
						
						lastNetSales[i] = i+3*10;
						netSales[i] = i+2*10;
						percentGrowth[i] = i+1*10;
					}
				}
			}
		});
		
		var mixedNetSales = {
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
				            "values":["Same","New","Change"],
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
								"values": lastNetSales,
								"border-width":1,
								"stacked":0,
								"background-color" : "#66CC00",
								"border-color":"#66CC00",
				                "text":"ยอดขาย Last"
				            },
				            {
				                "type":"bar",
								"values": netSales,
								"text":"ยอดขาย",
								"stacked":0,
								"background-color" : "#EEEE00",
								"border-color":"#EEEE00",
				                "border-width":1
				            },
				            {
				                "type":"line",
				                "values": percentGrowth,
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
		
		zingchart.render({
			id 			: 'g3',
			width 		: 800,
			height 		: 250,
			data 		: mixedNetSales
		});
	}
	
	function getNetSales(year, month, branch, area, section, division) {
		OperationDashboardAjax.getNetSales(year, month, branch, area, section, division, {
			callback : function(data) {
				//alert(data.length);
				if(data != null) {
					var str = '<table width="300" bordercolor="#000000" frame="box" rules="all"><tr bgcolor="#CD853F"><th colspan="4"><font color="#FFFFFF">Change</font></th></tr><tr bgcolor="#CD853F"><th width="100"></th><th><font color="#FFFFFF">MB</font></th><th><font color="#FFFFFF">vs.LY</font></th><th><font color="#FFFFFF">vs.Plan</font></th></tr>';
					for(var i=0;i<data.length;i++) {
						str += '<tr><td>'+data[i].productGroup+'</td><td align="right">'+data[i].netSales+'</td><td align="right">'+data[i].vsly+'</td><td align="right">'+data[i].vsplan+'</td></tr>';
					}
					str += '</table>';
					document.getElementById('netSaleTableDiv').innerHTML = str;
				}
				
				var pieNet = {
						  "graphset" : [
						  {
							"title":{
								"text": "Net Sales by Category",
								"background-color":"#FFFFFF",
								"color": "#000000"
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
						    "series" : [
						     {
						         "values" : [48.39],
								 "text" : "Bakery",
						 		 "tooltip-text" : "%t: 564.00"
						     },
						     {
						         "values": [26.76],
								 "text" : "Food",
						 		 "tooltip-text" : "%t: 320.80"
						     },
						     {
						         "values": [6.24],
								 "text" : "OPO",
						 		 "tooltip-text" : "%t: 47.50"
						     },
						     {
						         "values": [12.52],
								 "text" : "PP",
						 		 "tooltip-text" : "%t: 128.30"
						     },
						     {
						         "values": [10.33],
								 "text" : "Beverage",
						 		 "tooltip-text" : "%t: 107.20"
						     }] 
						  }]
						};
				
				zingchart.render({
					id : 'g4',
					width : 235,
					height : 270,
					data : pieNet
				});
			}
		});
	}
	
	function getLucre(year, month, limit) {
		OperationDashboardAjax.getLucre(year, month, limit, {
			callback : function(data) {
				if(data != null) {
					var str = '<table width=500 bordercolor="#000000" frame="box" rules="all"><tr bgcolor="#CD853F"><th><font color="#FFFFFF">#</font></th><th><font color="#FFFFFF">สาขา</font></th><th><font color="#FFFFFF">กำไร (บาท)</font></th><th><font color="#FFFFFF">%GP</font></th></tr>';
					for(var i=0;i<data.length;i++) {
						str += '<tr><td align=center>'+(i+1)+'</td><td align=center>'+data[i].branchName+'</td><td align=right>'+data[i].gpamt+'</td><td align=right>'+data[i].percentGP+'</td></tr>';
					}
					str += '</table>';
					document.getElementById('topProfitTableDiv').innerHTML = str;
				}
				//alert(data.length);
			}
		});
	}
	
	function getLoss(year, month, limit) {
		OperationDashboardAjax.getLoss(year, month, limit, {
			callback : function(data) {
				if(data != null) {
					var str = '<table width=500 bordercolor="#000000" frame="box" rules="all"><tr  bgcolor="#CD853F"><th><font color="#FFFFFF">#</font></th><th><font color="#FFFFFF">สาขา</font></th><th><font color="#FFFFFF">กำไร (บาท)</font></th><th><font color="#FFFFFF">%GP</font></th></tr>';
					for(var i=0;i<data.length;i++) {
						str += '<tr><td align=center>'+(i+1)+'</td><td align=center>'+data[i].branchName+'</td><td align=right>'+data[i].gpamt+'</td><td align=right>'+data[i].percentGP+'</td></tr>';
					}
					str += '</table>';
					document.getElementById('bottomProfitTableDiv').innerHTML = str;
				}
				//alert(data.length);
			}
		});
		
	}
	
	function getGoogleMap(year, month) {
		//OperationDashboardAjax.getGoogleMap(year, month, {
		//	callback : function(data) {
		//		alert(data.length);
		//	}
		//});
	}
	
	function getDiscount(year, month, branch, area, section, division) {
		var discountLastYear = new Array();
		var discountThisYear = new Array();
		var plan = new Array();
		OperationDashboardAjax.getDiscount(year, month, branch, area, section, division, {
			callback : function(data) {
				if(data != null) {
					for(var i=0;i<data.length;i++) {
						discountLastYear[i] = data[i].discountLastYear;
						discountThisYear[i] = data[i].discountThisYear;
						plan[i] = data[i].plan;
					}
					var barDiscount = {
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
				    				"bar-width":"25px"
				    			},
				    		    "series" : [
				    		     {
				    		        "values" : discountLastYear,
				    				 "background-color" : "#66CC00",
				    		 //"url": "<%=request.getContextPath()%>/Dashboard/Operation-Discount(test).jsp",
				    		 //"target" : "_self",
				    				 "text" : "Last Year"
				    		     },
				    		     {
				    		        "values" : discountThisYear,
				    				 "background-color" : "#EEEE00",
				    				 "text" : "This Year"
				    		     },
				    		     {
				    		        "values" : plan,
				    				 "background-color" : "#696969",
				    				 "text" : "Plan"
				    		     }] 
				    		  }]
				    		};
					
					zingchart.render({
						id : 'g8',
						width : 450,
						height : 235,
						data : barDiscount
					});
				}
				//alert(data.length);
			}
		});
	}
	
	function getCustomerPerDay(year, month, branch, area, section, division) {
		var customerPerDayLast = new Array();
		var customerPerDayThis = new Array();
		var growth = new Array();
		OperationDashboardAjax.getCustomerPerDay(year, month, branch, area, section, division, {
			callback : function(data) {
				//alert(data.length);
				if(data != null) {
					for(var i=0;i<data.length;i++) {
						customerPerDayLast[i] = data[i].customerPerDayLast;
						customerPerDayThis[i] = data[i].customerPerDayThis;
						growth[i] = data[i].growth;
					}
					
					var barCust = {
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
				    				"bar-width":"25px"
				    			},
				    		    "series" : [
				    		     {
				    		        "values" : customerPerDayLast,
				    				"background-color":"#66CC00",
				    				"text":"MTD ปีที่แล้ว"
				    		     },
				    		     {
				    		        "values" : customerPerDayThis,
				    				"background-color":"#EEEE00",
				    				"text":"MTD ปีนี้"
				    		     },
				    		     {
				    		        "values" : growth,
				    				"background-color":"#696969",
				    				"text":"%Growth",
				    		        "scales":"scale-x,scale-y-2"
				    		     }] 
				    		  }]
				    		};
					
					zingchart.render({
						id : 'g10',
						width : 400,
						height : 235,
						data : barCust
					});
				}
			}
		});
	}
	
	function getCost(year, month, branch, area, section, division) {
		OperationDashboardAjax.getCost(year, month, branch, area, section, division, {
			callback : function(data) {
				//alert(data.length);
				if(data != null) {
					var str = '<table width="300" bordercolor="#000000" frame="box" rules="all"><tr bgcolor="#CD853F"><th colspan="4"><font color="#FFFFFF">Change</font></th></tr><tr bgcolor="#CD853F"><th width="100"></th><th><font color="#FFFFFF">MB</font></th><th><font color="#FFFFFF">vs.LY</font></th><th><font color="#FFFFFF">vs.Plan</font></th></tr>';
					for(var i=0;i<data.length;i++) {
						str += '<tr><td>'+data[i].productGroup+'</td><td align="right">'+data[i].costAmt+'</td><td align="right">'+data[i].costAmtLastYear+'</td><td align="right">0%</td></tr>';
					}
					str += '</table>';
					document.getElementById('costTableDiv').innerHTML = str;
				}
			}
		});
		
		var pieCost = {
				  "graphset" : [
				  {
					"title":{
						"text": "Cost by Category",
						"background-color":"#FFFFFF",
						"color": "#000000"
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
				    "series" : [
				     {
				         "values" : [48.39],
						 "text" : "Bakery",
				 		 "tooltip-text" : "%t: 564.00"
				     },
				     {
				         "values": [26.76],
						 "text" : "Food",
				 		 "tooltip-text" : "%t: 320.80"
				     },
				     {
				         "values": [6.24],
						 "text" : "OPO",
				 		 "tooltip-text" : "%t: 47.50"
				     },
				     {
				         "values": [12.52],
						 "text" : "PP",
				 		 "tooltip-text" : "%t: 128.30"
				     },
				     {
				         "values": [10.33],
						 "text" : "Beverage",
				 		 "tooltip-text" : "%t: 107.20"
				     }] 
				  }]
				};
		
		zingchart.render({
			id : 'g5',
			width : 235,
			height : 270,
			data : pieCost
		});
	}
	
	function getAverageSalesPerBill(year, month, branch, area, section, division) {
		var growth = new Array();
		var salesPerBillLast = new Array();
		var salesPerBillThis = new Array();
		
		OperationDashboardAjax.getAverageSalesPerBill(year, month, branch, area, section, division, {
			callback : function(data) {
				//alert(data.length);
				if(data != null) {
					for(var i=0;i<data.length;i++) {
						growth[i] = data[i].growth;
						salesPerBillLast[i] = data[i].salesPerBillLast;
						salesPerBillThis[i] = data[i].salesPerBillThis;
					}
					
					var barAvgs = {
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
				    				"bar-width":"25px"
				    			},
				    		    "series" : [
				    		     {
				    		        "values" : salesPerBillLast,
				    				"background-color":"#66CC00",
				    				"text":"MTD ปีที่แล้ว"
				    		     },
				    		     {
				    		        "values" : salesPerBillThis,
				    				"background-color":"#EEEE00",
				    				"text":"MTD ปีนี้"
				    		     },
				    		     {
				    		        "values" : growth,
				    				"background-color":"#696969",
				    				"text":"%Growth",
				    		        "scales":"scale-x,scale-y-2"
				    		     }] 
				    		  }]
				    		};
					
					zingchart.render({
						id : 'g11',
						width : 400,
						height : 235,
						data : barAvgs
					});
				}
			}
		});
	}
	
	function getAverageCheck(year, month, branch, area, section, division) {
		var avgCheckLast = new Array();
		var avgCheckThis = new Array();
		var growth = new Array();
		OperationDashboardAjax.getAverageCheck(year, month, branch, area, section, division, {
			callback : function(data) {
				//alert(data.length);
				if(data != null) {
					for(var i=0;i<data.length;i++) {
						avgCheckLast[i] = data[i].avgCheckLast;
						avgCheckThis[i] = data[i].avgCheckThis;
						growth[i] = data[i].growth;
					}
					
					var barAvg = {
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
				    				"bar-width":"25px"
				    			},
				    		    "series" : [
				    		     {
				    		        "values" : avgCheckLast,
				    				"background-color" : "#66CC00",
				    				"text":"MTD ปีที่แล้ว"
				    		     },
				    		     {
				    		        "values" : avgCheckThis,
				    				"background-color" : "#EEEE00",
				    				"text":"MTD ปีนี้"
				    		     },
				    		     {
				    		        "values" : growth,
				    				"background-color" : "#696969",
				    				"text":"%Growth",
				    		        "scales":"scale-x,scale-y-2"
				    		     }] 
				    		  }]
				    		};
					
					zingchart.render({
						id : 'g9',
						width : 400,
						height : 235,
						data : barAvg
					});
				}
			}
		});
	}
	
	
	$(function() {
		$("#datepicker").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "d/m/yy"
		});
	});
	
	$(function() {
		// Tabs
		$("#tabs").tabs();
		$("#tabs-t1r1").tabs();
		$("#tabs-t1r2").tabs();
		$("#tabs-t1r3").tabs();
		$("#tabs-t1r4").tabs();

		$("#tabs-t2r1c1").tabs();
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
		$('#dialog_link, ul#icons li').hover(function() {
			$(this).addClass('ui-state-hover');
		}, function() {
			$(this).removeClass('ui-state-hover');
		});
	});

	/*$(function() {
		// Bar charts using inline values
		$('.bar').sparkline('html', {
			type : 'bar'
		});
	});*/
	
	var year = '';
	var month = '';
	function parameterForm() {
		var datepicker = document.getElementById('datepicker').value;
		var dateSpl = datepicker.split('/');
		year = dateSpl[2];
		month = dateSpl[1];
		if(datepicker == '') {
			alert("กรุณากรอกวันที่");
		} else {
			//alert(year +" : "+month);
			var sumBy = document.getElementById('SumBy').options[document.getElementById('SumBy').selectedIndex].value;
			var division = document.getElementById('Division').options[document.getElementById('Division').selectedIndex].value;
			var section = document.getElementById('Section').options[document.getElementById('Section').selectedIndex].value;
			var area = document.getElementById('Area').options[document.getElementById('Area').selectedIndex].value;
			var branch = document.getElementById('Branch').options[document.getElementById('Branch').selectedIndex].value;
			var tabSelected = document.getElementById('selectedTab').value;
			//alert(tabSelected);
			if(tabSelected == 'detail') {
				getNetSales(year, month, branch, area, section, division);
				getCost(year, month, branch, area, section, division);
				getProductCategories();
				//getProductGroups('category');
				getSalesTrend(2011,3, branch, area, section, division);
			} else if(tabSelected == 'map') {
				
			} else {
				
				//getSummaryMTD(2011,3);
				//getSummaryMTDDivision('.',2011,3);
				getSummaryMTDDivisionSection(division.trim(),section.trim(),year,month);
				
				var topProfit = document.getElementById('topProfit').value;
				var bottomProfit = document.getElementById('bottomProfit').value;
				getLucre(year, month, topProfit);
				getLoss(year, month, bottomProfit);
				
				var orderSaleGrowth = document.getElementById('orderSaleGrowth').options[document.getElementById('orderSaleGrowth').selectedIndex].value;
				var saleGrowthLimit = document.getElementById('saleGrowthLimit').value;
				getSalesGrowth(year, month, saleGrowthLimit, orderSaleGrowth);
				getSale_Day_PercentGrowth(year, month); // Make data draw graph
				
				getNetSalesByBranchStatus(year, month); // Don't have data
				getNetSalesByProductGroup(year, month); // Don't have data
			}
		}
		
		//location.href = '<%//=request.getContextPath()%>/Dashboard/Operation/Operations.jsp?y='+y+'&months='+months+'&sb='+sb+'&div='+div+'&sect='+sect+'&zone='+zone+'&maj='+maj+'&b1=0&b2=0';
	}
	
	function setSelectTab(tab) {
		document.getElementById('selectedTab').value = tab;
	}
	
	function getTopProfitTable() {
		var topProfit = document.getElementById('topProfit').value;
		getLucre(year, month, topProfit);
	}
	
	function getBottomProfitTable() {
		var bottomProfit = document.getElementById('bottomProfit').value;
		getLoss(year, month, bottomProfit);
	}
	
	function getSaleGrowth() {
		var orderSaleGrowth = document.getElementById('orderSaleGrowth').options[document.getElementById('orderSaleGrowth').selectedIndex].value;
		var saleGrowthLimit = document.getElementById('saleGrowthLimit').value;
		getSalesGrowth(year, month, saleGrowthLimit, orderSaleGrowth);
	}
</script>
<style type="text/css">
body {
	font: 55% "Trebuchet MS", sans-serif;
	margin: 50px;
}

.demoHeaders {
	margin-top: 1em;
}

#dialog_link {
	padding: .1em 1em .1em 20px;
	text-decoration: none;
	position: relative;
}

#dialog_link span.ui-icon {
	margin: 0 5px 0 0;
	position: absolute;
	top: 50%;
	margin-top: -8px;
}

ul#icons {
	margin: 0;
	padding: 0;
}

ul#icons li {
	margin: 1px;
	position: relative;
	padding: 1px 0;
	cursor: pointer;
	float: left;
	list-style: none;
}

ul#icons span.ui-icon {
	float: left;
	margin: 0 4px;
}

#tabs {
	top: 80px;
	left: 5px;
}
</style>
</head>
<body>
<input type="hidden" id="selectedTab" value="summary">
<!--         Parameter              -->
<div style="position: absolute; left: 45px; top: 20px;"><font
	size="3"> วันที่:</font><input type="text" name="datepicker"
	id="datepicker" /></div>
<div style="position: absolute; left: 320px; top: 20px;"><font
	size="3"> สรุปตาม : </font> <select name="SumBy"
	onChange="getSumBy(this.value);">
	<option value="1">MTD</option>
	<option value="2">YTD</option>
</select></div>
<div style="position: absolute; left: 600px; top: 20px;"><font
	size="3"> ฝ่าย : </font><span id="divisionListDiv"><select name="Division" onChange="getDivision(this.value);" id="Division"></select></span></div>
<div style="position: absolute; left: 45px; top: 50px;"><font
	size="3"> ส่วน : </font><span id="sectionListDiv"><select name="Section" onChange="getSection(this.value);" id="Section"></select></span></div>
<div style="position: absolute; left: 600px; top: 50px;"><font
	size="3"> เขต : </font><span id="areaListDiv"><select name="Area" onChange="getArea(this.value);" id="Area"></select></span></div>
<div style="position: absolute; left: 45px; top: 80px;"><font
	size="3"> สาขา : </font><span id="branchListDiv"><select name="Branch" onChange="getBranch(this.value);" id="Branch"></select></span></div>
<div style="position: absolute; left:700px; top: 80px;">
		<input type="button" value=" OK " onClick="parameterForm()"/>
</div>
<!-- End Parameter -->
<!--+++++++++++++++++++++++++ Tab Menu +++++++++++++++++++++++++-->
<div id="tabs" style="position: absolute; top:150px" bordercolor="#FFFFFF"
	border="5">
<ul>
	<li><a href="#tabs-t1" onclick="setSelectTab('summary');init()">Summary</a></li>
	<li><a href="#tabs-t2" onclick="setSelectTab('detail');init()">Detail</a></li>
	<li><a href="#tabs-t3" onclick="setSelectTab('map');init()">Map</a></li>
</ul>

<!--+++++++++++++++++++++++++ Tab Summary +++++++++++++++++++++++++-->
<table id="tabs-t1">
	<tr>
		<td>
		<table id="tabs-t1r1" width=1060>
			<tr bgcolor="#8B4513">
				<th><font color="#FFE742" size="3">ยอดขาย (ล้านบาท)</font></th>
			</tr>
			<tr>
				<td align="center">
				<div id="chart_sales"></div>
				</td>
			</tr>
			<!-- Chart -->
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
				<td>กำไรสูงสุด : <input type="text" id="topProfit" value="10"><input type="button" name="ok" value=" OK " onclick="getTopProfitTable()"/></td>
				<td>กำไรสูงสุด : <input type="text" id="bottomProfit" value="10"><input type="button" name="ok" value=" OK " onclick="getBottomProfitTable()"/></td>
			</tr>
			<tr>
			<td><p></p>
				<div id="topProfitTableDiv"></div>
			</td>

			<td><p></p>
				<div id="bottomProfitTableDiv"></div>
			</td>

			</tr>
			</table>

			<table id="tabs-t1r2_2">
			<tr><td width="1048">
				<select id="orderSaleGrowth">
					<option value="desc">ยอดขายสูงสุด</option>
					<option value="asc">ยอดขายต่ำสุด</option>
				</select>
				<input type="text" value="10" id="saleGrowthLimit">
				<input type="button" name="ok" value=" OK " onclick="getSaleGrowth()"/>
				<p></p>
			</td></tr>

			<tr><td align="center">
				<div id="saleGrowthTableDiv"></div>
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
				<select name="salesday" onChange="getChart(this.value);">
					<option value="1"># of branch</option>
					<option value="2">% Change in Sales</option>
				</select>
				<input type="button" name="ok" value=" OK "/>
			</td></tr>
			<tr>
				<td id="g1"></td><!-- Chart -->
				<td>
					<div id="salePerDayTableDiv"></div>
				</td><!-- Table of detail -->
			</tr>
			</table>
			<table id="tabs-t1r3_2">
			<tr><td colspan="2">
				<select name="salesday" onChange="getChart(this.value);">
					<option value="1"># of branch</option>
					<option value="2">% Change in Sales</option>
				</select>
				<input type="button" name="ok" value=" OK "/>
			</td></tr>
			<tr>
				<td id="g2"></td><!-- Chart -->
				<td>
					<div id="ebitPerDayTableDiv"></div>
				</td>
			</tr>
			</table>

		</td></tr>
	</table>

	<!---------------------------- Row 4 ------------------------>
	<table id="tabs-t1r4" width=1060>
		<tr><td align="center">
			<ul>
				<li><a href="#tabs-t1r4_1">Net Sales By Branch Status</a></li>
				<li><a href="#tabs-t1r4_2">Net Sales By Product Group</a></li>
			</ul>

			<table id="tabs-t1r4_1" width="100%">
				<tr><td id="g3"></td></tr>
			</table>

			<table id="tabs-t1r4_2" width="100%">
				<tr>
					<td align="center" id="gPG"></td>
					<td valign="top" align="center" width="100%"><p></p>
						<div id="netSalesProductGroupTableDiv"></div>
					</td>
				</tr>
			</table>
		</td></tr>
	</table>
		</td></tr>
	</table>
<!--+++++++++++++++++++++++++ Tab Detail +++++++++++++++++++++++++-->
	<table id="tabs-t2">
	<tr><td>

		<table width=1060>
		<tr>
			<td id="tabs-t2r1c1" valign="top">
				<table width="450"><tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Profit and Loss</font></tr></table>
				<br>
				<div id="profitLossTableDiv"></div>
			</td>

			<td id="tabs-t2r1c2" width="600">
				<ul>
					<li><a href="#tabs-t2r1c2_1"> Net Sales </a></li>
					<li><a href="#tabs-t2r1c2_2"> Cost </a></li>
				 </ul>

				 <table id="tabs-t2r1c2_1">
					<tr>
						<td id="g4"></td>
						<td valign="top">
						<div id="netSaleTableDiv"></div>
						</td>
					</tr>
				 </table>

				 <table id="tabs-t2r1c2_2">
					<tr>
						<td id="g5"></td>
						<td valign="top">
						<div id="costTableDiv"></div>
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
					<div id="categoryDiv"></div>
					</td></tr>
					
					<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มสินค้า</font></tr>
					<tr><td>
					<div id="productGroupDiv"></div>
					</td></tr>

					<tr><td align="right"><input type="submit" name="ok" value=" OK "/></td></tr>
				</table></td>
				
				<td id="chart1"><div id="g6"></div></td>
			</tr>
		</table>

		<table width="1060">
		<tr>
			<td id="tabs-t2r3c1">
				<table width="520">
					<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Sales by Sales Type</font></th></tr>
					<tr><td id="g7"></td></tr>
				</table>
			</td>
			
			<td id="tabs-t2r3c2">
				<table width="520">
					<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Discount</font></th></tr>
					<tr><td align="center" id="g8"></td></tr>
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

			<div id="tabsG-1"><div align="center" id="g9"></div></div>
			<div id="tabsG-2"><div align="center" id="g10"></div></div>
			<div id="tabsG-3"><div align="center" id="g11"></div></div>
			</td>

			<td id="tabs-t2r4c2" width="530">
			<ul>
				<li><a href="#tabsGET-1"> Sales/Sqm/Day </a></li>
				<li><a href="#tabsGET-2"> Sales/Staff/Day </a></li>
				<li><a href="#tabsGET-3"> Seat Turn/Day </a></li>
			</ul>

			<div id="tabsGET-1"><div align="center" id="g12"></div></div>
			<div id="tabsGET-2"><div align="center" id="g13"></div></div>
			<div id="tabsGET-3"><div align="center" id="g14"></div></div>
			</td>
		</tr>
		</table>

		<table width="1060">
		<tr>
			<td id="tabs-t2r5c1"><table width="520">
				<tr bgcolor="#8B4513"><th><font color="#FFE742">Selling Product</font></th></tr>
				<tr><td>
					<div class="top">
						<select name="s">
							<option>ยอดขายสูงสุด</option>
							<option>ยอดขายต่ำสุด</option>
						</select>
						 <input type="text" name="size" value="10" size="1">
						 <input type="submit" name="ok" value=" OK "/>
					</div>
					<br>
					<table width="500" align="center" bordercolor="#000000" frame="box" rules="all">
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
				</td></tr>
			</table></td>

			<td id="tabs-t2r5c2"><table width="520">
				<tr bgcolor="#8B4513"><th><font color="#FFE742">New Product</font></th></tr>
				<tr><td>
				<div class="top">
					<select name="s">
						<option>ยอดขายสูงสุด</option>
						<option>ยอดขายต่ำสุด</option>
					</select>
					 <input type="text" name="size" value="10" size="1">
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
				<div id="regionGrowthTableDiv"></div>

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

	function initSummary(year, month) {
		getSummaryMTD(year,month);
		
		getLucre(year, month, 10);
		getLoss(year, month, 10);
		
		getSalesGrowth(year, month, 10, 'asc');
		getSale_Day_PercentGrowth(year, month); // Make data draw graph
		
		getNetSalesByBranchStatus(year, month); // Don't have data
		getNetSalesByProductGroup(year, month); // Don't have data
	}
	
	function initDetail(year, month) {
		//alert("initDetail");
		var division = document.getElementById('Division').options[document.getElementById('Division').selectedIndex].value;
		var section = document.getElementById('Section').options[document.getElementById('Section').selectedIndex].value;
		var area = document.getElementById('Area').options[document.getElementById('Area').selectedIndex].value;
		var branch = document.getElementById('Branch').options[document.getElementById('Branch').selectedIndex].value;

		getNetSales(year, month, branch, area, section, division);
		getCost(year, month, branch, area, section, division);
		getProductCategories();
		getSalesTrend(year, month, branch, area, section, division);
		
		getSalesBySalesType(year, month, branch, area, section, division);
		getDiscount(year, month, branch, area, section, division);
		
		getAverageCheck(year, month, branch, area, section, division);
		getCustomerPerDay(year, month, branch, area, section, division);
		getAverageSalesPerBill(year, month, branch, area, section, division);
	}
	
	function initMap(year, month) {
		getRegionGrowth(year, month);
		getGoogleMap(year, month);
	}
	
	function init() {
		var datepicker = document.getElementById('datepicker').value;
		var selectedTab = document.getElementById('selectedTab').value;
		//alert(selectedTab);
		if(datepicker == null || datepicker.trim().length == 0) {
			var curDate = new Date();
			year = curDate.getFullYear();
			month = curDate.getMonth()+1;
		} else {
			var dateSpl = datepicker.split('/');
			year = dateSpl[2];
			month = dateSpl[1];
		}
		if(selectedTab == "summary") {
			initSummary(year, month);
		} else if(selectedTab == "detail") {
			initDetail(year, month);
		} else if(selectedTab == "map") {
			initMap(year, month);
		}
	}
	
	/* Script on load */
	listDivision();
	listSection();
	listArea();
	listBranch();
	init();
	
	/* Script in use for Summary Tab */
	
	//getSummaryMTD(2011,3);
	//getSummaryMTDDivision('.',2011,3);
	//getSummaryMTDDivisionSection('ALL','ALL',2011,3);
	
	//getLucre(2011, 1, 10);
	//getLoss(2011, 1, 10);
	
	//getSalesGrowth(2011, 1, 10, 'asc');
	//getSale_Day_PercentGrowth(2011, 1); // Make data draw graph
	
	//getNetSalesByBranchStatus(2011, 1); // Don't have data
	//getNetSalesByProductGroup(2011, 1); // Don't have data
	
	/* Script in use for Detail Tab */
	//getNetSales(2011, 3, 'ALL', 'ALL', 'ALL', 'ALL');
	//getCost(2011, 3, 'ALL', 'ALL', 'ALL', 'ALL');
	
	//getProductCategories();
	//getProductGroups('category');
	//getSalesTrend(2011,3,'ALL','ALL','ALL','ALL');
	
	//getSalesBySalesType(2011, 3, 'ALL', 'ALL', 'ALL', 'ALL');
	//getDiscount(2011, 3, 'ALL', 'ALL', 'ALL', 'ALL');
	
	//getAverageCheck(2011, 3, 'ALL', 'ALL', 'ALL', 'ALL');
	//getCustomerPerDay(2011, 3, 'ALL', 'ALL', 'ALL', 'ALL');
	//getAverageSalesPerBill(2011, 3, 'ALL', 'ALL', 'ALL', 'ALL');
	
	/* Script in use for Map Tab */
	//getRegionGrowth(2011, 3);
	//getGoogleMap(2011, 3);
	
	
	
	
</script>
</body>
</html>