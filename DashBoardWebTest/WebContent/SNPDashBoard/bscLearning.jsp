<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> <title>Learning & Growth treeview</title> </head>
<%@ page contentType="text/html; charset=UTF-8" %>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<META HTTP-EQUIV="EXPIRES" CONTENT="-1" />

<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>
<link type="text/css" href="<%=request.getContextPath()%>/chartLib/css/jquery.treeTable.css" rel="stylesheet"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.treeTable.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.sparkline.js"></script>

<body>

<%
String KPIWidth = new String("43%");
String InfoWidth = new String ("20px");
String WeightWidth = new String ("6%");
String FreqWidth = new String ("4%");
String TargetWidth = new String ("7%");
String ActualWidth = new String ("7%");
String PerTargetWidth = new String ("10%");
String TrendWidth = new String ("10%");
String ETLWidth = new String ("12%");

String SRC=request.getContextPath()+"/chartLib/images/question_shield.ico";
String ImgWidth = new String("20px");
String ImgHeight = new String("20px");
%>
	
	<table id="LearningTree" width="100%" height="20"  border="1"  background-color: #CD853F;>
	
			<tr height="5" align="center">
				<td width="<% out.println(KPIWidth);%>" class="tdsubheader">KPI</td>		
				<td width="<% out.println(InfoWidth);%>" class="tdsubheader"></td>	
				<td width="<% out.println(WeightWidth);%>" class="tdsubheader">Weight</td>		
				<td width="<% out.println(FreqWidth);%>" class="tdsubheader">Freq</td>		
				<td width="<% out.println(TargetWidth);%>%" class="tdsubheader">Target</td> 
				<td width="<% out.println(ActualWidth);%>%" class="tdsubheader">Actual</td>		
				<td width="<% out.println(PerTargetWidth);%>%" class="tdsubheader">% Target</td>	
				<td width="<% out.println(TrendWidth);%>%" class="tdsubheader">Trend</td>
				<td width="<% out.println(ETLWidth);%>%"	class="tdsubheader" >Last Updated</td>
			</tr>
		
	
			<tr id="LearningNode-L1-1" height="5" >
				<td width="<% out.println(KPIWidth);%>" style="padding-left: 20px;">
				<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head="+ "OverAll'" +",'ifrmgr4')"); %> >
				Employee turnover rate(%) : OverAll</a></td>

				<td width="<% out.println(InfoWidth);%>"  align="right">
				<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
				<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
				</td>

				<td width="<% out.println(WeightWidth);%>"  align="right">80%</td>			
				<td width="4%" align="right">Q</td>		
				<td width="7%"  align="right">14.45</td>		<td width="7%" align="right">10.89</td>		
				<td width="7%" align="center"><span class="targetLearningNode-1" title="38%">50,38,60,40,20</span></td>		
				<td width="7%" align="center"><span class="trendLearningNode-1" LineColor="red" ></span></td>
				<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
			</tr>
					<tr id="LearningNode-L1-1-1" class="child-of-LearningNode-L1-1" > 
						<td width="<% out.println(KPIWidth);%>">
						<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head="+ "Management'" +",'ifrmgr4')"); %> >
						Employee turnover rate(%) : Management</a></td>

						<td width="<% out.println(InfoWidth);%>"  align="right">
						<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
						<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
						</td>

						<td width="<% out.println(WeightWidth);%>"  align="right">50%</td>		
						<td width="4%" align="right">M</td>		
						<td width="7%"  align="right">14.50</td>		<td width="7%" align="right">9.50</td>		
						<td width="7%" align="center"><span class="targetLearningNode-2" title="27%">50,27,60,40,20</span></td>	
						<td width="7%" align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
						<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
					</tr>
					<tr id="LearningNode-L1-1-2" class="child-of-LearningNode-L1-1">
						<td width="<% out.println(KPIWidth);%>">
						<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head="+ "Operation'" +",'ifrmgr4')"); %> >
						Employee turnover rate(%) : Operation</a></td>

						<td width="<% out.println(InfoWidth);%>"  align="right">
						<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
						<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
						</td>

						<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
						<td width="4%" align="right">M</td>		
						<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
						<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
						<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
						<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
					</tr>
					<tr id="LearningNode-L1-1-3" class="child-of-LearningNode-L1-1">
						<td width="<% out.println(KPIWidth);%>">
						<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head="+ "Manufacturing'" +",'ifrmgr4')"); %> >
						Employee turnover rate(%) : Manufacturing</a></td>

						<td width="<% out.println(InfoWidth);%>"  align="right">
						<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
						<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
						</td>

						<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
						<td width="4%" align="right">M</td>		
						<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
						<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
						<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
						<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
					</tr>
					<tr id="LearningNode-L1-1-4" class="child-of-LearningNode-L1-1">
						<td width="<% out.println(KPIWidth);%>">
						<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head="+ "Support'" +",'ifrmgr4')"); %> >
						Employee turnover rate(%) : Support</a></td>

						<td width="<% out.println(InfoWidth);%>"  align="right">
						<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
						<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
						</td>

						<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
						<td width="4%" align="right">M</td>		
						<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
						<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
						<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
						<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
					</tr>
							
				
					<tr id="LearningNode-L1-1-5" class="child-of-LearningNode-L1-1">
						<td width="<% out.println(KPIWidth);%>" style="text-indent:-5px">
						<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head=Talent/Key%20staff'" +",'ifrmgr4')"); %> > 
						Employee turnover rate(%) : Talent/Key staff</a></td>

						<td width="<% out.println(InfoWidth);%>"  align="right">
						<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
						<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
						</td>

						<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
						<td width="4%" align="right">M</td>		
						<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
						<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
						<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
						<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
					</tr>

								<tr id="LearningNode-L1-1-5-1" class="child-of-LearningNode-L1-1-5">
											<td width="<% out.println(KPIWidth);%>">
											<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head=Caree%20paths'" +",'ifrmgr4')"); %> >
											Career paths</a></td>

											<td width="<% out.println(InfoWidth);%>"  align="right">
											<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
											<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
											</td>

											<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
											<td width="4%" align="right">M</td>		
											<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
											<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
											<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
											<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
								</tr>
											<tr id="LearningNode-L1-1-5-1-1" class="child-of-LearningNode-L1-1-5-1">
													<td width="<% out.println(KPIWidth);%>">
													<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head="+ "Maneger%20Level(Specialist)'" +",'ifrmgr4')"); %> >
													Q4:Maneger Level(Specialist)</a></td>

													<td width="<% out.println(InfoWidth);%>"  align="right">
													<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
													<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
													</td>

													<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
													<td width="4%" align="right">M</td>		
													<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
													<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
													<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
													<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
											</tr>

								<tr id="LearningNode-L1-1-5-2" class="child-of-LearningNode-L1-1-5">
											<td width="<% out.println(KPIWidth);%>" style="text-indent:5px">
											<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head=Job%20Satisfction%20(percent)'" +",'ifrmgr4')"); %> >
											Job Satisfction(%)</a></td>

											<td width="<% out.println(InfoWidth);%>"  align="right">
											<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
											<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
											</td>

											<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
											<td width="4%" align="right">M</td>		
											<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
											<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
											<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
											<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
								</tr>

								<tr id="LearningNode-L1-1-5-3" class="child-of-LearningNode-L1-1-5">
											<td width="<% out.println(KPIWidth);%>">
											<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head=Development%20Program(couse)'" +",'ifrmgr4')"); %> >
											Development Program(#couse)</a></td>

											<td width="<% out.println(InfoWidth);%>"  align="right">
											<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
											<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
											</td>

											<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
											<td width="4%" align="right">M</td>		
											<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
											<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
											<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
											<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
								</tr>

											<tr id="LearningNode-L1-1-5-3-1" class="child-of-LearningNode-L1-1-5-3">
													<td width="<% out.println(KPIWidth);%>">
													<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head=Training%20Roadmap'" +",'ifrmgr4')"); %> >
													Training Roadmap Q1-Q4:100%</a></td>

													<td width="<% out.println(InfoWidth);%>"  align="right">
													<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
													<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
													</td>

													<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
													<td width="4%" align="right">M</td>		
													<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
													<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
													<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
													<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
											</tr>

								<tr id="LearningNode-L1-1-5-4" class="child-of-LearningNode-L1-1-5">
											<td width="<% out.println(KPIWidth);%>">
											<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head=Remuneration%20review%20(percent%20progress)'" +",'ifrmgr4')"); %> >
											Remuneration review (%progress)</a></td>

											<td width="<% out.println(InfoWidth);%>"  align="right">
											<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
											<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
											</td>

											<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
											<td width="4%" align="right">M</td>		
											<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
											<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
											<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
											<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
								</tr>
											
											<tr id="LearningNode-L1-1-5-4-1" class="child-of-LearningNode-L1-1-5-4">
													<td width="<% out.println(KPIWidth);%>">
													<a href= <% out.println("javascript:loadmetergraph('mixChart.jsp?head=Remuneration','ifrmgr4')"); %> >
													Remuneration Q4:100%</a></td>

													<td width="<% out.println(InfoWidth);%>"  align="right">
													<a href="bscKPIDetail.jsp?head=Employee turnover rate" rel="facebox"> 
													<img src="<% out.println(SRC); %>" width="<% out.println(ImgWidth); %>" BORDER ="0"/></a>
													</td>

													<td width="<% out.println(WeightWidth);%>"  align="right">70%</td>		
													<td width="4%" align="right">M</td>		
													<td width="7%"  align="right">10.50</td>		<td width="7%" align="right">4.60</td>		
													<td width="7%" align="center"><span class="targetLearningNode-2" title="21.9%">50,21.9,60,40,20</span></td>	
													<td width="7%"  align="center"><span class="trendLearningNode-2" LineColor="red" ></span></td>
													<td width="<% out.println(ETLWidth);%>%" align="right">28/03/2011 00:00:00</td>
											</tr>
					
			
					
	</table>
	



<script type="text/javascript">
// have no effect when call by ajax
// only run for this stand alone page
/*
	$(document).ready(function()  {

		$('.targetLearningNode-1').sparkline('html', {type: 'bullet', TargetColor: 'red' , width:"60px"  } );
		$('.targetLearningNode-2').sparkline('html', {type: 'bullet', TargetColor: 'red' , width:"60px"  } );

		var kvalue = [1,2,3,4,5,6,7,8,9,10,11,12];
        $('.trendLearningNode-1').sparkline(kvalue , {barColor: 'red' , }); 
		var kvalue = [5,9,2,9,3,9,4,9,5,9,6,9,7,9];
		$('.trendLearningNode-2').sparkline(kvalue , {barColor: 'red' , }); 

		$("#tree").treeTable();
	  //$('#tree').columnTreeTable();
	});
*/
	</script>

</body>
</html>