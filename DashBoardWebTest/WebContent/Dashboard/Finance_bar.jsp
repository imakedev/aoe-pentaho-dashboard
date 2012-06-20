<html>
<%@ page contentType="text/html; charset=UTF-8" %>
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

	<script type="text/javascript"> 
	var _path='<%=request.getContextPath()%>';

//---------------------------------------------
   var sumByPop='<%=request.getParameter("sb")%>';
    var tabPop='<%=request.getParameter("tab")%>';
    var year='<%=request.getParameter("y")%>';
    var m='<%=request.getParameter("m")%>'; 
    var topic='<%=request.getParameter("topic")%>'; 
    function addCommas(nStr)
    {
    	nStr += '';
    	x = nStr.split('.');
    	x1 = x[0];
    	x2 = x.length > 1 ? '.' + x[1] : '';
    	var rgx = /(\d+)(\d{3})/;
    	while (rgx.test(x1)) {
    		x1 = x1.replace(rgx, '$1' + ',' + '$2');
    	}
    	return x1 + x2;
    }
    function renderBarOfChart(tabType){
		   // alert(tabType)  
		   $("#back_bt").css("display","none");
		   $("#sales_growth").html("%Sales Growth");
		   $("#g4").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
		   BalanceScorecardAjax.getBarOfPile( $("#financeYear").val(),  $("#financeMonth").val(), tabType, $("#SumBy").val(),{
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
						var val0={ 
									"values" :  [lastPeriodActual,,],
									"text" : "Last Period Actual",
									"background-color":"#66CC00"
								};
						var val1={ 
									"values" : [,actual,],
									"text" : "Actual",
									"background-color":"#EEEE00"
								};
						var val2={ 
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
						$("#g4").html("");  
						zingchart.render({
							id : 'g4',
							width : 600,
							height : 300,
							data : bar03
						});
						 zingchart.exec('g4', 'setdata', series);
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
					$("#back_bt").css("display",display_bt);
					$("#sales_growth").html("%Sales Growth"+label_sales);
			}
		   }); 
	} 	
	$(document).ready(function() {
		renderBarOfChart();
	});
   
	</script>

	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
	</style>

<body>

<table width="1000" height="300" border="1" align="center" style="text-decoration:none;"> 
     <tr>
         <td colspan="2" align="center">
         <div id="g4">
        
         </div>
             
         </td>
     </tr> 
</table> 
</body>
</html>