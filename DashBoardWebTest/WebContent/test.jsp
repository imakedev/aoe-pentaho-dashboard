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
 
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwroperationdashboard/interface/OperationDashboardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwroperationdashboard/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwroperationdashboard/util.js"></script>
 
 
<script type="text/javascript">  
jQuery(document).ready(function($) {
	alert("aoe")
	OperationDashboardAjax.listDivisions({
		callback:function(data){
			alert(data)
		}
	});
});
</script> 
</body>
</html>