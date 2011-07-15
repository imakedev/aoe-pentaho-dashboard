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
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/> 
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/zingchart-html5beta-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/license.js"></script>
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrbalancescorecard/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrbalancescorecard/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrbalancescorecard/util.js"></script>
  </head>
<body>
<%
String strvalue = new String("'" + "Sale growth(%) : Overall" + "'") ;
if (request.getParameter("head") == null) 
	
{	
		//out.println("Please enter the fields.");
} 
else 
{
		strvalue = "'" + request.getParameter("head") + "'" ;
}
%>


<script type="text/javascript">		
var texthead = 'Sale Amount' ;
	//texthead = 'Sale growth(%) : Overall' ;
	//texthead = '' ;
	//alert(texthead)
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
				//"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
				"values":["Jan","Feb","Mar"],
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
								
							}
							/*
							,
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
							*/
							
			],


			"series":[
				{
					"type":"line",
					//"values":[30,39,48,49,52,50,51,54,54,0,0,0],
					"values":[30,39,48],
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
				//	"values":[40,35,67,47,58,43,65,43,58,0,0,0],
					"values":[40,35,67],
					"text":"Actual 11",
					"background-color":"#000099 #0000FF",
					"stacked":0
				},
				{
					"type":"line",
				//	"values":[50,52,56,57,57,58,58,60,62,0,0,0],
					"values":[50,52,56],
					"text":"Target",
					"scales":"scale-x,scale-y",
					"line-color": "#696969",
					"stacked":0,
					"marker":{
						"type": "cross",
						"size":3,
						"background-color": "red",
						"border-color": "#4F81BD"
				} 
				,
				
				"tooltip-text":"%v%"
				},
				{
					"type":"line",
				//	"values":[109,109,109,109,109,109,109,109,109,0,0,0],
					"values":[10,15,27],
					"text":"Accum 11",
					"scales":"scale-x,scale-y",
					"stacked":"5",
					"line-color": "#FFCC00",
					"border-width":0 
				}
				
				]
			
		}]
		};

</script>

<script type="text/javascript">
var bscOwner = '<%=request.getParameter("bscOwner")%>';
var bscYear = '<%=request.getParameter("bscYear")%>';
var bscMonth = '<%=request.getParameter("bscMonth")%>';
var perspectiveKey = '<%=request.getParameter("perspectiveKey")%>';
var kpiKey = '<%=request.getParameter("kpiKey")%>';
var dateKey = '<%=request.getParameter("dateKey")%>';
var accumulatedFlag = '<%=request.getParameter("accumulatedFlag")%>';
  
window.onload = function(){ 
	 BalanceScorecardAjax.getKPIChart(bscYear,bscMonth,kpiKey,accumulatedFlag,{
			callback:function(data_KPIChart){
				if(data_KPIChart!=null && data_KPIChart.length>0){
					var size=data_KPIChart.length;
					var accums=[];
					var months=[];
					var actualLastyear_line_series=[];
					var actual_bar_series=[];
					var target_line_series=[];
					var tooltips=[];
					var kpiName="";
					//var year=parse
				//	"text":"Actual 10", series
					for(var i = 0;i<size;i++){
						var accumActualValue = data_KPIChart[i].accumActualValue!=null?data_KPIChart[i].accumActualValue:"";
						kpiName =data_KPIChart[i].kpiName;
						var monthNo =data_KPIChart[i].monthNo;
						var monthName =data_KPIChart[i].monthName;
						var lastYearActual =data_KPIChart[i].lastYearActual!=null?data_KPIChart[i].lastYearActual:"";						
						var actualValue =data_KPIChart[i].actualValue;
						var targetValue =data_KPIChart[i].targetValue;
					 	var accum = {
								"text" : accumActualValue,
								"hook" : "offset-x=10,offset-y=10",
								"x" : (i+1)*35,
								"y" : 40,
								"background-color":"#FFCC00", 
								"border-width":1, 
								"border-radius":15,
								"font-size": 16
								};
						accums.push(accum);
						months.push(monthName);
						actualLastyear_line_series.push(lastYearActual);
						actual_bar_series.push(actualValue);
						target_line_series.push(targetValue);
						tooltips.push(109);
					}
					var chartElement={"margin":"70 10 75 35"};
					var titleElement={
							"text" : kpiName ,
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
							};
					var legendElement={
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
							};
					var scale_xElement={ 
							"values":months,//["Jan","Feb","Mar"],
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
		  						"font-family": "Verdana"
								}
							};
					var scale_yElement={
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
							};
					
					var actualLastyear_line_Element={
								"type":"line",
								//"values":[30,39,48,49,52,50,51,54,54,0,0,0],
								"values":actualLastyear_line_series,//[30,39,48],
								"text":"Actual 10",
								"scales":"scale-x,scale-y",
								"stacked":0,
								"line-color": "#00FF00",
								"marker":{
									"type": "cross",
									"size":3
									},
								"tooltip-text":"%v%"
							};
					var actual_bar_Element={
							"type":"bar",
						//	"values":[40,35,67,47,58,43,65,43,58,0,0,0],
							"values":actual_bar_series,//[40,35,67],
							"text":"Actual 11",
							"background-color":"#000099 #0000FF",
							"stacked":0
							};
					var target_line_Element={
							"type":"line",
						//	"values":[50,52,56,57,57,58,58,60,62,0,0,0],
							"values":target_line_series,//[50,52,56],
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
							};
					var tooltipsElement={
							"type":"line",
						//	"values":[109,109,109,109,109,109,109,109,109,0,0,0],
							"values":tooltips,//[109,109,109],
							"text":"Accum 11",
							"scales":"scale-x,scale-y",
							"stacked":"5",
							"line-color": "#FFCC00",
							"border-width":0 
							};
					var labelsElement= accums;  
					var chartMixNoAccum =
						{
							"graphset":[
									{
									"type":"mixed",
									"background-color":"#FFFFFF #CCCCCC",
									"stacked":"1",
									"chart":chartElement,
									"title" :titleElement,
									"legend":legendElement,
									"scale-x":scale_xElement,
									"scale-y":scale_yElement,
								//	"labels" : accums,  
									"series":[
											actualLastyear_line_Element,
											actual_bar_Element,
											target_line_Element 
										]
								}]
							};
					var chartMix = 
					{
					"graphset":[
							{
							"type":"mixed",
							"background-color":"#FFFFFF #CCCCCC",
							"stacked":"1",
							"chart":chartElement,
							"title" :titleElement,
							"legend":legendElement,
							"scale-x":scale_xElement,
							"scale-y":scale_yElement,
							"labels" : accums,  
							"series":[
									actualLastyear_line_Element,
									actual_bar_Element,
									target_line_Element,
									tooltipsElement
								] 
							}]
						};
				}
				
				//alert(data_KPIChart);
				zingchart.render({
					id 				: 'showchart',
					data 		    : accumulatedFlag=='Y'?chartMix:chartMixNoAccum,
					width	 		: 450,
					height 			: 350
					
				});
			}
		});
	

}



</script>


<script type="text/javascript">
//function say(){
//alert('I am Zingchart. Who Click me');
//document.write(77);
//}

</script>



<div id="showchart" >
</div>

</body>
</html>