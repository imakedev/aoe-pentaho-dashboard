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
		

//---------------------------------------------
   var sumByPop='<%=request.getParameter("sb")%>';
    var tabPop='<%=request.getParameter("tab")%>';
    var year='<%=request.getParameter("y")%>';
    var m='<%=request.getParameter("m")%>';  
	$(document).ready(function() {
		$("#display_group_percent").html("<img src=\""+_path+"/Dashboard/images/loading.gif\"/>");
	//	alert(tabPop)
		BalanceScorecardAjax.getPopup3(year,m,tabPop,sumByPop,{
			callback:function(data_ajax){
				//alert(data_ajax)
				if(data_ajax!=null &data_ajax.length>0){
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
									"layout" : "x4",
									/* "width" : 370,
									"x" : 0,
									"y": 240 */
									 "x": 50,
									 "y": 240,
										"width": 900
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
									"decimals":0,
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
								"series" : [{"type": "bar", "values": "[-16.38,-8.20,0]","text":"ต้นทุนผลิตภัณฑ์ลาดกระบัง"},{"type": "bar", "values": "[-0.65,-0.83,0]","text":"ต้นทุนผลิตภัณฑ์อื่น ๆ"},{"type": "bar", "values": "[-0.05,-0.05,0]","text":"ต้นทุนอาหาร"},{"type": "bar", "values": "[-9.06,-8.98,0]","text":"ต้นทุนเครื่องดื่มขนมหวานไอศครีม"},{"type": "bar", "values": "[-9.97,-8.80,0]","text":"ต้นทุนเบเกอรี่"}]
							}
						]
					};
					var group_size=data_ajax.length;
					var valuesList=[];
					var str="";
					if(group_size>0){
						var group1=data_ajax[0];
						var group2=data_ajax[1]; 
						/* var v1=[-1.262673,-1.051224,0];
						var v2=[-0.330586,-0.261481,0];
						var v3=[-0.053274,-0.054603,0];
						var v4=[-1.332859,-1.361736,0];
						var v5=[-2.110140,-1.905174,0]; */
						/* var v1=[74.27,63.74,74.27];
						var v2=[32.88,63.74,74.27];
						var v3=[32.88,63.74,74.27];
						var v4=[32.88,63.74,74.27];
						var v5=[32.88,29.85,32.88];
						 
						var vv=[v1,v2,v3,v4,v5]; */
						
						/*  sup=ต้นทุนผลิตภัณฑ์ลาดกระบัง , getPercentLastPeriodActual=-1.262673, getPercentActual=-1.051224, getPercentBudget=
						     sup=ต้นทุนผลิตภัณฑ์อื่น ๆ , getPercentLastPeriodActual=-0.330586, getPercentActual=-0.261481, getPercentBudget=
						     sup=ต้นทุนอาหาร , getPercentLastPeriodActual=-0.053274, getPercentActual=-0.054603, getPercentBudget=
						     sup=ต้นทุนเครื่องดื่มขนมหวานไอศครีม , getPercentLastPeriodActual=-1.332859, getPercentActual=-1.361736, getPercentBudget=
						     sup=ต้นทุนเบเกอรี่ , getPercentLastPeriodActual=-2.110140, getPercentActual=-1.905174, getPercentBudget= */
						/* alert("group1 size="+group1.length)
						alert("group2 size="+group2.length) */
						var size_group1=group1.length;
						var size_group2=group2.length;
						var size_group=size_group1>size_group2?size_group1:size_group2; 
						//for(var i=0;i<group1.length;i++){ 						
						for(var i=0;i<size_group;i++){
						//	var color=(Math.floor(Math.random()*16777215).toString(16)); 
						//	alert(group2[i].percentLastPeriodActual+","+group1[i].percentActual+","+group1[i].percentBudget)
						var percentLastPeriodActual=0;
						var percentActual=0;
						var percentBudget=0;
						if(size_group2>i && (group2[i].percentLastPeriodActual!=null && group2[i].percentLastPeriodActual.length>0))
							percentLastPeriodActual=(Number(group2[i].percentLastPeriodActual).toFixed(2));
						if(size_group1>i && (group1[i].percentActual!=null && group1[i].percentActual.length>0))
							percentActual=(Number(group1[i].percentActual).toFixed(2));
						if(size_group1>i && (group1[i].percentBudget!=null && group1[i].percentBudget.length>0))
							percentBudget=(Number(group1[i].percentBudget).toFixed(2));
					// var group2_percentLastPeriodActual =size_group2>i?group2[i].percentLastPeriodActual:
							//var percentLastPeriodActual=(group2[i].percentLastPeriodActual!=null && group2[i].percentLastPeriodActual.length>0)?(Number(group2[i].percentLastPeriodActual).toFixed(2)):0;
							//var percentActual=(group1[i].percentActual!=null && group1[i].percentActual.length>0)?(Number(group1[i].percentActual).toFixed(2)):0;
							//var percentBudget=(group1[i].percentBudget!=null && group1[i].percentBudget.length>0)?(Number(group1[i].percentBudget).toFixed(2)):0;
							var group2_subCategory="";
							if(size_group2>i)
								group2_subCategory=group2[i].subCategory;
							var values={
									"type":"bar",
									//"values":[group2[i].percentLastPeriodActual,group1[i].percentActual,group1[i].percentBudget],
								 	"values":[percentLastPeriodActual,percentActual,percentBudget],
								//"values":vv[i],
									//"text":group2[i].subCategory
									"text":group2_subCategory
							//		"background-color":"#"+color, 
								};
							var list="["+percentLastPeriodActual+","+percentActual+","+percentBudget+"]";
							//var splitStr=(i==(group1.length-1))?"":",";
							var splitStr=(i==(size_group-1))?"":",";
							
							str=str+'{"type": "bar", "values": "'+list+'","text":"'+group2_subCategory+'"}'+splitStr;
							valuesList.push(values);
						} 
						 
						data.graphset[0].series=valuesList;
					} 
					 $("#display_group_percent").html(""+
				    			"<table width=\"100%\">"+
				                "<tr><th align=\"center\"><font size=\"2\"></font></th></tr>"+
				                "<tr><td align=\"center\" id=\"gGroup\"></td></tr>"+
				            "</table>");
				if(data_ajax!=null &data_ajax.length>0){
					zingchart.render({
						id : 'gGroup',
						 width : 1000,
							height : 330,
						data : data
					});
				}else{
					$("#display_group_percent").html(" No Data ");
				}
				//	var data = '[{"type": "bar", "values": "dashed"}]';
                  //  alert(str)
					///zingchart.exec("gGroup", "setseriesdata", '{"data": ' + str + '}');
				}
			}
		});

	});
  
	</script>

	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
	</style>

<body>

<table width="1000" height="300" border="1" align="center" style="text-decoration:none;">

<tr><th align="center" height="10px">
<div id="label_group_percent"><font size="3">%ต้นทุนเทียบยอดขาย</font></div> 
</th></tr>
<tr><td align="center" ><div id="display_group_percent"></div></td></tr>

</table>

</body>
</html>