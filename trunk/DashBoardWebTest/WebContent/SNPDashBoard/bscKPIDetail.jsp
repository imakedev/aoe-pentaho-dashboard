<html>
<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-1.6.1.min.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/zingchart-html5beta-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/license.js"></script>
 

<!------------------  My Custom          --------------------------->
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/kajax.js"></script>
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/customchart.css" rel="stylesheet"/> 

<!-----------------   TreeTable & Sparkline ------------------------->
<link	type="text/css"	href="<%=request.getContextPath()%>/chartLib/css/jquery.treeTable.css" rel="stylesheet"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.treeTable.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script> 

<!-----------------   Lib for Facebox       ------------------------->
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.facebox.css" media="screen" rel="stylesheet"/> 
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/facebox.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.dateFormat-1.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.number_format.js"></script>
<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/util.js"></script>
<script>
function getParentLoop(parentID){
	 // var parentElement=document.getElementById(parentID);
	  if ($("#"+parentID)){
		  // do something here
		  var classValues= $("#"+parentID).attr("class");
		 // alert(classValues)
		  if(classValues!=null && classValues!='undefined' && classValues.length>0){
			 if(classValues.indexOf("child-of-")!=-1){
				 var classArray= classValues.split(" ");
			//	 alert(classArray.length);
				 if(classArray!=null && classArray.length>0){
					 var nextParentId="";
					 for(var i=0;i<classArray.length;i++){
						 if(classArray[i].indexOf("child-of-")!=-1){
							var nextParentId= classArray[i].split("child-of-")[1];							 
							//alert(nextParentId);
							break;
						 }
					 }
					 if(nextParentId.length>0)
					 	return getParentLoop(nextParentId)+" "+parentID; 
			  	} 
		  } 
		}
	}
 return parentID;
} 

</script>
<body> 

<table width="700" height="300" border="1" align="center" style="text-decoration:none; background-color:	#e6e6fa" class="popup">

<%--
<table width="700" height="300" border="1" align="center"> 
--%>
	<tr>
      <td width="140" colspan="1" class="tdpopup">KPI Name </td><td><div id="data_KPIDetail_kpiName"></div></td>
	</tr> 
	<tr>
		<td>Objective </td> <td><div id="data_KPIDetail_objective"></div></td>
	</tr>
	<tr>
		<td>Formula</td><td><div id="data_KPIDetail_formulaDesc"></div></td> 
	</tr>
	<tr>
	   <td>Definition </td><td><div id="data_KPIDetail_kpiDesc"></div></td>
	</tr>
	<tr>
	   <td>Unit of measure</td><td><div id="data_KPIDetail_uom"></div></td>
	</tr>
	<tr>
		<td>Source of information <br>/ Data collector</td><td><div id="data_KPIDetail_dataSource"></div></td>
	</tr> 
	<tr>
		<td>Target range</td><td><div id="data_KPIDetail_targetRangeDesc"></div></td>
	</tr>
	<tr>
		<td>  Last revise</td><td><div id="data_KPIDetail_lastRevisedDT"></div></td>
	</tr>
</table>	
<script>
var kpiKeyDetail='<%=request.getParameter("kpiKey")%>';
var dateKeyDetail='<%=request.getParameter("dateKey")%>';
//alert(dateKeyDetail)
$(document).ready(function() { 
	   var pk={
			   kpiKey:kpiKeyDetail,
			   dateKey:dateKeyDetail
	   }; 
	   BalanceScorecardAjax.getKPIDetail(pk,{
			callback:function(data_KPIDetail){ 
				  if(data_KPIDetail!=null){
					  document.getElementById('data_KPIDetail_kpiName').innerHTML= data_KPIDetail.kpiName;
					  document.getElementById('data_KPIDetail_objective').innerHTML= data_KPIDetail.objective;
					  document.getElementById('data_KPIDetail_formulaDesc').innerHTML= data_KPIDetail.formulaDesc;
					  document.getElementById('data_KPIDetail_kpiDesc').innerHTML= data_KPIDetail.kpiDesc;
					  document.getElementById('data_KPIDetail_uom').innerHTML= data_KPIDetail.uom;
					  document.getElementById('data_KPIDetail_dataSource').innerHTML= data_KPIDetail.dataSource;
					  document.getElementById('data_KPIDetail_targetRangeDesc').innerHTML= data_KPIDetail.targetRangeDesc;
					  document.getElementById('data_KPIDetail_lastRevisedDT').innerHTML= data_KPIDetail.lastRevisedDT;
				  
				 } 
			}
		});
	var tag = document.createElement("script"); 
	tag.type = 'text/javascript';
	tag.src = '../chartLib/js/aoe.js';
	document.body.appendChild(tag);
});

</script>
<%--
<div id="kpiDetailResultElement"></div>
 --%>
</body>
</html>