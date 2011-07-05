<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Manufacturing Dashboard Page</title>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet"/>	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<!-------------------------  About Popup (#facebox) ------------------------->
	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.onLoad.css" media="screen" rel="stylesheet"/> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.onLoad.js"></script>

	<script type="text/javascript">
		$(function(){
			// Tabs
			$("#tabs").tabs();

			$("#tabs-t1r1").tabs();
			$("#tabs-t1r2").tabs();
			$("#tabs-t1r3").tabs();
				$("#param1").tabs();
				$("#chart1").tabs();
				$("#param2").tabs();
				$("#chart2").tabs();

			$("#tabs-t2r1c1").tabs();
			$("#tabs-t2r1c2").tabs();
			$("#tabs-t2r2").tabs();

			$("#tabs-t3r1").tabs();
			$("#tabs-t3r2").tabs();
			$("#tabs-t3r3").tabs();
			$("#tabs-t3r4c1").tabs();
			$("#tabs-t3r4c2").tabs();
			$("#tabs-t3r5").tabs();

			$("#tabs-t4r1").tabs();
			$("#tabs-t4r2").tabs();
				$("#param3").tabs();
				$("#chart3").tabs();
				$("#param4").tabs();
				$("#chart4").tabs();
			
			//hover states on the static widgets
			$('#dialog_link, ul#icons li').hover(
				function() { $(this).addClass('ui-state-hover'); }, 
				function() { $(this).removeClass('ui-state-hover'); }
			);
		});

		jQuery(document).ready(function($) {
			$('a[rel*=facebox]').facebox({
				loadingImage : '<%=request.getContextPath()%>/chartLib/images/loading.gif',
				closeImage   : '<%=request.getContextPath()%>/chartLib/images/closelabel.png'
			})
		})

	</script>

	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
		.demoHeaders { margin-top: 2em; }
		#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
		#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
		ul#icons {margin: 0; padding: 0;}
		ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
		ul#icons span.ui-icon {float: left; margin: 0 4px;}

		#tabs { position:absolute; top:60px; left:5px;}
	</style>

<%
	String keyT1 = request.getParameter("keyT1");
	String keyT2 = request.getParameter("keyT2");
	String keyT3 = request.getParameter("keyT3");

	String ProductType = request.getParameter("ProductType"); // Value of Product Type in Tab Inventory.
	String pt = request.getParameter("pt"); // Value of check Key in Tab 2.
%>

<script type="text/javascript">
	var barT1R1 = {
	"graphset" : [
	{
		"type" : "bar",
		"background-color":"#FFFFFF",
		"chart" : {     
			"margin" : "10 110 50 60"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 950,
			"y": 80
        },
        "scale-x":{
			"values":["Cake","Pasty","Thai Sweet","Bread","Moon Cake","Bean Cake"],
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
            "format":"%v%",
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
		"series" : [
		{
			"values" : ["20.8","10.13","13.37","5.09","9.07","13.37"],
			"url" : "<%=request.getContextPath()%>/Dashboard/ManuFac.jsp?keyT1= : %k&keyT2=<%=keyT2%>&keyT3=<%=keyT3%>&ProductType=<%=ProductType%>&pt=<%=pt%>",
			"text": "%Variance"
		},
		{
			"values" : ["22.2","11.23","20.19","-2.02","11.1","10.24"],
			"url" : "<%=request.getContextPath()%>/Dashboard/ManuFac.jsp?keyT1= : %k&keyT2=<%=keyT2%>&keyT3=<%=keyT3%>&ProductType=<%=ProductType%>&pt=<%=pt%>",
			"text": "%Growth"
		}]
	  }]
	};

	var mixedT1R2 = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart" : {     
			"margin" : "10 180 30 60"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 920,
			"y": 40
        },
		"guide":{
			"shared":true
		},
		"tooltip":{
			"visible": false
		},
        "scale-x":{
            "values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
			"decimals":0,
            "thousands-separator":",",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
		"scale-y-2":{
			"format":"%v%",     
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"plot":{
			"bars-space-left":"15%",
			"bars-space-right":"15%",
			"bar-width":"25px",
		},
		"series" : [
		{
			"type" : "bar",
			"values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37","15.15","10.37"],
			"text": "Actual 09",
			"background-color":"#66CC00",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type" : "bar",
			"values" : ["24.8","19.53","13.77","16.09","12.29","14.27","10.22","16.4","20.24","10.37","15.25","18.37"],
			"text": "Actual 10",
			"background-color":"#EEEE00",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type" : "bar",
			"values" : ["22.8","21.53","14.57","13.00","10.29","18.27","5.22","16.4","19.24","11.55","11.25","22.37"],
			"text": "Target",
			"background-color":"#696969",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type":"line",
			"values":["12.1","12.2","12.3","12.5","12.78","12.89","13.09","13.1","13.13","13.29","13.3","13.44"],
			"text":"%Variance",
			"scales":"scale-x,scale-y-2",
			"marker":{
				"visible":false
			}
		 },
		 {
			"type":"line",
			"values":["12.22","12.3","12.35","12.4","12.54","12.7","12.76","12.87","12.99","13.18","13.23","13.33"],
			"text":"%Growth",
			"scales":"scale-x,scale-y-2",
			"marker":{
				"visible":false
			}
		 }]
	  }]
	};

	var lineT1MTD = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "line",
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x1",
			"x": 700,
			"y": 20
		},
		"chart" : {
			"margin" : "20 150 40 50"
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
			"decimals":0,
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
				"text" : "ประมาณการยอดขาย"
			},
			{
				"values" : [2,3,5,7,1,2,9,3,2,3,6,7],
				//"aspect" : "spline",
				"text" : "ยอดสั่งจากลูกค้า"
			},
			{
				"values" : [7,3,6,8,4,9,6,7,5,8,5,8],
				//"aspect" : "spline",
				"text" : "ยอดสั่งผลิต"
			},
			{
				"values" : [3,3,4,8,3,3,8,3,3,4,7,9],
				//"aspect" : "spline",
				"text" : "ยอดการผลิต"
			},
			{
				"values" : [2,4,4,7,2,3,9,2,2,1,5,7],
				//"aspect" : "spline",
				"text" : "ยอดจัดส่ง"
			},
			{
				"values" : [1,1,0,1,2,3,2,1,1,3,2,2],
				//"aspect" : "spline",
				"text" : "ยอดคงคลัง"
			}
		] 
	}
	]
};

	var lineT1YTD = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "line",
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x1",
			"x": 700,
			"y": 20
		},
		"chart" : {
			"margin" : "20 150 40 50"
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
			"decimals":0,
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
				"values" : [4,9,16,25,33,34,39,46,52,61,69,71],
				//"aspect" : "spline",
				"text" : "ประมาณการยอดขาย"
			},
			{
				"values" : [2,3,5,7,9,12,19,23,25,27,30,31],
				//"aspect" : "spline",
				"text" : "ยอดสั่งจากลูกค้า"
			},
			{
				"values" : [7,10,16,24,28,37,43,50,55,63,68,76],
				//"aspect" : "spline",
				"text" : "ยอดสั่งผลิต"
			},
			{
				"values" : [3,11,17,21,28,33,37,45,49,54,57,61],
				//"aspect" : "spline",
				"text" : "ยอดการผลิต"
			},
			{
				"values" : [2,5,10,17,18,20,29,32,34,37,43,50],
				//"aspect" : "spline",
				"text" : "ยอดจัดส่ง"
			},
			{
				"values" : [3,4,6,7,9,10,12,15,17,19,23,24],
				//"aspect" : "spline",
				"text" : "ยอดคงคลัง"
			}
		] 
	}
	]
};

	//--------------------------------------
	var pieT2R1 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"10 0 100 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x3",
			"width" : "395px",
			"x":0,
			"y":210
		},
		"scale" : {
			"size-factor" : 1.0
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
			},
			"url" : "<%=request.getContextPath()%>/Dashboard/ManuFac.jsp?keyT1=<%=keyT1%>&keyT2= : %t&keyT3=<%=keyT3%>&ProductType=<%=ProductType%>&pt=1#tabs-t2"
		},
		"series" : [
			{
				"text" : "Cake",
				"values" : [30],
				"tooltip-text" : "%t: 3,000"
			},
			{
				"text" : "Pasty",
				"values" : [50],
				"tooltip-text" : "%t: 5,000"
			},
			{
				"text" : "Thai Sweet",
				"values" : [25],
				"tooltip-text" : "%t: 2,500"
			},
			{
				"text" : "Bread",
				"values" : [10],
				"tooltip-text" : "%t: 1,000"
			},
			{
				"text" : "Moon Cake",
				"values" : [9],
				"tooltip-text" : "%t: 900"
			},
			{
				"text" : "Bean Cake",
				"values" : [11],
				"tooltip-text" : "%t: 1,100"
			}]
	}]
};
	
	var mixedT2R1 = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart" : {     
			//"margin" : "10 130 30 50"
			"margin" : "50 130 25 50"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 555,
			"y": 120
        },
		"guide":{
			"shared":true
		},
		"tooltip":{
			"visible": false
		},
        "scale-x":{
            "values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
			"decimals":0,
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
			"decimals":0,
            "thousands-separator":",",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
		"scale-y-2":{
			"format":"%v",
			"thousands-separator":",",
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"plot":{
			"bars-space-left":"15%",
			"bars-space-right":"15%",
			"bar-width":"25px",
		},
		"series" : [
		{
			"type" : "bar",
			"values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37","15.15","10.37"],
			"text": "รับเข้า",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type" : "bar",
			"values" : ["24.8","19.53","13.77","16.09","12.29","14.27","10.22","16.4","20.24","10.37","15.25","18.37"],
			"text": "จ่ายออก",
			"scales":"scale-x,scale-y",
			"marker":{
				"visible":false
			}
		 },
		 {
			"type":"line",
			"values":["12.22","12.3","12.35","12.4","12.54","12.7","12.76","12.87","12.99","13.18","13.23","13.33"],
			"text":"คงคลัง",
			"scales":"scale-x,scale-y-2",
			"marker":{
				"visible":false
			}
		 }]
	  }]
	};

	var lineT2R2 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "line",
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x1",
			"x": 715,
			"y": 90
		},
		"chart" : {
			"margin" : "20 100 40 50"
		},
		"scale-x" : {
			"values" : ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"scale-y":{
			"decimals":0,
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
				"line-color":"#66CC00",
				"marker" : {
					"background-color":"#66CC00"
				},
				"text" : "Actual"
			},
			{
				"values" : [2,3,5,7,1,2,9,3,2,3,6,7],
				//"aspect" : "spline",
				"line-color":"#696969",
				"marker" : {
					"background-color":"#696969",
					"border-color":"#696969"
				},
				"text" : "Target"
			}
		] 
	}
	]
};

	//------------------------------------------------------------------
	var lineT3R1 = {
    "graphset" : [
	{
		"type" : "line",
		"background-color":"#FFFFFF",
		"chart" : {     
			"margin" : "10 200 30 60"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 870,
			"y": 60
        },
		/*"guide":{
			"shared":true
		},
		"tooltip":{
			"visible": false
		},*/
        "scale-x":{
            "values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
			"decimals":0,
            "thousands-separator":",",
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
			"values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37","15.15","10.37"],
			"text": "Production Volume (Kg)"
		 },
		 {
			"values":["12.22","12.3","12.35","12.4","12.54","12.7","12.76","12.87","12.99","13.18","13.23","13.33"],
			"text":"Production Value (Baht)"
		 },
		 {
			"values":["11","15","18","11","19","12","19","17","19","18","13","15"],
			"text":"Product Margin (Baht)"
		 }]
	  }]
	};

	var barT3R2C1 = {
	"graphset" : [
	{
		"type" : "bar",
		"background-color":"#FFFFFF",
		"chart" : {     
			"margin" : "10 10 50 60"
		}, 
        "scale-x":{
			"values":["ALL Category"],
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
            "format":"%v%",
			"decimals":1,
			"decimals-separator":".",
			"min-value" : 0,
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
		"series" : [
		{
			"values" : ["97.8"],
			"background-color":"#EEEE00",
			"text": "This Year"
		},
		{
			"values" : ["90.2"],
			"background-color":"#66CC00",
			"text": "Last Year"
		}]
	  }]
	};

	var barT3R2C2 = {
	"graphset" : [
	{
		"type" : "bar",
		"background-color":"#FFFFFF",
		"chart" : {     
			"margin" : "10 100 50 60"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 760,
			"y": 80
        },
        "scale-x":{
			"values":["Cake","Pasty","Thai Sweet","Bread","Moon Cake","Bean Cake"],
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
            "format":"%v%",
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
		"series" : [
		{
			"values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37"],
			"background-color":"#EEEE00",
			"text": "This Year"
		},
		{
			"values" : ["20.2","11.23","20.77","20.79","20.19","20.07","12.02","21.1","10.24","10.37"],
			"background-color":"#66CC00",
			"text": "Last Year"
		}]
	  }]
	};

	var mixedT3R3 = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart" : {     
			"margin" : "10 150 30 60"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 950,
			"y": 80
        },
		"guide":{
			"shared":true
		},
		"tooltip":{
			"visible": false
		},
        "scale-x":{
            "values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
			"decimals":0,
            "thousands-separator":",",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
		"scale-y-2":{
			"format":"%v%",
			"thousands-separator":",",
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"plot":{
			"bars-space-left":"15%",
			"bars-space-right":"15%",
			"bar-width":"25px",
		},
		"series" : [
		{
			"type" : "bar",
			"values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37","15.15","10.37"],
			"text": "ยอดผลิต",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type" : "bar",
			"values" : ["24.8","19.53","13.77","16.09","12.29","14.27","10.22","16.4","20.24","10.37","15.25","18.37"],
			"text": "แผนการผลิต",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type":"line",
			"values":["12.22","12.3","12.35","12.4","12.54","12.7","12.76","12.87","12.99","13.18","13.23","13.33"],
			"text":"%Yield",
			"scales":"scale-x,scale-y-2",
			"marker":{
				"visible":false
			}
		 }]
	  }]
	};
	
	var barT3R4C1 = {
	"graphset" : [
	{
		"type" : "bar",
		"background-color":"#FFFFFF",
		"chart" : {     
			"margin" : "10 90 25 50"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 570,
			"y": 120
        },
        "scale-x":{
			"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
			"decimals":0,
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
		"plot":{
			"bars-space-left":"15%",
			"bars-space-right":"15%",
			"bar-width":"25px",
		},
		"series" : [
		{
			"values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37","12.24","13.37"],
			"text": "RM",
			"url" : "<%=request.getContextPath()%>/Dashboard/ManuFac.jsp?keyT1=<%=keyT1%>&keyT2=<%=keyT2%>&keyT3=%k&ProductType=<%=ProductType%>&pt=<%=pt%>#tabs-t3"
		},
		{
			"values" : ["20.2","11.23","20.77","20.79","20.19","20.07","12.02","21.1","10.24","10.37","12.24","13.37"],
			"text": "FG",
			"url" : "<%=request.getContextPath()%>/Dashboard/ManuFac.jsp?keyT1=<%=keyT1%>&keyT2=<%=keyT2%>&keyT3=%k&ProductType=<%=ProductType%>&pt=<%=pt%>#tabs-t3"
		}]
	  }]
	};

	var pieT3R4C2 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"10 0 100 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x3",
			"width" : "395px",
			"x":0,
			"y":210
		},
		"scale" : {
			"size-factor" : 1.0
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
				"text" : "Cake",
				"values" : [30],
				"tooltip-text" : "%t: 3,000"
			},
			{
				"text" : "Pasty",
				"values" : [50],
				"tooltip-text" : "%t: 5,000"
			},
			{
				"text" : "Thai Sweet",
				"values" : [25],
				"tooltip-text" : "%t: 2,500"
			},
			{
				"text" : "Bread",
				"values" : [10],
				"tooltip-text" : "%t: 1,000"
			},
			{
				"text" : "Moon Cake",
				"values" : [9],
				"tooltip-text" : "%t: 900"
			},
			{
				"text" : "Bean Cake",
				"values" : [11],
				"tooltip-text" : "%t: 1,100"
			}]
	}]
};

	var barT3R5 = {
	"graphset" : [
	{
		"type" : "bar",
		"background-color":"#FFFFFF",
		"chart" : {     
			"margin" : "10 110 10 60"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 970,
			"y": 80
        },
        "scale-x":{
			"values":[" "," "," "," "," "," "," "," "," "," "," "," "],
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
			"decimals":0,
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
			"bar-width":"25px"
		},
		"series" : [
		{
			"values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37","12.24","13.37"],
			"background-color":"#66CC00",
			"text": "Actual"
		},
		{
			"values" : ["20.2","11.23","20.77","20.79","20.19","20.07","12.02","21.1","10.24","10.37","12.24","13.37"],
			"background-color":"#696969",
			"text": "Target"
		}]
	  }]
	};

	//------------------------------------------------------------------------
	var mixedT4R1 = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart" : {     
			"margin" : "10 180 30 60"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 920,
			"y": 40
        },
		"guide":{
			"shared":true
		},
		"tooltip":{
			"visible": false
		},
        "scale-x":{
            "values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
			"decimals":0,
            "thousands-separator":",",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
		"scale-y-2":{
			"format":"%v%",     
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"plot":{
			"bars-space-left":"15%",
			"bars-space-right":"15%",
			"bar-width":"25px",
		},
		"series" : [
		{
			"type" : "bar",
			"values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37","15.15","10.37"],
			"text": "Actual 09",
			"background-color":"#66CC00",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type" : "bar",
			"values" : ["24.8","19.53","13.77","16.09","12.29","14.27","10.22","16.4","20.24","10.37","15.25","18.37"],
			"text": "Actual 10",
			"background-color":"#EEEE00",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type" : "bar",
			"values" : ["10.8","13.33","15.57","17.39","19.59","10.27","15.32","13.2","18.34","13.57","20.45","11.27"],
			"text": "Target",
			"background-color":"#696969",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type":"line",
			"values":["12.1","12.2","12.3","12.5","12.78","12.89","13.09","13.1","13.13","13.29","13.3","13.44"],
			"text":"%Variance",
			"scales":"scale-x,scale-y-2",
			"marker":{
				"visible":false
			}
		 },
		 {
			"type":"line",
			"values":["12.22","12.3","12.35","12.4","12.54","12.7","12.76","12.87","12.99","13.18","13.23","13.33"],
			"text":"%Growth",
			"scales":"scale-x,scale-y-2",
			"marker":{
				"visible":false
			}
		 }]
	  }]
	};

	var mixedT4MTD = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart" : {
			"margin" : "10 200 30 50"
			//old "margin" : "10 180 30 60"
		}, 
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 700,
			"y": 60
        },
		"guide":{
			"shared":true
		},
		"tooltip":{
			"visible": false
		},
        "scale-x":{
            "values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
			"min-value":0,
			"decimals":0,
            "thousands-separator":",",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
		"scale-y-2":{
			"format":"%v%",
			"min-value":0,
			"max-value":30,
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"plot":{
			"bars-space-left":"15%",
			"bars-space-right":"15%",
			"bar-width":"25px",
		},
		"series" : [
		{
			"type" : "bar",
			"values" : ["24.8","19.53","13.77","16.09","12.29","14.27","10.22","16.4","20.24","10.37","15.25","18.37"],
			"text": "Production Value",
			//"background-color":"blue",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type" : "bar",
			"values" : ["20.8","10.13","13.37","15.09","12.19","19.07","10.02","13.1","12.24","13.37","15.15","10.37"],
			"text": "Product Margin",
			//"background-color":"orange",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type":"line",
			"values" : ["8.22","7.3","6.35","8.4","9.54","9.7","9.76","8.87","8.99","7.18","8.23","10.33"],
			"text":"%Margin",
			//"line-color" : "#EEEE00",
			"scales":"scale-x,scale-y-2",
			"marker":{
				"visible":false
			}
		 }]
	  }]
	};

	var mixedT4YTD = {
    "graphset" : [
	{
		"type" : "mixed",
		"background-color":"#FFFFFF",
		"chart" : {
			"margin" : "10 200 30 50"
			// old "margin" : "10 180 30 60"
		},
       "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x" : 700,
			"y": 40
        },
		"guide":{
			"shared":true
		},
		"tooltip":{
			"visible": false
		},
        "scale-x":{
            "values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "format":"%v",
			"min-value":0,
			"decimals":0,
            "thousands-separator":",",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
		"scale-y-2":{
			"format":"%v%",
			"min-value":0,
			"max-value":200,
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
		"plot":{
			"bars-space-left":"15%",
			"bars-space-right":"15%",
			"bar-width":"25px",
		},
		"series" : [
		{
			"type" : "bar",
			"values" : ["24.8","44.33","58.1","74.19","86.48","100.75","110.97","127.37","147.61","157.98","173.23","191.6"],
			"text": "Production Value",
			//"background-color":"blue",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type" : "bar",
			"values" : ["20.8","31.1","44.47","59.56","71.75","90.82","100.84","113.94","126.18","139.55","154.7","165.07"],
			"text": "Product Margin",
			//"background-color":"orange",
			"scales":"scale-x,scale-y"
		 },
		 {
			"type":"line",
			"values":["8.22","7.3","6.35","8.4","9.54","9.7","9.76","8.87","8.99","7.18","8.23","10.33"],
			"text":"%Margin",
			//"line-color" : "#EEEE00",
			"scales":"scale-x,scale-y-2",
			"marker":{
				"visible":false
			}
		 }]
	  }]
	};

	 //------------------------------------------------------------------
	 $(document).ready(function() {
		zingchart.render({
			id 			: 'gT1R1',
			width 		: 1050,
			height 		: 250,
			data 		: barT1R1
		});
		zingchart.render({
			id 			: 'gT1R2',
			width 		: 1050,
			height 		: 250,
			data 		: mixedT1R2
		});
		zingchart.render({
			id 			: 'gT1MTD',
			width 		: 840,
			height 		: 250,
			data 		: lineT1MTD
		});
		zingchart.render({
			id 			: 'gT1YTD',
			width 		: 840,
			height 		: 250,
			data 		: lineT1YTD
		});
		//------------------------------
		zingchart.render({
			id 			: 'gT2R1P',
			width 		: 395,
			height 		: 300,
			data 		: pieT2R1
		});
		zingchart.render({
			id 			: 'gT2R1M',
			width 		: 640,
			height 		: 300,
			data 		: mixedT2R1
		});
		zingchart.render({
			id 			: 'gT2R2',
			width 		: 800,
			height 		: 250,
			data 		: lineT2R2
		});
		//------------------------------
		zingchart.render({
			id 			: 'gT3R1',
			width 		: 1050,
			height 		: 250,
			data 		: lineT3R1
		});
		zingchart.render({
			id 			: 'gT3R2C1',
			width 		: 190,
			height 		: 250,
			data 		: barT3R2C1
		});
		zingchart.render({
			id 			: 'gT3R2C2',
			width 		: 850,
			height 		: 250,
			data 		: barT3R2C2
		});
		zingchart.render({
			id 			: 'gT3R3',
			width 		: 1050,
			height 		: 250,
			data 		: mixedT3R3
		});
		zingchart.render({
			id 			: 'gT3R4C1',
			width 		: 640,
			height 		: 300,
			data 		: barT3R4C1
		});
		zingchart.render({
			id 			: 'gT3R4C2',
			width 		: 395,
			height 		: 300,
			data 		: pieT3R4C2
		});
		zingchart.render({
			id 			: 'gT3R5',
			width 		: 1050,
			height 		: 250,
			data 		: barT3R5
		});
		//-----------------------------------------
		zingchart.render({
			id 			: 'gT4R1',
			width 		: 1050,
			height 		: 250,
			data 		: mixedT4R1
		});
		zingchart.render({
			id 			: 'gT4MTD',
			width 		: 840,
			height 		: 250,
			data 		: mixedT4MTD
		});
		zingchart.render({
			id 			: 'gT4YTD',
			width 		: 840,
			height 		: 250,
			data 		: mixedT4YTD
		});
	});
	
</script>

</head>

<body bgcolor="#FFFFFF">
<!-- Parameter -->
	<!--          Drop Down List              -->
	<div style="position:absolute; left:15px; top:20px; color:#000000;"><font size="3">โรงงาน :</font>
		<select name="Factory">
			<option value="1">ALL</option>
			<option value="2">ลาดกระบัง</option>
			<option value="3">สุขุมวิท 62</option>
			<option value="4">ศรีนครินทร์</option>
			<option value="5">Bakery</option>
		</select>
	</div>
	<!--          Drop Down List              -->
	<div style="position:absolute; left:175px; top:20px; color:#000000;"><font size="3"> ปี:</font>
		<select name="Year">
			<option value="1">2010</option>
			<option value="2">2009</option>
		</select>
	</div>
	<!--          Drop Down List             -->
	<div style="position:absolute; left:265px; top:20px; color:#000000;"><font size="3"> เดือน: </font>
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
	<div style="position:absolute; left:375px; top:20px; color:#000000;"><font size="3"> หน่วย: </font>
		<select name="Units">
			<option value="1">มูลค่า</option>
			<option value="2">จำนวน</option>
			<option value="3">น้ำหนัก</option>
		</select> 
	</div>
	<div style="position:absolute; left:490px; top:20px;">
		<input type="button" value=" OK "/></div>
	</div>
<!-- End Parameter -->

<div id="tabs">
	<ul>
		<li><a href="#tabs-t1">Production</a></li>
		<li><a href="#tabs-t2">Inventory</a></li>
		<li><a href="#tabs-t3">Indicator</a></li>
		<li><a href="#tabs-t4">Cost and Margin</a></li>
	</ul>

<!-- Tab Production -->
<div id="tabs-t1">
<table id="tabs-t1r1" width="1070">
	<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Comparative Production Volume Growth</font></th></tr>
	<tr><td id="gT1R1"></td></tr>
</table>

<table id="tabs-t1r2" width="1070">
	<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Production Volume<%out.print(keyT1);%></font></th></tr>
	<tr><td id="gT1R2"></td></tr>
</table>

<table id="tabs-t1r3" width="1070">
	<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">เปรียบเทียบ</font></th></tr>
	<tr><td>
	<ul>
		<li><a href="#tabs-t1r3_1">Monthly</a></li>
		<li><a href="#tabs-t1r3_2">YTD</a></li>
	</td></tr></ul>

	<tr><td>
		<table id="tabs-t1r3_1">
			<tr>
				<td id="param1" width="150"><table>
					<tr bgcolor="#CD853F">
						<th><font color="#FFFFFF">กลุ่มสินค้า</font></th>
					<tr>
					<tr><td>
						<select multiple size="4" style="width:150px;">
							<option value="1">ALL</option>
							<option value="2">Cake</option>
							<option value="3">Pasty</option>
							<option value="4">Thai Sweet</option>
							<option value="5">Bread</option>
							<option value="6">Moon Cake</option>
							<option value="7">Bean Cake</option>
						</select>
					</td></tr>

					<tr bgcolor="#CD853F">
						<th><font color="#FFFFFF">สินค้า</font></th>
					<tr>
					<tr><td>
						<select multiple size="4" style="width:150px;">
							<option value="1">ALL</option>
							<option value="2">เค๊กผลไม้</option>
							<option value="3">แยมโรลใบเตย</option>
							<option value="4">แยมโรลกาแฟ</option>
							<option value="5">คุ๊กกี้ชอกโกแล็ต</option>
						</select>
						<input type="button" value=" OK "/></div>
					</td></tr>
				</table></td>

				<td id="chart1" width="100%"><div id="gT1MTD"></div></td>
			</tr>
		</table>

		<table id="tabs-t1r3_2">
			<tr>
				<td id="param2" width="150"><table>
					<tr bgcolor="#CD853F">
						<th><font color="#FFFFFF">กลุ่มสินค้า</font></th>
					<tr>
					<tr><td>
						<select multiple size="4" style="width:150px;">
							<option value="1">ALL</option>
							<option value="2">Cake</option>
							<option value="3">Pasty</option>
							<option value="4">Thai Sweet</option>
							<option value="5">Bread</option>
							<option value="6">Moon Cake</option>
							<option value="7">Bean Cake</option>
						</select>
					</td></tr>

					<tr bgcolor="#CD853F">
						<th><font color="#FFFFFF">สินค้า</font></th>
					<tr>
					<tr><td>
						<select multiple size="4" style="width:150px;">
							<option value="1">ALL</option>
							<option value="2">เค๊กผลไม้</option>
							<option value="3">แยมโรลใบเตย</option>
							<option value="4">แยมโรลกาแฟ</option>
							<option value="5">คุ๊กกี้ชอกโกแล็ต</option>
						</select>
						<input type="button" value=" OK "/></div>
					</td></tr>
				</table></td>

				<td id="chart2" width="100%"><div id="gT1YTD"></div></td>
			</tr>
		</table>
	</td></tr>

</table>
</div>
<!-- End Tab Production -->

<!-- Tab Inventory -->
<div id="tabs-t2">
<table width="1070">
	<tr>
		<td id="tabs-t2r1c1" width="400"><table width="100%">
			
			<tr bgcolor="#8B4513">
				<th><font color="#FFE742" size="3">สินค้าคงคลัง</font></th>
			</tr>

			<form name="fProductType" method="post" action="<%=request.getContextPath()%>/Dashboard/ManuFac.jsp?keyT1=<%=keyT1%>&keyT2=<%=keyT2%>&keyT3=<%=keyT3%>&pt=0#tabs-t2">
			<tr><td>Product Type 
				<select name="ProductType">
					<option value="FG"<%if(ProductType.equals("FG")) out.print(" selected=\"selected\"");%>>FG</option>
					<option value="RM"<%if(ProductType.equals("RM")) out.print(" selected=\"selected\"");%>>RM</option>
				</select>
				<input type="submit" value=" OK "/></div>
			</td></tr>
			</form>

			<tr><td><!--<div style="height:270px; overflow:auto;">--><div id="gT2R1P"></div><!--</div>--></td></tr>
		</table></td>

		<td id="tabs-t2r1c2" valign="top"><table width="100%">
			<tr bgcolor="#8B4513">
				<th><font color="#FFE742" size="3">รับเข้า / จ่ายออก : <%out.print(ProductType); if(pt.equals("1")) out.print(keyT2);%></font></th>
			</tr>

			<tr><td id="gT2R1M"></td></tr>
		</table></td>
	</tr>
	<tr>
		<td colspan="2" id="tabs-t2r2"><table width="100%">
			<tr bgcolor="#8B4513">
				<th colspan="2"><font color="#FFE742" size="3">TurnOver : <%out.print(ProductType); if(pt.equals("1")) out.print(keyT2);%></font></th>
			</tr>

			<tr>
				<td width="800" id="gT2R2"></td>

				<td align="center" valign="top" align="center">
				<table bordercolor="#000000" frame="box" rules="all">
					<tr bgcolor="#CD853F">
						<th width="150"><font color="#FFFFFF">สินค้า</font></th>
						<th><font color="#FFFFFF">TurnOver</font></th>
					<tr>

					<tr>
						<td>เค้กรถไฟชูชู</td>
						<td align="right">15 รอบ</td>
					</tr>
					<tr>
						<td>เค้กหมีพูห์คริสต์มาส</td>
						<td align="right">13 รอบ</td>
					</tr>
					<tr>
						<td>เค้กมิกกี้เม้าส์</td>
						<td align="right">12 รอบ</td>
					</tr>
					<tr>
						<td>เค้กมินนี่เม้าส์</td>
						<td align="right">11 รอบ</td>
					</tr>
					<tr>
						<td>เค้กกระต่าย</td>
						<td align="right">10 รอบ</td>
					</tr>
					<tr>
						<td>เค้กฮีโร่เบ็น'10</td>
						<td align="right">9 รอบ</td>
					</tr>
					<tr>
						<td>เค้กการ์ตูน</td>
						<td align="right">8 รอบ</td>
					</tr>
					<tr>
						<td>เค้กซีบร้า</td>
						<td align="right">7 รอบ</td>
					</tr>
					<tr>
						<td>เค้กช่อกุหลาบ</td>
						<td align="right">5 รอบ</td>
					</tr>
					<tr>
						<td>เค้กนิลา</td>
						<td align="right">3 รอบ</td>
					</tr>
				</table>
				</td>
			</tr>
		</table></td>
	</tr>

</table>
</div>
<!-- End Tab Inventory -->

<!-- Tab Indicator -->
<div id="tabs-t3">

<table id="tabs-t3r1" width="1070">
	<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Productivity</font></th></tr>

	<tr><td>ต่อ :  
		<select>
			<option value="1">คน</option>
			<option value="2">ชั่วโมง</option>
			<!--<option value="1">Production Line</option>
			<option value="2">Category</option>-->
		</select>
		<input type="button" value=" OK "/></div>
	</td></tr>

	<tr><td id="gT3R1"></td></tr>
</table>

<table id="tabs-t3r2" width="1070">
	<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">Capacity Utilization</font></th></tr>
	<tr><td id="gT3R2C1"></td><td id="gT3R2C2"></td></tr>
</table>

<table id="tabs-t3r3" width="1070">
	<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">% Yield</font></th></tr>

	<tr><td>ดูตาม :  
		<select>
			<option value="1">ALL</option>
			<option value="2">Cake</option>
			<option value="3">Pasty</option>
			<option value="4">Thai Sweet</option>
			<option value="5">Bread</option>
			<option value="6">Moon Cake</option>
			<option value="7">Bean Cake</option>
		</select>
		<input type="button" value=" OK "/></div>
	</td></tr>

	<tr><td id="gT3R3"></td></tr>
</table>

<table width="1070">
<tr>
	<td id="tabs-t3r4c1" width="100%"><table width="100%">
		<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Waste</font></th></tr>
		<tr><td id="gT3R4C1"></td></tr>
	</table></td>

	<td id="tabs-t3r4c2" width="400"><table width="400">
		<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Waste Ratio : <%out.print(keyT3);%></font></th></tr>
		<tr><td id="gT3R4C2"></td></tr>
	</table></td>
</tr>
</table>

<table id="tabs-t3r5" width="1070" align="center">
	<tr bgcolor="#8B4513"><th colspan="12"><font color="#FFE742" size="3">Customer Complaint</font></th></tr>
	<tr><td colspan="12" id="gT3R5"></td></tr>
	<tr>
		<td align="center" width="15%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=January" rel="facebox"><font color="#000000" size="1"><dd><u>Jan</u></font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_PopupPie.jsp?m=Febuary" rel="facebox"><font color="#000000" size="1">Feb</font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=March" rel="facebox"><font color="#000000" size="1">Mar</font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=April" rel="facebox"><font color="#000000" size="1">Apr</font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=May" rel="facebox"><font color="#000000" size="1">May</font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=June" rel="facebox"><font color="#000000" size="1">Jun</font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=July" rel="facebox"><font color="#000000" size="1">Jul</font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=August" rel="facebox"><font color="#000000" size="1">Aug</font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=September" rel="facebox"><font color="#000000" size="1">Sep</font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=October" rel="facebox"><font color="#000000" size="1">Oct</font></td>
		<td width="7%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=November" rel="facebox"><font color="#000000" size="1">Nov</font></td>
		<td width="15%"><a href="<%=request.getContextPath()%>/Dashboard/ManuFac_Popup.jsp?m=December" rel="facebox"><font color="#000000" size="1">Dec</font></td>
	</tr>
</table>

</div>
<!-- End Tab Indicator -->

<!-- Tab Cost and Margin -->
<div id="tabs-t4">
<table id="tabs-t4r1" width="1070">
	<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Cost (Baht / KG)</font></th></tr>
	<tr><td id="gT4R1"></td></tr>
</table>

<table id="tabs-t4r2" width="1070">
<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Margin</font></th></tr>
	<tr><td>
	<ul>
		<li><a href="#tabs-t4r2_1">Monthly</a></li>
		<li><a href="#tabs-t4r2_2">YTD</a></li>
	</td></tr></ul>

	<tr><td>
		<table id="tabs-t4r2_1">
			<tr>
				<td id="param3" width="150"><table>
					<tr bgcolor="#CD853F">
						<th><font color="#FFFFFF">กลุ่มสินค้า</font></th>
					<tr>
					<tr><td>
						<select multiple size="4" style="width:150px;">
							<option value="1">ALL</option>
							<option value="2">Cake</option>
							<option value="3">Pasty</option>
							<option value="4">Thai Sweet</option>
							<option value="5">Bread</option>
							<option value="6">Moon Cake</option>
							<option value="7">Bean Cake</option>
						</select>
					</td></tr>

					<tr bgcolor="#CD853F">
						<th><font color="#FFFFFF">สินค้า</font></th>
					<tr>
					<tr><td>
						<select multiple size="4" style="width:150px;">
							<option value="1">ALL</option>
							<option value="2">เค๊กผลไม้</option>
							<option value="3">แยมโรลใบเตย</option>
							<option value="4">แยมโรลกาแฟ</option>
							<option value="5">คุ๊กกี้ชอกโกแล็ต</option>
						</select>
						<input type="button" value=" OK "/></div>
					</td></tr>
				</table></td>

				<td id="chart3" width="100%"><div id="gT4MTD"></div></td>
			</tr>
		</table>

		<table id="tabs-t4r2_2">
			<tr>
				<td id="param4" width="150"><table>
					<tr bgcolor="#CD853F">
						<th><font color="#FFFFFF">กลุ่มสินค้า</font></th>
					<tr>
					<tr><td>
						<select multiple size="4" style="width:150px;">
							<option value="1">ALL</option>
							<option value="2">Cake</option>
							<option value="3">Pasty</option>
							<option value="4">Thai Sweet</option>
							<option value="5">Bread</option>
							<option value="6">Moon Cake</option>
							<option value="7">Bean Cake</option>
						</select>
					</td></tr>

					<tr bgcolor="#CD853F">
						<th><font color="#FFFFFF">สินค้า</font></th>
					<tr>
					<tr><td>
						<select multiple size="4" style="width:150px;">
							<option value="1">ALL</option>
							<option value="2">เค๊กผลไม้</option>
							<option value="3">แยมโรลใบเตย</option>
							<option value="4">แยมโรลกาแฟ</option>
							<option value="5">คุ๊กกี้ชอกโกแล็ต</option>
						</select>
						<input type="button" value=" OK "/></div>
					</td></tr>
				</table></td>

				<td id="chart4" width="100%"><div id="gT4YTD"></div></td>
			</tr>
		</table>
	</td></tr>

</table>

</div>
<!-- End Tab Cost and Margin -->

</div>
</body>
</html>

