<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>HR Dashboard Page</title>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet" />	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<script type="text/javascript">
		$(function(){
			// Tabs
			$("#tabs").tabs();
			$("#tabs-r1c1").tabs();
			$("#tabs-r2c1").tabs();
			$("#tabs-r3c1").tabs();
			$("#tabs-r4c1").tabs();
			$("#tabs-r5c1").tabs();
			$("#tabs-r5c2").tabs();
			$("#tabs-r6c1").tabs();

			//hover states on the static widgets
			$('#dialog_link, ul#icons li').hover(
				function() { $(this).addClass('ui-state-hover'); }, 
				function() { $(this).removeClass('ui-state-hover'); }
			);
		});
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

<%
	String mPie = request.getParameter("mPie");
	String pm = ""; // Print Month

	if(!mPie.equals("1"))
	{
		pm = mPie.substring(0,3);
	}
%>

<script type="text/javascript">

	//-------------------- Chart 1 --------------------
	var mix1 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"%ค่าใช้จ่าย/ยอดขาย",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "29.21%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"scales":"scale-x,scale-y",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"scales":"scale-x,scale-y",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"scales":"scale-x,scale-y",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]
};
		//,
		//-------------------- Chart 2 --------------------
		var mix2 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"%ค่าใช้จ่าย YTD/ยอดขาย(YTD)",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.21%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]
};
		//,
		//-------------------- Chart 3 --------------------
		var mix3 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"%ค่าใช้จ่ายด้านสวัสดิการ/ค่าใช้จ่ายรวม",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]
};
		//,
		//-------------------- Chart 4 --------------------
		var mix4 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"%ค่าใช้จ่ายด้านสวัสดิการ YTD/ค่าใช้จ่ายรวม YTD",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]
};
		//,
		//-------------------- Chart 5 --------------------
		var mix5 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"%ค่าใช้จ่ายด้านอบรม/ค่าใช้จ่ายรวม",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "29.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					 "background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 6 --------------------
		var mix6 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"%ค่าใช้จ่ายด้านอบรม YTD/ค่าใช้จ่ายอบรม YTD",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 7 --------------------
		var mix7 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"%ค่าใช้จ่ายเงินเดือน/ค่าใช้จ่ายรวม",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 8 --------------------
		var mix8 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"%ค่าใช้จ่ายเงินเดือน YTD/ค่าใช้จ่ายรวม YTD",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 9 --------------------
		var mix9 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"ยอดขาย/คน",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 10 --------------------
		var mix10 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"ยอดขาย YTD/คน",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 11 --------------------
		var mix11 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"ค่าใช้จ่าย(ไม่รวมโบนัส)/คน",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format":"%v%",
				"min-value":0,
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"bold":true,
				"tick":{
					"line-width": 3
				},
				"guide":{
					"line-width": 0,
					"alpha": 1
				}
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 12 --------------------
		var mix12 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"ค่าใช้จ่าย(ไม่รวมโบนัส) YTD/คน",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 13 --------------------
		var mix13 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"ค่าใช้จ่ายอบรม/คน",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 14 --------------------
		var mix14 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"ค่าใช้จ่ายอบรม YTD/คน",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 15 --------------------
		var mix15 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"ค่าใช้จ่ายสวัสดิการ/คน",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
	]};
		//,
		//-------------------- Chart 16 --------------------
		var mix16 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"30 50 10 50"
			},
			"title":{
				"text":"ค่าใช้จ่ายสวัสดิการ YTD/คน",
				"text-align":"center",
				"font-size":"11px",
				"font-color":"#000000",
				"font-weight":"bold",
				"padding-top":"0px",
				"background-color":"#FFFFFF"
			},
			"labels" : [
				{
					"text" : "28.32%",
					"hook" : "node:plot=1,index=0",
					"background-color":"#3300FF",
					"color": "white",
					"border-width":5, 
					"border-color":"#3300FF",
					"bold": true
				},
				{
					"text" : "30.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"#CC00CC",
					"color": "white",
					"border-width":5, 
					"border-color":"#CC00CC",
					"bold": true
				}
			],
			"scale-x":{
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
			},
			"scale-y":{
				"format":"%v",
				"item":{
					"font-size":11,
					"color":"#000000",
					"font-family":"Calibri"
				},
				"font-size":12,
				"color":"#000000",
				"font-family":"Calibri",
				"text":"มูลค่า (สิบล้านบาท)",
				"bold":true,
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"series" : [
				{
					"type" : "bar",
					"values" : [12.1],
					"text":"Last",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [15.22],
					"text":"This",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [23],
					"text": "Budget",
					"background-color":"#696969"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#3300FF",
						"background-color":"#3300FF",
						"size":4
					},
					"text":"%Growth"
				},
				{
					"type":"line",
					"values":[ ],
					"marker":{
						"border-color": "#CC00CC",
						"background-color":"#CC00CC",
						"size":4
					},
					"text":"%เทียบเป้า"
				}
			]
		}
    ]
};

	var bar1 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "bar",
		"stacked" : true,
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x1",
			"x": 950,
			"y": 70
		},
		"chart" : {
			"margin" : "20 150 40 100"
		},
		"plot":{
			"bars-space-left":"25%",
			"bars-space-right":"25%",
			"bar-width":"25px",
		},
		"scale-x" : {
			"values" : ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
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
				"line-width": 3
			}
        },
		"series" : [
			{
				"text":"Full-time",
				"values":[60,65,62,70,60,69,74,76,80,78,78,0],
				"background-color":"#B1CBF3",
				"background-color-2":"#4481BA"
			},
			{
				"text":"Part-time",
				"values":[10,5,6,3,8,1,9,10,4,5,7,3,4,0],
				"background-color":"#DDB1A2",
				"background-color-2":"#BE483F"
			},
			{
				"text":"นร.ศูนย์การเรียน",
				"values":[5,2,6,3,1,1,3,1,4,2,3,3,4,0],
				"background-color":"#D6EBB2",
				"background-color-2":"#95B34E"
			},
			{
				"text":"นักเรียนทวิภาค",
				"values":[1,2,1,3,1,1,3,1,2,2,3,3,1,0],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			}
		] 
	}
	]
};

	var mix17 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "mixed",
		"stacked":"1",
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "1x",
			"x": 250,
			"y": 250,
			"width": 650
		},
		"chart" : {
			"margin" : "25 50 100 50"
		},
		"scale-x" : {
			"values" : ["Jan<br>รับเข้า","Jan<br>ลาออก", "Feb<br>รับเข้า","Feb<br>ลาออก", "Mar<br>รับเข้า", "Mar<br>ลาออก","Apr<br>รับเข้า", "Apr<br>ลาออก", "May<br>รับเข้า", "May<br>ลาออก", "Jun<br>รับเข้า", "Jun<br>ลาออก", "Jul<br>รับเข้า", "Jul<br>ลาออก","Aug<br>รับเข้า",  "Aug<br>ลาออก", "Sep<br>รับเข้า","Sep<br>ลาออก", "Oct<br>รับเข้า", "Oct<br>ลาออก", "Nov<br>รับเข้า", "Nov<br>ลาออก", "Dec<br>รับเข้า","Dec<br>ลาออก"],
			"line-color": "#8B8B7A",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"plot":{
			"bars-space-left":"25%",
			"bars-space-right":"25%",
			"bar-width":"25px",
		},
		"scale-y":{
			"min-value" : 0,
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
			"min-value" : 0,
			"guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"series" : [
			{
				"type":"bar",
				"text":"Full-time",
				"values":[60,60,65,62,70,69,69,76,76,78,60,55,65,62,70,69,69,76,76,78,78,55,60,60],
				"background-color":"#B1CBF3",
				"url": "<%=request.getContextPath()%>/Dashboard/HR.jsp?mPie=%k",
				"background-color-2":"#4481BA"
			},
			{
				"type":"bar",
				"text":"Part-time",
				"values":[10,10,6,6,8,7,9,6,4,5,7,8,4,6,5,6,3,5,1,3,10,12,5,6],
				"background-color":"#DDB1A2",
				"background-color-2":"#BE483F"
			},
			{
				"type":"bar",
				"text":"นร.ศูนย์การเรียน",
				"values":[5,6,6,7,1,3,3,4,4,4,3,4,4,4,6,5,8,7,9,8,4,5,7,8],
				"background-color":"#D6EBB2",
				"background-color-2":"#95B34E"
			},
			{
				"type":"bar",
				"text":"นักเรียนทวิภาค",
				"values":[5,5,1,3,3,4,3,4,2,4,3,4,7,6,4,6,5,6,7,8,8,8,9,8],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			},
			{
				"type":"line",
				"text":"%turnover",
				"scales":"scale-x,scale-y-2",
				"marker":{
					"type":"cross",
					"size":3
				},
				"values":[10,20,20,10,30,10,10,30,10,20,20,30,30,10,20,20,10,30,10,10,30,10,20,20],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			}
		] 
	}
	]
};

	var mix18 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "mixed",
		"stacked":"1",
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "1x",
			"x": 20,
			"y": 250,
			"width": 650
		},
		"chart" : {
			"margin" : "25 50 100 50"
		},
		"scale-x" : {
			"values" : ["พ่อครัว<br>รับเข้า","พ่อครัว<br>ลาออก","พนักงานขับรถ<br>รับเข้า","พนักงานขับรถ<br>ลาออก"," พนักงานเสริฟ<br>รับเข้า"," พนักงานเสริฟ<br>ลาออก","ผู้จัดการร้าน<br>รับเข้า","ผู้จัดการร้าน<br>ลาออก"],
			"line-color": "#8B8B7A",
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
			"bars-space-right":"30%"
		},
		"scale-y":{
			"min-value" : 0,
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
			"min-value" : 0,
			"guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"series" : [
			{
				"type":"bar",
				"text":"Full-time",
				"values":[60,60,65,62,70,69,69,76,76,78,60,55,65,62,70,69,69,76,76,78,78,55,60,60],
				"background-color":"#B1CBF3",
				"url": "<%=request.getContextPath()%>/Dashboard/HR.jsp?mPie=%k",
				"background-color-2":"#4481BA"
			},
			{
				"type":"bar",
				"text":"Part-time",
				"values":[10,10,6,6,8,7,9,6,4,5,7,8,4,6,5,6,3,5,1,3,10,12,5,6],
				"background-color":"#DDB1A2",
				"background-color-2":"#BE483F"
			},
			{
				"type":"bar",
				"text":"นร.ศูนย์การเรียน",
				"values":[5,6,6,7,1,3,3,4,4,4,3,4,4,4,6,5,8,7,9,8,4,5,7,8],
				"background-color":"#D6EBB2",
				"background-color-2":"#95B34E"
			},
			{
				"type":"bar",
				"text":"นักเรียนทวิภาค",
				"values":[5,5,1,3,3,4,3,4,2,4,3,4,7,6,4,6,5,6,7,8,8,8,9,8],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			},
			{
				"type":"line",
				"text":"%turnover",
				"scales":"scale-x,scale-y-2",
				"marker":{
					"type":"cross",
					"size":3
				},
				"values":[10,20,20,10,30,10,10,30,10,20,20,30,30,10,20,20,10,30,10,10,30,10,20,20],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			}
		] 
	}
	]
};
	var mix19 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "mixed",
		"stacked":"1",
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "1x",
			"x": 150,
			"y": 250,
			"width": 650
		},
		"chart" : {
			"margin" : "25 50 100 50"
		},
		"scale-x" : {
			"values" : ["< 10,000<br>รับเข้า","< 10,000<br>ลาออก","10,000-20,000<br>รับเข้า","10,000-20,000<br>ลาออก","20,000-30,000<br>รับเข้า","20,000-30,000<br>ลาออก","30,000-50,000<br>รับเข้า","30,000-50,000<br>ลาออก"],
			"line-color": "#8B8B7A",
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
			"bars-space-right":"30%"
		},
		"scale-y":{
			"min-value" : 0,
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
			"min-value" : 0,
			"guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"series" : [
			{
				"type":"bar",
				"text":"Full-time",
				"values":[60,60,65,62,70,69,69,76,76,78,60,55,65,62,70,69,69,76,76,78,78,55,60,60],
				"background-color":"#B1CBF3",
				"url": "<%=request.getContextPath()%>/Dashboard/HR.jsp?mPie=%k",
				"background-color-2":"#4481BA"
			},
			{
				"type":"bar",
				"text":"Part-time",
				"values":[10,10,6,6,8,7,9,6,4,5,7,8,4,6,5,6,3,5,1,3,10,12,5,6],
				"background-color":"#DDB1A2",
				"background-color-2":"#BE483F"
			},
			{
				"type":"bar",
				"text":"นร.ศูนย์การเรียน",
				"values":[5,6,6,7,1,3,3,4,4,4,3,4,4,4,6,5,8,7,9,8,4,5,7,8],
				"background-color":"#D6EBB2",
				"background-color-2":"#95B34E"
			},
			{
				"type":"bar",
				"text":"นักเรียนทวิภาค",
				"values":[5,5,1,3,3,4,3,4,2,4,3,4,7,6,4,6,5,6,7,8,8,8,9,8],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			},
			{
				"type":"line",
				"text":"%turnover",
				"scales":"scale-x,scale-y-2",
				"marker":{
					"type":"cross",
					"size":3
				},
				"values":[10,20,20,10,30,10,10,30,10,20,20,30,30,10,20,20,10,30,10,10,30,10,20,20],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			}
		] 
	}
	]
};

	var mix20 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "mixed",
		"stacked":"1",
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "1x",
			"x": 250,
			"y": 250,
			"width": 650
		},
		"chart" : {
			"margin" : "25 50 100 50"
		},
		"scale-x" : {
			"values" : ["1<br>รับเข้า","1<br>ลาออก","2<br>รับเข้า","2<br>ลาออก","3<br>รับเข้า","3<br>ลาออก","4<br>รับเข้า","4<br>ลาออก","5<br>รับเข้า","5<br>ลาออก","6<br>รับเข้า","6<br>ลาออก","7<br>รับเข้า","7<br>ลาออก","8<br>รับเข้า","8<br>ลาออก","9<br>รับเข้า","9<br>ลาออก","10<br>รับเข้า","10<br>ลาออก","11<br>รับเข้า","11<br>ลาออก","12<br>รับเข้า","12<br>ลาออก"],
			"line-color": "#8B8B7A",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"plot":{
			"bars-space-left":"25%",
			"bars-space-right":"25%",
			"bar-width":"25px",
		},
		"scale-y":{
			"min-value" : 0,
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
			"min-value" : 0,
			"guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"series" : [
			{
				"type":"bar",
				"text":"Full-time",
				"values":[60,60,65,62,70,69,69,76,76,78,60,55,65,62,70,69,69,76,76,78,78,55,60,60],
				"background-color":"#B1CBF3",
				"url": "<%=request.getContextPath()%>/Dashboard/HR.jsp?mPie=%k",
				"background-color-2":"#4481BA"
			},
			{
				"type":"bar",
				"text":"Part-time",
				"values":[10,10,6,6,8,7,9,6,4,5,7,8,4,6,5,6,3,5,1,3,10,12,5,6],
				"background-color":"#DDB1A2",
				"background-color-2":"#BE483F"
			},
			{
				"type":"bar",
				"text":"นร.ศูนย์การเรียน",
				"values":[5,6,6,7,1,3,3,4,4,4,3,4,4,4,6,5,8,7,9,8,4,5,7,8],
				"background-color":"#D6EBB2",
				"background-color-2":"#95B34E"
			},
			{
				"type":"bar",
				"text":"นักเรียนทวิภาค",
				"values":[5,5,1,3,3,4,3,4,2,4,3,4,7,6,4,6,5,6,7,8,8,8,9,8],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			},
			{
				"type":"line",
				"text":"%turnover",
				"scales":"scale-x,scale-y-2",
				"marker":{
					"type":"cross",
					"size":3
				},
				"values":[10,20,20,10,30,10,10,30,10,20,20,30,30,10,20,20,10,30,10,10,30,10,20,20],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			}
		] 
	}
	]
};

	var mix21 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "mixed",
		"stacked":"1",
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "1x",
			"x": 20,
			"y": 250,
			"width": 650
		},
		"chart" : {
			"margin" : "25 50 100 50"
		},
		"scale-x" : {
			"values" : ["ภาคเหนือ<br>รับเข้า","ภาคเหนือ<br>ลาออก","ภาคกลาง<br>รับเข้า","ภาคกลาง<br>ลาออก","ภาคตะวันออก<br>รับเข้า","ภาคตะวันออก<br>ลาออก","ภาคใต้<br>รับเข้า","ภาคใต้<br>ลาออก"],
			"line-color": "#8B8B7A",
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
			"bars-space-right":"30%"
		},
		"scale-y":{
			"min-value" : 0,
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
			"min-value" : 0,
			"guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"series" : [
			{
				"type":"bar",
				"text":"Full-time",
				"values":[60,60,65,62,70,69,69,76,76,78,60,55,65,62,70,69,69,76,76,78,78,55,60,60],
				"background-color":"#B1CBF3",
				"url": "<%=request.getContextPath()%>/Dashboard/HR.jsp?mPie=%k",
				"background-color-2":"#4481BA"
			},
			{
				"type":"bar",
				"text":"Part-time",
				"values":[10,10,6,6,8,7,9,6,4,5,7,8,4,6,5,6,3,5,1,3,10,12,5,6],
				"background-color":"#DDB1A2",
				"background-color-2":"#BE483F"
			},
			{
				"type":"bar",
				"text":"นร.ศูนย์การเรียน",
				"values":[5,6,6,7,1,3,3,4,4,4,3,4,4,4,6,5,8,7,9,8,4,5,7,8],
				"background-color":"#D6EBB2",
				"background-color-2":"#95B34E"
			},
			{
				"type":"bar",
				"text":"นักเรียนทวิภาค",
				"values":[5,5,1,3,3,4,3,4,2,4,3,4,7,6,4,6,5,6,7,8,8,8,9,8],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			},
			{
				"type":"line",
				"text":"%turnover",
				"scales":"scale-x,scale-y-2",
				"marker":{
					"type":"cross",
					"size":3
				},
				"values":[10,20,20,10,30,10,10,30,10,20,20,30,30,10,20,20,10,30,10,10,30,10,20,20],
				"background-color":"#A8B4CE",
				"background-color-2":"#7D609F"
			}
		] 
	}
	]
};

	var pie1 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"0 0 45 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x3",
			"x":10,
			"y":240
		},
		"title":{
            "text":"เหตุผลที่ออก <%out.print(pm);%>",
            "text-align":"center",
            "font-size":"15px",
			"font-color":"#000000",
            "font-weight":"bold",
            "padding-top":"0px",
            "background-color":"#FFFFFF"
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
		},
		"series" : [
			{
				"text" : "เรียนต่อ",
				"values" : [31.35],
				"tooltip-text" : "%t: 5,000"
			},
			{
				"text" : "ได้งานใหม่",
				"values" : [12.24],
				"tooltip-text" : "%t: 3,000"
			},
			{
				"text" : "กลับต่างจังหวัด",
				"values" : [21.52],
				"tooltip-text" : "%t: 3,395"
			},
			{
				"text" : "ไม่พอใจหัวหน้า",
				"values" : [25.87],
				"tooltip-text" : "%t: 4,975"
			},
			{
				"text" : "อื่นๆ",
				"values" : [9.02],
				"tooltip-text" : "%t: 2,000"			
			}]
	}]
};
	
	var pie2 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"0 50 0 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x1",
			"x":370,
			"y":30
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
		},
		"series" : [
			{
				"text" : "< 25 ปี",
				"values" : [23.42],
				"tooltip-text" : "%t: 27"
			},
			{
				"text" : "25 -30 ปี",
				"values" : [15.25],
				"tooltip-text" : "%t: 19"
			},
			{
				"text" : "30 - 35 ปี",
				"values" : [11.75],
				"tooltip-text" : "%t: 12"
			},
			{
				"text" : "35 - 40 ปี",
				"values" : [9.54],
				"tooltip-text" : "%t: 9"
			},
			{
				"text" : "40 - 45 ปี",
				"values" : [20.14],
				"tooltip-text" : "%t: 25v"			
			},
			{
				"text" : "45 - 50 ปี",
				"values" : [10.2],
				"tooltip-text" : "%t: 11"			
			},
			{
				"text" : "> 50 ปี",
				"values" : [9.7],
				"tooltip-text" : "%t: 10"			
			}]
	}]
};
	
	var pie3 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"0 50 0 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x1",
			"x":370,
			"y":60
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
		},
		"series" : [
			{
				"text" : "A",
				"values" : [25.36],
				"tooltip-text" : "%t: 29"
			},
			{
				"text" : "B",
				"values" : [21.34],
				"tooltip-text" : "%t: 25"
			},
			{
				"text" : "C",
				"values" : [15.26],
				"tooltip-text" : "%t: 19"
			},
			{
				"text" : "D",
				"values" : [38.04],
				"tooltip-text" : "%t: 42"
			}]
	}]
};

	$(document).ready(function() {
		zingchart.render({
			id 			: 'g1',
			width 		: 265,
			height 		: 250,
			data 		: mix1
		});
		zingchart.render({
			id 			: 'g2',
			width 		: 265,
			height 		: 250,
			data 		: mix2
		});
		zingchart.render({
			id 			: 'g3',
			width 		: 265,
			height 		: 250,
			data 		: mix3
		});
		zingchart.render({
			id 			: 'g4',
			width 		: 265,
			height 		: 250,
			data 		: mix4
		});
		zingchart.render({
			id 			: 'g5',
			width 		: 265,
			height 		: 250,
			data 		: mix5
		});
		zingchart.render({
			id 			: 'g6',
			width 		: 265,
			height 		: 250,
			data 		: mix6
		});
		zingchart.render({
			id 			: 'g7',
			width 		: 265,
			height 		: 250,
			data 		: mix7
		});
		zingchart.render({
			id 			: 'g8',
			width 		: 265,
			height 		: 250,
			data 		: mix8
		});
		zingchart.render({
			id 			: 'g9',
			width 		: 265,
			height 		: 250,
			data 		: mix9
		});
		zingchart.render({
			id 			: 'g10',
			width 		: 265,
			height 		: 250,
			data 		: mix10
		});
		zingchart.render({
			id 			: 'g11',
			width 		: 265,
			height 		: 250,
			data 		: mix11
		});
		zingchart.render({
			id 			: 'g12',
			width 		: 265,
			height 		: 250,
			data 		: mix12
		});
		zingchart.render({
			id 			: 'g13',
			width 		: 265,
			height 		: 250,
			data 		: mix13
		});
		zingchart.render({
			id 			: 'g14',
			width 		: 265,
			height 		: 250,
			data 		: mix14
		});
		zingchart.render({
			id 			: 'g15',
			width 		: 265,
			height 		: 250,
			data 		: mix15
		});
		zingchart.render({
			id 			: 'g16',
			width 		: 265,
			height 		: 250,
			data 		: mix16
		});
		zingchart.render({
			id 			: 'g17',
			width 		: 1080,
			height 		: 250,
			data 		: bar1
		});
		zingchart.render({
			id 			: 'g18',
			width 		: 1200,
			height 		: 300,
			data 		: mix17
		});
		zingchart.render({
			id 			: 'g19',
			width 		: 340,
			height 		: 300,
			data 		: pie1
		});
		zingchart.render({
			id 			: 'g20',
			width 		: 690,
			height 		: 300,
			data 		: mix18
		});
		zingchart.render({
			id 			: 'g21',
			width 		: 340,
			height 		: 300,
			data 		: pie1
		});
		zingchart.render({
			id 			: 'g22',
			width 		: 900,
			height 		: 300,
			data 		: mix19
		});
		zingchart.render({
			id 			: 'g23',
			width 		: 340,
			height 		: 300,
			data 		: pie1
		});
		zingchart.render({
			id 			: 'g24',
			width 		: 1200,
			height 		: 300,
			data 		: mix20
		});
		zingchart.render({
			id 			: 'g25',
			width 		: 340,
			height 		: 300,
			data 		: pie1
		});
		zingchart.render({
			id 			: 'g26',
			width 		: 690,
			height 		: 300,
			data 		: mix21
		});
		zingchart.render({
			id 			: 'g27',
			width 		: 340,
			height 		: 300,
			data 		: pie1
		});
		zingchart.render({
			id 			: 'g28',
			width 		: 537,
			height 		: 250,
			data 		: pie2
		});
		zingchart.render({
			id 			: 'g29',
			width 		: 537,
			height 		: 250,
			data 		: pie3
		});
	});

</script>

</head>

<body>
<!--+++++++++++++++++++++++++ Parameter +++++++++++++++++++++++++-->
	<!--          Drop Down List YEAR              -->
	<div style="position:absolute; left:45px; top:20px;"><font size="3"> ปี:</font>
		<select name="Year">
			<option value="2010">2010</option>
			<option value="2009">2009</option>
		</select> 
	</div>
	<!--          Drop Down List MONTH              -->
	<div style="position:absolute; left:250px; top:20px;"><font size="3"> เดือน:</font>
		<select name="Month">
			<option value="1">Jan</option>
			<option value="2">Feb</option>
			<option value="3">Mar</option>
			<option value="4">Apr</option>
			<option value="5">May</option>
			<option value="6">Jun</option>
			<option value="7">Jul</option>
			<option value="8">Aug</option>
			<option value="9">Sep</option>
			<option value="10">Oct</option>
			<option value="11">Nov</option>
			<option value="12">Dec</option>
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:20px; top:50px;"><font size="3"> ฝ่าย : </font>
		<select name="SumBy">
			<option value="1">ALL</option>
			<option value="2">ฝ่ายปฏิบัติการสาขา S&P</option>
			<option value="3">ฝ่ายปฏิบัติการสาขา Specialy</option>
			<option value="4">ฝ่าย Retail</option>
			<option value="5">ฝ่าย Food Service</option>
			<option value="6">ฝ่าย Export</option>
			<option value="7">ฝ่ายบริการจัดเลี้ยง</option>
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:250px; top:50px;"><font size="3"> ส่วน : </font>
		<select name="SumBy">
			<option value="1">ALL</option>
			<option value="2">ส่วนปฏิบัติการสาขา</option>
			<option value="3">ส่วนปฏิบัติการร้านวนิลา</option>
			<option value="4">ส่วนปฏิบัติการร้านภัทรา</option>
			<option value="5">ส่วนปฏิบัติการ Seaside</option>
			<option value="6">ส่วนปฏิบัติการ Patio</option>
			<option value="7">Caterman</option>
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:460px; top:50px;"><font size="3"> เขต : </font>
		<select name="SumBy">
			<option value="1">ALL</option>
			<option value="2">เขต 0</option>
			<option value="3">เขต 1</option>
			<option value="4">เขต 2</option>
			<option value="5">เขต 3 </option>
			<option value="6">เขต 4</option>
			<option value="7">เขต 5</option>
			<option value="8">เขต 6</option>
			<option value="9">เขต 7</option>
			<option value="10">เขต 8</option>
			<option value="11">เขต 9</option>
			<option value="12">เขต 10</option>
			<option value="13">เขต 11</option>
			<option value="14">เขต 12</option>
			<option value="15">เขต 13</option>
			<option value="16">เขต 14</option>
			<option value="17">เขต 15</option>
			<option value="18">เขต 16</option>
			<option value="19">เขต 17</option>
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:590px; top:50px;"><font size="3"> สาขา : </font>
		<select name="SumBy">
			<option value="1">ALL</option>
			<option value="2">Top รงสิต</option>
			<option value="3">วนิลาองหล่อ</option>
			<option value="4">เซ็นทรัลลาดพร้าว</option>
			<option value="5">RCA</option>
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:760px; top:50px;"><font size="3"> หน่วยงาน : </font>
		<select name="SumBy">
			<option value="1">ALL</option>
			<option value="2">ครัวไทย</option>
			<option value="3">บาร์น้ำ</option>
			<option value="4">บริการ</option>
			<option value="5">บริหาร</option>
		</select> 
	</div>

	<div style="position:absolute; left:920px; top:50px;">
		<input type="submit" name="ok" value=" OK "/></div>
	</div>
<!--+++++++++++++++++++++++++ End Parameter +++++++++++++++++++++++++-->

<!--+++++++++++++++++++++++++ +++++++++++++++++++++++++-->
<div id="tabs" style="position:absolute; height=500px;" bordercolor="#FFFFFF" border="5">
<!--+++++++++++++++++++++++++ Tab 1 +++++++++++++++++++++++++-->
<table id="tabs-r1c1">
<tr><td width=1090 align="center">
	<ul>
		<li><a href="#tabs-r1_1">อัตรากำลังคนสัปดาห์ล่าสุด</a></li>
		<li><a href="#tabs-r1_2">อัตรากำลังคน MTD</a></li>
	</ul>

	<!--+++++++++++++++++++++++++ Tab 1-1 +++++++++++++++++++++++++-->
	<table id="tabs-r1_1">
	<tr><td align="center">
		<table width=1000 bordercolor="#000000" frame="box" rules="all">
		<tr bgcolor="#CD853F">
			<th><font color="#FFFFFF">ตำแหน่ง</font></th>
			<th width=130><font color="#FFFFFF">Model vs Actual</font></th>
			<th width=90><font color="#FFFFFF">เป้า</font></th>
			<th width=90><font color="#FFFFFF">เข้าใหม่</font></th>
			<th width=110><font color="#FFFFFF">%เข้าใหม่เทียบเป้า</font></th>
			<th width=90><font color="#FFFFFF">ลาออก</font></th>
			<th width=90><font color="#FFFFFF">%Turn Over</font></th>
		</tr>
		<tr>
			<td>ผจก. บริหาร/ผู้เชี่ยวชาญ</td>
			<td align="right">15</td>
			<td align="right">15</td>
			<td align="right">5</td>
			<td align="right">33.3%</td>
			<td align="right">5</td>
			<td align="right">19.41%</td>
		</tr>
		<tr>
			<td>แคชเชียร์ / HOD Master</td>
			<td align="right">25</td>
			<td align="right">25</td>
			<td align="right">16</td>
			<td align="right">63.46%</td>
			<td align="right">4</td>
			<td align="right">17.12%</td>
		</tr>
		<tr>
			<td>หัวหน้าเขต (หัวหน้าอาวุโส)</td>
			<td align="right">15</td>
			<td align="right">15</td>
			<td align="right">9</td>
			<td align="right">67.35%</td>
			<td align="right">5</td>
			<td align="right">30.23%</td>
		</tr>
		<tr>
			<td>พนักงานระดับ สูง (หัวหน้า)</td>
			<td align="right">15</td>
			<td align="right">15</td>
			<td align="right">12</td>
			<td align="right">85.76%</td>
			<td align="right">6</td>
			<td align="right">41.23%</td>
		</tr>
		<tr>
			<td>พนักงานระดับกลาง (ระดับ 3/รอง)</td>
			<td align="right">20</td>
			<td align="right">20</td>
			<td align="right">14</td>
			<td align="right">79.35%</td>
			<td align="right">5</td>
			<td align="right">20.00%</td>
		</tr>
		<tr>
			<td>พนักงานระดับต้น (ระดับ 1-2)</td>
			<td align="right">25</td>
			<td align="right">25</td>
			<td align="right">17</td>
			<td align="right">63.42%</td>
			<td align="right">7</td>
			<td align="right">34.39%</td>
		</tr>
		</table>
	</td></tr>
	</table>

	<!--+++++++++++++++++++++++++ Tab 1-2 +++++++++++++++++++++++++-->
	<table id="tabs-r1_2">
	<tr><td align="center">
		<table width=1000 bordercolor="#000000" frame="box" rules="all">
		<tr bgcolor="#CD853F">
			<th><font color="#FFFFFF">ตำแหน่ง</font></th>
			<th width=130><font color="#FFFFFF">Model vs Actual</font></th>
			<th width=90><font color="#FFFFFF">เป้า</font></th>
			<th width=90><font color="#FFFFFF">เข้าใหม่</font></th>
			<th width=110><font color="#FFFFFF">%เข้าใหม่เทียบเป้า</font></th>
			<th width=90><font color="#FFFFFF">ลาออก</font></th>
			<th width=90><font color="#FFFFFF">%Turn Over</font></th>
		</tr>
		<tr>
			<td>ผจก. บริหาร/ผู้เชี่ยวชาญ</td>
			<td align="right">15</td>
			<td align="right">15</td>
			<td align="right">5</td>
			<td align="right">33.3%</td>
			<td align="right">5</td>
			<td align="right">19.41%</td>
		</tr>
		<tr>
			<td>แคชเชียร์ / HOD Master</td>
			<td align="right">25</td>
			<td align="right">25</td>
			<td align="right">17</td>
			<td align="right">63.42%</td>
			<td align="right">7</td>
			<td align="right">34.39%</td>
		</tr>
		<tr>
			<td>หัวหน้าเขต (หัวหน้าอาวุโส)</td>
			<td align="right">15</td>
			<td align="right">15</td>
			<td align="right">9</td>
			<td align="right">67.35%</td>
			<td align="right">5</td>
			<td align="right">30.23%</td>
		</tr>
		<tr>
			<td>พนักงานระดับ สูง (หัวหน้า)</td>
			<td align="right">15</td>
			<td align="right">15</td>
			<td align="right">12</td>
			<td align="right">85.76%</td>
			<td align="right">6</td>
			<td align="right">41.23%</td>
		</tr>
		<tr>
			<td>พนักงานระดับกลาง (ระดับ 3/รอง)</td>
			<td align="right">20</td>
			<td align="right">20</td>
			<td align="right">14</td>
			<td align="right">79.35%</td>
			<td align="right">5</td>
			<td align="right">20.00%</td>
		</tr>
		<tr>
			<td>พนักงานระดับต้น (ระดับ 1-2)</td>
			<td align="right">25</td>
			<td align="right">25</td>
			<td align="right">16</td>
			<td align="right">63.46%</td>
			<td align="right">4</td>
			<td align="right">17.12%</td>
		</tr>
		</table>
	</td></tr>
	</table>

</td></tr>
</table>
<!--+++++++++++++++++++++++++ End Tab 1 +++++++++++++++++++++++++-->

<!--+++++++++++++++++++++++++ Tab 2 +++++++++++++++++++++++++-->
<table id="tabs-r2c1">
<tr><td>

<table width=1090>
<tr bgcolor="#8B4513"><th colspan="4"><font color="#FFE742" size="3">ค่าใช้จ่าย</font></th></tr>

<tr>
	<td id="g1"></td><td id="g2"></td><td id="g3"></td><td id="g4"></td><!-- Chart -->
</tr>
<tr>
	<td id="g5"></td><td id="g6"></td><td id="g7"></td><td id="g8"></td><!-- Chart -->
</tr>
<tr>
	<td id="g9"></td><td id="g10"></td><td id="g11"></td><td id="g12"></td><!-- Chart -->
</tr>
<tr>
	<td id="g13"></td><td id="g14"></td><td id="g15"></td><td id="g16"></td><!-- Chart -->
</tr>
<tr>
	<td colspan="4" align="center">&nbsp;</td>
</tr>
<tr>
	<td colspan="4" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_HR.jpg"/></td><!-- legend_HR.jpg -->
</tr>
</table>

</td></tr>
</table>
<!--+++++++++++++++++++++++++ End Tab 2 +++++++++++++++++++++++++-->

<!--+++++++++++++++++++++++++ Tab 3 +++++++++++++++++++++++++-->
<table id="tabs-r3c1">
<tr><td>

<table width=1090>
<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">สัดส่วนพนักงาน</font></th></tr>

<tr>
	<td id="g17"></td><!-- Chart -->
</tr>
</table>

</td></tr>
</table>
<!--+++++++++++++++++++++++++ End Tab 3 +++++++++++++++++++++++++-->

<!--+++++++++++++++++++++++++ Tab 4 +++++++++++++++++++++++++-->
<table id="tabs-r4c1">
<tr><td>

<table width=1090>
<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">จำนวนพนักงานที่เข้าออก</font></th></tr>

<tr><td>
	<ul>
		<li><a href="#tabs-r4_1">เดือน</a></li>
		<li><a href="#tabs-r4_2">ตำแหน่ง</a></li>
		<li><a href="#tabs-r4_3">ช่วงเงินเดือน</a></li>
		<li><a href="#tabs-r4_4">ระดับพนักงาน</a></li>
		<li><a href="#tabs-r4_5">แหล่งสรรหา</a></li>
	</ul>

	<!--+++++++++++++++++++++++++ Tab 4-1 +++++++++++++++++++++++++-->
	<table id="tabs-r4_1"><tr><td><table bordercolor="#000000" frame="box" rules="all">
		<tr>
			<td><div style="width:690px; overflow:auto;"><table><td id="g18"></td></table></div></td>
			<td align="center"><div id="g19"></div></td>
		</tr>
	</table></td></tr></table>

	<!--+++++++++++++++++++++++++ Tab 4-2 +++++++++++++++++++++++++-->
	<table id="tabs-r4_2"><tr><td><table bordercolor="#000000" frame="box" rules="all">
		<tr>
			<td><div id="g20"></div></td>
			<td align="center"><div id="g21"></div></td>
		</tr>
	</table></td></tr></table>

	<!--+++++++++++++++++++++++++ Tab 4-3 +++++++++++++++++++++++++-->
	<table id="tabs-r4_3"><tr><td><table bordercolor="#000000" frame="box" rules="all">
		<tr>
			<td><div style="width:690px; overflow:auto;"><table><td id="g22"></td></table></div></td>
			<td align="center"><div id="g23"></div></td>
		</tr>
	</table></td></tr></table>

	<!--+++++++++++++++++++++++++ Tab 4-4 +++++++++++++++++++++++++-->
	<table id="tabs-r4_4"><tr><td><table bordercolor="#000000" frame="box" rules="all">
		<tr>
			<td><div style="width:690px; overflow:auto;"><table><td id="g24"></td></table></div></td>
			<td align="center"><div id="g25"></div></td>
		</tr>
	</table></td></tr></table>

	<!--+++++++++++++++++++++++++ Tab 4-5 +++++++++++++++++++++++++-->
	<table id="tabs-r4_5"><tr><td><table bordercolor="#000000" frame="box" rules="all">
		<tr>
			<td><div id="g26"></div></td>
			<td align="center"><div id="g27"></div></td>
		</tr>
	</table></td></tr></table>

</td></tr>
</table>

</td></tr>
</table>
<!--+++++++++++++++++++++++++ End Tab 4 +++++++++++++++++++++++++-->

<!--+++++++++++++++++++++++++ Tab 5 +++++++++++++++++++++++++-->
<table>
<tr><td id="tabs-r5c1">
	<table width=535>
	<tr bgcolor="#8B4513">
		<th><font color="#FFE742" size="3">สัดส่วนอายุงานที่ลาออก</font></th>
	</tr>
	<tr>
		<td align="center"><div id="g28"></div></td>
	</tr>
	</table>
</td>
<td id="tabs-r5c2">
	<table width=535>
	<tr bgcolor="#8B4513">
		<th><font color="#FFE742" size="3">สัดส่วนเกรดของพนักงานที่ลาออก</font></th>
	</tr>
	<tr>
		<td align="center"><div id="g29"></div></td>
	</tr>
	</table>
</td></tr>
</table>
<!--+++++++++++++++++++++++++ End Tab 5 +++++++++++++++++++++++++-->

<!--+++++++++++++++++++++++++ Tab 6 +++++++++++++++++++++++++-->
<table id="tabs-r6c1">
<tr><td>
	<table width=1090>
	<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">จำนวนผู้เข้าอบรม</font></th></tr>

	<tr><td align="center">
		<table width=1000 bordercolor="#000000" frame="box" rules="all">
		<tr bgcolor="#CD853F">
			<th><font color="#FFFFFF">ชื่อหลักสูตร</font></th>
			<th><font color="#FFFFFF">Jan</font></th>
			<th><font color="#FFFFFF">Feb</font></th>
			<th><font color="#FFFFFF">Mar</font></th>
			<th><font color="#FFFFFF">Apr</font></th>
			<th><font color="#FFFFFF">May</font></th>
			<th><font color="#FFFFFF">Jun</font></th>
			<th><font color="#FFFFFF">Jul</font></th>
			<th><font color="#FFFFFF">Aug</font></th>
			<th><font color="#FFFFFF">Sep</font></th>
			<th><font color="#FFFFFF">Oct</font></th>
			<th><font color="#FFFFFF">Nov</font></th>
			<th><font color="#FFFFFF">Dec</font></th>
		</tr>
		<tr>
			<td>พนักงานใหม่ฝึกงาน 5 วัน (ศูนย์มาตรฐาน)</td>
			<td align="right">9</td>
			<td align="right"></td>
			<td align="right">8</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">15</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">17</td>
		</tr>
		<tr>
			<td>Training for the trainer</td>
			<td align="right"></td>
			<td align="right">10</td>
			<td align="right">12</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">12</td>
			<td align="right"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td>ทบทวนมาตรฐานงาน</td>
			<td align="right">12</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">19</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">17</td>
			<td align="right"></td>
			<td align="right">11</td>
		</tr>
		<tr>
			<td>พื้นฐานการให้บริการ</td>
			<td align="right">8</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">19</td>
			<td align="right">17</td>
			<td align="right">16</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">20</td>
		</tr>
		<tr>
			<td>การจัดการทรัพยากรบุคคล</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">8</td>
			<td align="right">12</td>
			<td align="right">20</td>
			<td align="right"></td>
			<td align="right">12</td>
			<td align="right"></td>
		</tr>
		<tr>
			<td>ความรู้เกี่ยวกับกาแฟ/Barista Shop/เครื่องดื่ม</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">11</td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right">20</td>
			<td align="right">12</td>
			<td align="right"></td>
			<td align="right">8</td>
			<td align="right">10</td>
			<td align="right">9</td>
		</tr>
		<tr>
			<td>การอบขนม</td>
			<td align="right">9</td>
			<td align="right">11</td>
			<td align="right">15</td>
			<td align="right">12</td>
			<td align="right">8</td>
			<td align="right">9</td>
			<td align="right">10</td>
			<td align="right">12</td>
			<td align="right">11</td>
			<td align="right">8</td>
			<td align="right">15</td>
			<td align="right">9</td>
		</tr>
		<!--<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>-->
		</table>
	</td></tr>
	</table>
</td></tr>
</table>
<!--+++++++++++++++++++++++++ End Tab 5 +++++++++++++++++++++++++-->

</div>
</body>
</html>