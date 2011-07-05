<html>
<%@ page contentType="text/html; charset=UTF-8" %>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet"/>	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<script type="text/javascript">
		var barGroup = {
			"graphset" : [
			{
				"type" : "bar",
				"stacked": true,
				"background-color":"#FFFFFF",
				"chart":{
					"margin":"30 20 120 80"
				},
				"legend" : {
					"background-color": "#FFFFFF",
					"border-width": "2px",
					"border-color": "#4C77B6",
					"layout": "x3",
					"x": 40,
					"y": 265,
					"width": 310
				},
				"labels" : [
					{
						"text" : "3,895,235",
						"x" : 85,
						"y" : 0,
						"background-color":"blue",
						"color": "white",
						"border-width":1, 
						"border-color":"blue",
						"bold": true
					},
					{
						"text" : "3,539,582",
						"x" : 170,
						"y" : 0,
						"background-color":"blue",
						"color": "white",
						"border-width":1, 
						"border-color":"blue",
						"bold": true
					},
					{
						"text" : "4,035,962",
						"x" :255,
						"y" : 0,
						"background-color":"blue",
						"color": "white",
						"border-width":1, 
						"border-color":"blue",
						"bold": true
					},
					{
						"text" : "พันบาท",
						"bold":true,
						"x": "15",
						"y": "0"
					}
				],
				"plot":{
					"tooltip-text":"%t:%v",
					"thousands-separator":",",
					"bars-space-left":"30%",
					"bars-space-right":"30%"
				},
				"scale-x":{
					"values":["Bakery","Food","Drink"],
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
					"min-value":0,
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
				"series" : [
				// Bakery
					{
						"values" : [1806489,,],
						"background-color":"#6600FF",
						//"background-color-2":"#adadad",
						"text" : "Cake"
					},
					{
						"values" : [539582,,],
						"background-color":"#6666FF",
						//"background-color-2":"#848484",
						"text" : "Sandwich"
					},
					{
						"values" : [639582,,],
						"background-color":"#6699FF",
						//"background-color-2":"#848484",
						"text" : "Cookies"
					},
					{
						"values" : [909582,,],
						"background-color":"#66CCFF",
						//"background-color-2":"#848484",
						"text" : "Bread"
					},
				// Food
					{
						"values" : [,1659582,],
						"background-color":"#9400D3",
						//"background-color-2":"#848484",
						"text" : "Japaness Food"
					},
					{
						"values" : [,945235,],
						"background-color":"#BA55D3",
						//"background-color-2":"#adadad",
						"text" : "Thai Food"
					},
					{
						"values" : [,934765,],
						"background-color":"#EE82EE",
						//"background-color-2":"#848484",
						"text" : "Food"
					},
				// Drink
					{
						"values" : [,,1211112],
						"background-color":"#FF6600",
						//"background-color-2":"#adadad",
						"text" : "BuleCup"
					},
					{
						"values" : [,,2824850],
						"background-color":"#FF9900",
						//"background-color-2":"#848484",
						"text" : "Beer"
					}
				]
			}
		]
	};

/* TEST
{
  "graphset" : [
  {
    "type" : "bar",
    "stacked": true,
    "series" : [
    {
        "values" : [3,6,9,6,1]
    },
    {
        "values" : [11,18,19,15,17]
    },
    {
        "values" : [23,21,20,25,24]
    }] 
  }]
};
*/

//---------------------------------------------
	$(document).ready(function() {
			zingchart.render({
				id : 'gGroup',
				width : 350,
				height : 350,
				data : barGroup
			});
		});

	</script>

	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
	</style>

<body>

<table width="700" height="300" border="1" align="center" style="text-decoration:none;">

<tr><th align="center" colspan="2"><font size="3"><%out.print(request.getParameter("topic"));%></font></th></tr>

<td><table width="100%">
	<tr><th align="center"><font size="2">By Product Group</font></tr>
	<tr><td align="center" id="gGroup"></td></tr>
</table></td></tr>

</table>

</body>
</html>