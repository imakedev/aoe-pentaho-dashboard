<html>
<%@ page contentType="text/html; charset=UTF-8" %>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet" />	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

<%
	String m = request.getParameter("m");
%>

	<script type="text/javascript">
		var data = 
		{
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"0 0 65 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x3",
			"width": 310,
			"x":0,
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
				"text" : "สิ่งแปลกปลอม",
				"values" : [10],
				"tooltip-text" : "%t: 1,000"
			},
			{
				"text" : "จุลินทรีย์",
				"values" : [30],
				"tooltip-text" : "%t: 3,000"
			},
			{
				"text" : "กายภาพ",
				"values" : [20],
				"tooltip-text" : "%t: 2,000"			
			},
			{
				"text" : "สุขภาพ",
				"values" : [10],
				"tooltip-text" : "%t: 1,000"			
			},
			{
				"text" : "อื่น ๆ",
				"values" : [5],
				"tooltip-text" : "%t: 500"			
			},
			{
				"text" : "สัตวพาหะ",
				"values" : [15],
				"tooltip-text" : "%t: 1,500"			
			}]
	}]
};

//---------------------------------------------
	$(document).ready(function() {
			zingchart.render({
				id : 'g1',
				width : 310,
				height : 300,
				data : data
			});
		});

	</script>

	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
	</style>

<body>
<div align="center"><font size="3"><b><%out.print(m);%></b></font></div><br>
<table width="700" height="300" border="1" align="center" style="text-decoration:none;">
	<tr><td align="center" id="g1"></td></tr>
</table>

</body>
</html>