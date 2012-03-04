<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/jquery.ui.all.css">
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/demos.css">
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.5.1.js"></script> 
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.ui.core.js"></script> 
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.ui.widget.js"></script>
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
		alert("listDivision");
		OperationDashboardAjax
				.listDivisions({
					callback : function(data) {
						alert(data);
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
		alert("sad");
		OperationDashboardAjax
				.listBranch({
					callback : function(data) {
						alert("sad");
						str = str
								+ "<select name=\"Branch\" onChange=\"getBranch(this.value);\">";
						//str=str+"<option value=\"0\">-- Select Year --</option>";
						if (data != null && data.length > 0) {
							for ( var i = 0; i < data.length; i++) {
								str = str + "<option value=\""+data[i].branchCode+"\">"
										+ data[i].branchName + "</option>";
							}
						}
						str = str + "</select>";
						document.getElementById('branchListDiv').innerHTML = str;
					}
				});
	}
	
	$(function() {
		$( "#datepicker" ).datepicker({
			changeMonth: true,
			changeYear: true, 
			dateFormat :"dd/mm/yy"
		});
	});
</script>

</head>
<body>
<table>
	<!--+++++++++++++++++++++++++ Parameter +++++++++++++++++++++++++-->
	<tr>
		<td colspan="2"><!--          Drop Down List YEAR              -->
		<div class="demo"><input type="text" name="datepicker" id="datepicker"/> 
		</div></td>
		<td><!--          Drop Down List SUMMARY BY            -->
		<div><font
			size="3"> สรุปตาม : </font> <select name="SumBy"
			onChange="getSumBy(this.value);">
			<option value="1">MTD</option>
			<option value="2">YTD</option>
		</select></div>
		</td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><!--          Drop Down List            -->
		<div><font
			size="3"> ฝ่าย : </font><span id="divisionListDiv"></span></div>
		</td>
		<td><!--          Drop Down List            -->
		<div><font
			size="3"> ส่วน : </font><span id="sectionListDiv"></span></div>
		</td>
		<td><!--          Drop Down List            -->
		<div><font
			size="3"> เขต : </font><span id="areaListDiv"></span></div>
		</td>
		<td><!--          Drop Down List            -->
		<div><font
			size="3"> สาขา : </font><span id="branchListDiv"></span></div>
		</td>
		<td>
		<div><input
			type="button" value=" OK " onClick="goUrl()" /></div>
		</td>
	</tr>
</table>
<div id="tabs" style="position:absolute; height=500px;" bordercolor="#FFFFFF" border="5">
	<ul>
		<li><a href="#tabs-t1">Summary</a></li>
		<li><a href="#tabs-t2">Detail</a></li>
		<li><a href="#tabs-t3">Map</a></li>
	</ul>
</div>
<!--+++++++++++++++++++++++++ End Parameter +++++++++++++++++++++++++-->
<script type="text/javascript">
	listDivision();
	//listSection();
	//listArea();
	//listBranch();
</script>

</body>
</html>