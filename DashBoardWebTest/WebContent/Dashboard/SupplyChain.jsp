<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Supply Chain Dashboard Page</title>

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
			$("#tabs-r1c2").tabs();
			$("#tabs-r2c1").tabs();
			$("#tabs-r2c2").tabs();
			$("#tabs-r3c1").tabs();
			$("#tabs-r4c1").tabs();
			$("#tabs-r5c1").tabs();
			$("#tabs-r5c2").tabs();
			
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

		/*---------- Rotate Text ----------
		  SOURCE: http://www.ninenik.com/content.php?arti_id=283*/
		.textAlignVer{
			display:block;
			writing-mode: tb-rl;
			filter: flipv fliph;
			-webkit-transform: rotate(90deg); 
			-moz-transform: rotate(90deg);	
			transform: rotate(90deg); 
			position:relative;
			/*font-family: "Trebuchet MS", sans-serif; "Trebuchet MS", sans-serif;*/
			width:35px;
			white-space:nowrap;
			font-size:12px;
			margin-bottom:20px;
		}
		
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
			"x":10,
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
				"text" : "LKB",
				"values" : [50],
				"tooltip-text" : "%t: 5,000"
			},
			{
				"text" : "ศรีนครินทร์",
				"values" : [30],
				"tooltip-text" : "%t: 3,000%"
			},
			{
				"text" : "62",
				"values" : [20],
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
				"text" : "LKB",
				"values" : [27.35],
				"tooltip-text" : "%t: 2,847"
			},
			{
				"text" : "ศรีนครินทร์",
				"values" : [39.67],
				"tooltip-text" : "%t: 4,893"
			},
			{
				"text" : "62",
				"values" : [32.98],
				"tooltip-text" : "%t: 3,782"			
			}]
	}]
};
	
	var pie3 = {
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
				"text" : "LKB",
				"values" : [29.76],
				"tooltip-text" : "%t: 3,452"
			},
			{
				"text" : "ศรีนครินทร์",
				"values" : [47.92],
				"tooltip-text" : "%t: 6,332"
			},
			{
				"text" : "62",
				"values" : [22.32],
				"tooltip-text" : "%t: 2,631"			
			}]
	}]
};

	var pie4 = {
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
				"text" : "LKB",
				"values" : [12.45],
				"tooltip-text" : "%t: 1,245"
			},
			{
				"text" : "ศรีนครินทร์",
				"values" : [51.34],
				"tooltip-text" : "%t: 6,234"
			},
			{
				"text" : "62",
				"values" : [36.21],
				"tooltip-text" : "%t: 4,274"			
			}]
	}]
};
	
	var line = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "line",
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x1",
			"x": 1000,
			"y": 70
		},
		"chart" : {
			"margin" : "20 100 40 50"
		},
		"scale-x" : {
			"values" : ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
			"line-color": "#8B8B7A",
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
				"values" : [3,8,6,4,7,5,4,8,4,5,3,4],
				//"aspect" : "spline",
				"text" : "LKB"
			},
			{
				"values" : [2,3,5,7,1,2,9,3,2,3,6,7],
				//"aspect" : "spline",
				"text" : "ศรีนครินทร์"
			},
			{
				"values" : [4,5,7,9,8,1,5,7,6,9,8,2],
				//"aspect" : "spline",
				"text" : "62"
			}
		] 
	}
	]
};

	var bar1 = {
	"graphset" : [
	{
		"type" : "bar",
		"background-color":"#FFFFFF",
		"chart":{
			"margin":"10 5 40 50"
		},
		"scale-x":{
			"values":["This Period","เดือนที่แล้ว(MTD)","เดือนเดียวกัน<br>ปีที่แล้ว(MTD)","ไตรมาสที่แล้ว","ไตรมาสเดียวกัน<br>ปีที่แล้ว(QTD)","ปีที่แล้ว(YTD)"],
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
			"values":[128,119,152,124,153,112]
		}] 
	}]
};

	var mix1 = {
	"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart" : {
				"margin" : "10 50 30 70"
			},
			"stacked":"1",
			"plot":{
				"bars-space-left":"35%",
				"bars-space-right":"35%",
				"bar-width":"25px"
			},
			"labels":[
			{
				"text":"target",
				"font-size":"12px",
				"bold":true,
				"x":"440px", // Lock position.
				"y":"170px" // Change position with end target data.
			}],
			"scale-x" : {
				"values" : ["62","LKB","ศรีนครินทร์"],
				"guide":{
    				"line-width": 1,
    				"alpha": 1
    			},
				"tick":{
					"line-width": 3
				}
			},
			"scale-y" : {
				"min-value" : 0,
				"format" : "%v%",
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
					"type":"bar",
					"values":[74.27,,],
					"text":"62"
				},
				{
					"type":"bar",
					"values":[,32.88,],
					"text":"LKB"
				},
				{
					"type":"bar",
					"values":[,,63.74],
					"text":"ศรีนครินทร์"
				},
				{
					"type":"line",
					"stacked":"0",
					"values":[29.85,39.82,20.53],
					"text":"target"
				}
			]
		}
	]
};
	
	var mix2 = {
	"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart" : {
				"margin" : "10 50 30 70"
			},
			"stacked":"1",
			"plot":{
				"bars-space-left":"35%",
				"bars-space-right":"35%",
				"bar-width":"25px"
			},
			"labels":[
			{
				"text":"target",
				"font-size":"12px",
				"bold":true,
				"x":"440px", // Lock position.
				"y":"170px" // Change position with end target data.
			}],
			"scale-x" : {
				"values" : ["62","LKB","ศรีนครินทร์"],
				"guide":{
    				"line-width": 1,
    				"alpha": 1
    			},
				"tick":{
					"line-width": 3
				}
			},
			"scale-y" : {
				"min-value" : 0,
				"format" : "%v%",
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
					"type":"bar",
					"values":[74.27,,],
					"text":"62"
				},
				{
					"type":"bar",
					"values":[,32.88,],
					"text":"LKB"
				},
				{
					"type":"bar",
					"values":[,,63.74],
					"text":"ศรีนครินทร์"
				},
				{
					"type":"line",
					"stacked":"0",
					"values":[29.85,39.82,20.53],
					"text":"target"
				}
			]
		}
	]
};

	$(document).ready(function() {
		zingchart.render({
			id 			: 'g1',
			width 		: 300,
			height 		: 250,
			data 		: pie1
		});
		zingchart.render({
			id 			: 'g2',
			width 		: 310,
			height 		: 250,
			data 		: pie2
		});
		zingchart.render({
			id 			: 'g3',
			width 		: 310,
			height 		: 250,
			data 		: pie3
		});
		zingchart.render({
			id 			: 'g4',
			width 		: 310,
			height 		: 250,
			data 		: pie4
		});
		zingchart.render({
			id 			: 'g5',
			width 		: 1090,
			height 		: 250,
			data 		: line
		});
		zingchart.render({
			id 			: 'g6',
			width 		: 550,
			height 		: 250,
			data 		: bar1
		});
		zingchart.render({
			id 			: 'g7',
			width 		: 535,
			height 		: 270,
			data 		: mix1
		});
		zingchart.render({
			id 			: 'g8',
			width 		: 535,
			height 		: 270,
			data 		: mix2
		});
	});

	</script>

</head>

<body>
<!-- Parameter -->
	<!--          Drop Down List YEAR              -->
	<div style="position:absolute; left:15px; top:20px;"><font size="3"> ปี:</font>
		<select name="Year">
			<option value="2010">2010</option>
			<option value="2009">2009</option>
		</select> 
	</div>
	<!--          Drop Down List MONTH              -->
	<div style="position:absolute; left:125px; top:20px;"><font size="3"> เดือน:</font>
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
	<!--          Drop Down List             -->
	<div style="position:absolute; left:250px; top:20px;"><font size="3"> หน่วย: </font>
		<select name="SumBy">
			<option value="1">มูลค่า</option>
			<option value="2">จำนวน</option>
		</select> 
	</div>
	<div style="position:absolute; left:370px; top:20px;">
		<input type="button" name="ok" value=" OK "/></div>
	</div>
<!-- End Parameter -->

<!-- -->
<div id="tabs" style="position:absolute; height=500px;" bordercolor="#FFFFFF" border="5">

<!-- 1111111111111111111111111111111111111111111 -->
<table>
	<tr>
		<td>
		<table id="tabs-r1c1" width=545>
			<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">สัดส่วนการซื้อวัตถุดิบตามกลุ่มวัตถุดิบ</font></th></tr>
			<tr>
				<td>Stock Type : 
					<select name="StockType">
						<option value="1">ALL</option>
						<option value="2">Non-Stock</option>
						<option value="3">Stock</option>
					</select>
					<input type="button" name="ok" value=" OK "/>
				</td>
				<td>
					<select name="Top">
						<option value="1">Top</option> 
						<option value="2">Bottom</option>  
					</select>	
					<input type="text" name="size" value="10" size="1">
					<input type="button" name="ok" value=" OK "/>
				</td>
			</tr>
			<tr>
				<td id="g1"></td>

				<td valign="top">
					<table width="220" bordercolor="#000000" frame="box" rules="all">
						<tr bgcolor="#CD853F">
							<th><font color="#FFFFFF">กลุ่มวัตถุดิบ</font></th>
							<th><font color="#FFFFFF">มูลค่า</font></th>
							<th><font color="#FFFFFF">%เทียบทุก<br>กลุ่มวัตถุดิบ</font></th>
						</tr>
						<tr>
							<td>ของแช่แข็ง</td>
							<td align="right">1,000,000</td>
							<td align="right">32.15%</td>
						</tr>
						<tr>
							<td>ผักสด</td>
							<td align="right">800,000</td>
							<td align="right">23.47%</td>
						</tr>
						<tr>
							<td>วัตถุดิบ</td>
							<td align="right">750,000</td>
							<td align="right">23.18%</td>
						</tr>
						<tr>
							<td>บรรจุภัณฑ์</td>
							<td align="right">700,000</td>
							<td align="right">21.34%</td>
						</tr>
						<tr>
							<td>เบ็ดเตล็ด</td>
							<td align="right">650,000</td>
							<td align="right">19.32%</td>
						</tr>
						<tr>
							<td>วนิลา</td>
							<td align="right">600,000</td>
							<td align="right">18.35%</td>
						</tr>
					</table>
				</td>

			</tr>
		</table>
		</td>

		<td>
		<table id="tabs-r1c2" width=545>
			<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">สัดส่วนการรับวัตถุดิบตามกลุ่มวัตถุดิบ</font></th></tr>
			<tr>
				<td></td>
				<td>
					<select name="Top">
						<option value="1">Top</option> 
						<option value="2">Bottom</option>  
					</select>	
					<input type="text" name="size" value="10" size="1">
					<input type="button" name="ok" value=" OK "/>
				</td>
			</tr>
			<tr>
				<td id="g2"></td>

				<td valign="top">
					<table width="220" bordercolor="#000000" frame="box" rules="all">
						<tr bgcolor="#CD853F">
							<th><font color="#FFFFFF">กลุ่มวัตถุดิบ</font></th>
							<th><font color="#FFFFFF">มูลค่า</font></th>
							<th><font color="#FFFFFF">%เทียบทุก<br>กลุ่มวัตถุดิบ</font></th>
						</tr>
						<tr>
							<td>ของแช่แข็ง</td>
							<td align="right">1,000,000</td>
							<td align="right">32.15%</td>
						</tr>
						<tr>
							<td>ผักสด</td>
							<td align="right">800,000</td>
							<td align="right">23.47%</td>
						</tr>
						<tr>
							<td>วัตถุดิบ</td>
							<td align="right">750,000</td>
							<td align="right">23.18%</td>
						</tr>
						<tr>
							<td>บรรจุภัณฑ์</td>
							<td align="right">700,000</td>
							<td align="right">21.34%</td>
						</tr>
						<tr>
							<td>เบ็ดเตล็ด</td>
							<td align="right">650,000</td>
							<td align="right">19.32%</td>
						</tr>
						<tr>
							<td>วนิลา</td>
							<td align="right">600,000</td>
							<td align="right">18.35%</td>
						</tr>
					</table>
				</td>

			</tr>
		</table>
		</td>
	</tr>
</table>

<!-- 2222222222222222222222222222222222222222222 -->
<table>
	<tr>
		<td>
		<table id="tabs-r2c1" width=545>
			<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">สัดส่วนการจ่ายวัตถุดิบตามกลุ่มวัตถุดิบ</font></th></tr>
			<tr>
				<td></td>
				<td>
					<select name="Top">
						<option value="1">Top</option> 
						<option value="2">Bottom</option>  
					</select>	
					<input type="text" name="size" value="10" size="1">
					<input type="button" name="ok" value=" OK "/>
				</td>
			</tr>
			<tr>
				<td id="g3"></td>

				<td valign="top">
					<table width="220" bordercolor="#000000" frame="box" rules="all">
						<tr bgcolor="#CD853F">
							<th><font color="#FFFFFF">กลุ่มวัตถุดิบ</font></th>
							<th><font color="#FFFFFF">มูลค่า</font></th>
							<th><font color="#FFFFFF">%เทียบทุก<br>กลุ่มวัตถุดิบ</font></th>
						</tr>
						<tr>
							<td>ของแช่แข็ง</td>
							<td align="right">1,000,000</td>
							<td align="right">32.15%</td>
						</tr>
						<tr>
							<td>ผักสด</td>
							<td align="right">800,000</td>
							<td align="right">23.47%</td>
						</tr>
						<tr>
							<td>วัตถุดิบ</td>
							<td align="right">750,000</td>
							<td align="right">23.18%</td>
						</tr>
						<tr>
							<td>บรรจุภัณฑ์</td>
							<td align="right">700,000</td>
							<td align="right">21.34%</td>
						</tr>
						<tr>
							<td>เบ็ดเตล็ด</td>
							<td align="right">650,000</td>
							<td align="right">19.32%</td>
						</tr>
						<tr>
							<td>วนิลา</td>
							<td align="right">600,000</td>
							<td align="right">18.35%</td>
						</tr>
					</table>
				</td>

			</tr>
		</table>
		</td>

		<td>
		<table id="tabs-r2c2" width=545>
			<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">สัดส่วนการสต็อกวัตถุดิบตามกลุ่มวัตถุดิบ</font></th></tr>
			<tr>
				<td></td>
				<td>
					<select name="Top">
						<option value="1">Top</option> 
						<option value="2">Bottom</option>  
					</select>	
					<input type="text" name="size" value="10" size="1">
					<input type="button" name="ok" value=" OK "/>
				</td>
			</tr>
			<tr>
				<td id="g4"></td>

				<td valign="top">
					<table width="220" bordercolor="#000000" frame="box" rules="all">
						<tr bgcolor="#CD853F">
							<th><font color="#FFFFFF">กลุ่มวัตถุดิบ</font></th>
							<th><font color="#FFFFFF">มูลค่า</font></th>
							<th><font color="#FFFFFF">%เทียบทุก<br>กลุ่มวัตถุดิบ</font></th>
						</tr>
						<tr>
							<td>ของแช่แข็ง</td>
							<td align="right">1,000,000</td>
							<td align="right">32.15%</td>
						</tr>
						<tr>
							<td>ผักสด</td>
							<td align="right">800,000</td>
							<td align="right">23.47%</td>
						</tr>
						<tr>
							<td>วัตถุดิบ</td>
							<td align="right">750,000</td>
							<td align="right">23.18%</td>
						</tr>
						<tr>
							<td>บรรจุภัณฑ์</td>
							<td align="right">700,000</td>
							<td align="right">21.34%</td>
						</tr>
						<tr>
							<td>เบ็ดเตล็ด</td>
							<td align="right">650,000</td>
							<td align="right">19.32%</td>
						</tr>
						<tr>
							<td>วนิลา</td>
							<td align="right">600,000</td>
							<td align="right">18.35%</td>
						</tr>
					</table>
				</td>

			</tr>
		</table>
		</td>
	</tr>
</table>

<!-- 33333333333333333333333333333333333333333 -->
<table id="tabs-r3c1" width=1100>
	<tr bgcolor="#8B4513">
		<th><font color="#FFE742" size="3">อัตราหมุนเวียนสินค้าคงคลัง</font></th>
	</tr>
	<tr>
		<td id="g5"></td>
	</tr>
</table>

<!-- 444444444444444444444444444444444444444444 -->
<table id="tabs-r4c1" width=1100>
	<tr><td>
	<ul>
		<li><a href="#tabs-r4_1">วัตถุดิบที่ราคาเฉลี่ยแตกต่างกันเกิน
			<input type="text" name="size" value="10" size="3"> %
		</a></li>

		<li><a href="#tabs-r4_2">วัตถุดิบที่มูลค่าเบิกจ่ายต่างกันเกิน 
			<input type="text" name="size" value="10" size="3"> %
		</a></li>
	</ul>

	<table id="tabs-r4_1" width=1090>
	<tr><td valign="top">เทียบกับ :
			<select>
				<option value="1">เดือนที่แล้ว (MTD)</option>
				<option value="2">เดือนเดียวกันปีที่แล้ว (MTD)</option>
				<option value="3">ไตรมาสที่แล้ว</option>
				<option value="4">ไตรมาสเดียวกันปีที่แล้ว (QTD)</option>
				<option value="5">ปีที่แล้ว (YTD)</option>
			</select>
			<input type="button" name="ok" value=" OK "/>
	</td>
	<td>&nbsp;&nbsp;&nbsp;ราคาสินค้าเฉลี่ย</td>
	</tr>

	<tr>
		<td valign="top">
			<table width="500" bordercolor="#000000" frame="box" rules="all">
			<tr bgcolor="#CD853F">
				<th width="200"><font color="#FFFFFF">วัตถุดิบ</font></th>
				<th width="100"><font color="#FFFFFF">ราคาครั้งสุดท้าย<br>ของปีที่แล้ว</font></th>
				<th width="75"><font color="#FFFFFF">Lart Period</font></th>
				<th width="75"><font color="#FFFFFF">This Period</font></th>
				<th width="50"><font color="#FFFFFF">%</font></th>
			</tr>
			<tr>
				<td>แป้งมัน</td>
				<td align="right">50</td>
				<td align="right">45</td>
				<td align="right">52</td>
				<td align="right">1.24%</td>
			</tr>
			<tr>
				<td>วุ้นเส้น</td>
				<td align="right">50</td>
				<td align="right">43</td>
				<td align="right">51</td>
				<td align="right">1.06%</td>
			</tr>
			<tr>
				<td>แป้งมันฮ่องกง</td>
				<td align="right">150</td>
				<td align="right">137</td>
				<td align="right">151</td>
				<td align="right">2.53%</td>
			</tr>
			<tr>
				<td>ตะก้วง</td>
				<td align="right">50</td>
				<td align="right">42</td>
				<td align="right">56</td>
				<td align="right">5.42%</td>
			</tr>
			<tr>
				<td>แป้งโกกิ</td>
				<td align="right">70</td>
				<td align="right">53</td>
				<td align="right">78</td>
				<td align="right">6.53%</td>
			</tr>
			<tr>
				<td>แป้งข้าวโพด</td>
				<td align="right">50</td>
				<td align="right">46</td>
				<td align="right">54</td>
				<td align="right">3.21%</td>
			</tr>
			<tr>
				<td>เส้นใหญ่</td>
				<td align="right">50</td>
				<td align="right">45</td>
				<td align="right">57</td>
				<td align="right">4.36%</td>
			</tr>
			<tr>
				<td>ขนมจีน</td>
				<td align="right">63</td>
				<td align="right">56</td>
				<td align="right">65</td>
				<td align="right">0.56%</td>
			</tr>
			<tr>
				<td>ข้าวขาย</td>
				<td align="right">40</td>
				<td align="right">33</td>
				<td align="right">45</td>
				<td align="right">3.25%</td>
			</tr>
			<tr>
				<td>เส้นเล็ก</td>
				<td align="right">74</td>
				<td align="right">68</td>
				<td align="right">79</td>
				<td align="right">3.25%</td>
			</tr>
			<tr>
				<td>ฮอนตาชิ</td>
				<td align="right">36</td>
				<td align="right">31</td>
				<td align="right">40</td>
				<td align="right">5.35%</td>
			</tr>
			<!--<tr>
				<td>มักโรนี ตัวงอ 450 กรัม</td>
				<td align="right">50</td>
				<td align="right"></td>
				<td align="right"></td>
				<td align="right">%</td>
			</tr>-->
			</table>
		</td>

		<td><div id="g6"></div></td>
	</tr>
	</table>
	
	<table id="tabs-r4_2" width=1090>
	<tr><td>เทียบกับ :
			<select>
				<option value="1">เดือนที่แล้ว (MTD)</option>
				<option value="2">เดือนเดียวกันปีที่แล้ว (MTD)</option>
				<option value="3">ไตรมาสที่แล้ว</option>
				<option value="4">ไตรมาสเดียวกันปีที่แล้ว (QTD)</option>
				<option value="5">ปีที่แล้ว (YTD)</option>
			</select>
			<input type="button" name="ok" value=" OK "/>
	</td></tr>

	<tr>
		<td align="center" width=1000>
			<table width=500 bordercolor="#000000" frame="box" rules="all">
			<tr bgcolor="#CD853F">
				<th><font color="#FFFFFF">วัตถุดิบ</font></th>
				<th width=90><font color="#FFFFFF">Lart Period</font></th>
				<th width=90><font color="#FFFFFF">This Period</font></th>
				<th width=90><font color="#FFFFFF">%</font></th>
			</tr>
			<tr>
				<td>แป้งมัน</td>
				<td align="right">45</td>
				<td align="right">52</td>
				<td align="right">1.24%</td>
			</tr>
			<tr>
				<td>วุ้นเส้น</td>
				<td align="right">43</td>
				<td align="right">51</td>
				<td align="right">1.06%</td>
			</tr>
			<tr>
				<td>แป้งมันฮ่องกง</td>
				<td align="right">137</td>
				<td align="right">151</td>
				<td align="right">2.53%</td>
			</tr>
			<tr>
				<td>ตะก้วง</td>
				<td align="right">42</td>
				<td align="right">56</td>
				<td align="right">5.42%</td>
			</tr>
			<tr>
				<td>แป้งโกกิ</td>
				<td align="right">53</td>
				<td align="right">78</td>
				<td align="right">6.53%</td>
			</tr>
			<tr>
				<td>แป้งข้าวโพด</td>
				<td align="right">46</td>
				<td align="right">54</td>
				<td align="right">3.21%</td>
			</tr>
			<tr>
				<td>เส้นใหญ่</td>
				<td align="right">45</td>
				<td align="right">57</td>
				<td align="right">4.36%</td>
			</tr>
			<tr>
				<td>ขนมจีน</td>
				<td align="right">56</td>
				<td align="right">65</td>
				<td align="right">0.56%</td>
			</tr>
			<tr>
				<td>ข้าวขาย</td>
				<td align="right">33</td>
				<td align="right">45</td>
				<td align="right">3.25%</td>
			</tr>
			<tr>
				<td>เส้นเล็ก</td>
				<td align="right">68</td>
				<td align="right">79</td>
				<td align="right">3.25%</td>
			</tr>
			<tr>
				<td>ฮอนตาชิ</td>
				<td align="right">31</td>
				<td align="right">40</td>
				<td align="right">5.35%</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	
	</td></tr>
</table>

<!-- 5555555555555555555555555555555555555555555555555555 -->
<table>
	<tr>
		<td>
		<table id="tabs-r5c1" width=545>
			<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">% On time</font></th></tr>
			<tr><td id="g7"></td></tr>
		</table>
		</td>

		<td>
		<table id="tabs-r5c2" width=545>
			<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">% Infull</font></th></tr>
			<tr><td id="g8"></td></tr>
		</table>
		</td>
	</tr>
</table>

</div>
</body>
</html>