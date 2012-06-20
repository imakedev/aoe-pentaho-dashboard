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
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet"/>	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<!-------------------------  About Popup (#facebox) ------------------------->
	<!-- ---------------   Lib for Facebox       ----------------------- -->
    <link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.facebox.css" media="screen" rel="stylesheet"/> 
    <script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/facebox.js"></script>
	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.onLoad.css" media="screen" rel="stylesheet"/> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.onLoad.js"></script>
	 <!-- 
	DWR
	-->
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrfinancedashboard/util.js"></script>
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
var sumBy = '<%=request.getParameter("sumBy")%>';
var bscYear = '<%=request.getParameter("bscYear")%>';
var bscMonth = '<%=request.getParameter("bscMonth")%>';
var tabType = '<%=request.getParameter("tabType")%>'; 
var _path='<%=request.getContextPath()%>';
window.onload = function(){ 
//	 alert("tabType="+tabType)  
	 /*   $("#back_bt").css("display","none");
	   $("#sales_growth").html("%Sales Growth"); */
	   $("#g4_barchart").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
	   BalanceScorecardAjax.getBarOfPile( bscYear,bscMonth, tabType,sumBy,{
			callback:function(data){
			
				if(data!=null && data.length>0){
					var bar03 = 
					{
					"graphset" : [
						{
							"type" : "bar",
							"background-color":"#FFFFFF",
							"chart" : {
								"margin" : "20 130 50 150"
							},
							"stacked" : true,
							"plot":{
								"bars-space-left":"30%",
								"bars-space-right":"30%",
								"bar-width":"25px",
								"decimals":2,
		    					"decimals-separator":".",
		    					"thousands-separator":","
							},
							"scale-x" : {
								"values" : ["Last Period Actual","Actual","Budget"],
								"guide":{
				    				"line-width": 1,
				    				"alpha": 1
				    			},
								"tick":{
									"line-width": 3
								}
							},
							"scale-y" : {
								"format" : "%v%",
								"decimals":0,
								"guide":{
				    				"line-width": 1,
				    				"alpha": 1
				    			},
								"tick":{
									"line-width": 3
								}
							},
							"series" : []
						}
					]
				}; 
					
					var  lastPeriodActual=0;
					var thisActual=parseFloat(data[0].thisActual.replace(/,/g,""));
					var lastActual=parseFloat(data[0].lastActual.replace(/,/g,""));
					var twoLastActual=parseFloat(data[0].twoLastActual.replace(/,/g,""));
					var thisBudget=parseFloat(data[0].thisBudget.replace(/,/g,""));
					var lastBudget=parseFloat(data[0].lastBudget.replace(/,/g,""));
					//alert(lastActual)
					if(twoLastActual!=null && twoLastActual!=0)
						lastPeriodActual=((lastActual-twoLastActual)/twoLastActual)*100;
					var  actual=0;
					if(lastActual!=null && lastActual!=0)
						actual=((thisActual-lastActual)/lastActual)*100;
					var  budget=0;
					if(lastBudget!=null && lastBudget!=0)
						budget=((thisBudget-lastBudget)/lastBudget)*100; 
					/* if(data[0].twoLastActual!=null && data[0].twoLastActual.length>0)
						lastPeriodActual=((Number(data[0].lastActual).toFixed(2)-Number(data[0].twoLastActual).toFixed(2))/Number(data[0].twoLastActual).toFixed(2))*100;
					var  actual=0;
					if(data[0].lastActual!=null && data[0].lastActual.length>0)
						actual=((Number(data[0].thisActual).toFixed(2)-Number(data[0].lastActual).toFixed(2))/Number(data[0].lastActual).toFixed(2))*100;
					var  budget=0;
					if(data[0].lastBudget!=null && data[0].lastBudget.length>0)
						budget=((Number(data[0].thisBudget).toFixed(2)-Number(data[0].lastBudget).toFixed(2))/Number(data[0].lastBudget).toFixed(2))*100; */ 
					 	//alert("xx"+actual)  
					 	//{"type":"bar","values":[32.88,29.85,32.88],"background-color":"goldenrod","text":"ต้นทุนขาย"}
					var val0={ 
							"type":"bar",
								"values" :  [lastPeriodActual,,],
								"text" : "Last Period Actual",
								"background-color":"#66CC00"
							};
					var val1={ 
							"type":"bar",
								"values" : [,actual,],
								"text" : "Actual",
								"background-color":"#EEEE00"
							};
					var val2={ 
							"type":"bar",
								"values" : [,,budget],
								"text" : "Budget",
								"background-color":"#696969"
							};
					var series=[val0,val1,val2];
					/* bar03.graphset[0].series[0].values= [lastPeriodActual,,]; 
					bar03.graphset[0].series[1].values= [,actual,];
					bar03.graphset[0].series[2].values= [,,budget]; 
					 */
					bar03.graphset[0].series=series;
					$("#g4_barchart").html("");  
					 zingchart.render({
						id : 'g4_barchart',
						width : 600,
						height : 300,
						data : bar03
					}); 
					// zingchart.exec('g4', 'setdata', series);
				}else{
					//alert("null value")
					/* bar03.graphset[0].series[0].values= [,,]; 
					bar03.graphset[0].series[1].values= [,,];
					bar03.graphset[0].series[2].values= [,,];  */
				}
				
				var label_sales="";
				var display_bt="none";
				if(tabType!=null){  
					display_bt="";
					label_sales=" : "+tabType;
				}else{ 
				}
			/* 	$("#back_bt").css("display",display_bt);
				$("#sales_growth").html("%Sales Growth"+label_sales); */
		}
	   }); 
	

}



</script>


 
<div id="g4_barchart" style="width: 600px" align="center"></div> 
</body>
</html>