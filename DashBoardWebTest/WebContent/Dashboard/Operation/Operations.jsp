<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Operation Dashboard Page</title>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

<link type="text/css"
	href="<%=request.getContextPath()%>/chartLib/css/jquery-ui.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.min.js"></script>

<!-- Datepicker -->
<link href="<%=request.getContextPath()%>/chartLib/js/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/chartLib/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/chartLib/js/jquery-ui.min.js"></script>

<!--  DWR -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwroperationdashboard/interface/OperationDashboardAjax.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwroperationdashboard/engine.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwroperationdashboard/util.js"></script>

<script type="text/javascript">
	function listDivision() {
		var str = "";
		OperationDashboardAjax
				.listDivisions({
					callback : function(data) {
						//alert(555);
						str = str
								+ "<select name=\"Division\" onChange=\"getDivision(this.value);\">";
						//str=str+"<option value=\"0\">-- Select Year --</option>";
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								str = str + "<option value=\""+data[i]+"\">"
										+ data[i] + "</option>";
							}
						}
						str = str + "</select>";
						document.getElementById('divisionListDiv').innerHTML = str;
					}
				});
	}

	function listSection() {
		var str = "";
		OperationDashboardAjax
				.listSections({
					callback : function(data) {
						str = str
								+ "<select name=\"Section\" onChange=\"getSection(this.value);\">";
						//str=str+"<option value=\"0\">-- Select Year --</option>";
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								str = str + "<option value=\""+data[i]+"\">"
										+ data[i] + "</option>";
							}
						}
						str = str + "</select>";
						document.getElementById('sectionListDiv').innerHTML = str;
					}
				});
	}

	function listArea() {
		var str = "";
		OperationDashboardAjax
				.listAreas({
					callback : function(data) {
						str = str
								+ "<select name=\"Area\" onChange=\"getArea(this.value);\">";
						//str=str+"<option value=\"0\">-- Select Year --</option>";
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								str = str + "<option value=\""+data[i]+"\">"
										+ data[i] + "</option>";
							}
						}
						str = str + "</select>";
						document.getElementById('areaListDiv').innerHTML = str;
					}
				});
	}

	function listBranch() {
		var str = "";
		//alert("sad");
		OperationDashboardAjax
				.listBranch({
					callback : function(data) {
						//alert("sad");
						str = str
								+ "<select name=\"Branch\" onChange=\"getBranch(this.value);\">";
						//str=str+"<option value=\"0\">-- Select Year --</option>";
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								str = str
										+ "<option value=\""+data[i].branchCode+"\">"
										+ data[i].branchName + "</option>";
							}
						}
						str = str + "</select>";
						document.getElementById('branchListDiv').innerHTML = str;
					}
				});
	}
	
	function getSummaryMTD(year, month) {
		var str = "";
		//alert("sad");
		OperationDashboardAjax
				.getSummaryMTD(year, month, {
					callback : function(data) {
						alert(data.length);
						
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
						
		zingchart.render({
			id 			: 'chart_sales',
			width 		: 700,
			height 		: 250,
			data 		: barSales1
		});
	}});
	}
	
	function getSalesTrend(year, month, branch, area, section, division) {
		OperationDashboardAjax.getSalesTrend(year, month, branch, area, section, division, {
			callback : function(data) {
				alert(data.length);
			}
		});
	}

	$(function() {
		$("#datepicker").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "dd/mm/yy"
		});
	});
	
	$(function() {
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
		$('#dialog_link, ul#icons li').hover(function() {
			$(this).addClass('ui-state-hover');
		}, function() {
			$(this).removeClass('ui-state-hover');
		});
	});

	$(function() {
		// Bar charts using inline values
		$('.bar').sparkline('html', {
			type : 'bar'
		});
	});
	
	function goUrl() {
		//location.href = '<%//=request.getContextPath()%>/Dashboard/Operation/Operations.jsp?y='+y+'&months='+months+'&sb='+sb+'&div='+div+'&sect='+sect+'&zone='+zone+'&maj='+maj+'&b1=0&b2=0';
	}
</script>
<style type="text/css">
body {
	font: 55% "Trebuchet MS", sans-serif;
	margin: 50px;
}

.demoHeaders {
	margin-top: 1em;
}

#dialog_link {
	padding: .1em 1em .1em 20px;
	text-decoration: none;
	position: relative;
}

#dialog_link span.ui-icon {
	margin: 0 5px 0 0;
	position: absolute;
	top: 50%;
	margin-top: -8px;
}

ul#icons {
	margin: 0;
	padding: 0;
}

ul#icons li {
	margin: 1px;
	position: relative;
	padding: 1px 0;
	cursor: pointer;
	float: left;
	list-style: none;
}

ul#icons span.ui-icon {
	float: left;
	margin: 0 4px;
}

#tabs {
	top: 80px;
	left: 5px;
}
</style>
</head>
<body>
<!--         Parameter              -->
<div style="position: absolute; left: 45px; top: 20px;"><font
	size="3"> วันที่:</font><input type="text" name="datepicker"
	id="datepicker" /></div>
<div style="position: absolute; left: 430px; top: 20px;"><font
	size="3"> สรุปตาม : </font> <select name="SumBy"
	onChange="getSumBy(this.value);">
	<option value="1">MTD</option>
	<option value="2">YTD</option>
</select></div>
<div style="position: absolute; left: 20px; top: 50px;"><font
	size="3"> ฝ่าย : </font><span id="divisionListDiv"></span></div>
<div style="position: absolute; left: 250px; top: 50px;"><font
	size="3"> ส่วน : </font><span id="sectionListDiv"></span></div>
<div style="position: absolute; left: 460px; top: 50px;"><font
	size="3"> เขต : </font><span id="areaListDiv"></span></div>
<div style="position: absolute; left: 590px; top: 50px;"><font
	size="3"> สาขา : </font><span id="branchListDiv"></span></div>
<div style="position:absolute; left:760px; top:50px;">
		<input type="button" value=" OK " onClick="goUrl()"/>
</div>
<!-- End Parameter -->
<!--+++++++++++++++++++++++++ Tab Menu +++++++++++++++++++++++++-->
<div id="tabs" style="position: absolute;" bordercolor="#FFFFFF"
	border="5">
<ul>
	<li><a href="#tabs-t1">Summary</a></li>
	<li><a href="#tabs-t2">Detail</a></li>
	<li><a href="#tabs-t3">Map</a></li>
</ul>

<!--+++++++++++++++++++++++++ Tab Summary +++++++++++++++++++++++++-->
<table id="tabs-t1">
	<tr>
		<td>
		<table id="tabs-t1r1" width=1060>
			<tr bgcolor="#8B4513">
				<th><font color="#FFE742" size="3">ยอดขาย (ล้านบาท)</font></th>
			</tr>
			<tr>
				<td align="center">
				<div id="chart_sales"></div>
				</td>
			</tr>
			<!-- Chart -->
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
				<td>กำไรสูงสุด : <input type=text value=10><input type="button" name="ok" value=" OK "/></td>
				<td>Top : <input type=text value=10><input type="button" name="ok" value=" OK "/></td>
			</tr>
			<tr>
			<td><p></p>
				<table width=500 bordercolor="#000000" frame="box" rules="all">
				<tr bgcolor="#CD853F">
					<th><font color="#FFFFFF">#</font></th>
					<th><font color="#FFFFFF">สาขา</font></th>
					<th><font color="#FFFFFF">กำไร (บาท)</font></th>
					<th><font color="#FFFFFF">%GP</font></th>
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
					<th><font color="#FFFFFF">%Growth</font></th>
				</tr>
				<tr>
					<td align=center>1</td>
					<td align=center>ปิยรมย์ พาร์ค</td>
					<td align=right>950,000</td>
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
					<td align=right>7.5,000</td>
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
				<td>
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
					</table>
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
		</td>
	</tr>
</table>
</div>
<script type="text/javascript">
	listDivision();
	listSection();
	listArea();
	listBranch();
	getSummaryMTD(2011,3);
	getSalesTrend(2011,3,'ALL','ALL','ALL','ALL');
</script>
</body>
</html>