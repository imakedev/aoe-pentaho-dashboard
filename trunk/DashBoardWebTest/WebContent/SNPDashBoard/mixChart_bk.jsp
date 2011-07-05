<!--
*********************************************************
*	EditDate	: April 2011							*
*	Project		: S&P BI Dashboard						*
*	Version		: Prototype Ver.001						*
*	Programmer	: Kriengkrai							*
*********************************************************
-->
<html>
  <head>
    <title>SNP DashBoard</title>    
  </head>
<body>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

<%
String strvalue = new String("'" + "Sale growth(%) : Overall" + "'") ;
if (request.getParameter("head") == null) 
{	
		out.println("Please enter the fields.");
} 
else 
{
		strvalue = "'" + request.getParameter("head") + "'" ;
}
%>


<script type="text/javascript">		
var texthead = 'Sale Amount' ;
	//texthead = 'Sale growth(%) : Overall' ;
	texthead = <% out.println(strvalue); %> ;
var chart01 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF #CCCCCC",
			"stacked":"1",
			"chart":{
				"margin":"70 10 75 35"
			},
			"title" : {
				"text" : texthead ,
				"background-color":"#3399FF #3366FF",
				"font-color":"#FFFFFF",
				"font-size": 14,
  				"font-family": "Verdana",
				
				"bevel": true,
				"bevel-distance": 4,
				"bevel-angle": 50,
				"bevel-blur-x": 5,
				"bevel-blur-y": 5,
				"bevel-color": "navy"

			},
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
					"x": 5,
					"y": 315,
				"layout":"1x",
						"width": 440,
				"item":{
					"font-color":"#000000",
					"font-size": 14,
  				"font-family": "Verdana"
				}
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 0
				},
				"item":{
					"font-color":"#42426F",
					"font-size": 14,
  					"font-family": "Verdana",
				}
			},
			"scale-y":{
				"values":"0:100:20",
				"labels":["0","20","40","60","80","100"],
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
				"item":{
					"font-color":"#42426F",
					"font-size": 14,
  					"font-family": "Verdana",
				}
			},
			"labels" : [
							{
								"text" : " 10",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 35,
								"y" : 40,
								"background-color":"#FFCC00", 
								"border-width":1, 
								"border-radius":15,
								"font-size": 16
							},
							{
								"text" : " 15",
								"hook" : "offset-x=-10,offset-y=-10",
								"x" : 70,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-width":1, 
								"border-radius":15,
								"font-size": 16
								
							},
							{
								"text" : "27",
								"hook" : "offset-x=-10,offset-y=-10",
								"x" : 105,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
								
							},
							{
								"text" : "38",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 140,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
								
							},
							{
								"text" : "42",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 175,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
							},
							{
								"text" : "52",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 210,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
							},
							{
								"text" : "59",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 245,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
							},
							{
								"text" : "65",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 275,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
							},
							{
								"text" : "70",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 310,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
							},
							{
								"text" : "79",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 345,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
							},
							{
								"text" : "87",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 380,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
							},
							{
								"text" : "98",
								"hook" : "offset-x=10,offset-y=10",
								"x" : 410,
								"y" : 40,
								"background-color":"#FFCC00",
								"border-radius":15,
								"border-width":1, 
								"font-size": 16
							}
							
			],


			"series":[
				{
					"type":"line",
					"values":[30,39,48,49,52,50,51,54,54,55,56,58],
					"text":"Actual 10",
					"scales":"scale-x,scale-y",
					"stacked":0,
					"line-color": "#00FF00",
					"marker":{
						"type": "cross",
						"size":3
					},
					"tooltip-text":"%v%"
				},
				{
					"type":"bar",
					"values":[40,35,67,47,58,43,65,43,58,79,70,75],
					"text":"Actual 11",
					"background-color":"#000099 #0000FF",
					"stacked":0
				},
				{
					"type":"line",
					"values":[50,52,56,57,57,58,58,60,62,62,64,65],
					"text":"Target",
					"scales":"scale-x,scale-y",
					"line-color": "#696969",
					"stacked":0,
					"marker":{
						"type": "cross",
						"size":3,
						"background-color": "red",
						"border-color": "#4F81BD"
				},
				"tooltip-text":"%v%"
				},
				{
					"type":"line",
					"values":[109,109,109,109,109,109,109,109,109,109,109,109],
					"text":"Accum 11",
					"scales":"scale-x,scale-y",
					"stacked":"5",
					"line-color": "#FFCC00",
					"border-width":0 
				}]
		}]
		};

</script>

<script type="text/javascript">
   
window.onload = function(){
	zingchart.render({
		id 				: 'showchart',
		data 		    : chart01,
		width	 		: 450,
		height 			: 350
		
	});

}



</script>


<script type="text/javascript">
function say(){
//alert('I am Zingchart. Who Click me');
//document.write(77);
}

</script>



<div id="showchart" >
</div>

</body>
</html>