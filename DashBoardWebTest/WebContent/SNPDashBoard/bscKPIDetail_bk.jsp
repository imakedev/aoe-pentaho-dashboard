<html>
<%@ page contentType="text/html; charset=UTF-8" %>
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/customchart.css" rel="stylesheet"/> 
<body>



<table width="700" height="300" border="1" align="center" style="text-decoration:none; background-color:	#e6e6fa" class="popup">
<tr><td width="140" colspan="1" class="tdpopup">KPI Name </td><td><% out.println( request.getParameter("head") ); %></td></tr>

<tr>
<td>Objective </td> <td>S4.2 Continuously improve business process </td>
</tr>

<tr>
<td>Formula</td><td>( Number of orders delivered stores on time in full in a given period / Total of orders ) x 100
</td>
</tr>

<tr>
<td>Definition </td><td>On time: on time will usually be the time agreed with stores. The agreed due date is the first date requested by stores not the renegotiated due date. This is to ensure whether the stores' original requirements have been met. Orders: are the unit of transaction with stores. 
In full: only orders or transactions that are complete should be considered to be 'on time'. This prevents delivery of incomplete orders to manipulate the measure and achieve ta
</td>
</tr>

<tr>
<td>Unit of measure</td><td>Percentage
</td>
</tr>

<tr>
<td>Source of information <br>/ Data collector</td>
<td>Operation department. <br>
Operation department will record the due date when the order is taken and received feedback from those delivering the product or service when delivery is completed. The Operation department should use this data to understand actual lead times so that they can quote and negotiate realistic lead times and due dates. 
</td>
</tr>

  <tr>
  <td>Target range
</td><td>Red <= 60%, Yellow 60% - <75%, Green 75%-100%
</td>
  </tr>
   
  <tr>
  <td>  Last revise</td><td>29/04/2011 00:00:00 </td>
  </tr>



</table>


</body>
</html>