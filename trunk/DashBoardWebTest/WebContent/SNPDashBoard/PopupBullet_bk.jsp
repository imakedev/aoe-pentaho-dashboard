<html>
<%@ page contentType="text/html; charset=UTF-8" %>

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

<%
	String strvalue = new String("0") ;
	if (request.getParameter("gvalue") == null) 
	{	
		out.println("Please enter the fields.");
	} 
	else 
	{	
		strvalue = request.getParameter("gvalue") ;
	}

	int own = Integer.parseInt(request.getParameter("own"));
	String nameOwn = "";

	switch(own){
		case 1 : nameOwn = "Corporate";
			break;
		case 2 : nameOwn = "Financial";
			break;
		case 3 : nameOwn = "Factory";
			break;
		case 4 : nameOwn = "Operation";
			break;
		case 5 : nameOwn = "Trade Sale";
			break;
	}
%>

<script type="text/javascript">
		var barGroup = {
   "graphset":[
      {
         "type":"gauge",
         "border-width":0,
         "plotarea":{
            "margin":"20 0 0 0"
         },
         "background-color":"#CCCCCC #CCCCCC;",
         "fill-type":"radial",
         "scale":{
			"values": [
				"Ratio : Percent(%)"
				],
            "item":{
               "font-color":"white",
               "font-family":"helvetica",
               "text-align":"center",
               "font-size":11,
               "bold":true,
               "background-color":"000000",
			   "padding": "2",
               "offset-y":-20,
               "offset-x":0
            }
         },
		 "scale-r":{
            "values":"0:100:10",
			"size": 150,
            "aperture":270, //270
			"offset-start": "15",
			"offset-end": "15",
            "max-items":20,
            "ref-angle":-90,
            "background-color":"#CCCCCC #666666",
			"fill-type": "radial",
            "border-color":"#CCCC99",
            "border-width":"4",
            "item":{
               "padding":"1 1",
               "font-color":"black",
               "font-size":12,
               "font-family":"helvetica",
               "text-align":"center",
               "bold":true,
			   "rules": [
					{
					"rule": "%i >= 11",
					"visible": false
					}
			   ]
            },
            "tick":{
               "visible": false,
			   "placement": "inner",
               "line-color":"orange",
               "line-width":2
            },
			"center" : {
	            	"size" : 10,
	            	"background-color" : "#bbbbbb #000000",
	            	"border-color" : "#cccccc",
	            	"border-width" : "1",
	            	"fill-type" : "radial",
	            	"fill-offset-x" : -5,
	            	"fill-offset-y" : -5
	            },
            "ring":{
               "size":17,
               "alpha":-1,
               "border-width":2,
               "border-color":"black",
			   "rules": [
					{
					"rule": "%v <=30",
					"background-color": "red"
					},
					{
					"rule": "%v >= 30 && %v <= 70",
					"background-color": "yellow"
					},
					{
					"rule": "%v >= 70 && %v <= 100",
					"background-color": "green"
					},
					{
					"rule": "%v >= 1000",
					"background-color": "0",
					"border-color": "0"
					}
			   ]
            }
         },
         "plot":{
            "csize":"10",
			"tooltip-text": "%t: %v",
			"border-color": "#f00",
			"border-width": 1
         },
         "tooltip":{
			"border-radius": 10,
			"border-color": "black",
			"border-width": "2",
			"font-color": "black",
			"font-weight": "bold",
			"padding": "10",
			"rules": [
					{
					"rule": "%v <=100",
					"background-color": "lightgreen"
					},
					{
					"rule": "%v >= 0 && %v <= 30",
					"background-color": "red"
					},
					{
					"rule": "%v >= 30 && %v <= 70",
					"background-color": "yellow"
					},
					{
					"rule": "%v >= 70 && %v <= 100",
					"background-color": "green"
					}
					,
					{
					"rule": "%v >= 400",
					"background-color": "-1",
					"background-color": "orange",
					"border-color": "-1"
					}
			   ]
         },
         "series":[
            {
               "values":[<% out.print(strvalue); %>],
			   "size": "120",
               "text":"Value",
			   "background-color": "blue",
				//"alpha": 1,
				//"data-rpm": ["%"]
				}
         ]
      }
   ]
};

//---------------------------------------------
	$(document).ready(function() {
		 
			zingchart.render({
				id : 'gGroup',
				width : 450,
				height : 350,
				data : barGroup
			});
		});
	  
		
</script>

<body>
<div align="center"><font size="3"><b>Overall : <%out.print(nameOwn);%></b></font></div><br>
<table width="700" height="300" border="1" align="center" style="text-decoration:none;">
	<tr><td align="center" id="gGroup"></td></tr>
</table>

</body>
</html>