<html>
<%@ page contentType="text/html; charset=UTF-8" %>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet"/>	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<script type="text/javascript">
		var data = 
		{
			"graphset" : [
				{
					"type" : "mixed",
					"background-color":"#FFFFFF",
					"chart" : {
						"margin" : "10 50 120 50"
					},
					"stacked":"1",
					"plot":{
						"bars-space-left":"30%",
						"bars-space-right":"30%",
						"bar-width":"30px"
					},
					"legend" : {
						"background-color": "#FFFFFF",
						"border-width": "2px",
						"border-color": "#4C77B6",
						"layout" : "x2",
						"width" : 370,
						"x" : 0,
						"y": 240
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
					{
						"type":"bar",
						"values":[74.27,63.74,74.27],
						"text":"ต้นทุนขายเบเกอรี่"
					},
					{
						"type":"bar",
						"values":[32.88,63.74,74.27],
						"text":"ต้นทุนเครื่องดื่มขนมหวานไอศครีม"
					},
					{
						"type":"bar",
						"values":[32.88,63.74,74.27],
						"text":"ต้นทุนอาหาร"
					},
					{
						"type":"bar",
						"values":[32.88,63.74,74.27],
						"text":"ต้นทุนผลิตภัณฑ์ลาดกระบัง"
					},
					{
						"type":"bar",
						"values":[32.88,63.74,74.27],
						"text":"ต้นทุนผลิตภัณฑ์อื่น ๆ"
					},
					{
						"type":"bar",
						"values":[32.88,29.85,32.88],
						"text":"ต้นทุนสินค้าจุดขาย"
					}]
				}
			]
		};

//---------------------------------------------
	$(document).ready(function() {
			zingchart.render({
				id : 'g1',
				width : 370,
				height : 330,
				data : data
			});
		});

	</script>

	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
	</style>

<body>

<table width="700" height="300" border="1" align="center" style="text-decoration:none;">

<tr><th align="center"><font size="3">%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</font></th></tr>
<tr><td align="center" id="g1"></td></tr>

</table>

</body>
</html>