<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Finance Dashboard Page</title>

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
			$("#tabs-ratio").tabs();
			$("#tabs-ratio1").tabs();
			$("#tabs-table2").tabs();
			$("#tabs-table3").tabs();
			$("#tabs-table4").tabs();
			$("#tabs-table5").tabs();

			$("#tabs-t1r3").tabs();

			$("#tabs-t2r3").tabs();
			
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

		#tabs { position:absolute; width:1325px; top:60px; left:5px; height:1185px; }
		#tabs-ratio { position:absolute; left:3px; top:45px; width:100px; }
		#tabs-ratio1 { position:absolute; left:3px; top:45px; width:100px; }
	</style>	

<!-- Get Parameter -->
<%
	String y = request.getParameter("y"); // Value of Year Parameter.
	String months = request.getParameter("months"); // Value of Month Parameter.
	String sb = request.getParameter("sb"); // Value of Summary By Parameter.
	String month = ""; // Name of month (Jan -> Dec)

	switch(Integer.parseInt(months))
	{
		case 1 : month = "Jan";
			break;

		case 2 : month = "Feb";
			break;

		case 3 : month = "Mar";
			break;

		case 4 : month = "Apr";
			break;

		case 5 : month = "May";
			break;

		case 6 : month = "Jun";
			break;

		case 7 : month = "Jul";
			break;

		case 8 : month = "Aug";
			break;

		case 9 : month = "Sep";
			break;

		case 10 : month = "Oct";
			break;

		case 11 : month = "Nov";
			break;

		case 12 : month = "Dec";
			break;
	}

	String salesP = "";
	String countryP = "";

	String t1 = request.getParameter("t1"); // Value of Pie Chart(Sales) in Tab Local.
	String t2 = request.getParameter("t2"); // Value of Pie Chart(Sales) in Tab Foreign.

	String bar1 = request.getParameter("bar1"); // Data of Bar Chart1 in Tab Local.
	String bar2 = request.getParameter("bar2"); // Data of Bar Chart2 in Tab Local.
	String bar2F = request.getParameter("bar2F"); // Data of Bar Chart2 in Tab Foreign.
	String bar3 = request.getParameter("bar3"); // Data of Bar Chart3 in Tab Local.
	String bar3F = request.getParameter("bar3F"); // Data of Bar Chart3 in Tab Foreign.

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
	String b1 = "";
	if(bar1.equals("0"))
	{
		b1 = "{\"values\" : [50,100],\"text\" : \"Budget\",\"tooltip-text\" : \"%t: %v\"},"+
				"{\"values\" : [100,200],\"url\" : \""+request.getContextPath()+"/Dashboard/Finance.jsp?bar1=1&bar2="+bar2+"&bar2F="+bar2F+"&bar3="+bar3+"&bar3F="+bar3F+"&y="+y+"&months="+months+"&sb="+sb+"&t1="+t1+"&t2="+t2+"\",\"text\" : \"ยอดขาย\"	},"+
				"{\"values\" : [20,40],\"background-color\":\"#FFFF66\",\"text\" : \"กำไรขั้นต้น\"},"+
				"{\"values\" : [30,60],\"text\" : \"กำไรดำเนินงาน\"},"+
				"{\"values\" : [50,100],\"text\" : \"กำไรสุทธิ\"}";
	}else{
		b1 = "{\"values\" : [30,60],\"text\" : \"เบอเกอรี่\"},"+
				"{\"values\" : [25,50],\"text\" : \"อาหาร\"},"+
				"{\"values\" : [45,90],\"text\" : \"เครื่องดื่ม\"}";
	}

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------	
	String b2 = "{\"type\":\"bar\",\"values\":[54.27,43.74,54.27],\"background-color\":\"deepskyblue\",\"text\":\"ค่าใช้จ่ายการขายและบริหาร\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,29.85,32.88],\"background-color\":\"goldenrod\",\"text\":\"ต้นทุนขาย\"}";

	/*if(bar2.equals("0"))
	{
		b2 = "{\"type\":\"bar\",\"values\":[54.27,43.74,54.27],\"background-color\":\"deepskyblue\",\"url\" : \""+request.getContextPath()+"/Dashboard/Finance.jsp?bar2=1&bar2F="+bar2F+"&bar1="+bar1+"&bar3="+bar3+"&bar3F="+bar3F+"&y="+y+"&m="+m+"&sb="+sb+"&t1="+t1+"&t2="+t2+"\",\"text\":\"ค่าใช้จ่ายการขายและบริหาร\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,29.85,32.88],\"background-color\":\"goldenrod\",\"url\" : \""+request.getContextPath()+"/Dashboard/Finance.jsp?bar2=1&bar2F="+bar2F+"&bar1="+bar1+"&bar3="+bar3+"&bar3F="+bar3F+"&y="+y+"&m="+m+"&sb="+sb+"&t1="+t1+"&t2="+t2+"\",\"text\":\"ต้นทุนขาย\"}";
	}else{
		b2 = "{\"type\":\"bar\",\"values\":[74.27,63.74,74.27],\"text\":\"ต้นทุนขายเบเกอรี่\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,63.74,74.27],\"text\":\"ต้นทุนเครื่องดื่มขนมหวานไอศครีม\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,63.74,74.27],\"text\":\"ต้นทุนอาหาร\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,63.74,74.27],\"text\":\"ต้นทุนผลิตภัณฑ์ลาดกระบัง\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,63.74,74.27],\"text\":\"ต้นทุนผลิตภัณฑ์อื่น ๆ\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,29.85,32.88],\"text\":\"ต้นทุนสินค้าจุดขาย\"}";
	}*/	

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------	
	String b2F = b2F = "{\"type\":\"bar\",\"values\":[54.27,43.74,54.27],\"background-color\":\"deepskyblue\",\"text\":\"ค่าใช้จ่ายการขายและบริหาร\"},"+
			"{\"type\":\"bar\",\"values\":[32.88,29.85,32.88],\"background-color\":\"goldenrod\",\"text\":\"ต้นทุนขาย\"}";

	/*if(bar2F.equals("0"))
	{
		b2F = "{\"type\":\"bar\",\"values\":[54.27,43.74,54.27],\"background-color\":\"deepskyblue\",\"url\" : \""+request.getContextPath()+"/Dashboard/Finance.jsp?bar2F=1&bar2="+bar2+"&bar1="+bar1+"&bar3="+bar3+"&bar3F="+bar3F+"&y="+y+"&m="+m+"&sb="+sb+"&t1="+t1+"&t2="+t2+"#tabs-2\",\"text\":\"ค่าใช้จ่ายการขายและบริหาร\"},"+
			"{\"type\":\"bar\",\"values\":[32.88,29.85,32.88],\"background-color\":\"goldenrod\",\"url\" : \""+request.getContextPath()+"/Dashboard/Finance.jsp?bar2F=1&bar2="+bar2+"&bar1="+bar1+"&bar3="+bar3+"&bar3F="+bar3F+"&y="+y+"&m="+m+"&sb="+sb+"&t1="+t1+"&t2="+t2+"#tabs-2\",\"text\":\"ต้นทุนขาย\"}";
	}else{
		b2F = "{\"type\":\"bar\",\"values\":[74.27,63.74,74.27],\"text\":\"ต้นทุนขายเบเกอรี่\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,63.74,74.27],\"text\":\"ต้นทุนอาหาร\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,63.74,74.27],\"text\":\"ต้นทุนเครื่องดื่มขนมหวาน<br>ไอศครีม\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,63.74,74.27],\"text\":\"ต้นทุนผลิตภัณฑ์ลาดกระบัง\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,63.74,74.27],\"text\":\"ต้นทุนผลิตภัณฑ์อื่น ๆ\"},"+
				"{\"type\":\"bar\",\"values\":[32.88,29.85,32.88],\"text\":\"ต้นทุนสินค้าจุดขาย\"}";
	}*/

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------	
	String b3 = "";
	if(bar3.equals("0"))
	{
		b3 = "{\"values\" : [78.29,,],\"text\" : \"Last Year\",\"background-color\":\"#66CC00\"},"+
				"{\"values\" : [,63.78,],\"text\" : \"Actual\",\"background-color\":\"#EEEE00\"},"+
				"{\"values\" : [,,82.37],\"text\" : \"Budget\",\"background-color\":\"#696969\"}";
		salesP = " ";
	}else{
		b3 = "{\"values\" : [22.37,,],\"text\" : \"Last Year\",\"background-color\":\"#66CC00\"},"+
				"{\"values\" : [,18.29,],\"text\" : \"Actual\",\"background-color\":\"#EEEE00\"},"+
				"{\"values\" : [,,13.78],\"text\" : \"Budget\",\"background-color\":\"#696969\"}";
		salesP = " : " + t1;
	}

	String b3F = "";
	if(bar3F.equals("0"))
	{
		b3F = "{\"values\" : [78.29,,],\"text\" : \"Last Year\",\"background-color\":\"#66CC00\"},"+
				"{\"values\" : [,63.78,],\"text\" : \"Actual\",\"background-color\":\"#EEEE00\"},"+
				"{\"values\" : [,,82.37],\"text\" : \"Budget\",\"background-color\":\"#696969\"}";
		countryP = " ";
	}else{
		b3F = "{\"values\" : [22.37,,],\"text\" : \"Last Year\",\"background-color\":\"#66CC00\"},"+
				"{\"values\" : [,18.29,],\"text\" : \"Actual\",\"background-color\":\"#EEEE00\"},"+
				"{\"values\" : [,,13.78],\"text\" : \"Budget\",\"background-color\":\"#696969\"}";
		countryP = " : " + t2;
	}
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

		var urlP = '<%=request.getContextPath()%>/Dashboard/Finance.jsp'; // URL Page.
		var sb = <%=sb%>;
		function getSumBy(value)
		{
			sb = value;
			switch(sb){
				case '6' : urlP = '<%=request.getContextPath()%>/Dashboard/FinanceYTD.jsp';
					break;
				case '7' : urlP = '<%=request.getContextPath()%>/Dashboard/FinanceMTD.jsp';
					break;
			}
		}

		function goUrl()
		{
			location.href = urlP+'?y='+y+'&months='+months+'&sb='+sb+'&country=1&bar1=0&bar2=0&bar2F=0&bar3=0&bar3F=0&t1=0&t2=0';
		}
	</script>

	<script type="text/javascript">

	var bar01 = 
	{
	"graphset" : [
		{
			"type" : "bar",
			"background-color":"#FFFFFF",
			"chart" : {
				"margin" : "10 20 30 50"
			},
			"scale-x" : {
				"values" : ["Actual","Last Year","Budget"],
				"guide":{
    				"line-width": 1,
    				"alpha": 1
    			},
				"tick":{
					"line-width": 3
				}
			},
			"scale-y" : {
				"guide":{
    				"line-width": 1,
    				"alpha": 1
    			},
				"tick":{
					"line-width": 3
				}
			},
			"series" : [
				<%out.print(b1);%>
			]
		}
	]
};

	var bar0 = {
	"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart" : {
				"margin" : "20 20 30 50"
			},
			"stacked":"1",
			"plot":{
				"bars-space-left":"25%",
				"bars-space-right":"25%",
				"bar-width":"25px"
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
			"series" : [
			{
				"type":"bar",
				"values":[54.27,43.74,54.27],
				"background-color":"deepskyblue",
				"text":"ค่าใช้จ่ายการขายและบริหาร"
			},
			{
				"type":"bar",
				"values":[32.88,29.85,32.88],
				"background-color":"goldenrod",
				"text":"ต้นทุนขาย"
			}
			]
		}
	]
};

	var bar02 = 
	{
	"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart" : {
				"margin" : "20 20 30 50"
			},
			"stacked":"1",
			"plot":{
				"bars-space-left":"25%",
				"bars-space-right":"25%",
				"bar-width":"25px"
			},
			/*"legend" : {
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"layout" : "x2",
				"width" : 287,
				"x" : 0,
				"y": 250
			},*/
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
			"series" : [
				<%out.print(b2);%>
			]
		}
	]
};

	var pie01 = 
	{
	"graphset" : [
	{
		"type" : "pie",
		"background-color":"#FFFFFF",
		"chart" : {
			"margin" : "0 0 45 0",
			"padding-top":"0px"
		},
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "2x",
			"x": 10,
			"y": 265,
			"width": 400
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
			},
			"url" : "<%=request.getContextPath()%>/Dashboard/Finance.jsp?bar3=1&bar3F=<%=bar3F%>&bar1=<%=bar1%>&bar2=<%=bar2%>&bar2F=<%=bar2F%>&y=<%=y%>&months=<%=months%>&sb=<%=sb%>&t1=%t&t2=0"
		},
		"series" : [
		{
			"text": "Restaurant",
			"values" : [17.42],
			"tooltip-text" : "%t: 273,950"
		},
		{
			"text": "Bakery Shop",
			"values" : [21.49],
			"tooltip-text" : "%t: 312,060"
		},
		{
			"text": "Specialty",
			"values": [15.35],
			"tooltip-text" : "%t: 259,923"
		},
		{
			"text": "Trading",
			"values": [22.75],
			"tooltip-text" : "%t: 365,034"
		},
		{
			"text": "Caterman",
			"values": [12.67],
			"tooltip-text" : "%t: 212,355"
		},
		{
			"text": "Other",
			"values": [10.32],
			"tooltip-text" : "%t: 152,716"
		}
		] 
	}]
};

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
				"bar-width":"25px"
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
				"format" : "%v%",
				"guide":{
    				"line-width": 1,
    				"alpha": 1
    			},
				"tick":{
					"line-width": 3
				}
			},
			"series" : [
				<%out.print(b3);%>
			]
		}
	]
};


//--------- In Tab 2

	var bar17 = 
	{
	"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart" : {
				"margin" : "20 20 30 50"
			},
			"stacked":"1",
			"plot":{
				"bars-space-left":"25%",
				"bars-space-right":"25%",
				"bar-width":"25px"
			},
			/*"legend" : {
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"layout" : "x2",
				"width" : 287,
				"x" : 0,
				"y": 250
			},*/
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
			"series" : [
				<%out.print(b2F);%>
			]
		}
	]
};

	var pie02 = 
	{
	"graphset" : [
	{
		"type" : "pie",
		"background-color":"#FFFFFF",
		"chart" : {
			"margin" : "0 0 45 0",
			"padding-top":"0px"
		},
		"legend" : {
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "2x",
			"x": 10,
			"y": 265,
			"width": 400
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
			},
			"url" : "<%=request.getContextPath()%>/Dashboard/Finance.jsp?bar3F=1&bar3=<%=bar3%>&bar1=<%=bar1%>&bar2=<%=bar2%>&bar2F=<%=bar2F%>&y=<%=y%>&months=<%=months%>&sb=<%=sb%>&t1=<%=t1%>&t2=%t#tabs-2"
		},
		"series" : [
		{
			"text": "อังกฤษ",
			"values" : [17.42],
			"tooltip-text" : "%t: 273,950"
		},
		{
			"text": "สวิตเซอร์แลนด์",
			"values" : [21.49],
			"tooltip-text" : "%t: 312,060"
		},
		{
			"text": "สิงคโปร์",
			"values": [15.35],
			"tooltip-text" : "%t: 259,923"
		},
		{
			"text": "ไต้หวัน",
			"values": [22.75],
			"tooltip-text" : "%t: 365,034"
		},
		{
			"text": "จีน",
			"values": [12.67],
			"tooltip-text" : "%t: 212,355"
		},
		{
			"text": "ฟิลิปปินส์",
			"values": [10.32],
			"tooltip-text" : "%t: 152,716"
		}
		] 
	}]
};
	
	var bar18 = 
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
				"bar-width":"25px"
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
				"format" : "%v%",
				"guide":{
    				"line-width": 1,
    				"alpha": 1
    			},
				"tick":{
					"line-width": 3
				}
			},
			"series" : [
				<%out.print(b3F);%>
			]
		}
	]
};
			/*"series" : [
				{
					"values" : [5530,,],
					"text" : "Actual",
					"background-color" : "#FFFF00"
				},
				{
					"values" : [,6473,],
					"text" : "Last Year",
					"background-color" : "#228B22"
				},
				{
					"values" : [,,7839],
					"text" : "Budget",
					"background-color" : "#7F7F7F"
				}
			]*/

	var mixSales = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"25 25 35 50"
			},
			"labels" : [
				{
					"text" : "-2.31%",
					"hook" : "node:plot=1,index=0",
					"background-color":"red",
					"color": "white",
					"border-width":5, 
					"border-color":"red",
					"bold": true
				},
				{
					"text" : "12.79%",
					"hook" : "node:plot=2,index=0",
					"background-color":"blue",
					"color": "white",
					"border-width":5, 
					"border-color":"blue",
					"bold": true
				},
				{
					"text" : "ล้าน (บาท)",
					"bold":true,
					"x": "15",
					"y": "0"
				}
			],
			"plot":{
				"tooltip-text":"%v",
				"bars-space-left":"15%",
				"bars-space-right":"15%"
			},
			"scale-x":{
				"values":["ยอดขาย"],
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
				"min-value" : 0,
				"format":"%v",
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
				{
					"type" : "bar",
					"values" : ["390"],
					"text":"Actual",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : ["350"],
					"text":"Last Year",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : ["400"],
					"text": "Budget",
					"background-color":"#696969"
				}
			]
		}
	]
};

	var mixCost = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"25 5 31 40"
			},
			"labels" : [
				{
					"text" : "-3.42%",
					"hook" : "node:plot=1,index=0",
					"background-color":"red",
					"color": "white",
					"border-width":5, 
					"border-color":"red",
					"bold": true
				},
				{
					"text" : "6.64%",
					"hook" : "node:plot=2,index=0",
					"background-color":"blue",
					"color": "white",
					"border-width":5, 
					"border-color":"blue",
					"bold": true
				},
				{
					"text" : "ล้าน (บาท)",
					"bold":true,
					"x": "5",
					"y": "0"
				}
			],
			"plot":{
				"tooltip-text":"%v",
				"bars-space-left":"15%",
				"bars-space-right":"15%"
			},
			"scale-x":{
				"values":[" "],
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
				"min-value" : 0,
				"format":"%v",
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
				{
					"type" : "bar",
					"values" : [180],
					"text":"Actual",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [170],
					"text":"Last Year",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [180],
					"text": "Budget",
					"background-color":"#696969"
				}
			]
		}
	]
};

	var mixProfit1 = {
		//"layout" : "1x3",
		"graphset" : [
			{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"25 25 30 50"
			},
			"labels" : [
				{
					"text" : "-4.30%",
					"hook" : "node:plot=1,index=0",
					"background-color":"red",
					"color": "white",
					"border-width":5, 
					"border-color":"red",
					"bold": true
				},
				{
					"text" : "17.62%",
					"hook" : "node:plot=2,index=0",
					"background-color":"blue",
					"color": "white",
					"border-width":5, 
					"border-color":"blue",
					"bold": true
				},
				{
					"text" : "ล้าน (บาท)",
					"bold":true,
					"x": "5",
					"y": "0"
				}
			],
			"plot":{
				"tooltip-text":"%v",
				"bars-space-left":"15%",
				"bars-space-right":"15%"
			},
			"scale-x":{
				"values":["กำไรขั้นต้น"],
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
				"min-value" : 0,
				"format":"%v",
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
				{
					"type" : "bar",
					"values" : [190],
					"text":"Actual",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [160],
					"text":"Last Year",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [200],
					"text": "Budget",
					"background-color":"#696969"
				}
			]
		}
	]
};
		var mixProfit2 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"25 25 30 50"
			},
			"labels" : [
				{
					"text" : "-4.02%",
					"hook" : "node:plot=1,index=0",
					"background-color":"red",
					"color": "white",
					"border-width":5, 
					"border-color":"red",
					"bold": true
				},
				{
					"text" : "28.80%",
					"hook" : "node:plot=2,index=0",
					"background-color":"blue",
					"color": "white",
					"border-width":5, 
					"border-color":"blue",
					"bold": true
				},
				{
					"text" : "ล้าน (บาท)",
					"bold":true,
					"x": "5",
					"y": "0"
				}
			],
			"plot":{
				"tooltip-text":"%v",
				"bars-space-left":"15%",
				"bars-space-right":"15%"
			},
			"scale-x":{
				"values":["กำไรจากการดำเนินงาน"],
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
				"min-value" : 0,
				"format":"%v",
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
				{
					"type" : "bar",
					"values" : [70],
					"text":"Actual",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [60],
					"text":"Last Year",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [80],
					"text": "Budget",
					"background-color":"#696969"
				}
			]
		}
	]
};
		var mixProfit3 = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"25 25 30 50"
			},
			"labels" : [
				{
					"text" : "-14.06%",
					"hook" : "node:plot=1,index=0",
					"background-color":"red",
					"color": "white",
					"border-width":5, 
					"border-color":"red",
					"bold": true
				},
				{
					"text" : "34.20%",
					"hook" : "node:plot=2,index=0",
					"background-color":"blue",
					"color": "white",
					"border-width":5, 
					"border-color":"blue",
					"bold": true
				},
				{
					"text" : "ล้าน (บาท)",
					"bold":true,
					"x": "5",
					"y": "0"
				}
			],
			"plot":{
				"tooltip-text":"%v",
				"bars-space-left":"15%",
				"bars-space-right":"15%"
			},
			"scale-x":{
				"values":["กำไรสุทธิ"],
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
				"min-value" : 0,
				"format":"%v",
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
				{
					"type" : "bar",
					"values" : [30],
					"text":"Actual",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [30],
					"text":"Last Year",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [40],
					"text": "Budget",
					"background-color":"#696969"
				}
			]
		}
	]
};

//----------------RESTAURANT--------------------------------------
	var mixSalesRest = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"25 25 35 50"
			},
			"labels" : [
				{
					"text" : "-3.91%",
					"hook" : "node:plot=1,index=0",
					"background-color":"red",
					"color": "white",
					"border-width":5, 
					"border-color":"red",
					"bold": true
				},
				{
					"text" : "6.05%",
					"hook" : "node:plot=2,index=0",
					"background-color":"blue",
					"color": "white",
					"border-width":5, 
					"border-color":"blue",
					"bold": true
				},
				{
					"text" : "ล้าน (บาท)",
					"bold":true,
					"x": "5",
					"y": "0"
				}
			],
			"plot":{
				"tooltip-text":"%v",
				"bars-space-left":"15%",
				"bars-space-right":"15%"
			},
			"scale-x":{
				"values":["ยอดขาย"],
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
				"min-value" : 0,
				"format":"%v",
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
				{
					"type" : "bar",
					"values" : [200],
					"text":"Actual",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [180],
					"text":"Last Year",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [200],
					"text": "Budget",
					"background-color":"#696969"
				}
			]
		}
	]
};

	var mixCostRest = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"25 25 31 50"
			},
			"labels" : [
				{
					"text" : "-2.88%",
					"hook" : "node:plot=1,index=0",
					"background-color":"red",
					"color": "white",
					"border-width":5, 
					"border-color":"red",
					"bold": true
				},
				{
					"text" : "4.20%",
					"hook" : "node:plot=2,index=0",
					"background-color":"blue",
					"color": "white",
					"border-width":5, 
					"border-color":"blue",
					"bold": true
				},
				{
					"text" : "ล้าน (บาท)",
					"bold":true,
					"x": "5",
					"y": "0"
				}
			],
			"plot":{
				"tooltip-text":"%v",
				"bars-space-left":"15%",
				"bars-space-right":"15%"
			},
			"scale-x":{
				"values":[" "],
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
				"min-value" : 0,
				"format":"%v",
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
				{
					"type" : "bar",
					"values" : [90],
					"text":"Actual",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [80],
					"text":"Last Year",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [90],
					"text": "Budget",
					"background-color":"#696969"
				}
			]
		}
	]
};

//----------------BAKERY--------------------------------------
	var mixSalesBak = {
		"graphset" : [
		{
			"type" : "mixed",
			"background-color":"#FFFFFF",
			"chart":{
				"margin":"25 25 35 50"
			},
			"labels" : [
				{
					"text" : "-0.14%",
					"hook" : "node:plot=1,index=0",
					"background-color":"red",
					"color": "white",
					"border-width":5, 
					"border-color":"red",
					"bold": true
				},
				{
					"text" : "24.18%",
					"hook" : "node:plot=2,index=0",
					"background-color":"blue",
					"color": "white",
					"border-width":5, 
					"border-color":"blue",
					"bold": true
				},
				{
					"text" : "ล้าน (บาท)",
					"bold":true,
					"x": "5",
					"y": "0"
				}
			],
			"plot":{
				"tooltip-text":"%v",
				"bars-space-left":"15%",
				"bars-space-right":"15%"
			},
			"scale-x":{
				"values":["ยอดขาย"],
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
				"min-value" : 0,
				"format":"%v",
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
				{
					"type" : "bar",
					"values" : [150],
					"text":"Actual",
					"background-color":"#66CC00"
				},
				{
					"type" : "bar",
					"values" : [120],
					"text":"Last Year",
					"background-color":"#EEEE00"
				},
				{
					"type" : "bar",
					"values" : [15],
					"text": "Budget",
					"background-color":"#696969"
				}
			]
		}
	]
};

		$(document).ready(function() {
//---------------------------------------------
			zingchart.render({
				id : 'gSales',
				width : 190,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit1',
				width : 190,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit2',
				width : 190,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit3',
				width : 190,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'g2',
				width : 290,
				height : 229,
				data : bar02
			});
			zingchart.render({
				id : 'g3',
				width : 420,
				height : 320,
				data : pie01
			});
			zingchart.render({
				id : 'g4',
				width : 600,
				height : 300,
				data : bar03
			});

//--------------- Restaurant ---------------
			zingchart.render({
				id : 'gSales1',
				width : 188,
				height : 230,
				data : mixSalesRest
			});
			/*zingchart.render({
				id : 'gCost1',
				width : 150,
				height : 220,
				data : mixCostRest
			});*/
			zingchart.render({
				id : 'gProfitRest1',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfitRest2',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfitRest3',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC1',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Bakery ---------------
			zingchart.render({
				id : 'gSales2',
				width : 188,
				height : 230,
				data : mixSalesBak
			});
			/*zingchart.render({
				id : 'gCost2',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit4',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit5',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit6',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC2',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Specialty ---------------
			zingchart.render({
				id : 'gSales3',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost3',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit7',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit8',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit9',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC3',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Trading ---------------
			zingchart.render({
				id : 'gSales4',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost4',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit10',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit11',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit12',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC4',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Caterman ---------------
			zingchart.render({
				id : 'gSales5',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost5',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit13',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit14',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit15',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC5',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Other ---------------
			zingchart.render({
				id : 'gSales6',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost6',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit16',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit17',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit18',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC6',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------------------------------
			zingchart.render({
				id : 'gSales7',
				width : 190,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost7',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit19',
				width : 190,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit20',
				width : 190,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit21',
				width : 190,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'g18',
				width : 290,
				height : 229,
				data : bar17
			});
			zingchart.render({
				id : 'g19',
				width : 420,
				height : 320,
				data : pie02
			});
			zingchart.render({
				id : 'g20',
				width : 600,
				height : 300,
				data : bar18
			});

//--------------- England ---------------
			zingchart.render({
				id : 'gSales8',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost8',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit22',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit23',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit24',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC8',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Switzerland ---------------
			zingchart.render({
				id : 'gSales9',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost9',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit25',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit26',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit27',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC9',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Singapore ---------------
			zingchart.render({
				id : 'gSales10',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost10',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit28',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit29',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit30',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC10',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Taiwan ---------------
			zingchart.render({
				id : 'gSales11',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost11',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit31',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit32',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit33',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC11',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Chaina ---------------
			zingchart.render({
				id : 'gSales12',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost12',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit34',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit35',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit36',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC12',
				width : 290,
				height : 229,
				data : bar0
			});

//--------------- Philippines ---------------
			zingchart.render({
				id : 'gSales13',
				width : 188,
				height : 230,
				data : mixSales
			});
			/*zingchart.render({
				id : 'gCost13',
				width : 150,
				height : 220,
				data : mixCost
			});*/
			zingchart.render({
				id : 'gProfit37',
				width : 188,
				height : 220,
				data : mixProfit1
			});
			zingchart.render({
				id : 'gProfit38',
				width : 188,
				height : 220,
				data : mixProfit2
			});
			zingchart.render({
				id : 'gProfit39',
				width : 188,
				height : 220,
				data : mixProfit3
			});
			zingchart.render({
				id : 'gC13',
				width : 290,
				height : 229,
				data : bar0
			});		
		});
	</script>

</head>

<body bgcolor="#FFFFFF">
<!-- Parameter -->
	<!--          Drop Down List YEAR              -->
	<div style="position:absolute; left:15px; top:20px; color:#000000;"><font size="3"> ปี:</font>
		<select name="Year" onChange="getYear(this.value);">
			<option value="1"<%if(y.equals("1")) out.print(" selected=\"selected\"");%>>2010</option>
			<option value="2"<%if(y.equals("2")) out.print(" selected=\"selected\"");%>>2009</option>
		</select> 
	</div>
	<!--          Drop Down List MONTH              -->
	<div style="position:absolute; left:125px; top:20px; color:#000000;"><font size="3"> เดือน:</font>
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
	<!--          Drop Down List             -->
	<div style="position:absolute; left:250px; top:20px; color:#000000;"><font size="3"> สรุปตาม: </font>
		<select name="SumBy" onChange="getSumBy(this.value);">
			<option value="6">YTD</option>
			<option value="7">Monthly</option>
			<option value="1"<%if(sb.equals("1")) out.print(" selected=\"selected\"");%>>YTD vs Last YTD</option>
			<option value="2"<%if(sb.equals("2")) out.print(" selected=\"selected\"");%>>Quarter vs Last Quarter</option>
			<option value="3"<%if(sb.equals("3")) out.print(" selected=\"selected\"");%>>Quarter vs Last Year same Quarter</option>
			<option value="4"<%if(sb.equals("4")) out.print(" selected=\"selected\"");%>>Monthly vs Last Monthly</option>
			<option value="5"<%if(sb.equals("5")) out.print(" selected=\"selected\"");%>>Monthly vs Last Year same Monthly</option>
		</select> 
	</div>
	<div style="position:absolute; left:580px; top:20px;">
		<input type="button" value=" OK " onClick="goUrl()"/>
	</div>
<!-- End Parameter -->

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">ในประเทศ</a></li>
		<li><a href="#tabs-2">ต่างประเทศ</a></li>
	</ul>
<div id="tabs-1">
<table>
<tr>
<td>
  <table id=tabs-ratio width=100>
	<tr>
	  <td>
		<!-- Table Data -->
		<ul>
		  <li><a href="#tabs">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial Indicator&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp</a></li>
		</ul>

		<table id=table-data>
		  <tr>
			<th bgcolor=#CD853F colspan=3><font color="#FFFFFF"> <%out.print(month+" 10 vs "+month+" 09");%> </font></th>
		  </tr>

		  <!-- Data -->

		  <tr>
			<th colspan=3> Profitablity Ratio </th>
		  </tr>
		  <tr>
			<td>Gross Profit Margin </td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">44.94 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Net Profit Margin </font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">7.16 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">EBITDA Margin </font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">00</font></td>
		  </tr>
		  <tr>
			<td><font size="2">EBIT Margin </font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">00</font></td>
		  </tr>
		  <tr>
			<td><font size="2">Return on Equity</font></td>
			<td></td>
			<td><font size="2">00</font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Operating Efficiency</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Return on Assets</font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Return on Fixed Assets </font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Leverage Ratio</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Current Ratio</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Quick Ratio</font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Debt to Equity Ratio (Times)</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Turnover Ratio</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">A/R Day</font></td>
			<td> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">A/P Day</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Inventory Day</font></td>
			<td> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Growth Rates
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Sales and Service Income</font></td>
			<td> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Gross Profit</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Net Profit</font></td>
			<td><font size="2"><img src=images/down1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Total Assets</font></td>
			<td> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Per Share Data</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Book Value per Share (Bt.)</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Earnings per Share (Bt.)</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <!-- End Data -->
		</table>

		<!-- End Table -->
	  </td>
	</tr>
  </table>
</td>

<td>
  <table id=tabs-table2 width=800px style="position:absolute; left:242px; top:45px;" bordercolor="#000000" frame="box" rules="all">

  <tr><td><table>
  <tr bgcolor="#8B4513">
  <td>
	<div align=center><font color="#FFE742" size="3"><b>บริษัทเอส แอน พี ซินดิเคท จำกัด (มหาชน)</b></font></div>
  </td>
  </tr>

  <tr><td><table bordercolor="#CCCCCC" frame="box" rules="all">
  <tr>
	  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
	  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
	  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

  </tr>

  <!-- Chart -->
  <tr>
	<td valign="middle" align="center">
		<div id="gSales"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
	</td>
	<td valign="middle"><table><tr>
		<td align="center"><div id="gProfit1"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
		<td align="center"><div id="gProfit2"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
		<td align="center"><div id="gProfit3"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	</tr></table></td>
	<td valign="middle" align="center">
		<div id="g2"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopupPer.jsp?topic=%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
	</td>
  </tr>

  <!-- img Legend -->
  <tr>
	<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
	<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
</tr> 
  </table></td></tr>
  </table></td></tr>

  <tr><td valign="top" align="center"><table>
  <tr bgcolor="#8B4513">
  <td>
	<div align=center><font color="#FFE742" size="3"><b>สัดส่วน แยกตามประเภทธุรกิจ</b></font></div>
  </td>
  </tr>

  <tr><td valign="top" align="center"><table width=1070 bordercolor="#8B4513" frame="box" rules="all">
  <tr>
	  <td bgcolor="#CD853F"><font size="3" color="#FFFFFF"><div align=center>Sales</div></font></td>
	  <td bgcolor="#CD853F"><font size="3" color="#FFFFFF"><div align=center>%Sales Growth<%out.print(salesP);%></div></font></td>
  </tr>

  <tr>
	<td valign="top" align="center"><div id="g3"></div></td>
	<td valign="top">
		<!--------------------------- Print Button BACK --------------------------->
		<%
			if(bar3.equals("1"))
			{
				out.print("<form name=\"back1\" method=\"post\"");
				out.print(" action=\""+request.getContextPath()+"/Dashboard/Finance.jsp?bar3=0&bar3F="+bar3F+"&bar1="+bar1+"&bar2="+bar2+"&bar2F="+bar2F+"&y="+y+"&months="+months+"&sb="+sb+"&t1="+t1+"&t2="+t2+"\">");
				out.print("<input type=\"submit\" name=\"back\" value=\" BACK \"></form>");
			}
		%>
		<div id="g4"></div>
	</td>
  </tr>
  </table></td></tr>
  </table></td></tr>

  </table>
</td></tr>
</table>

<!-- -->
<div style=" position:absolute; top:775px; left:242px;">
<table id="tabs-t1r3">
  <tr height=350><td valign="top" width=1067>
	<ul>
		<li><a href="#tabs-t1r3_1">Restaurant</a></li>
		<li><a href="#tabs-t1r3_2">Bakery</a></li>
		<li><a href="#tabs-t1r3_3">Specialty</a></li>
		<li><a href="#tabs-t1r3_4">Trading</a></li>
		<li><a href="#tabs-t1r3_5">Caterman</a></li>
		<li><a href="#tabs-t1r3_6">Other</a></li>
	</ul>

	<!-- Reataurant -->
	<table id="tabs-t1r3_1" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		  <td valign="middle" align="center">
			<div id="gSales1"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfitRest1"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfitRest2"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfitRest3"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC1"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr> 
	</table>
	</td></tr></table>

	<!-- Bakery -->
	<table id="tabs-t1r3_2" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
				<td valign="middle" align="center">
			<div id="gSales2"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit4"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit5"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit6"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC2"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Specialty -->
	<table id="tabs-t1r3_3" height="360">
	<tr>
	<%--
	<td>&nbsp;&nbsp;Drill Down : 
		<select name="speciatly">
			<option value="1">สินค้า</option>
			<option value="2">ประเภทร้านค้า</option>
		</select>&nbsp;&nbsp;
		<input type="submit" name="ok" value=" OK "/>
	</td>
	 --%>
	 </tr>

	<tr><td>
	<table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:90px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center">
			<div id="gSales3"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit7"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit8"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit9"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC3"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Trading -->
	<table id="tabs-t1r3_4" height="360">
	<tr>
	<%--
	<td>&nbsp;&nbsp;Drill Down : 
		<select name="speciatly">
			<option value="1">สินค้า</option>
			<option value="2">ช่องทางการขาย</option>
		</select>&nbsp;&nbsp;
		<input type="submit" name="ok" value=" OK "/><p></p>
	</td>
	 --%></tr>

	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:90px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
				<td valign="middle" align="center">
			<div id="gSales4"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit10"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit11"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit12"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC4"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>
	
	<!-- Caterman -->
	<table id="tabs-t1r3_5" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
				<td valign="middle" align="center">
			<div id="gSales5"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit13"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit14"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit15"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC5"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Other -->
	<table id="tabs-t1r3_6" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center">
		<div id="gSales6"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit16"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit17"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit18"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC6"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

<!-- END -->
  </td></tr>
  </table></div>

</div>

<!-- Tab ต่างประเทศ -->
<div id="tabs-2">
<table>
<tr>
<td>
  <table id=tabs-ratio1 width=100>
	<tr>
	  <td>
		<!-- Table Data -->
		<ul>
		  <li><a href="#tabs">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial Indicator&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp</a></li>
		</ul>

		<table id=table-data>
		  <tr>
			<th bgcolor=#CD853F colspan=3><font color="#FFFFFF"> <%out.print(month+" 10 vs "+month+" 09");%> </font></th>
		  </tr>

		  <!-- Data -->

		  <tr>
			<th colspan=3> Profitablity Ratio </th>
		  </tr>
		  <tr>
			<td>Gross Profit Margin </td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">44.94 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Net Profit Margin </font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">7.16 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">EBITDA Margin </font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">00</font></td>
		  </tr>
		  <tr>
			<td><font size="2">EBIT Margin </font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">00</font></td>
		  </tr>
		  <tr>
			<td><font size="2">Return on Equity</font></td>
			<td></td>
			<td><font size="2">00</font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Operating Efficiency</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Return on Assets</font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Return on Fixed Assets </font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Leverage Ratio</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Current Ratio</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Quick Ratio</font></td>
			<td><img src=images/down1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Debt to Equity Ratio (Times)</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Turnover Ratio</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">A/R Day</font></td>
			<td> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">A/P Day</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Inventory Day</font></td>
			<td> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Growth Rates
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Sales and Service Income</font></td>
			<td> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Gross Profit</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Net Profit</font></td>
			<td><font size="2"><img src=images/down1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Total Assets</font></td>
			<td> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>

		  <tr>
			<th colspan=3><font size="2">
			  Per Share Data</font>
			</th>
		  </tr>
		  <tr>
			<td><font size="2">Book Value per Share (Bt.)</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">25.50 </font></td>
		  </tr>
		  <tr>
			<td><font size="2">Earnings per Share (Bt.)</font></td>
			<td><img src=images/up1.png> </td>
			<td><font size="2">14.20 </font></td>
		  </tr>
		  <!-- End Data -->
		</table>

		<!-- End Table -->
	  </td>
	</tr>
  </table>
</td>

<td>
  <table id=tabs-table2 width=850px style="position:absolute; left:242px; top:45px;" bordercolor="#000000" frame="box" rules="all">

  <tr><td><table>
  <tr bgcolor="#8B4513">
  <td>
	<div align=center><font color="#FFE742" size="3"><b>สรุปรวม ต่างประเทศ</b></font></div>
  </td>
  </tr>

  <tr><td><table bordercolor="#CCCCCC" frame="box" rules="all">
  <tr>
	  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
	  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
	  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

  </tr>


  <!-- Chart -->
  <tr width=600>
	<td valign="middle" align="center">
	<div id="gSales7"></div>
	<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
		<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
	</a>
	</td>
	<td valign="middle"><table><tr>
		<td align="center"><div id="gProfit19"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
		<td align="center"><div id="gProfit20"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
		<td align="center"><div id="gProfit21"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	</tr></table></td>
	<td valign="middle" align="center">
		<div id="g18"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopupPer.jsp?topic=%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
	</td>
  </tr>

  <!-- img Legend -->
  <tr>
	<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
	<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
</tr> 
  </table></td></tr>
  </table></td></tr>

  <tr><td valign="top" align="center"><table>
  <tr bgcolor="#8B4513">
  <td>
	<div align=center><font color="#FFE742" size="3"><b>สัดส่วน แยกตามประเทศ</b></font></div>
  </td>
  </tr>

  <tr><td valign="top" align="center"><table width=1070 bordercolor="#8B4513" frame="box" rules="all">
  <tr bgcolor="#CD853F">
	  <td><font size="3" color="#FFFFFF"><div align=center>Sales</div></font></td>
	  <td><font size="3" color="#FFFFFF"><div align=center>%Sales Growth<%out.print(countryP);%></div></font></td>
  </tr>

  <tr>
	<td valign="top" align="center"><div id="g19"></div></td>
	<td valign="top">
		<!--------------------------- Print Button BACK --------------------------->
		<%
			if(bar3F.equals("1"))
			{
				out.print("<form name=\"back1\" method=\"post\"");
				out.print(" action=\""+request.getContextPath()+"/Dashboard/Finance.jsp?bar3="+bar3+"&bar3F=0&bar1="+bar1+"&bar2="+bar2+"&bar2F="+bar2F+"&y="+y+"&months="+months+"&sb="+sb+"&t1="+t1+"&t2="+t2+"#tabs-2\">");
				out.print("<input type=\"submit\" name=\"back\" value=\" BACK \"></form>");
			}
		%>
		<div id="g20"></div>
	</td>
  </tr>
  </table></td></tr>
  </table></td></tr>

  </table>
</td></tr>
</table>

<!-- -->
<div style=" position:absolute; top:775px; left:242px;">
<table id="tabs-t2r3">
  <tr height=350><td valign="top" width=1067>
	<ul>
		<li><a href="#tabs-t2r3_1">อังกฤษ</a></li>
		<li><a href="#tabs-t2r3_2">สวิตเซอร์แลนด์</a></li>
		<li><a href="#tabs-t2r3_3">สิงคโปร์</a></li>
		<li><a href="#tabs-t2r3_4">ไต้หวัน</a></li>
		<li><a href="#tabs-t2r3_5">จีน</a></li>
		<li><a href="#tabs-t2r3_6">ฟิลิปปินส์</a></li>
	</ul>

	<!-- Reataurant -->
	<table id="tabs-t2r3_1" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center">
		<div id="gSales8"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit22"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit23"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit24"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC8"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Bakery -->
	<table id="tabs-t2r3_2" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center">
		<div id="gSales9"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit25"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit26"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit27"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC9"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Specialty -->
	<table id="tabs-t2r3_3" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center">
		<div id="gSales10"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit28"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit29"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit30"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC10"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Trading -->
	<table id="tabs-t2r3_4" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center">
		<div id="gSales11"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit31"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit32"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit33"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC11"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>
	
	<!-- Caterman -->
	<table id="tabs-t2r3_5" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center">
		<div id="gSales12"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit34"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit35"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit36"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC12"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

	<!-- Other -->
	<table id="tabs-t2r3_6" height="350">
	<tr><td><table bordercolor="#CCCCCC" frame="box" rules="all" style=" position:absolute; top:60px; left:8px;">
	  <tr>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>ยอดขาย</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>กำไร</b></div></font></td>
		  <td bgcolor="#CD853F"><font size="2" color="#FFFFFF"><div align=center><b>%ต้นทุนและค่าใช้จ่ายเทียบยอดขาย</b></div></font></td>

	  </tr>

	  <!-- Chart -->
	  <tr width=600>
		<td valign="middle" align="center">
		<div id="gSales13"></div>
		<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
			<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
		</a>
		</td>
		<td valign="middle"><table><tr>
			<td align="center"><div id="gProfit37"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรขั้นต้น" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit38"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรจากการดำเนินงาน" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
			<td align="center"><div id="gProfit39"></div>
				<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=กำไรสุทธิ" rel="facebox">
					<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
				</a>
			</td>
		</tr></table></td>
		<td valign="middle" align="center">
			<div id="gC13"></div>
			<a href="<%=request.getContextPath()%>/Dashboard/FinancePopup.jsp?topic=ยอดขาย" rel="facebox">
				<img src="<%=request.getContextPath()%>/Dashboard/images/Popup.jpg" border="0"/> <font color="blue" size="1">Drill Down</font>
			</a>
		</td>
	  </tr>

	  <tr>
		<td colspan="2" align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin_1.jpg"/></td>
		<td align="center"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Fin2.jpg"/></td>
	</tr>
	</table>
	</td></tr></table>

<!-- END -->
  </td></tr>
  </table>
</td>

</tr>
</table>

</div>
</div>

</body>
</html>

