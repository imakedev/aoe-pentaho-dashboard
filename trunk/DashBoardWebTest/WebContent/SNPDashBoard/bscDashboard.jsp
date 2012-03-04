<!--
*********************************************************
*	EditDate	: April 2011							*
*	Project		: S&P BI Dashboard						*
*	Version		: Prototype Ver.001						*
*	Programmer	: Kriengkrai							*
*********************************************************
Integration Data
---------------------------------------------------------

---------------------------------------------------------
*********************************************************
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	<Title> S&P Dashboard </Title> </head>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<META HTTP-EQUIV="EXPIRES" CONTENT="-1" />
<%@ page contentType="text/html; charset=UTF-8" %>


<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-1.6.1.min.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/zingchart-html5beta-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/license.js"></script>
 

<!-- ----------------  My Custom          ------------------------- -->
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/kajax.js"></script>
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/customchart.css" rel="stylesheet"/> 

<!-- ---------------   TreeTable & Sparkline ----------------------- -->
<link	type="text/css"	href="<%=request.getContextPath()%>/chartLib/css/jquery.treeTable.css" rel="stylesheet"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.treeTable.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script> 

<!-- ---------------   Lib for Facebox       ----------------------- -->
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.facebox.css" media="screen" rel="stylesheet"/> 
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/facebox.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.dateFormat-1.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.number_format.js"></script>
 
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrbalancescorecard/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrbalancescorecard/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwrbalancescorecard/util.js"></script>
 <script type="text/javascript"
        	src="<%=request.getContextPath() %>/chartLib/js/bsc.js"></script>
<!-- Use for call JQuery treetable  -->
<script type="text/javascript">
var _path='<%=request.getContextPath()%>';

jQuery(document).ready(function($) {
	$.facebox.settings.closeImage=_path+'/chartLib/images/closelabel.png';
	$("#targetAllSparkline").facebox();
	listYear();
});
/*  -----------------  Use JQuery to Create Tree ------------------------*/

</script>
<!-- -------------------------------------------------------------------- --> 

<body>
 
<Table width="100%" border="0" height="50" charset="utf-8"> 
		<tr	id="r4">
			<td colspan="2" align="left" class="tdmainheader"> 
				<div align="center"> S&P Balanced Scorecard </div>
			</td>
		</tr>
		 <tr>
		    <td colspan="2">
		    <div id="bscKPIDetail" style="display:none;"></div>
		    </td>
		  </tr>
<!-- ----------------  Condition Combobox ----------------- -->
		<tr>
			<td colspan="2" align="left" class="tdcondition">
				<form method="post" action="<%=request.getContextPath()%>/SNPDashBoard/bscDashboard.jsp?viewKPI=1">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year : <span id="bscYearElement"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month :
				<select name="bscMonth" id="bscMonth" onchange="listOwnerResult()" >
					<option value="0">-- Select Month --</option>
					<option value="1">January</option>
					<option value="2">February</option>
					<option value="3">March</option>
					<option value="4">April</option>
					<option value="5">May</option>
					<option value="6">June</option>
					<option value="7">July</option>
					<option value="8">August</option>
					<option value="9">September</option>
					<option value="10">October</option>
					<option value="11">November</option>
					<option value="12">December</option>
				</select> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Owner : <span id="bscOwnerElement">
				<select name="bscOwner" id="bscOwner" onchange="clearTargetElement()">
					<option value="0">-- Select Owner --</option>
				</select>
				</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value=" View KPI " onclick="viewKPI()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a id="targetAllSparkline" rev="iframe|420">
				 <span class="targetAllElement" style="cursor: pointer;"></span>
				</a> 
				</form>
			  </td>
		  </tr> 
		 
		  <tr>
		  <td colspan="2">
		 
		  </td>
		  </tr>
		  <tr>
		    <td colspan="2">
		    <span id="perspectiveElement"></span>
		    </td>
		  </tr>
		   
	</Table> 
</body>
</html>