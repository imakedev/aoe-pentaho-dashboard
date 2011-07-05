<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Sales Dashboard Page</title>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet" />	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<%
		String y = request.getParameter("y"); // Year Parameter
		String months = request.getParameter("months"); // Month Parameter
		String sb = request.getParameter("sb"); // Summary By Parameter

		String t = "YTD";

	%>

	<script type="text/javascript">

		var y = <%=y%>; // Value of Year(Default 1)
		function getYear(value)
		{
			y = value;
		}

		var months = <%=months%>; // Value of Month(Default 1)
		function getMonth(value)
		{
			months = value;
		}

		var urlP = '<%=request.getContextPath()%>/Dashboard/SalesYTD.jsp'; // URL Page.
		var sb = <%=sb%>;
		function getSumBy(value)
		{
			sb = value;
			switch(sb){
				case '2' : 
				case '3' : urlP = '<%=request.getContextPath()%>/Dashboard/Sales.jsp';
					break;
			}
		}

		function goUrl()
		{
			location.href = urlP+'?y='+y+'&months='+months+'&sb='+sb;
		}

	</script>

	<script type="text/javascript">
		$(function(){
			// Tabs
			$("#tabs").tabs();
			$("#tabs-r1c1").tabs();
			$("#tabs-r2c1").tabs();
				// tabs-r2_1
				$("#tabs-r2_1-1").tabs();
					$("#tabs-param1").tabs();
					$("#tabs-chart1").tabs();
				$("#tabs-r2_1-2").tabs();
					$("#tabs-r2_1-2_1").tabs();
				$("#tabs-r2_1-3").tabs();

				// tabs-r2_2
				$("#tabs-r2_2-1").tabs();
					$("#tabs-param2").tabs();
					$("#tabs-chart2").tabs();
				$("#tabs-r2_2-2").tabs();
					$("#tabs-r2_2-2_1").tabs();
				$("#tabs-r2_2-3").tabs();

				// tabs-r2_3
				$("#tabs-r2_3-1").tabs();
					$("#tabs-param3").tabs();
					$("#tabs-chart3").tabs();
				$("#tabs-r2_3-2").tabs();
					$("#tabs-r2_3-2_1").tabs();
				$("#tabs-r2_3-3").tabs();

				// tabs-r2_4
				$("#tabs-r2_4-1").tabs();
					$("#tabs-param4").tabs();
					$("#tabs-chart4").tabs();
				$("#tabs-r2_4-2").tabs();
					$("#tabs-r2_4-2_1").tabs();
				$("#tabs-r2_4-3").tabs();

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
		#tabs { top:60px; left:5px; }
		
	</style>

	<script type="text/javascript">

	var pie1 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"0 0 15 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "1x",
			"x":20,
			"y":220
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
				"text" : "Retail",
				"values" : [50],
				"tooltip-text" : "%t: 5,000"
			},
			{
				"text" : "Food Service",
				"values" : [30],
				"tooltip-text" : "%t: 3,000"
			},
			{
				"text" : "Export",
				"values" : [20],
				"tooltip-text" : "%t: 2,000"				
			}]
	}]
};

	var bar1 = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"plot":{
			"tooltip-text" : "%t เดือน %k <br>%v "
        },
		"chart" : {     
			"margin" : "10 50 120 60"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
            "layout":"3x",
            "width":"750px",
			"x" : 40,
			"y": 230
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
    "series" : [
	  {
            "type":"line",
            "values":["12.1","12.2","12.3","12.5","12.78","12.89","13.09","13.1","13.13","13.29","13.3","13.44"],
            "text":"ยอดขายปีที่แล้ว",
            "scales":"scale-x,scale-y"
      },
	  {
            "type":"line",
            "values":["12.22","12.3","12.35","12.4","12.54","12.7","12.76","12.87","12.99","13.18","13.23","13.33"],
            "text":"ยอดขายปีนี้",
            "scales":"scale-x,scale-y"
      },
	  {
            "type":"line",
            "values":["12.22","12.31","12.39","12.4","12.45","12.57","12.77","12.8","12.95","12.99","13.12","13.14"],
            "text":"เป้า",
            "scales":"scale-x,scale-y"
      },
	  {
            "type":"line",
            "values":["11.13","11.4","11.75","12.1","12.28","12.39","12.49","12.52","12.63","12.79","12.8","12.92"],
            "text":"สินค้าหมดอายุ",
            "scales":"scale-x,scale-y"
      },
	  {
            "type":"line",
            "values":["11.2","11.3","11.85","11.9","12.04","12.1","12.16","12.27","12.39","12.48","12.53","12.62"],
            "text":"ยอดขายสินค้าใหม่",
            "scales":"scale-x,scale-y"
      },
	  {
		"type" : "bar",
        "values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37","15.15","10.37"],
        "text": "%ยอดขายเทียบกับปีที่แล้ว",
		"scales":"scale-x,scale-y-2"
     },
     {
		"type" : "bar",
        "values" : ["24.8","19.53","13.77","16.09","12.29","14.27","10.22","16.4","20.24","10.37","15.25","18.37"],
        "text": "%ยอดขายเทียบกับเป้า",
		"scales":"scale-x,scale-y-2"
     },
     {
		"type" : "bar",
        "values" : ["10.8","13.33","15.57","17.39","19.59","10.27","15.32","13.2","18.34","13.57","20.45","11.27"],
        "text": "%สินค้าหมดอายุเทียบกับยอดขาย",
		"scales":"scale-x,scale-y-2"
     },
     {
		"type" : "bar",
        "values" : ["20.2","11.23","20.77","20.79","20.19","20.07","12.02","21.1","10.24","10.37","13.05","14.07"],
        "text": "%ยอดขายสินค้าปีนี้เทียบกับยอดขายสินค้าใหม่",
		"scales":"scale-x,scale-y-2"
     }]
  }]
};

	var mix1 = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart":{
			"margin":"10 45 100 50"
		},
        "legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x2",
			"x": 400,
			"y": 280,
			"width" : 300
		},
		"plot":{
			"bars-space-left":"25%",
			"bars-space-right":"25%",
			"bar-width":"25px",
		},
        "scale-x":{
			"values":["Frozen<br>Food<br>-Savory","Frozen<br>Food<br>-Sweet","Frozen<br>Pasta","Bakery","Frozen<br>Sauce","Moon<br>Cake","Sausage","Salad<br>Dressing","Phuket","Seriwat<br>Product","Cookie","Dim Sum","QM<br>Food","QM<br>Dessert","Mini Moon<br>Cake","Other"],
			"item":{
                "font-size":11,
				"font-angle":300,
				"offset-y":"10px",
				"offset-x":"-10px",
                "color":"#000000",
                "font-family":"Calibri"
            },
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
            "item":{
                "font-size":11,
                "color":"#000000",
                "font-family":"Calibri"
            },
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
			"format":"%v%",
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3,
			}
		},
		"series" : [
			{
				"type" : "bar",
				"values" : ["23000","12000","14500","20000","26700","42000","32000","23000","20000","26700","42000","32000","23000","12000","14500","20000","26700","42000","32000"],
				"text": "ยอดขาย",
				"scales":"scale-x,scale-y"
			},
			{
				"type":"line",
				"values":["2.8","3.93","5.30","6.4","8.7","10.5","13","5.30","6.4","8.7","10.5","13","2.8","3.93","5.30","6.4","8.7","10.5","13"],
				"text":"% เทียบเป้าหมาย",
				"scales":"scale-x,scale-y-2"
			}
		]
	}]
};

	var mix2 = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart":{
			"margin":"10 45 90 50"
		},
        "legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x2",
			"x": 150,
			"y": 280,
			"width" : 300
		},
		"plot":{
			"bars-space-left":"25%",
			"bars-space-right":"25%",
			"bar-width":"25px",
		},
        "scale-x":{
			"values":["Frozen<br>Food","Frozen<br>Cake","Sausage","Cookie","Moon<br>Cake","Patio","Seriwat","Dim<br>Sum","Other"],
            "item":{
                "font-size":11,
				"font-angle":300,
				"offset-y":"10px",
				"offset-x":"-10px",
                "color":"#000000",
                "font-family":"Calibri"
            },
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
            "item":{
                "font-size":11,
                "color":"#000000",
                "font-family":"Calibri"
            },
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
			"format":"%v%",
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3,
			}
		},
		"series" : [
			{
				"type" : "bar",
				"values" : ["23000","12000","14500","20000","26700","42000","32000","23000","14500"],
				"text": "ยอดขาย",
				"scales":"scale-x,scale-y"
			},
			{
				"type":"line",
				"values":["2.8","3.93","5.30","6.4","8.7","10.5","13","4.8","5.93"],
				"text":"% เทียบเป้าหมาย",
				"scales":"scale-x,scale-y-2"
			}
		]
	}]
};	
	var mix3 = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart":{
			"margin":"10 45 100 50"
		},
        "legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x2",
			"x": 250,
			"y": 280,
			"width" : 300
		},
		"plot":{
			"bars-space-left":"25%",
			"bars-space-right":"25%",
			"bar-width":"25px",
		},
        "scale-x":{
			"values":["Frozen<br>Food<br>-Savory","Frozen<br>Food<br>-Sweet","Frozen<br>Pasta","Bakery","Frozen<br>Sauce","Moon<br>Cake","Sausage","Salad<br>Dressing","Phuket","Seriwat"],
            "item":{
                "font-size":11,
				"font-angle":300,
				"offset-y":"10px",
				"offset-x":"-10px",
                "color":"#000000",
                "font-family":"Calibri"
            },
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
            "item":{
                "font-size":11,
                "color":"#000000",
                "font-family":"Calibri"
            },
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
			"format":"%v%",
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3,
			}
		},
		"series" : [
			{
				"type" : "bar",
				"values" : ["23000","12000","14500","20000","26700","42000","32000","26700","42000","32000"],
				"text": "ยอดขาย",
				"scales":"scale-x,scale-y"
			},
			{
				"type":"line",
				"values":["2.8","3.93","5.30","6.4","8.7","10.5","13","8.7","10.5","9.00"],
				"text":"% เทียบเป้าหมาย",
				"scales":"scale-x,scale-y-2"
			}
		]
	}]
};
	var mix4 = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart":{
			"margin":"10 45 100 50"
		},
        "legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x2",
			"x": 175,
			"y": 280,
			"width" : 300
		},
		"plot":{
			"bars-space-left":"25%",
			"bars-space-right":"25%",
			"bar-width":"25px",
		},
        "scale-x":{
			"values":["QM<br>Food","QM<br>Dessert","Frozen<br>Cake","Cookie","Moon<br>Cake","Mini Moon<br>Cake","Sausage","Other"],
            "item":{
                "font-size":11,
				"font-angle":300,
				"offset-y":"10px",
				"offset-x":"-10px",
                "color":"#000000",
                "font-family":"Calibri"
            },
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
            "item":{
                "font-size":11,
                "color":"#000000",
                "font-family":"Calibri"
            },
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
			"format":"%v%",
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3,
			}
		},
		"series" : [
			{
				"type" : "bar",
				"values" : ["23000","12000","14500","20000","26700","42000","32000","35721"],
				"text": "ยอดขาย",
				"scales":"scale-x,scale-y"
			},
			{
				"type":"line",
				"values":["2.8","3.93","5.30","6.4","8.7","10.5","8.67","9.32"],
				"text":"% เทียบเป้าหมาย",
				"scales":"scale-x,scale-y-2"
			}
		]
	}]
};

	$(document).ready(function() {
		zingchart.render({
			id 			: 'g1',
			width 		: 350,
			height 		: 250,
			data 		: pie1
		});
		zingchart.render({
			id 			: 'g2',
			width 		: 820,
			height 		: 320,
			data 		: bar1
		});
		zingchart.render({
			id 			: 'g3',
			width 		: 820,
			height 		: 320,
			data 		: bar1
		});
		zingchart.render({
			id 			: 'g4',
			width 		: 820,
			height 		: 320,
			data 		: bar1
		});
		zingchart.render({
			id 			: 'g5',
			width 		: 820,
			height 		: 320,
			data 		: bar1
		});
		zingchart.render({
			id 			: 'g6',
			width 		: 1150,
			height 		: 320,
			data 		: mix1
		});
		zingchart.render({
			id 			: 'g7',
			width 		: 600,
			height 		: 320,
			data 		: mix2
		});
		zingchart.render({
			id 			: 'g8',
			width 		: 800,
			height 		: 320,
			data 		: mix3
		});
		zingchart.render({
			id 			: 'g9',
			width 		: 650,
			height 		: 320,
			data 		: mix4
		});
	});

	</script>

</head>

<body>
<!--+++++++++++++++++++++++++ Parameter +++++++++++++++++++++++++-->
	<!--          Drop Down List YEAR              -->
	<div style="position:absolute; left:15px; top:20px;"><font size="3"> ปี:</font>
		<select name="Year" onChange="getYear(this.value);">
			<option value="1"<%if(y.equals("1")) out.print(" selected=\"selected\"");%>>2010</option>
			<option value="2"<%if(y.equals("2")) out.print(" selected=\"selected\"");%>>2009</option>
		</select> 
	</div>
	<!--          Drop Down List MONTH              -->
	<div style="position:absolute; left:125px; top:20px;"><font size="3"> เดือน:</font>
		<select name="Month" onChange="getMonth(this.value);">
			<option value="1"<%if(months.equals("1")) out.print(" selected=\"selected\"");%>>Jan</option>
			<option value="2"<%if(months.equals("2")) out.print(" selected=\"selected\"");%>>Feb</option>
			<option value="3"<%if(months.equals("3")) out.print(" selected=\"selected\"");%>>Mar</option>
			<option value="4"<%if(months.equals("4")) out.print(" selected=\"selected\"");%>>Apr</option>
			<option value="5"<%if(months.equals("5")) out.print(" selected=\"selected\"");%>>May</option>
			<option value="6"<%if(months.equals("6")) out.print(" selected=\"selected\"");%>>Jun</option>
			<option value="7"<%if(months.equals("7")) out.print(" selected=\"selected\"");%>>Jul</option>
			<option value="8"<%if(months.equals("8")) out.print(" selected=\"selected\"");%>>Aug</option>
			<option value="9"<%if(months.equals("9")) out.print(" selected=\"selected\"");%>>Sep</option>
			<option value="10"<%if(months.equals("10")) out.print(" selected=\"selected\"");%>>Oct</option>
			<option value="11"<%if(months.equals("11")) out.print(" selected=\"selected\"");%>>Nov</option>
			<option value="12"<%if(months.equals("12")) out.print(" selected=\"selected\"");%>>Dec</option>
		</select> 
	</div>
	<!--          Drop Down List SUMMARY BY            -->
	<div style="position:absolute; left:250px; top:20px;"><font size="3"> สรุปตาม : </font>
		<select name="SumBy" onChange="getSumBy(this.value);">
			<option value="1" selected="selected">YTD</option>
			<option value="2">QTD</option>
			<option value="3">MTD</option>
		</select> 
	</div>
	<div style="position:absolute; left:390px; top:20px;">
		<input type="button" value=" OK " onClick="goUrl()"/></div>
	</div>
<!--+++++++++++++++++++++++++ End Parameter +++++++++++++++++++++++++-->

<!--+++++++++++++++++++++++++ +++++++++++++++++++++++++-->
<div id="tabs" style="position:absolute; height=500px;" bordercolor="#FFFFFF" border="5">
<!--+++++++++++++++++++++++++ Tab 1 +++++++++++++++++++++++++-->
<table id="tabs-r1c1" width=1100>
	<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">สัดส่วนการขายตามช่องทางจำหน่าย</font></th></tr>

	<tr>
		<td align="right" id="g1"></td>

		<td align="center">
		<table width="550" bordercolor="#000000" frame="box" rules="all">
			<tr bgcolor="#CD853F">
				<th><font color="#FFFFFF">ช่องทางจำหน่าย</font></th>
				<th width=100><font color="#FFFFFF">Net Sales</font></th>
				<th width=100><font color="#FFFFFF">Net Sales<br>Last Year <%out.print(t);%></font></th>
				<th width=70><font color="#FFFFFF">กำไร</font></th>
				<th width=70><font color="#FFFFFF">%Growth</font></th>
			</tr>
			<tr>
				<td>Retail</td>
				<td align="right">3,353,945</td>
				<td align="right">4,928,406</td>
				<td align="right">75%</td>
				<td align="right">37.95%</td>
			</tr>
			<tr>
				<td>Food Service</td>
				<td align="right">3,129,483</td>
				<td align="right">3,673,193</td>
				<td align="right">63%</td>
				<td align="right">35.28%</td>
			</tr>
			<tr>
				<td>Export</td>
				<td align="right">2,970,343</td>
				<td align="right">3,129,483</td>
				<td align="right">51%</td>
				<td align="right">30.45%</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<!--+++++++++++++++++++++++++ Tab 2 +++++++++++++++++++++++++-->
<table id="tabs-r2c1" width=1100>
<tr><td>
	<ul>
		<li><a href="#tabs-r2_1">ยอดรวม</a></li>
		<li><a href="#tabs-r2_2">Retail</a></li>
		<li><a href="#tabs-r2_3">Food Service</a></li>
		<li><a href="#tabs-r2_4">Export</a></li>
	</ul>

<!--+++++++++++++++++++++++++ Tab 2_1 +++++++++++++++++++++++++-->
	<table id="tabs-r2_1" width=1080>
	<tr><td>
		<table id="tabs-r2_1-1"><tr>
		<td valign="top">
		<table id="tabs-param1">
			<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มสินค้า</font></th></tr>

			<tr><td>
			<select multiple size="8" style="width:190px;">
				<option value="1">&nbsp;Frozen Food - Savory</option>
				<option value="2">&nbsp;Frozen Food - Sweet</option>
				<option value="3">&nbsp;Frozen Pasta</option>
				<option value="4">&nbsp;Bakery</option>
				<option value="5">&nbsp;Frozen Sauce</option>
				<option value="6">&nbsp;Moon Cake</option>
				<option value="7">&nbsp;Sausage</option>
				<option value="8">&nbsp;Salad Dressing</option>
				<option value="9">&nbsp;Phuket</option>
				<option value="10">&nbsp;Seriwat Product</option>
				<option value="11">&nbsp;Cookie</option>
				<option value="12">&nbsp;Dim Sum</option>
				<option value="13">&nbsp;QM Food</option>
				<option value="14">&nbsp;QM Dessert</option>
				<option value="15">&nbsp;Mini Moon Cake</option>
				<option value="16">&nbsp;Other</option>
			</select>
			</td></tr>

			<tr><td align="right"><input type="button" name="ok" value=" OK "/></td></tr>
		</table>
		</td>

		<td>
			<table id="tabs-chart1">
				<tr><td id="g2"></td></tr>
			</table>
		</td>
		</tr></table>

	</td></tr>
<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->
	<tr><td>
	<table width=1055>
		<tr><td><table id="tabs-r2_1-2">
		<tr>
			<td>ยอดขายสินค้าตาม : 
			<select>
				<option value="1">กลุ่มสินค้า</option>
				<option value="2">กลุ่มลูกค้า</option>
			</select>
			<input type="button" value=" OK "/>
			</td>
		</tr>

		<tr>
			<td><div style="width:573px; overflow:auto;"><table><td id="g6"></td></table></div></td>
		</tr></table>
		</td>

		<td valign="top">
			<table id="tabs-r2_1-2_1" height=378>
				<tr><td>
					<select>
						<option value="1">Top</option>
						<option value="2">Bottom</option>
					</select> 
					<input type="text" name="size" value="10" size="1"> กลุ่มสินค้า 
					<select>
						<option value="1">&nbsp;Frozen Food - Savory</option>
						<option value="2">&nbsp;Frozen Food - Sweet</option>
						<option value="3">&nbsp;Frozen Pasta</option>
						<option value="4">&nbsp;Bakery</option>
						<option value="5">&nbsp;Frozen Sauce</option>
						<option value="6">&nbsp;Moon Cake</option>
						<option value="7">&nbsp;Sausage</option>
						<option value="8">&nbsp;Salad Dressing</option>
						<option value="9">&nbsp;Phuket</option>
						<option value="10">&nbsp;Seriwat Product</option>
						<option value="11">&nbsp;Cookie</option>
						<option value="12">&nbsp;Dim Sum</option>
						<option value="13">&nbsp;QM Food</option>
						<option value="14">&nbsp;QM Dessert</option>
						<option value="15">&nbsp;Mini Moon Cake</option>
						<option value="16">&nbsp;Other</option>
					</select>
					<input type="button" value=" OK "/>
				</td></tr>

				<tr><td valign="top">
					<table width=450 bordercolor="#000000" frame="box" rules="all">
						<tr bgcolor="#CD853F">
							<th><font color="#FFFFFF">สินค้า</font></th>
							<th><font color="#FFFFFF">จำนวนขาย</font></th>
							<th><font color="#FFFFFF">ยอดขาย</font></th>
							<th><font color="#FFFFFF">%Share</font></th>
							<th><font color="#FFFFFF">%กำไร</font></th>
						</tr>
						<tr>
							<td>&nbsp;เค้กเนยสด สตาร์บัคส์</td>
							<td align="right">53,153</td>
							<td align="right">2,490,352</td>
							<td align="right">31.30%</td>
							<td align="right">24.59%</td>
						</tr>
						<tr>
							<td>&nbsp;เอสเปรสโซ่ ซ็อคโกแลตชิพบราวนี่</td>
							<td align="right">52,352</td>
							<td align="right">2,346,268</td>
							<td align="right">30.92%</td>
							<td align="right">22.47%</td>
						</tr>
						<tr>
							<td>&nbsp;เค้กเนยสด 75 กรัม</td>
							<td align="right">51,351</td>
							<td align="right">2,263,493</td>
							<td align="right">30.l2%</td>
							<td align="right">21.34%</td>
						</tr>
						<tr>
							<td>&nbsp;ครัวซองท์ไส้ครีมอัลมอนด์</td>
							<td align="right">46,345</td>
							<td align="right">1,893,427</td>
							<td align="right">29.64%</td>
							<td align="right">19.75%</td>
						</tr>
						<tr>
							<td>&nbsp;หมูทอดกระเทียมพริกไทย</td>
							<td align="right">40,173</td>
							<td align="right">195,345</td>
							<td align="right">27.54%</td>
							<td align="right">19.24%</td>
						</tr>
						<tr>
							<td>&nbsp;แกงเขียวหวานไก่ 140 กรัม</td>
							<td align="right">38,356</td>
							<td align="right">164,364</td>
							<td align="right">25.45%</td>
							<td align="right">18.35%</td>
						</tr>
						<tr>
							<td>&nbsp;กระเพราไก่ 120 กรัม</td>
							<td align="right">36,356</td>
							<td align="right">145,352</td>
							<td align="right">23.64%</td>
							<td align="right">14.24%</td>
						</tr>
						<tr>
							<td>&nbsp;สาคูถั่วดำมะพร้าวอ่อน 170 กรัม</td>
							<td align="right">35,504</td>
							<td align="right">115,245</td>
							<td align="right">20.35%</td>
							<td align="right">11.56%</td>
						</tr>
						<tr>
							<td>&nbsp;เต้าทึงร้อน 180 กรัม</td>
							<td align="right">32,554</td>
							<td align="right">98,352</td>
							<td align="right">17.35%</td>
							<td align="right">9.54%</td>
						</tr>
						<tr>
							<td>&nbsp;บัวลอยน้ำขิง 160 กรัม</td>
							<td align="right">30,254</td>
							<td align="right">90,375</td>
							<td align="right">15.97%</td>
							<td align="right">9.08%</td>
						</tr>
					</table>
				</td></tr>
			</table>
			</td>
		</tr>
		</table>
	</td></tr>
	</table>

<!--+++++++++++++++++++++++++ Tab 2_2 +++++++++++++++++++++++++-->
	<table id="tabs-r2_2" width=1080>
	<tr><td>
		<table id="tabs-r2_2-1"><tr>
		<td valign="top">
		<table id="tabs-param2">
			<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มสินค้า</font></th></tr>

			<tr><td>
				<select multiple size="8" style="width:190px;">
					<option value="1">&nbsp;Frozen Food</option>
					<option value="2">&nbsp;Frozen Cake</option>
					<option value="3">&nbsp;Sausage</option>
					<option value="4">&nbsp;Cookie</option>
					<option value="5">&nbsp;Moon Cake</option>
					<option value="6">&nbsp;Patio</option>
					<option value="7">&nbsp;Seriwat</option>
					<option value="8">&nbsp;Dim Sum</option>
					<option value="9">&nbsp;Other</option>
				</select>
			</td></tr>

			<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มลูกค้า</font></th></tr>

			<tr><td>
			<select multiple size="7" style="width:190px;">
				<option value="1">The Pizza</option>
				<option value="2">Sizzler</option>
				<option value="3">Swenzen</option>
				<option value="4">NC</option>
				<option value="5">Dairy Queen</option>
				<option value="6">Starbuck</option>
				<option value="7">Food House</option>
				<option value="8">TG</option>
				<option value="9">Others</option>
			</select>
			</td></tr>

			<tr><td align="right"><input type="button" name="ok" value=" OK "/></td></tr>
		</table>
		</td>

		<td>
			<table id="tabs-chart2">
				<tr><td id="g3"></td></tr>
			</table>
		</td>
		</tr></table>

	</td></tr>
<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->
	<tr><td>
	<table width=1055>
		<tr><td><table id="tabs-r2_2-2">
		<tr>
			<td>ยอดขายสินค้าตาม : 
			<select>
				<option value="1">กลุ่มสินค้า</option>
				<option value="2">กลุ่มลูกค้า</option>
			</select>
			<input type="button" value=" OK "/>
			</td>
		</tr>

		<tr>
			<td><div style="width:573px; overflow:auto;"><table><td id="g7"></td></table></div></td>
		</tr></table>
		</td>

		<td valign="top">
			<table id="tabs-r2_2-2_1" height=378>
				<tr><td>
					<select>
						<option value="1">Top</option>
						<option value="2">Bottom</option>
					</select> 
					<input type="text" name="size" value="10" size="1"> กลุ่มสินค้า 
					<select>
						<option value="1">&nbsp;Frozen Food</option>
						<option value="2">&nbsp;Frozen Cake</option>
						<option value="3">&nbsp;Sausage</option>
						<option value="4">&nbsp;Cookie</option>
						<option value="5">&nbsp;Moon Cake</option>
						<option value="6">&nbsp;Patio</option>
						<option value="7">&nbsp;Seriwat</option>
						<option value="8">&nbsp;Dim Sum</option>
						<option value="9">&nbsp;Other</option>
					</select>
					<input type="button" value=" OK "/>
				</td></tr>

				<tr><td valign="top">
					<table width=450 bordercolor="#000000" frame="box" rules="all">
						<tr bgcolor="#CD853F">
							<th><font color="#FFFFFF">สินค้า</font></th>
							<th><font color="#FFFFFF">จำนวนขาย</font></th>
							<th><font color="#FFFFFF">ยอดขาย</font></th>
							<th><font color="#FFFFFF">%Share</font></th>
							<th><font color="#FFFFFF">%กำไร</font></th>
						</tr>
						<tr>
							<td>&nbsp;เค้กเนยสด สตาร์บัคส์</td>
							<td align="right">53,153</td>
							<td align="right">2,490,352</td>
							<td align="right">31.30%</td>
							<td align="right">24.59%</td>
						</tr>
						<tr>
							<td>&nbsp;เอสเปรสโซ่ ซ็อคโกแลตชิพบราวนี่</td>
							<td align="right">52,352</td>
							<td align="right">2,346,268</td>
							<td align="right">30.92%</td>
							<td align="right">22.47%</td>
						</tr>
						<tr>
							<td>&nbsp;เค้กเนยสด 75 กรัม</td>
							<td align="right">51,351</td>
							<td align="right">2,263,493</td>
							<td align="right">30.l2%</td>
							<td align="right">21.34%</td>
						</tr>
						<tr>
							<td>&nbsp;ครัวซองท์ไส้ครีมอัลมอนด์</td>
							<td align="right">46,345</td>
							<td align="right">1,893,427</td>
							<td align="right">29.64%</td>
							<td align="right">19.75%</td>
						</tr>
						<tr>
							<td>&nbsp;หมูทอดกระเทียมพริกไทย</td>
							<td align="right">40,173</td>
							<td align="right">195,345</td>
							<td align="right">27.54%</td>
							<td align="right">19.24%</td>
						</tr>
						<tr>
							<td>&nbsp;แกงเขียวหวานไก่ 140 กรัม</td>
							<td align="right">38,356</td>
							<td align="right">164,364</td>
							<td align="right">25.45%</td>
							<td align="right">18.35%</td>
						</tr>
						<tr>
							<td>&nbsp;กระเพราไก่ 120 กรัม</td>
							<td align="right">36,356</td>
							<td align="right">145,352</td>
							<td align="right">23.64%</td>
							<td align="right">14.24%</td>
						</tr>
						<tr>
							<td>&nbsp;สาคูถั่วดำมะพร้าวอ่อน 170 กรัม</td>
							<td align="right">35,504</td>
							<td align="right">115,245</td>
							<td align="right">20.35%</td>
							<td align="right">11.56%</td>
						</tr>
						<tr>
							<td>&nbsp;เต้าทึงร้อน 180 กรัม</td>
							<td align="right">32,554</td>
							<td align="right">98,352</td>
							<td align="right">17.35%</td>
							<td align="right">9.54%</td>
						</tr>
						<tr>
							<td>&nbsp;บัวลอยน้ำขิง 160 กรัม</td>
							<td align="right">30,254</td>
							<td align="right">90,375</td>
							<td align="right">15.97%</td>
							<td align="right">9.08%</td>
						</tr>
					</table>
				</td></tr>
			</table>
			</td>
		</tr>
		</table>
	</td></tr>
	</table>

<!--+++++++++++++++++++++++++ Tab 2_3 +++++++++++++++++++++++++-->
	<table id="tabs-r2_3" width=1080>
	<tr><td>
		<table id="tabs-r2_3-1"><tr>
		<td valign="top">
		<table id="tabs-param3">
			<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มสินค้า</font></th></tr>

			<tr><td>
			<select multiple size="8" style="width:190px;">
				<option value="1">&nbsp;Frozen Food - Savory</option>
				<option value="2">&nbsp;Frozen Food - Sweet </option>
				<option value="3">&nbsp;Frozen Pasta</option>
				<option value="4">&nbsp;Bakery</option>
				<option value="5">&nbsp;Frozen Sauce</option>
				<option value="6">&nbsp;Moon Cake</option>
				<option value="7">&nbsp;Sausage</option>
				<option value="8">&nbsp;Salad Dressing</option>
				<option value="9">&nbsp;Phuket</option>
				<option value="9">&nbsp;Seriwat</option>
			</td></tr>

			<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มลูกค้า</font></th></tr>

			<tr><td>
			<select multiple size="7" style="width:190px;">
				<option value="1">The Pizza</option>
				<option value="2">Sizzler</option>
				<option value="3">Swenzen</option>
				<option value="4">NC</option>
				<option value="5">Dairy Queen</option>
				<option value="6">Starbuck</option>
				<option value="7">Food House</option>
				<option value="8">TG</option>
				<option value="9">Others</option>
			</select>
			</td></tr>

			<tr><td align="right"><input type="button" name="ok" value=" OK "/></td></tr>
		</table>
		</td>

		<td>
			<table id="tabs-chart3">
				<tr><td id="g4"></td></tr>
			</table>
		</td>
		</tr></table>

	</td></tr>
<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->
	<tr><td>
	<table width=1055>
		<tr><td><table id="tabs-r2_3-2">
		<tr>
			<td>ยอดขายสินค้าตาม : 
			<select>
				<option value="1">กลุ่มสินค้า</option>
				<option value="2">กลุ่มลูกค้า</option>
			</select>
			<input type="button" value=" OK "/>
			</td>
		</tr>

		<tr>
			<td><div style="width:573px; overflow:auto;"><table><td id="g8"></td></table></div></td>
		</tr></table>
		</td>

		<td valign="top">
			<table id="tabs-r2_3-2_1" height=378>
				<tr><td>
					<select>
						<option value="1">Top</option>
						<option value="2">Bottom</option>
					</select> 
					<input type="text" name="size" value="10" size="1"> กลุ่มสินค้า 
					<select>
						<option value="1">&nbsp;Frozen Food - Savory</option>
						<option value="2">&nbsp;Frozen Food - Sweet </option>
						<option value="3">&nbsp;Frozen Pasta</option>
						<option value="4">&nbsp;Bakery</option>
						<option value="5">&nbsp;Frozen Sauce</option>
						<option value="6">&nbsp;Moon Cake</option>
						<option value="7">&nbsp;Sausage</option>
						<option value="8">&nbsp;Salad Dressing</option>
						<option value="9">&nbsp;Phuket</option>
						<option value="9">&nbsp;Seriwat</option>
					</select>
					<input type="button" value=" OK "/>
				</td></tr>

				<tr><td valign="top">
					<table width=450 bordercolor="#000000" frame="box" rules="all">
						<tr bgcolor="#CD853F">
							<th><font color="#FFFFFF">สินค้า</font></th>
							<th><font color="#FFFFFF">จำนวนขาย</font></th>
							<th><font color="#FFFFFF">ยอดขาย</font></th>
							<th><font color="#FFFFFF">%Share</font></th>
							<th><font color="#FFFFFF">%กำไร</font></th>
						</tr>
						<tr>
							<td>&nbsp;เค้กเนยสด สตาร์บัคส์</td>
							<td align="right">53,153</td>
							<td align="right">2,490,352</td>
							<td align="right">31.30%</td>
							<td align="right">24.59%</td>
						</tr>
						<tr>
							<td>&nbsp;เอสเปรสโซ่ ซ็อคโกแลตชิพบราวนี่</td>
							<td align="right">52,352</td>
							<td align="right">2,346,268</td>
							<td align="right">30.92%</td>
							<td align="right">22.47%</td>
						</tr>
						<tr>
							<td>&nbsp;เค้กเนยสด 75 กรัม</td>
							<td align="right">51,351</td>
							<td align="right">2,263,493</td>
							<td align="right">30.l2%</td>
							<td align="right">21.34%</td>
						</tr>
						<tr>
							<td>&nbsp;ครัวซองท์ไส้ครีมอัลมอนด์</td>
							<td align="right">46,345</td>
							<td align="right">1,893,427</td>
							<td align="right">29.64%</td>
							<td align="right">19.75%</td>
						</tr>
						<tr>
							<td>&nbsp;หมูทอดกระเทียมพริกไทย</td>
							<td align="right">40,173</td>
							<td align="right">195,345</td>
							<td align="right">27.54%</td>
							<td align="right">19.24%</td>
						</tr>
						<tr>
							<td>&nbsp;แกงเขียวหวานไก่ 140 กรัม</td>
							<td align="right">38,356</td>
							<td align="right">164,364</td>
							<td align="right">25.45%</td>
							<td align="right">18.35%</td>
						</tr>
						<tr>
							<td>&nbsp;กระเพราไก่ 120 กรัม</td>
							<td align="right">36,356</td>
							<td align="right">145,352</td>
							<td align="right">23.64%</td>
							<td align="right">14.24%</td>
						</tr>
						<tr>
							<td>&nbsp;สาคูถั่วดำมะพร้าวอ่อน 170 กรัม</td>
							<td align="right">35,504</td>
							<td align="right">115,245</td>
							<td align="right">20.35%</td>
							<td align="right">11.56%</td>
						</tr>
						<tr>
							<td>&nbsp;เต้าทึงร้อน 180 กรัม</td>
							<td align="right">32,554</td>
							<td align="right">98,352</td>
							<td align="right">17.35%</td>
							<td align="right">9.54%</td>
						</tr>
						<tr>
							<td>&nbsp;บัวลอยน้ำขิง 160 กรัม</td>
							<td align="right">30,254</td>
							<td align="right">90,375</td>
							<td align="right">15.97%</td>
							<td align="right">9.08%</td>
						</tr>
					</table>
				</td></tr>
			</table>
			</td>
		</tr>
		</table>
	</td></tr>
	</table>

<!--+++++++++++++++++++++++++ Tab 2_4 +++++++++++++++++++++++++-->
	<table id="tabs-r2_4" width=1080>
	<tr><td>
		<table id="tabs-r2_4-1"><tr>
		<td valign="top">
		<table id="tabs-param4">
			<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มสินค้า</font></th></tr>

			<tr><td>
			<select multiple size="8" style="width:190px;">
				<option value="1">&nbsp;QM Food</option>
				<option value="2">&nbsp;QM Dessert</option>
				<option value="3">&nbsp;Frozen Cake</option>
				<option value="4">&nbsp;Cookie</option>
				<option value="5">&nbsp;Moon Cake</option>
				<option value="6">&nbsp;Mini Moon Cake</option>
				<option value="7">&nbsp;Sausage</option>
				<option value="8">&nbsp;Other</option>
			</select>
			</td></tr>

			<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มลูกค้า</font></th></tr>

			<tr><td>
			<select multiple size="7" style="width:190px;">
				<option value="1">The Pizza</option>
				<option value="2">Sizzler</option>
				<option value="3">Swenzen</option>
				<option value="4">NC</option>
				<option value="5">Dairy Queen</option>
				<option value="6">Starbuck</option>
				<option value="7">Food House</option>
				<option value="8">TG</option>
				<option value="9">Others</option>
			</select>
			</td></tr>

			<tr><td align="right"><input type="button" name="ok" value=" OK "/></td></tr>
		</table>
		</td>

		<td>
			<table id="tabs-chart4">
				<tr><td id="g5"></td></tr>
			</table>
		</td>
		</tr></table>

	</td></tr>
<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->
	<tr><td>
	<table width=1055>
		<tr><td><table id="tabs-r2_4-2">
		<tr>
			<td>ยอดขายสินค้าตาม : 
			<select>
				<option value="1">กลุ่มสินค้า</option>
				<option value="2">กลุ่มลูกค้า</option>
			</select>
			<input type="button" value=" OK "/>
			</td>
		</tr>

		<tr>
			<td><div style="width:573px; overflow:auto;"><table><td id="g9"></td></table></div></td>
		</tr></table>
		</td>

		<td valign="top">
			<table id="tabs-r2_4-2_1" height=378>
				<tr><td>
					<select>
						<option value="1">Top</option>
						<option value="2">Bottom</option>
					</select> 
					<input type="text" name="size" value="10" size="1"> กลุ่มสินค้า 
					<select>
						<option value="1">&nbsp;QM Food</option>
						<option value="2">&nbsp;QM Dessert</option>
						<option value="3">&nbsp;Frozen Cake</option>
						<option value="4">&nbsp;Cookie</option>
						<option value="5">&nbsp;Moon Cake</option>
						<option value="6">&nbsp;Mini Moon Cake</option>
						<option value="7">&nbsp;Sausage</option>
						<option value="8">&nbsp;Other</option>
					</select>
					<input type="button" value=" OK "/>
				</td></tr>

				<tr><td valign="top">
					<table width=450 bordercolor="#000000" frame="box" rules="all">
						<tr bgcolor="#CD853F">
							<th><font color="#FFFFFF">สินค้า</font></th>
							<th><font color="#FFFFFF">จำนวนขาย</font></th>
							<th><font color="#FFFFFF">ยอดขาย</font></th>
							<th><font color="#FFFFFF">%Share</font></th>
							<th><font color="#FFFFFF">%กำไร</font></th>
						</tr>
						<tr>
							<td>&nbsp;เค้กเนยสด สตาร์บัคส์</td>
							<td align="right">53,153</td>
							<td align="right">2,490,352</td>
							<td align="right">31.30%</td>
							<td align="right">24.59%</td>
						</tr>
						<tr>
							<td>&nbsp;เอสเปรสโซ่ ซ็อคโกแลตชิพบราวนี่</td>
							<td align="right">52,352</td>
							<td align="right">2,346,268</td>
							<td align="right">30.92%</td>
							<td align="right">22.47%</td>
						</tr>
						<tr>
							<td>&nbsp;เค้กเนยสด 75 กรัม</td>
							<td align="right">51,351</td>
							<td align="right">2,263,493</td>
							<td align="right">30.l2%</td>
							<td align="right">21.34%</td>
						</tr>
						<tr>
							<td>&nbsp;ครัวซองท์ไส้ครีมอัลมอนด์</td>
							<td align="right">46,345</td>
							<td align="right">1,893,427</td>
							<td align="right">29.64%</td>
							<td align="right">19.75%</td>
						</tr>
						<tr>
							<td>&nbsp;หมูทอดกระเทียมพริกไทย</td>
							<td align="right">40,173</td>
							<td align="right">195,345</td>
							<td align="right">27.54%</td>
							<td align="right">19.24%</td>
						</tr>
						<tr>
							<td>&nbsp;แกงเขียวหวานไก่ 140 กรัม</td>
							<td align="right">38,356</td>
							<td align="right">164,364</td>
							<td align="right">25.45%</td>
							<td align="right">18.35%</td>
						</tr>
						<tr>
							<td>&nbsp;กระเพราไก่ 120 กรัม</td>
							<td align="right">36,356</td>
							<td align="right">145,352</td>
							<td align="right">23.64%</td>
							<td align="right">14.24%</td>
						</tr>
						<tr>
							<td>&nbsp;สาคูถั่วดำมะพร้าวอ่อน 170 กรัม</td>
							<td align="right">35,504</td>
							<td align="right">115,245</td>
							<td align="right">20.35%</td>
							<td align="right">11.56%</td>
						</tr>
						<tr>
							<td>&nbsp;เต้าทึงร้อน 180 กรัม</td>
							<td align="right">32,554</td>
							<td align="right">98,352</td>
							<td align="right">17.35%</td>
							<td align="right">9.54%</td>
						</tr>
						<tr>
							<td>&nbsp;บัวลอยน้ำขิง 160 กรัม</td>
							<td align="right">30,254</td>
							<td align="right">90,375</td>
							<td align="right">15.97%</td>
							<td align="right">9.08%</td>
						</tr>
					</table>
				</td></tr>
			</table>
			</td>
		</tr>
		</table>
	</td></tr>
	</table>
<!--+++++++++++++++++++++++++++ END +++++++++++++++++++++++++++++-->

</td></tr>
</table>

</div>
</body>
</html>