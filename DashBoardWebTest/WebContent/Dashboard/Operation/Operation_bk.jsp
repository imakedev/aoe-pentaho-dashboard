<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Operation Dashboard Page</title>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet" />	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.min.js"></script>

	<script type="text/javascript">
		$(function(){
			// Tabs
			$("#tabs").tabs();
			$("#tabs-t1r1").tabs();
			$("#tabs-t1r2").tabs();
			$("#tabs-t1r3").tabs();
			$("#tabs-t1r4").tabs();

			$("#tabs-t2r1c1").tabs();
			$("#tabs-t2r1c2").tabs();
			$("#tabs-t2r2").tabs();
				$("#param1").tabs();
				$("#chart1").tabs();
			$("#tabs-t2r3c1").tabs();
			$("#tabs-t2r3c2").tabs();
			$("#tabs-t2r4c1").tabs();
			$("#tabs-t2r4c2").tabs();
			$("#tabs-t2r5c1").tabs();
			$("#tabs-t2r5c2").tabs();

			$("#tabs-t3r1").tabs();
			$("#tabs-t3r2").tabs();
			

			//hover states on the static widgets
			$('#dialog_link, ul#icons li').hover(
				function() { $(this).addClass('ui-state-hover'); }, 
				function() { $(this).removeClass('ui-state-hover'); }
			);
		});

		$(function() {
			// Bar charts using inline values
			$('.bar').sparkline('html', {type: 'bar'});
		});
	</script>
	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
		.demoHeaders { margin-top: 1em; }
		#dialog_link {padding: .1em 1em .1em 20px;text-decoration: none;position: relative;}
		#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;top: 50%;margin-top: -8px;}
		ul#icons {margin: 0; padding: 0;}
		ul#icons li {margin: 1px; position: relative; padding: 1px 0; cursor: pointer; float: left;  list-style: none;}
		ul#icons span.ui-icon {float: left; margin: 0 4px;}
		#tabs { top:80px; left:5px; }
	</style>

<!-- Get Parameter -->
<%
	String y = request.getParameter("y"); // Value of Year Parameter.
	String months = request.getParameter("months"); // Value of Month Parameter.
	String sb = request.getParameter("sb"); // Value of Summary By Parameter.
	String div = request.getParameter("div"); // Value of Divsion Parameter.
	String sect = request.getParameter("sect"); // Value of Section Parameter.
	String zone = request.getParameter("zone"); // Value of Zone Parameter.
	String maj = request.getParameter("maj"); // Value of Major Parameter.

	String b1 = request.getParameter("b1"); // Value of check when click chart g1(bar1) In Tab Sales/Day.
	String b2 = request.getParameter("b2"); // Value of check when click chart g2(bar2) In Tab EBIT/Day.
%>

	<script type="text/javascript">
		var y = <%=y%>; // Value of Year(Default 1)
		function getYear(value)
		{
			y = value;
		}

		var months = <%=months%>; // Value of Month(Default 1)
		function getMonth(value)
		{
			months = value;
		}

		var sb = <%=sb%>;
		function getSumBy(value)
		{
			sb = value;
		}

		var div = <%=div%>;
		function getDivision(value)
		{
			div = value;
		}

		var sect = <%=sect%>;
		function getSection(value)
		{
			sect = value;
		}

		var zone = <%=zone%>;
		function getZone(value)
		{
			zone = value;
		}

		var maj = <%=maj%>;
		function getMajor(value)
		{
			maj = value;
		}

		function goUrl()
		{
			location.href = '<%=request.getContextPath()%>/Dashboard/Operation.jsp?y='+y+'&months='+months+'&sb='+sb+'&div='+div+'&sect='+sect+'&zone='+zone+'&maj='+maj+'&b1=0&b2=0';
		}

	</script>

<script type="text/javascript">

	var barSales1 = {
	"graphset":[
    {
		"background-color":"#FFFFFF",
        "type":"bar",
        "legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"x": 570,
			"y": 70
		},
		"chart" : {
			"margin" : "20 150 40 100"
		},
		"plot":{
            "bars-space-left":"20%",
			"bars-space-right":"20%",
            "bar-width":"25px"
        },
		"scale-x":{
            "values":["ฝ่ายปฏิบัติการสาขา S&P","ฝ่ายปฏิบัติการ Specialty"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
		},
        "scale-y":{
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-color": "#8B8B7A"
			}
        },
        "tooltip":{
            "border-radius":"15",
            "font-color":"#000000",
            "alpha":0.7
        },
		"series" : [
		 {
			"values" : [11,26],
			 "background-color" : "#66CC00",
	 /*"url": "<%=request.getContextPath()%>/SNP/Finance/Operation_Bar1.jsp",
	 "target" : "_self",*/
			 "text" : "ยอดขาย Last"
		 },
		 {
			"values" : [42,13],
			 "background-color" : "#EEEE00",
			 "text" : "ยอดขาย"
		 },
		 {
			"values" : [23,24],
			 "background-color" : "#696969",
			 "text" : "เป้าหมาย"
		 }] 
	  }]
	};

	var bar1 = {
	"graphset":[
    {
        "type":"bar",
        "background-color":"#FFFFFF",
		"plotarea":{
            "border-width":"0px",
            "margin":"10 30 70 70"
        },
        "plot":{
            "bars-space-left":"25%",
            "bar-width":"25px"
        },
        "scale-y":{
            "values":"-30:30:10",
            "format":"%v",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "tooltip":{
            "border-radius":"15",
            "alpha":0.7
        },
        "scale-x":{
			"tick":{
				"line-width": 3
			},
            "max-items":9,
            "item":{
                "font-family":"Calibri",
                "font-size":"13",
                "offset-y":"20px",
                "font-angle":300,
                "offset-x":"-20px"
            },
            "values":["- >20%","- 10-20%","- 1-10%","+/- 1%","+ 1-10%","+ 10-20%","+ >20%"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1,
                "rules":[
                    {
                        "rule":"%i == 0",
                        "line-width":"0px"
                    }]
                },
                "items-overlap":true
		},
		"series":[
			{
				"text":"",
                "tooltip-text":"%v%",
                "values":[-7,-4,-15,6,33,15,6],
				"url": "<%=request.getContextPath()%>/Dashboard/Operation.jsp?y=<%=y%>&months=<%=months%>&sb=<%=sb%>&div=<%=div%>&sect=<%=sect%>&zone=<%=zone%>&maj=<%=maj%>&b1=%v&b2=<%=b2%>#tabs-t1r3_1",
                "border-width":"2px",
                "rules":[
                    {
                        "rule":"%v >= 1",
                        "background-color":"#009933",
                        "border-color":"#009933"
                    },
                    {
                        "rule":"%v < 1",
                        "background-color":"#ff0000",
                        "border-color":"#ff0000"
				}]
			}]
		}]
    };

	var bar2 = {
	"graphset":[
    {
        "type":"bar",
        "background-color":"#FFFFFF",
		"plotarea":{
            "border-width":"0px",
            "margin":"10 30 70 70"
        },
        "plot":{
            "bars-space-left":"25%",
            "bar-width":"25px"
        },
        "scale-y":{
            "values":"-30:30:10",
            "format":"%v",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "tooltip":{
            "border-radius":"15",
            "alpha":0.7
        },
        "scale-x":{
			"tick":{
				"line-width": 3,
			},
            "max-items":9,
            "item":{
                "font-family":"Calibri",
                "font-size":"13",
                "offset-y":"20px",
                "font-angle":300,
                "offset-x":"-20px"
            },
            "values":["- >20%","- 10-20%","- 1-10%","+/- 1%","+ 1-10%","+ 10-20%","+ >20%"],
            "guide":{
    			"line-width": 1,
    			"alpha": 1,
                "rules":[
                    {
                        "rule":"%i == 0",
                        "line-width":"0px"
                    }]
                },
                "items-overlap":true
		},
		"series":[
			{
				"text":"",
				"tooltip-text":"%v",
				"values":[-14,-2,-4,1,6,15,46],
				"url": "<%=request.getContextPath()%>/Dashboard/Operation.jsp?y=<%=y%>&months=<%=months%>&sb=<%=sb%>&div=<%=div%>&sect=<%=sect%>&zone=<%=zone%>&maj=<%=maj%>&b1=<%=b1%>&b2=%v#tabs-t1r3_2",
				"border-width":"2px",
				"rules":[
					{
						"rule":"%v >= 1",
						"background-color":"#009933",
						"border-color":"#009933"
					},
					{
						"rule":"%v < 1",
						"background-color":"#ff0000",
						"border-color":"#ff0000"
				}]
			}]
		}]
	};

	var mixedNetSales = {
"graphset":[
    {
		"background-color":"#FFFFFF",
        "type":"mixed",
        "chart":{
			"margin":"10 205 30 100"
        },
		"legend":{
            "margin":"60 10 20 670",
            "layout":"x1",
            "border-width": "2px",
			"border-color": "#4C77B6",
            "item":{
                "font-color":"#000000"
            }
        },
		"plot":{
			"bars-space-left":"25%",
			"bars-space-right":"25%",
			"bar-width":"25px"
		},
        "scale-x":{
            "values":["Same","New","Change"],
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
            "min-value": 0,
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
        "scale-y-2":{
			"min-value": 0,
            "format":"%v%",     
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			},
            "item":{
                "font-color":"#000000"
            }
        },
        "series":[
            {
                "type":"bar",
				"values":[62,61,58],
				"border-width":1,
				"stacked":0,
				"background-color" : "#66CC00",
				"border-color":"#66CC00",
                "text":"ยอดขาย Last"
            },
            {
                "type":"bar",
				"values":[63,82,74],
				"text":"ยอดขาย",
				"stacked":0,
				"background-color" : "#EEEE00",
				"border-color":"#EEEE00",
                "border-width":1
            },
            {
                "type":"line",
                "values":[1.61,34.43,29.59],
                "text":"%Growth",
                "scales":"scale-x,scale-y-2",
                "stacked":"0",
				"line-color" : "#00BFFF",
                "marker":{
                    "size":3,
					"background-color" : "#00BFFF",
					"border-color":"#00BFFF"
                },
                "tooltip-text":"%v%"
            }]
        }]
    };

	var mixedSalesPG = {
	"graphset":[
    {
        "background-color":"#FFFFFF",
        "type":"hbar",
        "title":{
                "visible":false,
            "text":""
        },
        "chart":{
            "margin":"10 20 40 120"
        },
        "legend":{
                "visible":false
        },
        "tooltip":{
            "text-align":"center"
        },
        "scale-x":{
            "values":["Total","Outsource Products<br>& Others","Packaged Products","Bakery","Food","Beverage"],
			"guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "scale-y":{
            "min-value": 0,
			"format" : "%v",
			"thousands-separator":",",
            "guide":{
    			"line-width": 1,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			}
        },
        "plot":{
            "animate":1,
            "tooltip-text":"%v"
        },
        "series":[
            {
                "values":[1167.9,47.6,126.3,564,320,107.2],
                "text":"Goals"
            }]
        }]
    };

//------------------------------------------------------------------------------
var pieNet = {
  "graphset" : [
  {
	"title":{
		"text": "Net Sales by Category",
		"background-color":"#FFFFFF",
		"color": "#000000",
	},
	"background-color":"#FFFFFF",
    "type" : "pie",
	"chart":{
		"margin":"35 0 65 0"
    },
	"legend":{
		"background-color": "#FFFFFF",
		"border-width": "2px",
		"border-color": "#4C77B6",
		"layout":"2x",
		"width":230,
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
         "values" : [48.39],
		 "text" : "Bakery",
 		 "tooltip-text" : "%t: 564.00"
     },
     {
         "values": [26.76],
		 "text" : "Food",
 		 "tooltip-text" : "%t: 320.80"
     },
     {
         "values": [6.24],
		 "text" : "OPO",
 		 "tooltip-text" : "%t: 47.50"
     },
     {
         "values": [12.52],
		 "text" : "PP",
 		 "tooltip-text" : "%t: 128.30"
     },
     {
         "values": [10.33],
		 "text" : "Beverage",
 		 "tooltip-text" : "%t: 107.20"
     }] 
  }]
};

var pieCost = {
  "graphset" : [
  {
	"title":{
		"text": "Cost by Category",
		"background-color":"#FFFFFF",
		"color": "#000000",
	},
	"background-color":"#FFFFFF",
    "type" : "pie",
	"chart":{
		"margin":"35 0 65 0"
    },
	"legend":{
		"background-color": "#FFFFFF",
		"border-width": "2px",
		"border-color": "#4C77B6",
		"layout":"2x",
		"width":230,
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
         "values" : [48.39],
		 "text" : "Bakery",
 		 "tooltip-text" : "%t: 564.00"
     },
     {
         "values": [26.76],
		 "text" : "Food",
 		 "tooltip-text" : "%t: 320.80"
     },
     {
         "values": [6.24],
		 "text" : "OPO",
 		 "tooltip-text" : "%t: 47.50"
     },
     {
         "values": [12.52],
		 "text" : "PP",
 		 "tooltip-text" : "%t: 128.30"
     },
     {
         "values": [10.33],
		 "text" : "Beverage",
 		 "tooltip-text" : "%t: 107.20"
     }] 
  }]
};

var mixedMTD = {
"graphset":[
    {
		"background-color":"#FFFFFF",
        "type":"mixed",
        "chart":{
			"margin":<%if(sb.equals("2")) out.print("\"10 155 30 70\""); if(sb.equals("1")) out.print("\"10 155 30 50\"");%>
        },
		"legend":{
            "margin":"40 10 20 755",
            "layout":"5x",
            "border-width": "2px",
			"border-color": "#4C77B6",
            "item":{
                "font-color":"#000000"
            }
        },
        "scale-x":{
            <%if(sb.equals("2")) out.print("//");%>"values":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"],
			<%if(sb.equals("1")) out.print("//");%>"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
            "min-value": 0,
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
        "scale-y-2":{
			"min-value": 0,
            "format":"%v%",     
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			},
            "item":{
                "font-color":"#000000"
            }
        },<%if(sb.equals("2")) out.print("/*");%>
        "series":[
            {
                "type":"bar",
                "values":[2783,3674,2455,2565,4853,5622,4673,3879,4689,4214,6492,5116,5549,6077,4715,6921,3777,4390,5759,7247,9776,9629,9908,8311,8829,8348,8856,7675,7133,6332,9060],
                "border-width":1,
				"stacked":0,
				"background-color" : "#66CC00",
				"border-color":"#66CC00",
                "text":"Actual 09"
            },
            {
                "type":"bar",
                "values":[1872,2784,2251,1234,2356,3452,3754,4331,4521,5942,3562,4362,5674,5975,6842,6124,6743,7920,8940,7842,8592,9053,9583,9905,8032,9024,9371,9717,9044,9402,8495],
                "text":"Actual 10",
				"stacked":0,
				"background-color" : "#EEEE00",
				"border-color":"#EEEE00",
                "border-width":1
            },
            {
                "type":"bar",
                "values":[1872,2784,2251,1234,2356,3452,3754,4331,4521,5942,3562,4362,5674,5975,6842,6124,6743,7920,8940,7842,8592,9053,9583,9905,8032,9024,9371,9717,9044,9402,8495],
                "text":"Target",
				"stacked":0,
				"background-color" : "#696969",
				"border-color":"#696969",
                "border-width":1
            },
			{
                "type":"line",
                "values":[21,31,41,47,47,54,54,54,56,56,57,57,57,57,57,58,58,58,58,58,59,59,59,60,60,62,63,63,65,67,67],
                "text":"%Actaul/<br>Target",
                "scales":"scale-x,scale-y-2",
                "stacked":0,
				"line-color" : "#FF6600",
                "marker":{
                    "size":3
                },
                "tooltip-text":"%v%"
            },
            {
                "type":"line",
                "values":[20,21,24,29,30,31,32,34,35,35,36,40,40,40,42,45,46,48,50,50,52,56,57,57,58,58,60,62,62,64,65],
                "text":"%Growth",
                "scales":"scale-x,scale-y-2",
                "stacked":"0",
				"line-color" : "#3860BB",
                "marker":{
                    "size":3
                },
                "tooltip-text":"%v%"
            }]
        }]
    };<%if(sb.equals("2")) out.print("*/");%>
	<%if(sb.equals("1")) out.print("/*");%>
        "series":[
            {
                "type":"bar",
                "values":[1048726,1917776,1962904,2008033,1653161,1518290,2143418,2188546,1633675,2278803,3323932,2769060],
                "border-width":1,
				"stacked":0,
				"background-color" : "#66CC00",
				"border-color":"#66CC00",
                "text":"Actual YTD 09"
            },
            {
                "type":"bar",
                "values":[1148726,1517776,1762904,2438033,2053161,1718290,1843418,1488546,2633675,1978803,2323932,2669060],
                "text":"Actual YTD 10",
				"stacked":0,
				"background-color" : "#EEEE00",
				"border-color":"#EEEE00",
                "border-width":1
            },
			{
                "type":"bar",
                "values":[1184478,1524298,1553528,1754042,1798656,1879170,2014555,2088913,2359684,2473785,2669427,2704812],
                "text":"Target YTD",
				"stacked":0,
				"background-color" : "#696969",
				"border-color":"#696969",
                "border-width":1
            },
            {
                "type":"line",
                "values":[42,47,48,48,48,50,51,52,52,58,67,67],
                "text":"%Actaul YTD/<br>Target YTD",
                "scales":"scale-x,scale-y-2",
                "stacked":0,
				"line-color" : "#FF6600",
                "marker":{
                    "size":3
                },
                "tooltip-text":"%v%"
            },
			{
                "type":"line",
                "values":[50,52,56,57,57,58,58,60,62,62,64,65],
                "text":"%Growth YTD",
                "scales":"scale-x,scale-y-2",
                "stacked":"0",
				"line-color" : "#3860BB",
                "marker":{
                    "size":3
                },
                "tooltip-text":"%v%"
            }]
        }]
    };<%if(sb.equals("1")) out.print("*/");%>

var datapiano = {
	"graphset" : [
		{
			"background-color":"#cccccc",
			"type" : "piano",
			"chart":{
				"margin":"0 0 30 70"
			},
			"scale-x" : {
				"values" : ["THU", "FRI", "SAT", "SUN", "MON", "TUE", "WED"]
			},
			"scale-y" : {
				"values" : ["Eat In","Take Away","HOD","PINTO"]
			},
			"series" : [
            	{
            		"values" : [25707.8,26524.6,26372.3,25273.8,23980.6,25652.4,26943,26367.4],
					"text" : "Eat In",
					"background-image":"<%=request.getContextPath()%>/Dashboard/images/home.png"
            	}
            	,
            	{
            	    "values" : [6944.6,6747.2,7020.5,6987.7,6772.4,6680.1,6897.1],
		    		"text" : "Take Away",
					"background-image":"<%=request.getContextPath()%>/Dashboard/images/takeaway.png"
            	}
            	,
            	{
            	    "values" : [445.4,423.8,392.6,399.1,399.1,369.5,393.7],
				    "text" : "HOD",
					"background-image":"<%=request.getContextPath()%>/Dashboard/images/Delivery.png"
            	}
            	,
            	{
            	    "values" : [1600.7,1523.6,1561.2,1578.7,1661.9,1688,1613.5],
		    		"text" : "PINTO",
					"background-image":"<%=request.getContextPath()%>/Dashboard/images/Pinto.png"
            	}
            ]
		}
	]
};

var stackedSales = {
"graphset":[
    {
        "type":"bar",
		"stacked": true,
        "background-color":"#FFFFFF",
        "chart" : {
		"margin" : "10 105 30 50"
	},
	 "legend":{
		"background-color": "#FFFFFF",
		"border-width": "2px",
		"border-color": "#4C77B6",
		"layout":"x1",
		"x" : 410,
		"y" : 40,
		"item":{
			"font-color":"#000000"
		}
    },
	"scale-x" : {
		"values":["THU", "FRI", "SAT", "SUN", "MON", "TUE", "WED"],
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
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
     "scale-y-2":{ 
		"format":"%v%",     
            "guide":{
    			"line-width": 0,
    			"alpha": 1
    		},
			"tick":{
				"line-width": 3
			},
            "item":{
                "font-color":"#000000"
            }
    },
	"plot":{
		"bars-space-left":"25%",
		"bars-space-right":"25%",
		"bar-width":"25px"
	},
    "series" : [
     {
        "values" : [25707.8,26524.6,26372.3,25273.8,23980.6,25652.4,26943,26367.4],
		"text" : "Eat In"
		//"background-color" : "#1E90FF"
     },
     {
        "values" : [6944.6,6747.2,7020.5,6987.7,6772.4,6680.1,6897.1],
		"text" : "Take Away"
		//"background-color" : "#A020F0"
     },
	 {
        "values" : [3445.4,3423.8,3392.6,3399.1,3399.1,3369.5,3393.7],
		"text" : "HOD"
		//"background-color" : "#8bb934"
     },
	 {
         "values" : [1600.7,1523.6,1561.2,1578.7,1661.9,1688,1613.5],
		 "text" : "PINTO"
		 //"background-color" : "#FF4500"
     },
     {
         "values" : [2600.7,2523.6,2561.2,2578.7,2661.9,2688,2613.5],
		 "text" : "WholeSales"
		 //"background-color" : "#4169E1"
     }] 
  }]
};

var barDiscount = {
"graphset":[
{
    "background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","Plan"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
		"thousands-separator":",",
		"guide":{
			"line-width": 1,
			"alpha": 1
		},
		"tick":{
			"line-width": 3
		}
     },
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : [11,,],
		 "background-color" : "#66CC00",
 //"url": "<%=request.getContextPath()%>/Dashboard/Operation-Discount(test).jsp",
 //"target" : "_self",
		 "text" : "Last Year"
     },
     {
        "values" : [,42,],
		 "background-color" : "#EEEE00",
		 "text" : "This Year"
     },
     {
        "values" : [,,23],
		 "background-color" : "#696969",
		 "text" : "Plan"
     }] 
  }]
};

	var pieDiscount = {
	"graphset":[
		{
        "type":"pie",
        "background-color":"#FFFFFF",
        "chart":{
			"margin":"20 100 20 0"
		},
		"legend":{
			"margin":"50 0 0 300",
			"layout":"x1",
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6"
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
			"values" : [11],
			"text" : "คูปอง",
			"tooltip-text" : "%t: 11,000"
		 },
		 {
			"values" : [42],
			"text" : "สมาชิก",
			"tooltip-text" : "%t: 42,000"
		 },
		 {
			"values" : [23],
			"text" : "ส่วนลดพักงาน",
			"tooltip-text" : "%t: 23,000"
		 },
		 {
			"values" : [23],
			"text" : "ส่วนลดวันพุธ",
			"tooltip-text" : "%t: 23,000"
		 }] 
	  }]
	};

var barAvg = {
  "graphset" : [
  {
	"background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","%Growth"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
		"format" : "%v%",
		"guide":{
			"line-width": 0,
			"alpha": 0
		},
		"tick":{
			"line-width": 3
		}
    },
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : [189,,],
		"background-color" : "#66CC00",
		"text":"MTD ปีที่แล้ว"
     },
     {
        "values" : [,193,],
		"background-color" : "#EEEE00",
		"text":"MTD ปีนี้"
     },
     {
        "values" : [,,2.12],
		"background-color" : "#696969",
		"text":"%Growth",
        "scales":"scale-x,scale-y-2"
     }] 
  }]
};

var barCust = {
  "graphset" : [
  {
	"background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","%Growth"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
		"format" : "%v%",
		"guide":{
			"line-width": 0,
			"alpha": 0
		},
		"tick":{
			"line-width": 3
		}
    },
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : [29492,,],
		"background-color":"#66CC00",
		"text":"MTD ปีที่แล้ว"
     },
     {
        "values" : [,32686,],
		"background-color":"#EEEE00",
		"text":"MTD ปีนี้"
     },
     {
        "values" : [,,10.83],
		"background-color":"#696969",
		"text":"%Growth",
        "scales":"scale-x,scale-y-2"
     }] 
  }]
};

var barAvgs = {
  "graphset" : [
  {
	"background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","%Growth"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
		"format" : "%v%",
		"guide":{
			"line-width": 0,
			"alpha": 0
		},
		"tick":{
			"line-width": 3
		}
    },
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : [83859,,],
		"background-color":"#66CC00",
		"text":"MTD ปีที่แล้ว"
     },
     {
        "values" : [,90283,],
		"background-color":"#EEEE00",
		"text":"MTD ปีนี้"
     },
     {
        "values" : [,,9.03],
		"background-color":"#696969",
		"text":"%Growth",
        "scales":"scale-x,scale-y-2"
     }] 
  }]
};

var barSales2 = {
  "graphset" : [
  {
	"background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","%Growth"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
		"format" : "%v%",
		"guide":{
			"line-width": 0,
			"alpha": 0
		},
		"tick":{
			"line-width": 3
		}
    },
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : [290,,],
		"background-color":"#66CC00",
		"text":"MTD ปีที่แล้ว"
     },
     {
        "values" : [,590,],
		"background-color":"#EEEE00",
		"text":"MTD ปีนี้"
     },
     {
        "values" : [,,68.97],
		"background-color":"#696969",
		"text":"%Growth",
        "scales":"scale-x,scale-y-2"
     }] 
  }]
};

var barSales3 = {
  "graphset" : [
  {
	"background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","%Growth"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
		"format" : "%v%",
		"guide":{
			"line-width": 0,
			"alpha": 0
		},
		"tick":{
			"line-width": 3
		}
    },
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : [3071,,],
		"background-color":"#66CC00",
		"text":"MTD ปีที่แล้ว"
     },
     {
        "values" : [,4847,],
		"background-color":"#EEEE00",
		"text":"MTD ปีนี้"
     },
     {
        "values" : [,,57.83],
		"background-color":"#696969",
		"text":"%Growth",
        "scales":"scale-x,scale-y-2"
     }] 
  }]
};

var barSeat = {
  "graphset" : [
  {
	"background-color":"#FFFFFF",
    "type" : "bar",
	"stacked" : true,
	"chart" : {
		"margin" : "10 50 30 50"
	},
	"scale-x" : {
		"values":["Last Year","This Year","%Growth"],
		"guide":{
    		"line-width": 1,
    		"alpha": 1
    	},
		"tick":{
			"line-width": 3
		}
     },
    "scale-y" : {
		"min-value": 0,
		"format" : "%v",
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
		"format" : "%v%",
		"guide":{
			"line-width": 0,
			"alpha": 0
		},
		"tick":{
			"line-width": 3
		}
    },
	"plot":{
		"bars-space-left":"30%",
		"bars-space-right":"30%",
		"bar-width":"25px",
	},
    "series" : [
     {
        "values" : [7.4,,],
		"background-color":"#66CC00",
		"text":"MTD ปีที่แล้ว"
     },
     {
        "values" : [,8.7,],
		"background-color":"#EEEE00",
		"text":"MTD ปีนี้"
     },
     {
        "values" : [,,17.57],
		"background-color":"#696969",
		"text":"%Growth",
        "scales":"scale-x,scale-y-2"
     }] 
  }]
};

	$(document).ready(function() {
		zingchart.render({
			id 			: 'chart_sales',
			width 		: 700,
			height 		: 250,
			data 		: barSales1
		});
		zingchart.render({
			id 			: 'g1',
			width 		: 500,
			height 		: 250,
			data 		: bar1
		});
		zingchart.render({
			id 			: 'g2',
			width 		: 500,
			height 		: 250,
			data 		: bar2
		});
		zingchart.render({
			id 			: 'g3',
			width 		: 800,
			height 		: 250,
			data 		: mixedNetSales
		});
		zingchart.render({
			id 			: 'gPG',
			width 		: 600,
			height 		: 270,
			data 		: mixedSalesPG
		});

//----------------------------------------------------------------------------------
		zingchart.render({
			id 			: 'g4',
			width 		: 235,
			height 		: 270,
			data 		: pieNet
		});
		zingchart.render({
			id 			: 'g5',
			width 		: 235,
			height 		: 270,
			data 		: pieCost
		});
		zingchart.render({
			id 			: 'g6',
			width 		: 870,
			height 		: 350,
			data 		: mixedMTD
		});
		zingchart.render({
			id 			: 'g7',
			width 		: 510,
			height 		: 235,
			data 		: stackedSales
		});
		zingchart.render({
			id 			: 'g8',
			width 		: 450,
			height 		: 235,
			data 		: barDiscount
		});
		zingchart.render({
			id 			: 'g9',
			width 		: 400,
			height 		: 235,
			data 		: barAvg
		});
		zingchart.render({
			id 			: 'g10',
			width 		: 400,
			height 		: 235,
			data 		: barCust
		});
		zingchart.render({
			id 			: 'g11',
			width 		: 400,
			height 		: 235,
			data 		: barAvgs
		});
		zingchart.render({
			id 			: 'g12',
			width 		: 400,
			height 		: 235,
			data 		: barSales2
		});
		zingchart.render({
			id 			: 'g13',
			width 		: 400,
			height 		: 235,
			data 		: barSales3
		});
		zingchart.render({
			id 			: 'g14',
			width 		: 400,
			height 		: 235,
			data 		: barSeat
		});
	});

</script>

</head>

<body>
<!--+++++++++++++++++++++++++ Parameter +++++++++++++++++++++++++-->
	<!--          Drop Down List YEAR              -->
	<div style="position:absolute; left:45px; top:20px;"><font size="3"> ปี:</font>
		<select name="Year" onChange="getYear(this.value);">
			<option value="1"<%if(y.equals("1")) out.print(" selected=\"selected\"");%>>2010</option>
			<option value="2"<%if(y.equals("2")) out.print(" selected=\"selected\"");%>>2009</option>
		</select> 
	</div>
	<!--          Drop Down List MONTH              -->
	<div style="position:absolute; left:250px; top:20px;"><font size="3"> เดือน:</font>
		<select name="Month" onChange="getMonth(this.value);">
			<option value="1"<%if(months.equals("1")) out.print(" selected=\"selected\"");%>>Jan</option>
			<option value="2"<%if(months.equals("2")) out.print(" selected=\"selected\"");%>>Feb</option>
			<option value="3"<%if(months.equals("3")) out.print(" selected=\"selected\"");%>>Mar</option>
			<option value="4"<%if(months.equals("4")) out.print(" selected=\"selected\"");%>>Apr</option>
			<option value="5"<%if(months.equals("5")) out.print(" selected=\"selected\"");%>>May</option>
			<option value="6"<%if(months.equals("6")) out.print(" selected=\"selected\"");%>>Jun</option>
			<option value="7"<%if(months.equals("7")) out.print(" selected=\"selected\"");%>>Jul</option>
			<option value="8"<%if(months.equals("8")) out.print(" selected=\"selected\"");%>>Aug</option>
			<option value="9"<%if(months.equals("9")) out.print(" selected=\"selected\"");%>>Sep</option>
			<option value="10"<%if(months.equals("10")) out.print(" selected=\"selected\"");%>>Oct</option>
			<option value="11"<%if(months.equals("11")) out.print(" selected=\"selected\"");%>>Nov</option>
			<option value="12"<%if(months.equals("12")) out.print(" selected=\"selected\"");%>>Dec</option>
		</select> 
	</div>
	<!--          Drop Down List SUMMARY BY            -->
	<div style="position:absolute; left:430px; top:20px;"><font size="3"> สรุปตาม : </font>
		<select name="SumBy" onChange="getSumBy(this.value);">
			<option value="1"<%if(sb.equals("1")) out.print(" selected=\"selected\"");%>> MTD</option>
			<option value="2"<%if(sb.equals("2")) out.print(" selected=\"selected\"");%>> YTD</option>
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:20px; top:50px;"><font size="3"> ฝ่าย : </font>
		<select name="Division" onChange="getDivision(this.value);">
			<option value="1"<%if(div.equals("1")) out.print(" selected=\"selected\"");%>>ALL</option>
			<option value="2"<%if(div.equals("2")) out.print(" selected=\"selected\"");%>>ฝ่ายปฏิบัติการสาขา S&P</option>
			<option value="3"<%if(div.equals("3")) out.print(" selected=\"selected\"");%>>ฝ่ายปฏิบัติการสาขา Specialy</option>
			<option value="4"<%if(div.equals("4")) out.print(" selected=\"selected\"");%>>ฝ่าย Retail</option>
			<option value="5"<%if(div.equals("5")) out.print(" selected=\"selected\"");%>>ฝ่าย Food Service</option>
			<option value="6"<%if(div.equals("6")) out.print(" selected=\"selected\"");%>>ฝ่าย Export</option>
			<option value="7"<%if(div.equals("7")) out.print(" selected=\"selected\"");%>>ฝ่ายบริการจัดเลี้ยง</option>
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:250px; top:50px;"><font size="3"> ส่วน : </font>
		<select name="Section" onChange="getSection(this.value);">
			<option value="1"<%if(sect.equals("1")) out.print(" selected=\"selected\"");%>>ALL</option>
			<option value="2"<%if(sect.equals("2")) out.print(" selected=\"selected\"");%>>ส่วนปฏิบัติการสาขา</option>
			<option value="3"<%if(sect.equals("3")) out.print(" selected=\"selected\"");%>>ส่วนปฏิบัติการร้านวนิลา</option>
			<option value="4"<%if(sect.equals("4")) out.print(" selected=\"selected\"");%>>ส่วนปฏิบัติการร้านภัทรา</option>
			<option value="5"<%if(sect.equals("5")) out.print(" selected=\"selected\"");%>>ส่วนปฏิบัติการ Seaside</option>
			<option value="6"<%if(sect.equals("6")) out.print(" selected=\"selected\"");%>>ส่วนปฏิบัติการ Patio</option>
			<option value="7"<%if(sect.equals("7")) out.print(" selected=\"selected\"");%>>Caterman</option>
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:460px; top:50px;"><font size="3"> เขต : </font>
		<select name="Zone" onChange="getZone(this.value);">
			<option value="1"<%if(zone.equals("1")) out.print(" selected=\"selected\"");%>>ALL</option>
			<option value="2"<%if(zone.equals("2")) out.print(" selected=\"selected\"");%>>เขต 0</option>
			<option value="3"<%if(zone.equals("3")) out.print(" selected=\"selected\"");%>>เขต 1</option>
			<option value="4"<%if(zone.equals("4")) out.print(" selected=\"selected\"");%>>เขต 2</option>
			<option value="5"<%if(zone.equals("5")) out.print(" selected=\"selected\"");%>>เขต 3 </option>
			<option value="6"<%if(zone.equals("6")) out.print(" selected=\"selected\"");%>>เขต 4</option>
			<option value="7"<%if(zone.equals("7")) out.print(" selected=\"selected\"");%>>เขต 5</option>
			<option value="8"<%if(zone.equals("8")) out.print(" selected=\"selected\"");%>>เขต 6</option>
			<option value="9"<%if(zone.equals("9")) out.print(" selected=\"selected\"");%>>เขต 7</option>
			<option value="10"<%if(zone.equals("10")) out.print(" selected=\"selected\"");%>>เขต 8</option>
			<option value="11"<%if(zone.equals("11")) out.print(" selected=\"selected\"");%>>เขต 9</option>
			<option value="12"<%if(zone.equals("12")) out.print(" selected=\"selected\"");%>>เขต 10</option>
			<option value="13"<%if(zone.equals("13")) out.print(" selected=\"selected\"");%>>เขต 11</option>
			<option value="14"<%if(zone.equals("14")) out.print(" selected=\"selected\"");%>>เขต 12</option>
			<option value="15"<%if(zone.equals("15")) out.print(" selected=\"selected\"");%>>เขต 13</option>
			<option value="16"<%if(zone.equals("16")) out.print(" selected=\"selected\"");%>>เขต 14</option>
			<option value="17"<%if(zone.equals("17")) out.print(" selected=\"selected\"");%>>เขต 15</option>
			<option value="18"<%if(zone.equals("18")) out.print(" selected=\"selected\"");%>>เขต 16</option>
			<option value="19"<%if(zone.equals("19")) out.print(" selected=\"selected\"");%>>เขต 17</option>
		</select> 
	</div>
	<!--          Drop Down List            -->
	<div style="position:absolute; left:590px; top:50px;"><font size="3"> สาขา : </font>
		<select name="Major" onChange="getMajor(this.value);">
			<option value="1"<%if(maj.equals("1")) out.print(" selected=\"selected\"");%>>ALL</option>
			<option value="2"<%if(maj.equals("2")) out.print(" selected=\"selected\"");%>>Top รงสิต</option>
			<option value="3"<%if(maj.equals("3")) out.print(" selected=\"selected\"");%>>วนิลาองหล่อ</option>
			<option value="4"<%if(maj.equals("4")) out.print(" selected=\"selected\"");%>>เซ็นทรัลลาดพร้าว</option>
			<option value="5"<%if(maj.equals("5")) out.print(" selected=\"selected\"");%>>RCA</option>
		</select> 
	</div>

	<div style="position:absolute; left:760px; top:50px;">
		<input type="button" value=" OK " onClick="goUrl()"/>
	</div>
<!--+++++++++++++++++++++++++ End Parameter +++++++++++++++++++++++++-->

<!--+++++++++++++++++++++++++ +++++++++++++++++++++++++-->
<div id="tabs" style="position:absolute; height=500px;" bordercolor="#FFFFFF" border="5">
	<ul>
		<li><a href="#tabs-t1">Summary</a></li>
		<li><a href="#tabs-t2">Detail</a></li>
		<li><a href="#tabs-t3">Map</a></li>
	</ul>

<!--+++++++++++++++++++++++++ Tab Summary +++++++++++++++++++++++++-->
	<table id="tabs-t1">
	<tr><td>
	
		<table id="tabs-t1r1" width=1060>
			<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">ยอดขาย (ล้านบาท)</font></th></tr>
			<tr><td align="center"><div id="chart_sales"></div></td></tr><!-- Chart -->
		</table>
	<!----------------- Row 2 -------------------->
		<table id="tabs-t1r2" width=1060>
		<tr><td>
			<ul>
				<li><a href="#tabs-t1r2_1">กำไร</a></li>
				<li><a href="#tabs-t1r2_2">Sales Growth</a></li>
			</ul>

			<table id="tabs-t1r2_1">
			<tr>
				<td>กำไรมากสุด : <input type=text value=10><input type="button" name="ok" value=" OK "/></td>
				<td>กำไรน้อยสุด : <input type=text value=10><input type="button" name="ok" value=" OK "/></td>
			</tr>
			<tr>
			<td><p></p>
				<table width=500 bordercolor="#000000" frame="box" rules="all">
				<tr bgcolor="#CD853F">
					<th><font color="#FFFFFF">#</font></th>
					<th><font color="#FFFFFF">สาขา</font></th>
					<th><font color="#FFFFFF">กำไร (บาท)</font></th>
					<th><font color="#FFFFFF">% GP</font></th>
				</tr>
				<tr>
					<td align=center>1</td>
					<td align=center>โลตัส บางใหญ่</td>
					<td align=right>500,000</td>
					<td align=right>10</td>
				</tr>
				<tr>
					<td align=center>2</td>
					<td align=center>โลตัส รังสิต</td>
					<td align=right>400,000</td>
					<td align=right>9</td>
				</tr>
				<tr>
					<td align=center>3</td>
					<td align=center>อาคารสินธร</td>
					<td align=right>300,000</td>
					<td align=right>9</td>
				</tr>
				<tr>
					<td align=center>4</td>
					<td align=center>โลตัส ประชาชื่น</td>
					<td align=right>200,000</td>
					<td align=right>8</td>
				</tr>
				<tr>
					<td align=center>5</td>
					<td align=center>โลตัสบางกะปิ</td>
					<td align=right>100,000</td>
					<td align=right>8</td>
				</tr>
				<tr>
					<td align=center>6</td>
					<td align=center>โลตัสบางนา</td>
					<td align=right>100,000</td>
					<td align=right>8</td>
				</tr>
				<tr>
					<td align=center>7</td>
					<td align=center>โลตัสสระบุรี</td>
					<td align=right>100,000</td>
					<td align=right>7</td>
				</tr>
				<tr>
					<td align=center>8</td>
					<td align=center>โลตัสลาดพร้าว</td>
					<td align=right>100,000</td>
					<td align=right>7</td>
				</tr>
				<tr>
					<td align=center>9</td>
					<td align=center>โลตัสรามอินทรา</td>
					<td align=right>100,000</td>
					<td align=right>6</td>
				</tr>
				<tr>
					<td align=center>10</td>
					<td align=center>โลตัสสาธร</td>
					<td align=right>100,000</td>
					<td align=right>6</td>
				</tr>
				</table>
			</td>

			<td><p></p>
				<table width=500 bordercolor="#000000" frame="box" rules="all">
				<tr  bgcolor="#CD853F">
					<th><font color="#FFFFFF">#</font></th>
					<th><font color="#FFFFFF">สาขา</font></th>
					<th><font color="#FFFFFF">กำไร (บาท)</font></th>
					<th><font color="#FFFFFF">% GP</font></th>
				</tr>
				<tr>
					<td align=center>1</td>
					<td align=center>ปิยรมย์ พาร์ค</td>
					<td align=right>95,000</td>
					<td align=right>5.5</td>
				</tr>
				<tr>
					<td align=center>2</td>
					<td align=center>บิ๊กซี รังสิต</td>
					<td align=right>90,000</td>
					<td align=right>5</td>
				</tr>
				<tr>
					<td align=center>3</td>
					<td align=center>รพ.เซ็นต์หลุยส์</td>
					<td align=right>85,000</td>
					<td align=right>4.5</td>
				</tr>
				<tr>
					<td align=center>4</td>
					<td align=center>รพ.เพชรเวช</td>
					<td align=right>80,000</td>
					<td align=right>4</td>
				</tr>
				<tr>
					<td align=center>5</td>
					<td align=center>เซ็นทรัลรัตนาธิเบศร์</td>
					<td align=right>75,000</td>
					<td align=right>3.5</td>
				</tr>
				<tr>
					<td align=center>6</td>
					<td align=center>เซ็นทรัลพระราม3</td>
					<td align=right>70,000</td>
					<td align=right>3</td>
				</tr>
				<tr>
					<td align=center>7</td>
					<td align=center>เฉลิมกรุง</td>
					<td align=right>65,000</td>
					<td align=right>2.5</td>
				</tr>
				<tr>
					<td align=center>8</td>
					<td align=center>เจริญนคร</td>
					<td align=right>60,000</td>
					<td align=right>2</td>
				</tr>
				<tr>
					<td align=center>9</td>
					<td align=center>คาร์ฟูร์ บางใหญ่</td>
					<td align=right>55,000</td>
					<td align=right>1.5</td>
				</tr>
				<tr>
					<td align=center>10</td>
					<td align=center>แกรนด์คาแนล</td>
					<td align=right>50,000</td>
					<td align=right>1</td>
				</tr>				
				</table>
			</td>

			</tr>
			</table>

			<table id="tabs-t1r2_2">
			<tr><td width="1048">
				<select>
					<option value="">ยอดขายสูงสุด</option>
					<option value="">ยอดขายต่ำสุด</option>
				</select>
				<input type=text value=10>
				<input type="button" name="ok" value=" OK "/>
				<p></p>
			</td></tr>

			<tr><td align="center">
				<table bordercolor="#000000" frame="box" rules="all">
				<tr bgcolor="#CD853F">
					<th width="50"><font color="#FFFFFF">#</font></th>
					<th width="150"><font color="#FFFFFF">สาขา</font></th>
					<th width="70"><font color="#FFFFFF">ยอดขาย</font></th>
					<th width="100"><font color="#FFFFFF">Last ยอดขาย</font></th>
					<th width="100"><font color="#FFFFFF">Diff ยอดขาย</font></th>
					<th width="70"><font color="#FFFFFF">% Growth</font></th>
				</tr>
				<tr>
					<td align=center>1</td>
					<td align=center>โลตัส บางใหญ่</td>
					<td align=center>500,000</td>
					<td align=center>600,000</td>
					<td align=center>100,000</td>
					<td align=center>10</td>
				</tr>
				<tr>
					<td align=center>2</td>
					<td align=center>วงศ์สว่าง</td>
					<td align=center>400,000</td>
					<td align=center>450,000</td>
					<td align=center>50,000</td>
					<td align=center>9</td>
				</tr>
				<tr>
					<td align=center>3</td>
					<td align=center>อาคารสินธร</td>
					<td align=center>300,000</td>
					<td align=center>320,000</td>
					<td align=center>20,000</td>
					<td align=center>9</td>
				</tr>
				<tr>
					<td align=center>4</td>
					<td align=center>โลตัส ประชาชื่น</td>
					<td align=center>200,000</td>
					<td align=center>210,000</td>
					<td align=center>10,000</td>
					<td align=center>7</td>
				</tr>
				<tr>
					<td align=center>5</td>
					<td align=center>โลตัสบางกะปิ</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>6</td>
				</tr>
				<tr>
					<td align=center>6</td>
					<td align=center>โลตัสสระบุรี</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>5</td>
				</tr>
				<tr>
					<td align=center>7</td>
					<td align=center>โลตัสลำลูกกา</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>5</td>
				</tr>
				<tr>
					<td align=center>8</td>
					<td align=center>โลตัสฟอร์จูน</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>4</td>
				</tr>
				<tr>
					<td align=center>9</td>
					<td align=center>โลตัสรามอินทรา</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>3</td>
				</tr>
				<tr>
					<td align=center>10</td>
					<td align=center>โลตัสภูเก็ต</td>
					<td align=center>100,000</td>
					<td align=center>100,000</td>
					<td align=center>0</td>
					<td align=center>3</td>
				</tr>
				</table>
			</td></tr>
			</table>
		</td></tr>
		</table>

	<!---------------------------- Row 3 ------------------------>
	<table id="tabs-t1r3" width=1060>
		<tr><td>
			<ul>
				<li><a href="#tabs-t1r3_1">Sales/Day</a></li>
				<li><a href="#tabs-t1r3_2">EBIT/Day</a></li>
			</ul>

			<table id="tabs-t1r3_1">
			<tr><td colspan="2">
				<select name="salesday" onChange="getChart(this.value);">
					<option value="1"># of branch</option>
					<option value="2">% Change in Sales</option>
				</select>
				<input type="button" name="ok" value=" OK "/>
			</td></tr>
			<tr>
				<td id="g1"></td><!-- Chart -->
				<td><%if(b1.equals("0")) out.print("<!--");%>
					<table width="100%" bordercolor="#000000" frame="box" rules="all">
					<tr bgcolor="#CD853F">
						<th width=20px><font color="#FFFFFF">#</font></th>
						<th width=80px><font color="#FFFFFF">สาขา</font></th>
						<th width=150px><font color="#FFFFFF">ยอดขาย</font></th>
						<th width=150px><font color="#FFFFFF">Last ยอดขาย</font></th>
						<th width=150px><font color="#FFFFFF">Diff ยอดขาย</font></th>
						<th width=70px><font color="#FFFFFF">% Growth</font></th>
					</tr>
					<tr>
						<td align=center>1</td>
						<td align=center>โลตัส บางใหญ่</td>
						<td align=right>500,000</td>
						<td align=right>600,000</td>
						<td align=right>100,000</td>
						<td align=right>10</td>
					</tr>
					<tr>
						<td align=center>2</td>
						<td align=center>วงศ์สว่าง</td>
						<td align=right>400,000</td>
						<td align=right>450,000</td>
						<td align=right>50,000</td>
						<td align=right>9</td>
					</tr>
					<tr>
						<td align=center>3</td>
						<td align=center>อาคารสินธร</td>
						<td align=right>300,000</td>
						<td align=right>320,000</td>
						<td align=right>20,000</td>
						<td align=right>9</td>
					</tr>
					<tr>
						<td align=center>4</td>
						<td align=center>โลตัส ประชาชื่น</td>
						<td align=right>200,000</td>
						<td align=right>210,000</td>
						<td align=right>10,000</td>
						<td align=right>7</td>
					</tr>
					<tr>
						<td align=center>5</td>
						<td align=center>โลตัสบางกะปิ</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>6</td>
					</tr>
					<tr>
						<td align=center>6</td>
						<td align=center>โลตัสสระบุรี</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>5</td>
					</tr>
					<tr>
						<td align=center>7</td>
						<td align=center>โลตัสลำลูกกา</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>5</td>
					</tr>
					<tr>
						<td align=center>8</td>
						<td align=center>โลตัสฟอร์จูน</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>4</td>
					</tr>
					<tr>
						<td align=center>9</td>
						<td align=center>โลตัสรามอินทรา</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>3</td>
					</tr>
					<tr>
						<td align=center>10</td>
						<td align=center>โลตัสภูเก็ต</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>3</td>
					</tr>
					</table><%if(b1.equals("0")) out.print("-->");%>
				</td><!-- Table of detail -->
			</tr>
			</table>

			<table id="tabs-t1r3_2">
			<tr><td colspan="2">
				<select name="salesday" onChange="getChart(this.value);">
					<option value="1"># of branch</option>
					<option value="2">% Change in Sales</option>
				</select>
				<input type="button" name="ok" value=" OK "/>
			</td></tr>
			<tr>
				<td id="g2"></td><!-- Chart -->
				<td><%if(b2.equals("0")) out.print("<!--");%>
					<table width="100%" bordercolor="#000000" frame="box" rules="all">
					<tr bgcolor="#CD853F">
						<th width=20px><font color="#FFFFFF">#</font></th>
						<th width=80px><font color="#FFFFFF">สาขา</font></th>
						<th width=150px><font color="#FFFFFF">ยอดขาย</font></th>
						<th width=150px><font color="#FFFFFF">Last ยอดขาย</font></th>
						<th width=150px><font color="#FFFFFF">Diff ยอดขาย</font></th>
						<th width=70px><font color="#FFFFFF">% Growth</font></th>
					</tr>
					<tr>
						<td align=center>1</td>
						<td align=center>โลตัส บางใหญ่</td>
						<td align=right>500,000</td>
						<td align=right>600,000</td>
						<td align=right>100,000</td>
						<td align=right>10</td>
					</tr>
					<tr>
						<td align=center>2</td>
						<td align=center>วงศ์สว่าง</td>
						<td align=right>400,000</td>
						<td align=right>450,000</td>
						<td align=right>50,000</td>
						<td align=right>9</td>
					</tr>
					<tr>
						<td align=center>3</td>
						<td align=center>อาคารสินธร</td>
						<td align=right>300,000</td>
						<td align=right>320,000</td>
						<td align=right>20,000</td>
						<td align=right>9</td>
					</tr>
					<tr>
						<td align=center>4</td>
						<td align=center>โลตัส ประชาชื่น</td>
						<td align=right>200,000</td>
						<td align=right>210,000</td>
						<td align=right>10,000</td>
						<td align=right>7</td>
					</tr>
					<tr>
						<td align=center>5</td>
						<td align=center>โลตัสบางกะปิ</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>6</td>
					</tr>
					<tr>
						<td align=center>6</td>
						<td align=center>โลตัสสระบุรี</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>5</td>
					</tr>
					<tr>
						<td align=center>7</td>
						<td align=center>โลตัสลำลูกกา</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>5</td>
					</tr>
					<tr>
						<td align=center>8</td>
						<td align=center>โลตัสฟอร์จูน</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>4</td>
					</tr>
					<tr>
						<td align=center>9</td>
						<td align=center>โลตัสรามอินทรา</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>3</td>
					</tr>
					<tr>
						<td align=center>10</td>
						<td align=center>โลตัสภูเก็ต</td>
						<td align=right>100,000</td>
						<td align=right>100,000</td>
						<td align=right>0</td>
						<td align=right>3</td>
					</tr>
					</table><%if(b2.equals("0")) out.print("-->");%>
				</td><!-- Table of detail -->
			</tr>
			</table>

		</td></tr>
	</table>

	<!---------------------------- Row 4 ------------------------>
	<table id="tabs-t1r4" width=1060>
		<tr><td align="center">
			<ul>
				<li><a href="#tabs-t1r4_1">Net Sales By Branch Status</a></li>
				<li><a href="#tabs-t1r4_2">Net Sales By Product Group</a></li>
			</ul>

			<table id="tabs-t1r4_1" width="100%">
				<tr><td id="g3"></td></tr>
			</table>

			<table id="tabs-t1r4_2" width="100%">
				<tr>
					<td align="center" id="gPG"></td>
					<td valign="top" align="center" width="100%"><p></p>
						<table width="350" height="220" bordercolor="#000000" frame="box" rules="all">
						<tr bgcolor="#CD853F"><th colspan=3><font color="#FFFFFF">Change</font></th></tr>
						<tr bgcolor="#CD853F">
							<th><font color="#FFFFFF">MB</font></th>
							<th><font color="#FFFFFF">vs.LY</font></th>
							<th><font color="#FFFFFF">vs.Plan</font></th>
						</tr>
						<!-- DATA -->
						<tr>
							<td align=right>+58.0</td>
							<td align=right>+8.05%</td>
							<td align=right><font color=red>-1.82%</font></td>
						</tr>
						<tr>
							<td align=right>+32.9</td>
							<td align=right>+7.98%</td>
							<td align=right>+2.10%</td>
						</tr>
						<tr>
							<td align=right>+1.8</td>
							<td align=right>+1.19%</td>
							<td align=right><font color=red>-2.82%</font></td>
						</tr>
						<tr>
							<td align=right>+15.8</td>
							<td align=right>+9.19%</td>
							<td align=right><font color=red>-3.82%</font></td>
						</tr>
						<tr>
							<td align=right>+13.8</td>
							<td align=right>+25.19%</td>
							<td align=right>+2.82%</td>
						</tr>
						<tr>
							<td align=right>+131.8</td>
							<td align=right>+8.19%</td>
							<td align=right><font color=red>-0.82%</font></td>
						</tr>
						<!-- End -->
						</table>
					</td>
				</tr>
			</table>
		</td></tr>
	</table>

<!-- -->
	</td></tr>
	</table>
<!--+++++++++++++++++++++++++ Tab Detail +++++++++++++++++++++++++-->
	<table id="tabs-t2">
	<tr><td>

		<table width=1060>
		<tr>
			<td id="tabs-t2r1c1" valign="top">
				<table width="450"><tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Profit and Loss</font></tr></table>
				<br>
				<table width="430" align="center" bordercolor="#000000" frame="box" rules="all">
				  <tr bgcolor="#CD853F">
					<th><font color="#FFFFFF">Profit and Loss</font></th>
					<th><font color="#FFFFFF">Actual MTD</font></th>
					<th><font color="#FFFFFF">Budget MTD</font></th>
					<th><font color="#FFFFFF">%of Budget</font></th>
					<th><font color="#FFFFFF">Prev. YTD</font></th>
					<th><font color="#FFFFFF">%of Prev YTD</font></th>
				  <tr>
				  <tr>
					<!--<td width="60" align="center"><span class="bar">5,6,2,5,3,5,6,9,9,7,8</span></td>-->
					<td>&nbsp;ยอดขายสุทธิ</td>
					<td align="right">21,007</td>
					<td align="right">20,424</td>
					<td align="right">103%</td>
					<td align="right">19,816</td>
					<td align="right">106%</td>
				  </tr>
				  <tr>
					<!--<td align="center"><span class="bar">7,8,7,5,6,5,6,9,9,7,8</span></td>-->
					<td>&nbsp;ต้นทุนสินค้า</td>
					<td align="right">8,984</td>
					<td align="right">8,375</td>
					<td align="right">104%</td>
					<td align="right">6,460</td>
					<td align="right">134%</td>
				  </tr>
				  <tr>
					<!--<td align="center"><span class="bar">4,3,6,5,2,5,6,2,5,3,4</span></td>-->
					<td>&nbsp;Gross Profit</td>
					<td align="right">12,323</td>
					<td align="right">12,050</td>
					<td align="right">102%</td>
					<td align="right">13,356</td>
					<td align="right">92%</td>
				  </tr>
				  <tr>
					<!--<td align="center"><span class="bar">7,8,7,5,6,8,6,5,6,7,8</span></td>-->
					<td>&nbsp;ค่าใช้จ่ายพนักงาน</td>
					<td align="right">8,041</td>
					<td align="right">8,666</td>
					<td align="right">93%</td>
					<td align="right">7,501</td>
					<td align="right">96%</td>
				  </tr>
				  <tr>
					<!--<td align="center"><span class="bar">7,8,7,5,9,9,7,8,6,5,6</span></td>-->
					<td>&nbsp;ค่าใช้จ่ายสถานที่</td>
					<td align="right">4,282</td>
					<td align="right">3,384</td>
					<td align="right">127%</td>
					<td align="right">4,994</td>
					<td align="right">86%</td>
				  </tr>
				  <tr>
					<!--<td align="center"><span class="bar">1,2,1,5,2,3,1,1,5,3,4</span></td>-->
					<td>&nbsp;ค่าใช้จ่ายอื่นๆ</td>
					<td align="right">203</td>
					<td align="right">151</td>
					<td align="right">135%</td>
					<td align="right">120</td>
					<td align="right">169%</td>
				  </tr>
				  <tr>
					<!--<td align="center"><span class="bar">2,8,3,2,6,1,2,9,9,7,2</span></td>-->
					<td>&nbsp;กำไรจากการดำเนินงาน</td>
					<td align="right">4,079</td>
					<td align="right">3,232</td>
					<td align="right">126%</td>
					<td align="right">4,873</td>
					<td align="right">84%</td>
				  </tr>
				  </table>
			</td>

			<td id="tabs-t2r1c2" width="600">
				<ul>
					<li><a href="#tabs-t2r1c2_1"> Net Sales </a></li>
					<li><a href="#tabs-t2r1c2_2"> Cost </a></li>
				 </ul>

				 <table id="tabs-t2r1c2_1">
					<tr>
						<td id="g4"></td>
						<td valign="top"><table width="300" bordercolor="#000000" frame="box" rules="all">
							<tr bgcolor="#CD853F">
								<th colspan="4"><font color="#FFFFFF">Change</font></th>
							</tr>
							<tr bgcolor="#CD853F">
								<th width="100"></th>
								<th><font color="#FFFFFF">MB</font></th>
								<th><font color="#FFFFFF">vs.LY</font></th>
								<th><font color="#FFFFFF">vs.Plan</font></th>
							</tr>
							<tr>
								<td>Bakery</td>
								<td align="right">58.0</td>
								<td align="right">8.05%</td>
								<td align="right">-1.82%</td>
							</tr>
							<tr>
								<td>Food</td>
								<td align="right">32.9</td>
								<td align="right">7.98%</td>
								<td align="right">2.10%</td>
							</tr>
							<tr>
								<td>Packaged Products(PP)</td>
								<td align="right">15.5</td>
								<td align="right">9.59%</td>
								<td align="right">-3.01%</td>
							</tr>
							<tr>
								<td>Outsource Products & Others(OPO)</td>
								<td align="right">13.7</td>
								<td align="right">25.69%</td>
								<td align="right">2.87%</td>
							</tr>
							<tr>
								<td>Beverage</td>
								<td align="right">1.8</td>
								<td align="right">1.19%</td>
								<td align="right">-2.80%</td>
							</tr>
							<tr>
								<td><b>Total</b></td>
								<td align="right"><b>121.5</b></td>
								<td align="right"><b>8.12%</b></td>
								<td align="right"><b>-0.84%</b></td>
							</tr>
						</table></td>
					</tr>
				 </table>

				 <table id="tabs-t2r1c2_2">
					<tr>
						<td id="g5"></td>
						<td valign="top"><table width="300" bordercolor="#000000" frame="box" rules="all">
							<tr bgcolor="#CD853F">
								<th colspan="4"><font color="#FFFFFF">Change</font></th>
							</tr>
							<tr bgcolor="#CD853F">
								<th width="100"></th>
								<th><font color="#FFFFFF">MB</font></th>
								<th><font color="#FFFFFF">vs.LY</font></th>
								<th><font color="#FFFFFF">vs.Plan</font></th>
							</tr>
							<tr>
								<td>Bakery</td>
								<td align="right">58.0</td>
								<td align="right">8.05%</td>
								<td align="right">-1.82%</td>
							</tr>
							<tr>
								<td>Food</td>
								<td align="right">32.9</td>
								<td align="right">7.98%</td>
								<td align="right">2.10%</td>
							</tr>
							<tr>
								<td>Packaged Products(PP)</td>
								<td align="right">15.5</td>
								<td align="right">9.59%</td>
								<td align="right">-3.01%</td>
							</tr>
							<tr>
								<td>Outsource Products & Others(OPO)</td>
								<td align="right">13.7</td>
								<td align="right">25.69%</td>
								<td align="right">2.87%</td>
							</tr>
							<tr>
								<td>Beverage</td>
								<td align="right">1.8</td>
								<td align="right">1.19%</td>
								<td align="right">-2.80%</td>
							</tr>
							<tr>
								<td><b>Total</b></td>
								<td align="right"><b>121.5</b></td>
								<td align="right"><b>8.12%</b></td>
								<td align="right"><b>-0.84%</b></td>
							</tr>
						</table></td>
					</tr>
				 </table>

			</td>
		</tr>
		</table>

		<table id="tabs-t2r2" width="1060">
			<tr bgcolor="#8B4513">
				<th colspan="2"><font color="#FFE742" size="3"> Sales Trend </font></th>
			</tr>
			<tr>
				<td width="150" valign="top"><table id="param1" width="100%">
					<tr bgcolor="#CD853F"><th><font color="#FFFFFF">หมวดสินค้า</font></tr>
					<tr><td>
					<select name="param" MULTIPLE size="3"  style="width:150px;">
						<option value="1">&nbsp;เบเกอรี่</option>
						<option value="2">&nbsp;อาหาร</option>
						<option value="3">&nbsp;เครื่องดื่ม</option>
					</select>
					</td></tr>
					
					<tr bgcolor="#CD853F"><th><font color="#FFFFFF">กลุ่มสินค้า</font></tr>
					<tr><td>
					<select name="param" MULTIPLE size="6"  style="width:150px;">
						<option value="1">&nbsp;เค้ก</option>
						<option value="2">&nbsp;คุ๊กกี้</option>
						<option value="3">&nbsp;ขนมปัง</option>
						<option value="4">&nbsp;อาหารไทย</option>
						<option value="5">&nbsp;อาหารชุด</option>
						<option value="6">&nbsp;อาหารญี่ปุ่น</option>
						<option value="7">&nbsp;บลูคัพ</option>
						<option value="8">&nbsp;เบียร์</option>
						<option value="9">&nbsp;ไอศครีม</option>
					</select>
					</td></tr>

					<!--<tr bgcolor="#CD853F"><th><font color="#FFFFFF">สินค้า</font></tr>
					<tr><td>
					<select name="param" MULTIPLE size="6"  style="width:150px;">
						<option value="1">&nbsp;บัทเทอร์เค้กซอง</option>
						<option value="2">&nbsp;บลูเบอรี่ครีมชีสพาย</option>
						<option value="3">&nbsp;พิซซ่าหน้าแฮมไส้กรอก</option>
						<option value="4">&nbsp;ข้าวกล้องผัดหมูเค็ม-ส้มตำ</option>
						<option value="5">&nbsp;ข้าวกล้องไก่อบ S&P</option>
						<option value="6">&nbsp;เส้นบุกผัดไทยกุ้งสด</option>
					</select>
					</td></tr>-->

					<tr><td align="right"><input type="submit" name="ok" value=" OK "/></td></tr>
				</table></td>
				
				<td id="chart1"><div id="g6"></div></td>
			</tr>
		</table>

		<table width="1060">
		<tr>
			<td id="tabs-t2r3c1">
				<table width="520">
					<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Sales by Sales Type</font></th></tr>
					<tr><td id="g7"></td></tr>
				</table>
			</td>
			
			<td id="tabs-t2r3c2">
				<table width="520">
					<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3">Discount</font></th></tr>
					<tr><td align="center" id="g8"></td></tr>
				</table>
			</td>
		</tr>
		</table>

		<table width="1060">
		<tr>
			<td id="tabs-t2r4c1" width="530">
			<ul>
				<li><a href="#tabsG-1"> Average Check </a></li>
				<li><a href="#tabsG-2"> Customers/Day </a></li>
				<li><a href="#tabsG-3"> Average Sales/Bill </a></li>
			</ul>

			<div id="tabsG-1"><div align="center" id="g9"></div></div>
			<div id="tabsG-2"><div align="center" id="g10"></div></div>
			<div id="tabsG-3"><div align="center" id="g11"></div></div>
			</td>

			<td id="tabs-t2r4c2" width="530">
			<ul>
				<li><a href="#tabsGET-1"> Sales/Sqm/Day </a></li>
				<li><a href="#tabsGET-2"> Sales/Staff/Day </a></li>
				<li><a href="#tabsGET-3"> Seat Turn/Day </a></li>
			</ul>

			<div id="tabsGET-1"><div align="center" id="g12"></div></div>
			<div id="tabsGET-2"><div align="center" id="g13"></div></div>
			<div id="tabsGET-3"><div align="center" id="g14"></div></div>
			</td>
		</tr>
		</table>

		<table width="1060">
		<tr>
			<td id="tabs-t2r5c1"><table width="520">
				<tr bgcolor="#8B4513"><th><font color="#FFE742">Selling Product</font></th></tr>
				<tr><td>
					<div class="top">
						<select name="s">
							<option>ยอดขายสูงสุด</option>
							<option>ยอดขายต่ำสุด</option>
						</select>
						 <input type="text" name="size" value="10" size="1">
						 <input type="submit" name="ok" value=" OK "/>
					</div>
					<br>
					<table width="500" align="center" bordercolor="#000000" frame="box" rules="all">
					<tr bgcolor="#CD853F">
						<th width=200><font color="#FFFFFF">Product</font></th>
						<th><font color="#FFFFFF">ยอดขายปีนี้</font></th>
						<th><font color="#FFFFFF">ยอดขายปีที่แล้ว</font></th>
						<th><font color="#FFFFFF">%เทียบปีที่แล้ว</font></th>
						<th><font color="#FFFFFF">%เทียบยอดขายทั้งหมด</font></th>
					</tr>
					<tr>
						<td>เกี๊ยวกุ้งเซี่ยงไฮ้ </td>
						<td align="right">2,374,691</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">11.90%</td>
					</tr>
					<tr>
						<td>ไก่ย่างโอชา</td>
						<td align="right">2,124,000</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">10.20%</td>
					</tr>
					<tr>
						<td>หมี่กรอบ</td>
						<td align="right">1,950,321</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">9.50%</td>
					</tr>
					<tr>
						<td>ยำไส้กรอกแฟรงเฟอร์เตอร์</td>
						<td align="right">1,912,000</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">9.10%</td>
					</tr>
					<tr>
						<td>ขนมจีบไข่กุ้ง</td>
						<td align="right">1,374,691</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">7.82%</td>
					</tr>
					<tr>
						<td>แกงส้มชะอมกุ้งสด</td>
						<td align="right">1,091,100</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">5.03%</td>
					</tr>
					<tr>
						<td>ต้มยำกุ้งแม่น้ำ</td>
						<td align="right">974,691</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">3.97%</td>
					</tr>
					<tr>
						<td>น้ำพริกปูผักจิ้ม-แซลมอนแดดเดียว</td>
						<td align="right">923,125</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">3.36%</td>
					</tr>
					<tr>
						<td>ซี่โครงหมูทอดกระเทียมพริกไทย</td>
						<td align="right">874,411</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">2.45%</td>
					</tr>
					<tr>
						<td>กุ้งแม่น้ำทอดกระเทียมพริกไทย</td>
						<td align="right">795,691</td>
						<td align="right">2,374,691</td>
						<td align="right">11.90%</td>
						<td align="right">2.00%</td>
					</tr>
					</table>
				</td></tr>
			</table></td>

			<td id="tabs-t2r5c2"><table width="520">
				<tr bgcolor="#8B4513"><th><font color="#FFE742">New Product</font></th></tr>
				<tr><td>
				<div class="top">
					<select name="s">
						<option>ยอดขายสูงสุด</option>
						<option>ยอดขายต่ำสุด</option>
					</select>
					 <input type="text" name="size" value="10" size="1">
					 <input type="submit" name="ok" value=" OK "/>
				</div>
				<br>
				<table width="500" align="center" bordercolor="#000000" frame="box" rules="all" bgcolor="#FFFFFF">
				<tr bgcolor="#CD853F">
					<th width=200><font color="#FFFFFF">Product</font></th>
					<th><font color="#FFFFFF">ยอดขาย</font></th>
					<th><font color="#FFFFFF">เป้าหมาย</font></th>
					<th><font color="#FFFFFF">%เทียบเป้าหมาย</font></th>
					<th><font color="#FFFFFF">%เทียบยอดขายทั้งหมด</font></th>
				</tr>
				<tr>
					<td>เกี๊ยวกุ้งเซี่ยงไฮ้ </td>
					<td align="right">2,374,691</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">11.90%</td>
				</tr>
				<tr>
					<td>ไก่ย่างโอชา</td>
					<td align="right">2,124,000</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">10.20%</td>
				</tr>
				<tr>
					<td>หมี่กรอบ</td>
					<td align="right">1,950,321</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">9.50%</td>
				</tr>
				<tr>
					<td>ยำไส้กรอกแฟรงเฟอร์เตอร์</td>
					<td align="right">1,912,000</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">9.10%</td>
				</tr>
				<tr>
					<td>ขนมจีบไข่กุ้ง</td>
					<td align="right">1,374,691</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">7.82%</td>
				</tr>
				<tr>
					<td>แกงส้มชะอมกุ้งสด</td>
					<td align="right">1,091,100</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">5.03%</td>
				</tr>
				<tr>
					<td>ต้มยำกุ้งแม่น้ำ</td>
					<td align="right">974,691</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">3.97%</td>
				</tr>
				<tr>
					<td>น้ำพริกปูผักจิ้ม-แซลมอนแดดเดียว</td>
					<td align="right">923,125</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">3.36%</td>
				</tr>
				<tr>
					<td>ซี่โครงหมูทอดกระเทียมพริกไทย</td>
					<td align="right">874,411</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">2.45%</td>
				</tr>
				<tr>
					<td>กุ้งแม่น้ำทอดกระเทียมพริกไทย</td>
					<td align="right">795,691</td>
					<td align="right">2,374,691</td>
					<td align="right">11.90%</td>
					<td align="right">2.00%</td>
				</tr>
				</table>
				</td></tr>
			</table></td>
		</tr>
		</table>

	</td></tr>
	</table>

<!--+++++++++++++++++++++++++ Tab Map +++++++++++++++++++++++++-->
	<table id="tabs-t3">
	<tr><td>
		<table id="tabs-t3r1">
		<tr><td>
			<table width=1060 align=center border=0>
			<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">Region Growth</font></th></tr>
			<tr>
				<td width=400 align=center><img src='<%=request.getContextPath()%>/Dashboard/images/thailand.png'></td>
				<td  valign=middle>
				<table bordercolor="#000000" frame="box" rules="all" width=100%>
				<tr bgcolor="#CD853F">
					<th rowspan=2 align=center><font color="#FFFFFF">ภาค</font></th>
					<th align=center colspan=2><font color="#FFFFFF">ยอดขาย</font></th>
					<th rowspan=2><font color="#FFFFFF">%Growth</font></th>
				</tr>	
				<tr bgcolor="#CD853F">
					<th align=center><font color="#FFFFFF">Dec 53</font></th>
					<th align=center><font color="#FFFFFF">Dec 54</font></th>
				</tr>	
				<tr>
					<td align=center>เหนือ</td>
					<td align=center>100,000 </td>
					<td align=center>200,000 </td>
					<td align=center>-10%</td>
				</tr>	
				<tr>
					<td align=center>ภาคตะวันออกเฉียงเหนือ</td>
					<td align=center>200,000 </td>
					<td align=center>300,000 </td>
					<td align=center>-10%</td>
				</tr>	
				<tr>
					<td align=center>ภาคตะวันออก</td>
					<td align=center>200,000 </td>
					<td align=center>300,000 </td>
					<td align=center>10%</td>
				</tr>	
				<tr>
					<td align=center>ภาคตะวันตก</td>
					<td align=center>200,000 </td>
					<td align=center>300,000 </td>
					<td align=center>-10%</td>
				</tr>	
				<tr>
					<td align=center>กลาง</td>
					<td align=center>300,000 </td>
					<td align=center>200,000 </td>
					<td align=center>10%</td>
				</tr>	
				<tr>
					<td align=center>ใต้</td>
					<td align=center>400,000 </td>
					<td align=center>200,000 </td>
					<td align=center>10%</td>
				</tr>	
				</table>

			</td></tr>

			<tr bgcolor="#8B4513"><th colspan="2"><font color="#FFE742" size="3">Google Map</font></th></tr>
			<tr><td colspan="2" align="center"><br><img src='<%=request.getContextPath()%>/Dashboard/images/SnPGoogleMap.jpg'></td></tr>
			</table>

		</td></tr>
		</table>

	</td></tr>
	</table>

</div>
</body>
</html>