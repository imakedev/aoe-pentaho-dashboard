<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>Caterman Dashboard Page</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/chartLib/css/caterman2.css" type="text/css"/>
    <link href="<%=request.getContextPath()%>/chartLib/css/stylemenu2.css" rel="stylesheet" media="all" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css" rel="stylesheet" />	
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

<!------------------- Get Parameter ------------------->
<%
	String y = request.getParameter("y"); // Value of Year Parameter.
	String months = request.getParameter("months"); // Value of Month Parameter.
	String sb = request.getParameter("sb"); // Value of Summary By Parameter.
%>
<!------------------- End Get Parameter ------------------->

<script type="text/javascript">

		var y = <%=y%>; // Value of Year(Default 1)
		var months = <%=months%>; // Value of Month(Default 1)
		var urlP = '<%=request.getContextPath()%>/Dashboard/CatermanYTD.jsp?y='+y+'&months='+months+'&sb='+sb; // URL Page.
		var sb = <%=sb%>;

		function getYear(value)
		{
			y = value;
		}
		 
		function getMonth(value)
		{
			months = value;
		}

		
		function getSumBy(value)
		{
			sb = value;
			switch(sb){
				case '1' : urlP = '<%=request.getContextPath()%>/Dashboard/Caterman.jsp?y='+y+'&months='+months+'&sb='+sb;
					break;
				case '3' : urlP = '<%=request.getContextPath()%>/Dashboard/CatermanQTD.jsp?y='+y+'&months='+months+'&sb='+sb;
					break;
			}
		}

		function goUrl()
		{
			location.href = urlP;
		}
	</script>

<script type="text/javascript">
var mix = {
"graphset":[
    {
        "type":"mixed",
        "background-color":"#FFFFFF",
		"stacked":"1",
		"chart":{
			"margin":"10 120 30 70"
		},
        "legend":{
            "background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"margin":"50 0 0 980",
            "layout":"x1"
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
			"thousands-separator":","
		},
        "series":[
            {
                "type":"bar",
                "values":[140307,114853,114218,98231,140555,84972,140972,118015,138171,118102,126579,79487],
                "text":"Net Sales",
				"stacked":0
            },
            {
                "type":"bar",
                "values":[37377,47714,51206,30735,42175,25497,31916,49013,49408,50999,32185,55744],
                "border-width":1,
                "text":"COGs",
				"stacked":0
            },
            {
                "type":"bar",
                "values":[102930,67139,63012,67496,98380,59475,109056,69002,88763,67103,94394,23743],
                "text":"Net Profit",
				"stacked":0,
                "border-width":1
            }]
        }]
    };

	var pie1 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"0 0 15 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "1x",
			"x":50,
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
				"text" : "องค์กร",
				"values" : [50],
				"tooltip-text" : "%t: 5,000"
			},
			{
				"text" : "ทั่วไป",
				"values" : [30],
				"tooltip-text" : "%t: 3,000"
			},
			{
				"text" : "ราชการ",
				"values" : [20],
				"tooltip-text" : "%t: 2,000"			
			}]
	}]
};

	var pie2 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"0 0 15 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "1x",
			"x":80,
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
			"text" : "call in",
			"values" : [60],
			"tooltip-text" : "%t: 950.4"
		},
		{
			"text" : "call out",
			"values" : [40],
			"tooltip-text" : "%t: 780.8"			
		}]
	}]
};

	var pie3 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"0 0 70 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "x3",
			"x":13,
			"y":180,
			"width":300
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
			"text" : "บุฟเฟ่",
			"values" : [22],
			"tooltip-text" : "%t: 22,000"
		},
		{
			"text" : "คอกเทล",
			"values" : [18],
			"tooltip-text" : "%t: 18,000"
		},
		{
			"text" : "เลี้ยงอาหารพระ",
			"values" : [15],
			"tooltip-text" : "%t: 15,000"
		},
		{
			"text" : "ซุ้มอาหาร",
			"values" : [14],
			"tooltip-text" : "%t: 14,000"
		},
		{
			"text" : "อาหารว่าง",
			"values" : [11],
			"tooltip-text" : "%t: 11000"
		},
		{
			"text" : "Sit down",
			"values" : [9],
			"tooltip-text" : "%t: 9,000"
		},
		{
			"text" : "Snack box",
			"values" : [7],
			"tooltip-text" : "%t: 7,000"
		},
		{
			"text" : "ของว่างเสริฟ์",
			"values" : [4],
			"tooltip-text" : "%t: 4,000"			
		}]
	}]
};

	var pie4 = {
	"graphset" : [
	{
		"background-color":"#FFFFFF",
		"type" : "pie",
		"chart":{
			"margin":"0 0 15 0"
		},
		"legend":{
			"background-color": "#FFFFFF",
    		"border-width": "2px",
			"border-color": "#4C77B6",
			"layout": "1x",
			"x":20,
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
			"text" : "งานแต่งงาน",
			"values" : [70],
			"tooltip-text" : "%t: 70,000"
		},
		{
			"text" : "งานศพ",
			"values" : [5],
			"tooltip-text" : "%t: 5,000"			
		},
		{
			"text" : "งานอีเว้นท์",
			"values" : [25],
			"tooltip-text" : "%t: 25,000"
		}]
	}]
};

$(document).ready(function() {
		zingchart.render({
			id 			: 'g1',
			width 		: 1090,
			height 		: 270,
			data 		: mix
		});
		zingchart.render({
			id 			: 'g3',
			width 		: 310,
			height 		: 250,
			data 		: pie1
		});
		zingchart.render({
			id 			: 'g4',
			width 		: 310,
			height 		: 250,
			data 		: pie2
		});
		zingchart.render({
			id 			: 'g5',
			width 		: 330,
			height 		: 265,
			data 		: pie3
		});
		zingchart.render({
			id 			: 'g6',
			width 		: 310,
			height 		: 250,
			data 		: pie4
		});

});

</script>

<!-------------- Configuration Tab -------------->
<script type="text/javascript">
	$(function() {
		$("#tabs").tabs();
		$("#tabsH").tabs();
		$("#tabsTABLE").tabs();
		$("#tabsG").tabs();
		$("#tabsGET").tabs();
		$("#tabspiano").tabs();	
		$("#tabsLine").tabs();
		$("#tabsGS").tabs();
		$("#tabsGETS").tabs();
		$("#tabsL").tabs();
		$("#tabsLAST").tabs();
	});
</script>

	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; }
		.demoHeaders { margin-top: 2em; }
		#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
		#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
		ul#icons {margin: 0; padding: 0;}
		ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
		ul#icons span.ui-icon {float: left; margin: 0 4px;}

		#tabsH { position:absolute; height:250px; top:355px; background-color:#FFFFFF; }
		#tabsTABLE { position:absolute; height:250px; top:355px; background-color:#FFFFFF; }
		#tabsG { position:absolute; top:615px; background-color:#FFFFFF; }
		#tabsGET { position:absolute; top:615px; background-color:#FFFFFF; }
		#tabspiano { position:absolute; top:925px; background-color:#FFFFFF; }
		#tabsLine { position:absolute; top:925px; background-color:#FFFFFF; }
		#tabsGS { position:absolute; height:270px; top:1235px; background-color:#FFFFFF; }
		#tabsGETS { position:absolute; height:270px; top:1235px; background-color:#FFFFFF; }
		#tabsL { position:absolute; height:270px; top:1515px; background-color:#FFFFFF; }
	</style>
<!-------------- End Configuration Tab -------------->

  </head>
  <body LINK="white" ALINK="blue" VLINK="gray">
<!-------------- Parameter -------------->
<div id="MAIN">
 <div id="YEAR1"><font size="2" color="#000000">Year:</font>
	<select name="Year" style="width:60px;" onChange="getYear(this.value);">
		<option value="1"<%if(y.equals("1")) out.print(" selected=\"selected\"");%>>2011</option>
		<option value="2"<%if(y.equals("2")) out.print(" selected=\"selected\"");%>>2010</option>
		<option value="3"<%if(y.equals("3")) out.print(" selected=\"selected\"");%>>2009</option>
		<option value="4"<%if(y.equals("4")) out.print(" selected=\"selected\"");%>>2008</option>
	</select> 
  </div>
  <div id="MONTH1"><font size="2" color="#000000"> Month:</font>
	<select name="Month" style="width:70px;" onChange="getMonth(this.value);">
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
  <div id="SUMMARYBY"><font size="2" color="#000000"> By:</font>
	<select name="SumBy" style="width:90px;" onChange="getSumBy(this.value);">
		<option value="1">Daily</option>
		<option value="2" selected="selected">Monthly</option>
		<option value="3">Quarter</option>
	</select> 
  </div>
  <div style=" position:absolute; left:450px; "><input type="button" value=" OK " onClick="goUrl()"/></div>
</div>
<!-------------- End Parameter -------------->

<!-------------- Tab 1 (tabs) -------------->
	<table id="tabs" cellspacing="0" cellpadding="0">
	<tr bgcolor="#8B4513">
		<th><font color="#FFE742" size="3">Profit/Loss</font></th>
	 </tr>
	 <tr><td><div id="g1"></div></td></tr>
	</table>
<!-------------- End Tab 1 -------------->

<!-------------- Tab 2 (tabsH) -------------->
<div id="tabsH">
<table cellspacing="5">
<tr bgcolor="#8B4513"><th><font color="#FFE742" size="3"> Service Type </font></th></tr>
<tr><td>
	<table width="530" align="center" bordercolor="#000000" frame="box" rules="all">
	<tr bgcolor="#CD853F">
		<th width="100"><font color="#FFFFFF">Service Type</font></th>
		<th><font color="#FFFFFF"># Staffs</font></th>
		<th><font color="#FFFFFF">Sales Amount</font></th>
		<th><font color="#FFFFFF">COGs</font></th>
		<th><font color="#FFFFFF">%COGs</font></th>
	</tr>
	<tr>
		<td>บุฟเฟ่</a></td>
		<td align="right">75</td>
		<td align="right">953,085.00</td>
		<td align="right">301,884.89</td>
		<td align="right">31.67%</td>
	</tr>
	<tr>
		<td>คอกเทล</a></td>
		<td align="right">57</td>
		<td align="right">113,950.00</td>
		<td align="right">37,530.96</td>
		<td align="right">32.94%</td>
	</tr>
	<tr>
		<td>เลี้ยงอาหารพระ</td>
		<td align="right">30</td>
		<td align="right">117,025.00</td>
		<td align="right">43,845.12</td>
		<td align="right">37.47%</td>
	</tr>
	<tr>
		<td>ซุ้มอาหาร</td>
		<td align="right">95</td>
		<td align="right">424,750.00</td>
		<td align="right">83,897.01</td>
		<td align="right">19.75%</td>
	</tr>
	<tr>
		<td>อาหารว่าง</td>
		<td align="right">12</td>
		<td align="right">229,925.00</td>
		<td align="right">83,904.04</td>
		<td align="right">36.49%</td>
	</tr>
	<tr>
		<td>Sit down</td>
		<td align="right">60</td>
		<td align="right">548,495.00</td>
		<td align="right">232,724.32</td>
		<td align="right">42.43%</td>
	</tr>
	<tr>
		<td>Snack box</td>
		<td align="right">15</td>
		<td align="right">158,160.00</td>
		<td align="right">53,348.93</td>
		<td align="right">33.73%</td>
	</tr>
	<tr>
		<td>ของว่างเสริฟ์</td>
		<td align="right">50</td>
		<td align="right">234,460.00</td>
		<td align="right">79,029.45</td>
		<td align="right">33.71%</td>
	</tr>

	<tr>
		<td><b>Total</b></td>
		<td align="right"><b>394</b></td>
		<td align="right"><b>2,779,850</b></td>
		<td align="right"><b>916,164.72</b></td>
		<td align="right"><b>268.19</b></td>
	</tr>
	</table>
</td></tr>
</table>
</div>
<!-------------- End Tab 2 -------------->

<!-------------- Tab 3 (tabsTABLE) -------------->
<div id="tabsTABLE">
<table cellspacing="5">
<tr><th bgcolor="#8B4513"><font color="#FFE742" size="3"> Customer </font></th></tr>
<tr><td>
	<table width="530" align="center" bordercolor="#000000" frame="box" rules="all">
		<tr bgcolor="#CD853F">
			<th width="180"><font color="#FFFFFF">Customer Name</font></th>
			<th><font color="#FFFFFF">Job Type</font></th>
			<th width="60"><font color="#FFFFFF"># Straffs</font></th>
			<th width="50"><font color="#FFFFFF"># Days</font></th>
			<th width="70"><font color="#FFFFFF"># Guests</font></th>
			<th><font color="#FFFFFF">Sales Amount</font></th>
		</tr>
		<tr>
			<td>คุณนิสารัตน์ ปิติ</td>
			<td>งานแต่งงาน</td>
			<td align="right">9</td>
			<td align="right">1</td>
			<td align="right">250</td>
			<td align="right">103,780</td>
		</tr>
		<tr>
			<td>บริษัท สามารถโอเปอเรชั่น จำกัด</td>
			<td>งานอีเว้นท์</td>
			<td align="right">15</td>
			<td align="right">2</td>
			<td align="right">150</td>
			<td align="right">128,483</td>
		</tr>
		<tr>
			<td>บริษัท ทีโอที จำกัด (มหาชน)</td>
			<td>งานอีเว้นท์</td>
			<td align="right">11</td>
			<td align="right">1</td>
			<td align="right">200</td>
			<td align="right">93,228</td>
		</tr>
		<tr>
			<td>คุณกฤติกา อ่อนหวาน</td>
			<td>งานอีเว้นท์</td>
			<td align="right">15</td>
			<td align="right">1</td>
			<td align="right">250</td>
			<td align="right">103,314</td>
		</tr>
		<tr>
			<td>บริษัท ลักษ์ 666 จำกัด</td>
			<td>งานอีเว้นท์</td>
			<td align="right">10</td>
			<td align="right">2</td>
			<td align="right">70</td>
			<td align="right">116,587</td>
		</tr>
		<tr>
			<td>บริษัท สยาม จำกัด</td>
			<td>งานอีเว้นท์</td>
			<td align="right">10</td>
			<td align="right">1</td>
			<td align="right">150</td>
			<td align="right">112,744</td>
		</tr>
		<tr>
			<td>คุณสามารถ ณ นคร</td>
			<td>งานแต่งงาน</td>
			<td align="right">10</td>
			<td align="right">1</td>
			<td align="right">250</td>
			<td align="right">124,199</td>
		</tr>
		<tr>
			<td>คุณกรกนก เอี่ยมสะอาด</td>
			<td>งานอีเว้นท์</td>
			<td align="right">5</td>
			<td align="right">1</td>
			<td align="right">100</td>
			<td align="right">89,250</td>
		</tr>
		<tr>
			<td>บริษัท เครื่องไหมไทย จำกัด</td>
			<td>งานอีเว้นท์</td>
			<td align="right">10</td>
			<td align="right">2</td>
			<td align="right">150</td>
			<td align="right">129,084</td>
		</tr>
		<!--<tr>
			<td>คุณนารถนัดดา โบร์จี้</td>
			<td>งานอีเว้นท์</td>
			<td align="right">5</td>
			<td align="right">1</td>
			<td align="right">25</td>
			<td align="right">13,125</td>-->
		</tr>
	</table>
</td></tr></table>
</div>
<!-------------- End Tab 3 -------------->

<!-------------- Tab 4 (tabsG) -------------->
<div id="tabsG">
<table cellspacing="5">
<tr><th bgcolor="#8B4513"><font color="#FFE742" size="3"> Sales Mixed By Customer Type </font></th></tr>
<tr><td>
  <table width="530" align="center">
  <tr>
  <td width="300">
	<div id="g3"></div>
  </td>
  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<table width="200" align="right" bordercolor="#000000" frame="box" rules="all" style=" position:absolute; top:35px; left:335px; ">
	<tr bgcolor="#CD853F">
		<th><font color="#FFFFFF">Customer Type</font></th>
		<th><font color="#FFFFFF">Success Rate</font></th>
	</tr>
	<tr>
		<td>องค์กร</td>
		<td align="right">50%</td>
	</tr>
	<tr>
		<td>ทั่วไป</td>
		<td align="right">30%</td>
	</tr>
	<tr>
		<td>ราชการ</td>
		<td align="right">20%</td>
	</tr>
	</table>
  </td>
  </tr></table>
</td></tr></table>
</div>
<!-------------- End Tab 4 -------------->

<!-------------- Tab 5 (tabsGET) -------------->
<div id="tabsGET">
<table cellspacing="5">
<tr><th bgcolor="#8B4513"><font color="#FFE742" size="3"> Sales Mixed By Job Source </font></th></tr>
<tr><td>
  <table width="530" align="center">
  <tr>
  <td>
	<div id="g4" align="left"></div>
  </td>
  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<table width="200" align="right" bordercolor="#000000" frame="box" rules="all" style=" position:absolute; top:35px; left:330px; ">
	<tr bgcolor="#CD853F">
		<th width="80"><font color="#FFFFFF">Job Source</font></th>
		<th><font color="#FFFFFF">Success Rate</font></th>
	</tr>
	<tr>
		<td align="center">call in</td>
		<td align="right">60%</td>
	</tr>
	<tr>
		<td align="center">call out</td>
		<td align="right">40%</td>
	</tr>
	</table>
  </td>
  </tr></table>
</td></tr></table>
</div>
<!-------------- End Tab 5 -------------->

<!-------------- Tab 6 (tabspiano) -------------->
<div id="tabspiano">
<table cellspacing="5">
<tr><th bgcolor="#8B4513"><font color="#FFE742" size="3"> Sales Mixed By Service Type </font></th></tr>
<tr><td>
  <table width="530" align="center">
  <tr>
  <td><!--style=" position:absolute; top:0px; left:2px; "-->
	<div id="g5"></div>
  </td>
  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<table width="190" align="right" bordercolor="#000000" frame="box" rules="all" style=" position:absolute; top:35px; left:340px; ">
	<tr bgcolor="#CD853F">
		<th><font color="#FFFFFF">Service Type</font></th>
		<th><font color="#FFFFFF">Success Rate</font></th>
	</tr>
	<tr>
		<td>บุฟเฟ่</td>
		<td align="right">22%</td>
	</tr>
	<tr>
		<td>คอกเทล</td>
		<td align="right">18%</td>
	</tr>
	<tr>
		<td>เลี้ยงอาหารพระ</td>
		<td align="right">15%</td>
	</tr>
	<tr>
		<td>ซุ้มอาหาร</td>
		<td align="right">14%</td>
	</tr>
	<tr>
		<td>อาหารว่าง</td>
		<td align="right">11%</td>
	</tr>
	<tr>
		<td>Sit down</td>
		<td align="right">9%</td>
	</tr>
	<tr>
		<td>Snack box</td>
		<td align="right">7%</td>
	</tr>
	<tr>
		<td>ของว่างเสริฟ์</td>
		<td align="right">4%</td>
	</tr>
	</table>
  </td>
  </tr></table>
</td></tr></table>
</div>
<!-------------- End Tab 6 -------------->

<!-------------- Tab 7 (tabsLine) -------------->
<div id="tabsLine">
<table cellspacing="5">
<tr><th bgcolor="#8B4513"><font color="#FFE742" size="3"> Sales Mixed By Job Type </font></th></tr>
<tr><td>
  <table width="530" align="center">
  <tr>
  <td>
	<div id="g6" align="left"></div>
  </td>
  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<table width="200" align="right" bordercolor="#000000" frame="box" rules="all" style=" position:absolute; top:35px; left:330px; ">
	<tr bgcolor="#CD853F">
		<th><font color="#FFFFFF">Job Type</font></th>
		<th><font color="#FFFFFF">Success Rate</font></th>
	</tr>
	<tr>
		<td>งานแต่งงาน</td>
		<td align="right">70%</td>
	</tr>
	<tr>
		<td>งานอีเว้นท์</td>
		<td align="right">25%</td>
	</tr>
	<tr>
		<td>งานศพ</td>
		<td align="right">5%</td>
	</tr>
	</table>
  </td>
  </tr></table>
</td></tr></table>
</div>
<!-------------- End Tab 7 -------------->

<!-------------- Tab 8 (tabsGS) -------------->
<div id="tabsGS">
<table cellspacing="5">
<tr><th bgcolor="#8B4513"><font color="#FFE742" size="3"> Top Customers </font></th></tr>
<tr><td>
   <label> Top : <input type="text" name="size" value="10" size="1"></label>
   <input type="submit" name="ok" value=" OK "/>
</td><tr>
<tr><td>
	<table width="530" align="center" bordercolor="#000000" frame="box" rules="all">
	<tr bgcolor="#CD853F">
		<th><font color="#FFFFFF">Customer Name</font></th>
		<th><font color="#FFFFFF">% GP</font></th>
	</tr>
	<tr>
		<td>บริษัท สามารถโอเปอเรชั่น จำกัด</td>
		<td align="right">5.79%</td>
	</tr>
	<tr>
		<td>บริษัท ทีโอที จำกัด (มหาชน)</td>
		<td align="right">5.43%</td>
	</tr>
	<tr>
		<td>บริษัท ลักษ์ 666 จำกัด</td>
		<td align="right">4.34%</td>
	</tr>
	<tr>
		<td>บริษัท เครื่องไหมไทย จำกัด</td>
		<td align="right">4.13%</td>
	</tr>
	<tr>
		<td>บริษัท ยามาซากิ จำกัด</td>
		<td align="right">3.90%</td>
	</tr>
	<tr>
		<td>คุณนิสารัตน์ ปิติ</td>
		<td align="right">2.67%</td>
	</tr>
	<tr>
		<td>คุณกฤติกา อ่อนหวาน</td>
		<td align="right">2.24%</td>
	</tr>
	<tr>
		<td>คุณสามารถ ณ นคร</td>
		<td align="right">1.95%</td>
	</tr>
	<tr>
		<td>คุณกรกนก เอี่ยมสะอาด</td>
		<td align="right">1.84%</td>
	</tr>
	<tr>
		<td>บริษัท สยาม จำกัด</td>
		<td align="right">1.45%</td>
	</tr>	
	</table>
</td><tr></table>
</div>
<!-------------- End Tab 8 -------------->

<!-------------- Tab 9 (tabsGETS) -------------->
<div id="tabsGETS">
<table cellspacing="5">
<tr><th bgcolor="#8B4513"><font color="#FFE742" size="3"> Bottom Customers </font></th></tr>
<tr><td>
   <label> Bottom : <input type="text" name="size" value="10" size="1"></label>
   <input type="submit" name="ok" value=" OK "/>
</td><tr>
<tr><td>
	<table width="530" align="center" bordercolor="#000000" frame="box" rules="all">
	<tr bgcolor="#CD853F">
		<th><font color="#FFFFFF">Customer Name</font></th>
		<th><font color="#FFFFFF">% GP</font></th>
	</tr>
	<tr>
		<td>บริษัท สามารถโอเปอเรชั่น จำกัด</td>
		<td align="right">5.79%</td>
	</tr>
	<tr>
		<td>บริษัท ทีโอที จำกัด (มหาชน)</td>
		<td align="right">5.43%</td>
	</tr>
	<tr>
		<td>บริษัท ลักษ์ 666 จำกัด</td>
		<td align="right">4.34%</td>
	</tr>
	<tr>
		<td>บริษัท เครื่องไหมไทย จำกัด</td>
		<td align="right">4.13%</td>
	</tr>
	<tr>
		<td>บริษัท ยามาซากิ จำกัด</td>
		<td align="right">3.90%</td>
	</tr>
	<tr>
		<td>บริษัท สยาม จำกัด</td>
		<td align="right">1.45%</td>
	</tr>
	<tr>
		<td>บริษัท น้ำไทย จำกัด</td>
		<td align="right">1.41%</td>
	</tr>
	<tr>
		<td>บริษัท ขนส่ง จำกัด</td>
		<td align="right">1.23%</td>
	</tr>
	<tr>
		<td>บริษัท เอลเอ จำกัด</td>
		<td align="right">1.12%</td>
	</tr>
	<tr>
		<td>บริษัท เอไอ จำกัด</td>
		<td align="right">1.09%</td>
	</tr>
	</table>
</td></tr></table>
</div>
<!-------------- End Tab 9 -------------->

<!-------------- Tab 10 (tabsL) -------------->
<div id="tabsL" style="width:1090px;">
<table cellspacing="5">
<tr><th bgcolor="#8B4513"><font color="#FFE742" size="3"> Top/Bottom Products </font></th></tr>
<tr><td>
	<select>
		<option value="1">Top</option>
		<option value="2">Bottom</option>
	</select>
	<input type="text" name="size" value="10" size="1"/>
	<input type="submit" name="ok" value=" OK "/>
</td></tr>
<tr><td>
	<table width="1080" align="center" bordercolor="#000000" frame="box" rules="all">
	<tr bgcolor="#CD853F">
		<th><font color="#FFFFFF">Menu Group</font></th>
		<th><font color="#FFFFFF">Menu Item</font></th>
		<th><font color="#FFFFFF">Sales Amount</font></th>
		<th><font color="#FFFFFF">COGs</font></th>
		<th><font color="#FFFFFF">%Sales Mixed</font></th>
		<th><font color="#FFFFFF">%COGs</font></th>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>ทอดมันกุ้ง</td>
		<td align="right">49,585</td>
		<td align="right">15,015</td>
		<td align="right">58.43%</td>
		<td align="right">12.43%</td>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>ไก่ทอด</td>
		<td align="right">44,195</td>
		<td align="right">12,341</td>
		<td align="right">52.32%</td>
		<td align="right">11.93%</td>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>หมูแดดเดียว</td>
		<td align="right">39,402</td>
		<td align="right">10,853</td>
		<td align="right">48.39%</td>
		<td align="right">10.23%</td>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>หมี่กรอบ </td>
		<td align="right">35,627</td>
		<td align="right">9,523</td>
		<td align="right">47.23%</td>
		<td align="right">10.02%</td>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>หมูทอดกระเทียมพริกไทย</td>
		<td align="right">30,485</td>
		<td align="right">8,485</td>
		<td align="right">45.35%</td>
		<td align="right">9.74%</td>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>ซี่โครงหมูทอดกระเทียมพริกไทย</td>
		<td align="right">27,452</td>
		<td align="right">7,452</td>
		<td align="right">42.12%</td>
		<td align="right">9.35%</td>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>กุ้งแม่น้ำทอดกระเที่ยมพริกไทย</td>
		<td align="right">25,375</td>
		<td align="right">6,375</td>
		<td align="right">37.95%</td>
		<td align="right">9.21%</td>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>ไข่ฟูปู </td>
		<td align="right">22,353</td>
		<td align="right">6,353</td>
		<td align="right">32.15%</td>
		<td align="right">9.12%</td>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>ปลาสลิดฟู </td>
		<td align="right">19,532</td>
		<td align="right">5,532</td>
		<td align="right">29.51%</td>
		<td align="right">8.93%</td>
	</tr>
	<tr>
		<td>อาหารทอด</td>
		<td>ใข่เจียวหมูสับ</td>
		<td align="right">17,543</td>
		<td align="right">5,543</td>
		<td align="right">27.83%</td>
		<td align="right">8.47%</td>
	</tr>
	<!--<tr>
		<td></td>
		<td></td>
		<td align="right"></td>
		<td align="right">%</td>
		<td align="right">%</td>
	</tr>-->
	</table>
</td></tr></table>
</div>
<!-------------- End Tab 10 -------------->
 </body>
</html>