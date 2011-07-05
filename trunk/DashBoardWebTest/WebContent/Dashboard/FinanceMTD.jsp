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
	</script>
	<style type="text/css">
		body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}
		.demoHeaders { margin-top: 1em; }
		#dialog_link {padding: .1em 1em .1em 20px;text-decoration: none;position: relative;}
		#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;top: 50%;margin-top: -8px;}
		ul#icons {margin: 0; padding: 0;}
		ul#icons li {margin: 1px; position: relative; padding: 1px 0; cursor: pointer; float: left;  list-style: none;}
		ul#icons span.ui-icon {float: left; margin: 0 4px;}
		#tabs { position:absolute; width:1325px; top:60px; left:5px; height:750px; }
		#tabs-ratio { position:absolute; left:3px; top:45px; }
		#tabs-ratio1 { position:absolute; left:3px; top:45px; }
	</style>
	
<%
	String y = request.getParameter("y"); // Value of Year Parameter.
	String months = request.getParameter("months"); // Value of Month Parameter.
	String sb = request.getParameter("sb"); // Value of Summary By Parameter.
	String country = request.getParameter("country"); // Value of Country Parameter.
	String month = ""; // Name of month (Jan -> Dec)

	String LastActV1 = ""; // Value of Last Actual in chart01
	String ThisActV1 = ""; // Value of This Actual in chart01
	String TargetV1 = ""; // Value of Target in chart01
	String perVarianceV1 = ""; // Value of %Variance in chart01
	String perGrowthV1 = ""; // Value of %Growth in chart01

	String LastActV2 = ""; // Value of Last Actual in chart02
	String ThisActV2 = ""; // Value of This Actual in chart02
	String TargetV2 = ""; // Value of Target in chart02
	String perVarianceV2 = ""; // Value of %Variance in chart02
	String perGrowthV2 = ""; // Value of %Growth in chart02

	String LastActV3 = ""; // Value of Last Actual in chart03
	String ThisActV3 = ""; // Value of This Actual in chart03
	String TargetV3 = ""; // Value of Target in chart03
	String perVarianceV3 = ""; // Value of %Variance in chart03
	String perGrowthV3 = ""; // Value of %Growth in chart03

	String LastActV4 = ""; // Value of Last Actual in chart04
	String ThisActV4 = ""; // Value of This Actual in chart04
	String TargetV4 = ""; // Value of Target in chart04
	String perVarianceV4 = ""; // Value of %Variance in chart04
	String perGrowthV4 = ""; // Value of %Growth in chart04

	switch(Integer.parseInt(months))
	{
		case 1 : month = "Jan";
			LastActV1 = "349290.69";
			ThisActV1 = "393970.68";
			TargetV1 = "403274.18";
			perVarianceV1 = "-2.31";
			perGrowthV1 = "12.79";

			LastActV2 = "184168.87";
			ThisActV2 = "195305.89";
			TargetV2 = "203258.65";
			perVarianceV2 = "-3.91";
			perGrowthV2 = "6.05";

			LastActV3 = "121112.31";
			ThisActV3 = "150401.66";
			TargetV3 = "150191.20";
			perVarianceV3 = "0.14";
			perGrowthV3 = "24.18";

			LastActV4 = "1048726";
			ThisActV4 = "1148726";
			TargetV4 = "1000000";
			perVarianceV4 = "30";
			perGrowthV4 = "50";

			break;

		case 2 : month = "Feb";
			LastActV1 = "349290.69,289439.46";
			ThisActV1 = "393970.68,340642.51";
			TargetV1 = "403274.18,344501.28";
			perVarianceV1 = "-2.31,-1.12";
			perGrowthV1 = "12.79,17.69";

			LastActV2 = "184168.87,156257.00";
			ThisActV2 = "195305.89,168903.88";
			TargetV2 = "203258.65,174677.29";
			perVarianceV2 = "-3.91,-3.31";
			perGrowthV2 = "6.05,8.09";

			LastActV3 = "121112.31,95225.66";
			ThisActV3 = "150401.66,126021.01";
			TargetV3 = "150191.20,120865.71";
			perVarianceV3 = "0.14,4.27";
			perGrowthV3 = "24.18,32.34";

			LastActV4 = "8861587,8753279";
			ThisActV4 = "641357,1068221";
			TargetV4 = "8220230,7685058";
			perVarianceV4 = "30,39";
			perGrowthV4 = "42,47";

			break;

		case 3 : month = "Mar";
			LastActV1 = "349290.69,289439.46,334740.72";
			ThisActV1 = "393970.68,340642.51,372209.03";
			TargetV1 = "403274.18,344501.28,361373.27";
			perVarianceV1 = "-2.31,-1.12,3.00";
			perGrowthV1 = "12.79,17.69,11.19";

			LastActV2 = "184168.87,156257.00,176122.22";
			ThisActV2 = "195305.89,168903.88,183040.13";
			TargetV2 = "203258.65,174677.29,188784.68";
			perVarianceV2 = "-3.91,-3.31,-3.04";
			perGrowthV2 = "6.05,8.09,3.93";

			LastActV3 = "121112.31,95225.66,111807.21";
			ThisActV3 = "150401.66,126021.01,136374.73";
			TargetV3 = "150191.20,120865.71,122017.04";
			perVarianceV3 = "0.14,4.27,11.77";
			perGrowthV3 = "24.18,32.34,21.97";

			LastActV4 = "8861587,8753279,2548349";
			ThisActV4 = "641357,1068221,446077";
			TargetV4 = "8220230,7685058,2102272";
			perVarianceV4 = "30,39,48";
			perGrowthV4 = "42,47,48";

			break;

		case 4 : month = "Apr";
			LastActV1 = "349290.69,289439.46,334740.72,325053.87";
			ThisActV1 = "393970.68,340642.51,372209.03,346070.01";
			TargetV1 = "403274.18,344501.28,361373.27,347975.37";
			perVarianceV1 = "-2.31,-1.12,3.00,-0.55";
			perGrowthV1 = "12.79,17.69,11.19,6.47";

			LastActV2 = "184168.87,156257.00,176122.22,165411.25";
			ThisActV2 = "195305.89,168903.88,183040.13,175555.86";
			TargetV2 = "203258.65,174677.29,188784.68,178495.62";
			perVarianceV2 = "-3.91,-3.31,-3.04,-1.65";
			perGrowthV2 = "6.05,8.09,3.93,6.13";

			LastActV3 = "121112.31,95225.66,111807.21,115158.35";
			ThisActV3 = "150401.66,126021.01,136374.73,125164.07";
			TargetV3 = "150191.20,120865.71,122017.04,119850.84";
			perVarianceV3 = "0.14,4.27,11.77,4.43";
			perGrowthV3 = "24.18,32.34,21.97,8.69";

			LastActV4 = "8861587,8753279,2548349,2380802";
			ThisActV4 = "641357,1068221,446077,340199";
			TargetV4 = "8220230,7685058,2102272,2040603";
			perVarianceV4 = "30,39,48,49";
			perGrowthV4 = "42,47,48,48";

			break;

		case 5 : month = "May";
			LastActV1 = "349290.69,289439.46,334740.72,325053.87,319829.16";
			ThisActV1 = "393970.68,340642.51,372209.03,346070.01,354454.13";
			TargetV1 = "403274.18,344501.28,361373.27,347975.37,356081.45";
			perVarianceV1 = "-2.31,-1.12,3.00,-0.55,-0.46";
			perGrowthV1 = "12.79,17.69,11.19,6.47,10.83";

			LastActV2 = "184168.87,156257.00,176122.22,165411.25,166159.84";
			ThisActV2 = "195305.89,168903.88,183040.13,175555.86,174266.10";
			TargetV2 = "203258.65,174677.29,188784.68,178495.62,178202.64";
			perVarianceV2 = "-3.91,-3.31,-3.04,-1.65,-2.21";
			perGrowthV2 = "6.05,8.09,3.93,6.13,4.88";

			LastActV3 = "121112.31,95225.66,111807.21,115158.35,111685.68";
			ThisActV3 = "150401.66,126021.01,136374.73,125164.07,135768.80";
			TargetV3 = "150191.20,120865.71,122017.04,119850.84,131773.12";
			perVarianceV3 = "0.14,4.27,11.77,4.43,3.03";
			perGrowthV3 = "24.18,32.34,21.97,8.69,21.56";

			LastActV4 = "8861587,8753279,2548349,2380802,3262142";
			ThisActV4 = "641357,1068221,446077,340199,1640702";
			TargetV4 = "8220230,7685058,2102272,2040603,1621440";
			perVarianceV4 = "30,39,48,49,52";
			perGrowthV4 = "42,47,48,48,48";

			break;

		case 6 : month = "Jun";
			LastActV1 = "349290.69,289439.46,334740.72,325053.87,319829.16,329195.55";
			ThisActV1 = "393970.68,340642.51,372209.03,346070.01,354454.13,377622.19";
			TargetV1 = "403274.18,344501.28,361373.27,347975.37,356081.45,371401.74";
			perVarianceV1 = "-2.31,-1.12,3.00,-0.55,-0.46,1.67";
			perGrowthV1 = "12.79,17.69,11.19,6.47,10.83,14.71";

			LastActV2 = "184168.87,156257.00,176122.22,165411.25,166159.84,163692.33";
			ThisActV2 = "195305.89,168903.88,183040.13,175555.86,174266.10,180366.81";
			TargetV2 = "203258.65,174677.29,188784.68,178495.62,178202.64,177230.84";
			perVarianceV2 = "-3.91,-3.31,-3.04,-1.65,-2.21,1.77";
			perGrowthV2 = "6.05,8.09,3.93,6.13,4.88,10.19";

			LastActV3 = "121112.31,95225.66,111807.21,115158.35,111685.68,114957.15";
			ThisActV3 = "150401.66,126021.01,136374.73,125164.07,135768.80,143137.54";
			TargetV3 = "150191.20,120865.71,122017.04,119850.84,131773.12,136036.91";
			perVarianceV3 = "0.14,4.27,11.77,4.43,3.03,5.22";
			perGrowthV3 = "24.18,32.34,21.97,8.69,21.56,24.51";

			LastActV4 = "8861587,8753279,2548349,2380802,3262142,3023343";
			ThisActV4 = "641357,1068221,446077,340199,1640702,1499906";
			TargetV4 = "8220230,7685058,2102272,2040603,1621440,1523437";
			perVarianceV4 = "30,39,48,49,52,50";
			perGrowthV4 = "42,47,48,48,48,50";

			break;

		case 7 : month = "Jul";
			LastActV1 = "349290.69,289439.46,334740.72,325053.87,319829.16,329195.55,361280.34";
			ThisActV1 = "393970.68,340642.51,372209.03,346070.01,354454.13,377622.19,407092.97";
			TargetV1 = "403274.18,344501.28,361373.27,347975.37,356081.45,371401.74,410555.30";
			perVarianceV1 = "-2.31,-1.12,3.00,-0.55,-0.46,1.67,-0.84";
			perGrowthV1 = "12.79,17.69,11.19,6.47,10.83,14.71,12.68";

			LastActV2 = "184168.87,156257.00,176122.22,165411.25,166159.84,163692.33,181538.59";
			ThisActV2 = "195305.89,168903.88,183040.13,175555.86,174266.10,180366.81,203632.04";
			TargetV2 = "203258.65,174677.29,188784.68,178495.62,178202.64,177230.84,191186.98";
			perVarianceV2 = "-3.91,-3.31,-3.04,-1.65,-2.21,1.77,6.51";
			perGrowthV2 = "6.05,8.09,3.93,6.13,4.88,10.19,12.17";

			LastActV3 = "121112.31,95225.66,111807.21,115158.35,111685.68,114957.15,130060.99";
			ThisActV3 = "150401.66,126021.01,136374.73,125164.07,135768.80,143137.54,154294.27";
			TargetV3 = "150191.20,120865.71,122017.04,119850.84,131773.12,136036.91,167945.94";
			perVarianceV3 = "0.14,4.27,11.77,4.43,3.03,5.22,-8.13";
			perGrowthV3 = "24.18,32.34,21.97,8.69,21.56,24.51,18.63";

			LastActV4 = "8861587,8753279,2548349,2380802,3262142,3023343,2555507";
			ThisActV4 = "641357,1068221,446077,340199,1640702,1499906,1190894";
			TargetV4 = "8220230,7685058,2102272,2040603,1621440,1523437,1364613";
			perVarianceV4 = "30,39,48,49,52,50,51";
			perGrowthV4 = "42,47,48,48,48,50,51";

			break;

		case 8 : month = "Aug";
			LastActV1 = "349290.69,289439.46,334740.72,325053.87,319829.16,329195.55,361280.34,368751.43";
			ThisActV1 = "393970.68,340642.51,372209.03,346070.01,354454.13,377622.19,407092.97,440248.01";
			TargetV1 = "403274.18,344501.28,361373.27,347975.37,356081.45,371401.74,410555.30,446265.71";
			perVarianceV1 = "-2.31,-1.12,3.00,-0.55,-0.46,1.67,-0.84,-1.35";
			perGrowthV1 = "12.79,17.69,11.19,6.47,10.83,14.71,12.68,19.39";

			LastActV2 = "184168.87,156257.00,176122.22,165411.25,166159.84,163692.33,181538.59,190718.66";
			ThisActV2 = "195305.89,168903.88,183040.13,175555.86,174266.10,180366.81,203632.04,214081.70";
			TargetV2 = "203258.65,174677.29,188784.68,178495.62,178202.64,177230.84,191186.98,203790.90";
			perVarianceV2 = "-3.91,-3.31,-3.04,-1.65,-2.21,1.77,6.51,5.05";
			perGrowthV2 = "6.05,8.09,3.93,6.13,4.88,10.19,12.17,12.25";

			LastActV3 = "121112.31,95225.66,111807.21,115158.35,111685.68,114957.15,130060.99,130288.21";
			ThisActV3 = "150401.66,126021.01,136374.73,125164.07,135768.80,143137.54,154294.27,161338.70";
			TargetV3 = "150191.20,120865.71,122017.04,119850.84,131773.12,136036.91,167945.94,168305.13";
			perVarianceV3 = "0.14,4.27,11.77,4.43,3.03,5.22,-8.13,-4.14";
			perGrowthV3 = "24.18,32.34,21.97,8.69,21.56,24.51,18.63,23.83";

			LastActV4 = "8861587,8753279,2548349,2380802,3262142,3023343,2555507,6767281";
			ThisActV4 = "641357,1068221,446077,340199,1640702,1499906,1190894,1873229";
			TargetV4 = "8220230,7685058,2102272,2040603,1621440,1523437,1364613,4894052";
			perVarianceV4 = "30,39,48,49,52,50,51,54";
			perGrowthV4 = "42,47,48,48,48,50,51,52";

			break;

		case 9 : month = "Sep";
			LastActV1 = "349290.69,289439.46,334740.72,325053.87,319829.16,329195.55,361280.34,368751.43,460771.92";
			ThisActV1 = "393970.68,340642.51,372209.03,346070.01,354454.13,377622.19,407092.97,440248.01,541778.87";
			TargetV1 = "403274.18,344501.28,361373.27,347975.37,356081.45,371401.74,410555.30,446265.71,529870.57";
			perVarianceV1 = "-2.31,-1.12,3.00,-0.55,-0.46,1.67,-0.84,-1.35,2.25";
			perGrowthV1 = "12.79,17.69,11.19,6.47,10.83,14.71,12.68,19.39,17.58";

			LastActV2 = "184168.87,156257.00,176122.22,165411.25,166159.84,163692.33,181538.59,190718.66,255666.87";
			ThisActV2 = "195305.89,168903.88,183040.13,175555.86,174266.10,180366.81,203632.04,214081.70,269889.20";
			TargetV2 = "203258.65,174677.29,188784.68,178495.62,178202.64,177230.84,191186.98,203790.90,264386.53";
			perVarianceV2 = "-3.91,-3.31,-3.04,-1.65,-2.21,1.77,6.51,5.05,2.08";
			perGrowthV2 = "6.05,8.09,3.93,6.13,4.88,10.19,12.17,12.25,5.56";

			LastActV3 = "121112.31,95225.66,111807.21,115158.35,111685.68,114957.15,130060.99,130288.21,160555.47";
			ThisActV3 = "150401.66,126021.01,136374.73,125164.07,135768.80,143137.54,154294.27,161338.70,196506.24";
			TargetV3 = "150191.20,120865.71,122017.04,119850.84,131773.12,136036.91,167945.94,168305.13,201908.01";
			perVarianceV3 = "0.14,4.27,11.77,4.43,3.03,5.22,-8.13,-4.14,-2.68";
			perGrowthV3 = "24.18,32.34,21.97,8.69,21.56,24.51,18.63,23.83,22.39";

			LastActV4 = "8861587,8753279,2548349,2380802,3262142,3023343,2555507,6767281,7226174";
			ThisActV4 = "641357,1068221,446077,340199,1640702,1499906,1190894,1873229,1746897";
			TargetV4 = "8220230,7685058,2102272,2040603,1621440,1523437,1364613,4894052,5479277";
			perVarianceV4 = "30,39,48,49,52,50,51,54,54,";
			perGrowthV4 = "42,47,48,48,48,50,51,52,52";

			break;

		case 10 : month = "Oct";
			LastActV1 = "349290.69,289439.46,334740.72,325053.87,319829.16,329195.55,361280.34,368751.43,460771.92,389552.27";
			ThisActV1 = "393970.68,340642.51,372209.03,346070.01,354454.13,377622.19,407092.97,440248.01,541778.87,404931.67";
			TargetV1 = "403274.18,344501.28,361373.27,347975.37,356081.45,371401.74,410555.30,446265.71,529870.57,384364.06";
			perVarianceV1 = "-2.31,-1.12,3.00,-0.55,-0.46,1.67,-0.84,-1.35,2.25,5.35";
			perGrowthV1 = "12.79,17.69,11.19,6.47,10.83,14.71,12.68,19.39,17.58,3.95";

			LastActV2 = "184168.87,156257.00,176122.22,165411.25,166159.84,163692.33,181538.59,190718.66,255666.87,201329.13";
			ThisActV2 = "195305.89,168903.88,183040.13,175555.86,174266.10,180366.81,203632.04,214081.70,269889.20,205279.84";
			TargetV2 = "203258.65,174677.29,188784.68,178495.62,178202.64,177230.84,191186.98,203790.90,264386.53,188585.84";
			perVarianceV2 = "-3.91,-3.31,-3.04,-1.65,-2.21,1.77,6.51,5.05,2.08,8.85";
			perGrowthV2 = "6.05,8.09,3.93,6.13,4.88,10.19,12.17,12.25,5.56,1.96";

			LastActV3 = "121112.31,95225.66,111807.21,115158.35,111685.68,114957.15,130060.99,130288.21,160555.47,140692.52";
			ThisActV3 = "150401.66,126021.01,136374.73,125164.07,135768.80,143137.54,154294.27,161338.70,196506.24,147713.15";
			TargetV3 = "150191.20,120865.71,122017.04,119850.84,131773.12,136036.91,167945.94,168305.13,201908.01,139236.04";
			perVarianceV3 = "0.14,4.27,11.77,4.43,3.03,5.22,-8.13,-4.14,-2.68,6.09";
			perGrowthV3 = "24.18,32.34,21.97,8.69,21.56,24.51,18.63,23.83,22.39,4.99";

			LastActV4 = "8861587,8753279,2548349,2380802,3262142,3023343,2555507,6767281,7226174,5608110";
			ThisActV4 = "641357,1068221,446077,340199,1640702,1499906,1190894,1873229,1746897,377508";
			TargetV4 = "8220230,7685058,2102272,2040603,1621440,1523437,1364613,4894052,5479277,5230602";
			perVarianceV4 = "30,39,48,49,52,50,51,54,54,55";
			perGrowthV4 = "42,47,48,48,48,50,51,52,52,58";

			break;

		case 11 : month = "Nov";
			LastActV1 = "349290.69,289439.46,334740.72,325053.87,319829.16,329195.55,361280.34,368751.43,460771.92,389552.27,362060.88,";
			ThisActV1 = "393970.68,340642.51,372209.03,346070.01,354454.13,377622.19,407092.97,440248.01,541778.87,404931.67,420453.06";
			TargetV1 = "403274.18,344501.28,361373.27,347975.37,356081.45,371401.74,410555.30,446265.71,529870.57,384364.06,399121.39";
			perVarianceV1 = "-2.31,-1.12,3.00,-0.55,-0.46,1.67,-0.84,-1.35,2.25,5.35,5.34";
			perGrowthV1 = "12.79,17.69,11.19,6.47,10.83,14.71,12.68,19.39,17.58,3.95,16.13";

			LastActV2 = "184168.87,156257.00,176122.22,165411.25,166159.84,163692.33,181538.59,190718.66,255666.87,201329.13,175766.78";
			ThisActV2 = "195305.89,168903.88,183040.13,175555.86,174266.10,180366.81,203632.04,214081.70,269889.20,205279.84,189979.85";
			TargetV2 = "203258.65,174677.29,188784.68,178495.62,178202.64,177230.84,191186.98,203790.90,264386.53,188585.84,190611.28";
			perVarianceV2 = "-3.91,-3.31,-3.04,-1.65,-2.21,1.77,6.51,5.05,2.08,8.85,-0.33";
			perGrowthV2 = "6.05,8.09,3.93,6.13,4.88,10.19,12.17,12.25,5.56,1.96,8.09";

			LastActV3 = "121112.31,95225.66,111807.21,115158.35,111685.68,114957.15,130060.99,130288.21,160555.47,140692.52,122592.37";
			ThisActV3 = "150401.66,126021.01,136374.73,125164.07,135768.80,143137.54,154294.27,161338.70,196506.24,147713.15,145070.32";
			TargetV3 = "150191.20,120865.71,122017.04,119850.84,131773.12,136036.91,167945.94,168305.13,201908.01,139236.04,135831.53";
			perVarianceV3 = "0.14,4.27,11.77,4.43,3.03,5.22,-8.13,-4.14,-2.68,6.09,6.80,";
			perGrowthV3 = "24.18,32.34,21.97,8.69,21.56,24.51,18.63,23.83,22.39,4.99,18.34";

			LastActV4 = "8861587,8753279,2548349,2380802,3262142,3023343,2555507,6767281,7226174,5608110,1605731";
			ThisActV4 = "641357,1068221,446077,340199,1640702,1499906,1190894,1873229,1746897,377508,385248";
			TargetV4 = "8220230,7685058,2102272,2040603,1621440,1523437,1364613,4894052,5479277,5230602,1220483";
			perVarianceV4 = "30,39,48,49,52,50,51,54,54,55,56";
			perGrowthV4 = "42,47,48,48,48,50,51,52,52,58,67";

			break;

		case 12 : month = "Dec";
			LastActV1 = "349290.69,289439.46,334740.72,325053.87,319829.16,329195.55,361280.34,368751.43,460771.92,389552.27,362060.88,507921.29";
			ThisActV1 = "393970.68,340642.51,372209.03,346070.01,354454.13,377622.19,407092.97,440248.01,541778.87,404931.67,420453.06,567799.68";
			TargetV1 = "403274.18,344501.28,361373.27,347975.37,356081.45,371401.74,410555.30,446265.71,529870.57,384364.06,399121.39,599093.74";
			perVarianceV1 = "-2.31,-1.12,3.00,-0.55,-0.46,1.67,-0.84,-1.35,2.25,5.35,5.34,-5.22";
			perGrowthV1 = "12.79,17.69,11.19,6.47,10.83,14.71,12.68,19.39,17.58,3.95,16.13,11.79";

			LastActV2 = "184168.87,156257.00,176122.22,165411.25,166159.84,163692.33,181538.59,190718.66,255666.87,201329.13,175766.78,243888.99";
			ThisActV2 = "195305.89,168903.88,183040.13,175555.86,174266.10,180366.81,203632.04,214081.70,269889.20,205279.84,189979.85,268747.50";
			TargetV2 = "203258.65,174677.29,188784.68,178495.62,178202.64,177230.84,191186.98,203790.90,264386.53,188585.84,190611.28,295515.94";
			perVarianceV2 = "-3.91,-3.31,-3.04,-1.65,-2.21,1.77,6.51,5.05,2.08,8.85,-0.33,-9.06";
			perGrowthV2 = "6.05,8.09,3.93,6.13,4.88,10.19,12.17,12.25,5.56,1.96,8.09,10.19";

			LastActV3 = "121112.31,95225.66,111807.21,115158.35,111685.68,114957.15,130060.99,130288.21,160555.47,140692.52,122592.37,189652.20";
			ThisActV3 = "150401.66,126021.01,136374.73,125164.07,135768.80,143137.54,154294.27,161338.70,196506.24,147713.15,145070.32,221346.44";
			TargetV3 = "150191.20,120865.71,122017.04,119850.84,131773.12,136036.91,167945.94,168305.13,201908.01,139236.04,135831.53,225658.72";
			perVarianceV3 = "0.14,4.27,11.77,4.43,3.03,5.22,-8.13,-4.14,-2.68,6.09,6.80,-1.91";
			perGrowthV3 = "24.18,32.34,21.97,8.69,21.56,24.51,18.63,23.83,22.39,4.99,18.34,16.71";

			LastActV4 = "8861587,8753279,2548349,2380802,3262142,3023343,2555507,6767281,7226174,5608110,1605731,5324984";
			ThisActV4 = "641357,1068221,446077,340199,1640702,1499906,1190894,1873229,1746897,377508,385248,723547";
			TargetV4 = "8220230,7685058,2102272,2040603,1621440,1523437,1364613,4894052,5479277,5230602,1220483,4601437";
			perVarianceV4 = "30,39,48,49,52,50,51,54,54,55,56,58";
			perGrowthV4 = "42,47,48,48,48,50,51,52,52,58,67,67";

			break;
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

		var urlP = ''; // URL Page.
		var sb = <%=sb%>;
		function getSumBy(value)
		{
			sb = value;
			switch(sb){
				case '1' :
				case '2' :
				case '3' :
				case '4' :
				case '5' : urlP = '<%=request.getContextPath()%>/Dashboard/Finance.jsp';
					break;
				case '6' : urlP = '<%=request.getContextPath()%>/Dashboard/FinanceYTD.jsp';
					break;
				case '7' : urlP = '<%=request.getContextPath()%>/Dashboard/FinanceMTD.jsp';
					break;
			}
		}

		var country = <%=country%>; // Value of Country(Default 1)
		function getCountry(value)
		{
			country = value;
		}

		function goUrl()
		{
			location.href = urlP+'?y='+y+'&months='+months+'&sb='+sb+'&country=1&bar1=0&bar2=0&bar2F=0&bar3=0&bar3F=0&t1=0&t2=0';
		}

		function goPage()
		{
			location.href = '<%=request.getContextPath()%>/Dashboard/FinanceMTD.jsp?y='+y+'&months='+months+'&country='+country+'#tabs-2';
		}

	</script>

	<script type="text/javascript">

	var chart01 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
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
					"values":[<%=LastActV1%>],
					"text":"Actual 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV1%>],
					"text":"Actual 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=TargetV1%>],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
					"values":[<%=perVarianceV1%>],
					"text":"%Variance",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
					"values":[<%=perGrowthV1%>],
					"text":"%Growth",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]
			}]
		};

	var chart02 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
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
					"values":[<%=LastActV2%>],
					"text":"Actual 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV2%>],
					"text":"Actual 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=TargetV2%>],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
					"values":[<%=perVarianceV2%>],
					"text":"%Variance",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
					"values":[<%=perGrowthV2%>],
					"text":"%Growth",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]
			}]
		};

	var chart03 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
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
					"values":[<%=LastActV3%>],
					"text":"Actual 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV3%>],
					"text":"Actual 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=TargetV3%>],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
					"values":[<%=perVarianceV3%>],
					"text":"%Variance",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
					"values":[<%=perGrowthV3%>],
					"text":"%Growth",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]
			}]
		};

	var chart04 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
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
					"values":[<%=LastActV4%>],
					"text":"Actual 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"Actual 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=TargetV4%>],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
					"values":[<%=perVarianceV4%>],
					"text":"%Variance",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
					"values":[<%=perGrowthV4%>],
					"text":"%Growth",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]
			}]
		};

	var chart05 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
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
					"values":[<%=LastActV4%>],
					"text":"Actual 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"Actual 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=TargetV4%>],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
					"values":[<%=perVarianceV4%>],
					"text":"%Variance",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
					"values":[<%=perGrowthV4%>],
					"text":"%Growth",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]
			}]
		};

	var chart06 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
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
					"values":[<%=LastActV4%>],
					"text":"Actual 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"Actual 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=TargetV4%>],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
					"values":[<%=perVarianceV4%>],
					"text":"%Variance",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
					"values":[<%=perGrowthV4%>],
					"text":"%Growth",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]
			}]
		};

	var chart07 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
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
					"values":[<%=LastActV4%>],
					"text":"Actual 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"Actual 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=TargetV4%>],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
					"values":[<%=perVarianceV4%>],
					"text":"%Variance",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
					"values":[<%=perGrowthV4%>],
					"text":"%Growth",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]
			}]
		};

	var chart08 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
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
					"values":[<%=LastActV4%>],
					"text":"Actual 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"Actual 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=TargetV4%>],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
					"values":[<%=perVarianceV4%>],
					"text":"%Variance",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
					"values":[<%=perGrowthV4%>],
					"text":"%Growth",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]
			}]
		};

	var chart09 = 
	{
	"graphset":[
		{
			"type":"mixed",
			"background-color":"#FFFFFF",
			"stacked":"1",
			"chart":{
				"margin":"30 60 30 80"
			},
			"labels" : [
				{
					"text":"พันบาท",
					"bold":true,
					"font-size":12,
					"x": "60",
					"y": "0"
				}
			],
			"legend":{
				"background-color": "#FFFFFF",
				"border-width": "2px",
				"border-color": "#4C77B6",
				"margin":"70 0 0 885",
				"layout":"x1",
				"item":{
					"font-color":"#000000"
				}
			},
			"guide":{
				"shared":true
			},
			"tooltip":{
				"visible": false
			},
			"scale-x":{
				"values":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
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
				"format":"%v",
				"decimals":0,
				"decimals-separator":".",
				"thousands-separator":",",
				"guide":{
					"line-width": 1,
					"alpha": 1
				},
				"tick":{
					"line-width": 3
				},
			},
			"scale-y-2":{
				"format" : "%v%",
				"guide":{
					"line-width": 0,
					"alpha": 0
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
					"values":[<%=LastActV4%>],
					"text":"Actual 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"Actual 10",
					"background-color":"#EEEE00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=TargetV4%>],
					"text":"Budget",
					"background-color":"#696969",
					"stacked":0
				},
				{
					"type":"line",
					"values":[<%=perVarianceV4%>],
					"text":"%Variance",
					"scales":"scale-x,scale-y-2",
					"stacked":0,
					"line-color": "#E46C0A",
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				},
				{
					"type":"line",
					"values":[<%=perGrowthV4%>],
					"text":"%Growth",
					"scales":"scale-x,scale-y-2",
					"line-color": "#4F81BD",
					"stacked":0,
					"aspect" : "spline",
					"marker":{
						"visible":false
					}
				}]
			}]
		};

		$(document).ready(function() {
			zingchart.render({
				id : 'g1',
				width 	: 850,
				height 	: 270,
				data : chart01
			});
			zingchart.render({
				id : 'g2',
				width 	: 850,
				height 	: 270,
				data : chart02
			});
			zingchart.render({
				id : 'g3',
				width 	: 850,
				height 	: 270,
				data : chart03
			});
			zingchart.render({
				id : 'g4',
				width 	: 850,
				height 	: 270,
				data : chart04
			});
			zingchart.render({
				id : 'g5',
				width 	: 850,
				height 	: 270,
				data : chart05
			});
			zingchart.render({
				id : 'g6',
				width 	: 850,
				height 	: 270,
				data : chart06
			});
			zingchart.render({
				id : 'g7',
				width 	: 850,
				height 	: 270,
				data : chart07
			});
			zingchart.render({
				id : 'g8',
				width 	: 850,
				height 	: 270,
				data : chart08
			});
			zingchart.render({
				id : 'g9',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g10',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g11',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g12',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g13',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g14',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
		});
	</script>

</head>

<body bgcolor="#FFFFFF">
<!-- Parameter -->
	<!--          Drop Down List YEAR              -->
	<div style="position:absolute; left:15px; top:20px;"><font size="3"> ปี:</font>
		<select name="Year" onChange="getYear(this.value);">
			<option value="1"<%if(y.equals("1")) out.print(" selected=\"selected\"");%>>2010</option>
			<option value="2"<%if(y.equals("2")) out.print(" selected=\"selected\"");%>>2009</option>
		</select> 
	</div>
	<!--          Drop Down List MONTH              -->
	<div style="position:absolute; left:125px; top:20px;"><font size="3"> เดือน:</font>
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
	<div style="position:absolute; left:250px; top:20px;"><font size="3"> สรุปตาม: </font>
		<select name="SumBy" onChange="getSumBy(this.value);">
			<option value="6">YTD</option>
			<option value="7" selected="selected">Monthly</option>
			<option value="1">YTD vs Last YTD</option>
			<option value="2">Quarter vs Last Quarter</option>
			<option value="3">Quarter vs Last Year same Quarter</option>
			<option value="4">Monthly vs Last Monthly</option>
			<option value="5">Monthly vs Last Year same Monthly</option>
		</select> 
	</div>
	<div style="position:absolute; left:580px; top:20px;">
		<input type="button" value=" OK " onClick="goUrl()"/></div>
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
  <table id=tabs-ratio width=202px>
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
			<th colspan=3>
			  Profitablity Ratio
			</th>
		  </tr>
		  <tr>
			<td>Gross Profit Margin </td>
			<td><img src=images/up1.png> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Net Profit Margin </td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>EBITDA Margin </td>
			<td><img src=images/up1.png> </td>
			<td>00</td>
		  </tr>
		  <tr>
			<td>EBIT Margin </td>
			<td><img src=images/down1.png> </td>
			<td>00</td>
		  </tr>
		  <tr>
			<td>Return on Equity</td>
			<td></td>
			<td>00</td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Operating Efficiency
			</th>
		  </tr>
		  <tr>
			<td>Return on Assets</td>
			<td><img src=images/down1.png> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Return on Fixed Assets </td>
			<td><img src=images/down1.png> </td>
			<td>14.20 </td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Leverage Ratio
			</th>
		  </tr>
		  <tr>
			<td>Current Ratio</td>
			<td><img src=images/up1.png> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Quick Ratio</td>
			<td><img src=images/down1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>Debt to Equity Ratio (Times)</td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Turnover Ratio
			</th>
		  </tr>
		  <tr>
			<td>A/R Day</td>
			<td> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>A/P Day</td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>Inventory Day</td>
			<td> </td>
			<td>14.20 </td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Growth Rates
			</th>
		  </tr>
		  <tr>
			<td>Sales and Service Income</td>
			<td> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Gross Profit</td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>Net Profit</td>
			<td><img src=images/down1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>Total Assets</td>
			<td> </td>
			<td>14.20 </td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Per Share Data
			</th>
		  </tr>
		  <tr>
			<td>Book Value per Share (Bt.)</td>
			<td><img src=images/up1.png> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Earnings per Share (Bt.)</td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <!-- End Data -->
		</table>

		<!-- End Table -->
	  </td>
	</tr>
  </table>
</td>

<td>
  <table id=tabs-table2 style="position:absolute; left:242px; top:45px;" bordercolor="#000000" frame="box" rules="all">
  <tr><td align=center>
		<table width=1070>
			<tr bgcolor="#8B4513">
				<td colspan="2"><div align=center><font color="#FFE742" size="3"><b>บริษัท เอส แอน พี ซินดิเคท จำกัด (มหาชน)</b></font></div></td>
			</tr>
			<tr>
				<td align=center><div id="g1"></div></td>
				<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
			</tr>
		</table>
  </td></tr>
  </table>
</td>
</tr>
</table>
<!-- -->

<!-- -->
<div style=" position:absolute; top:365px; left:242px;">
<table id="tabs-t1r3">
  <tr height=300><td valign="top" width=1065>
	<ul>
		<li><a href="#tabs-t1r3_1">Restaurant</a></li>
		<li><a href="#tabs-t1r3_2">Bakery</a></li>
		<li><a href="#tabs-t1r3_3">Specialty</a></li>
		<li><a href="#tabs-t1r3_4">Trading</a></li>
		<li><a href="#tabs-t1r3_5">Caterman</a></li>
		<li><a href="#tabs-t1r3_6">Other</a></li>
	</ul>

	<!-- Reataurant -->
	<table id="tabs-t1r3_1">
		<tr>
			<td align="center"><div id="g2"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

	<!-- Bakery -->
	<table id="tabs-t1r3_2">
		<tr>
			<td align=center><div id="g3"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

	<!-- Specialty -->
	<table id="tabs-t1r3_3">
		<tr>
			<td align=center><div id="g4"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

	<!-- Trading -->
	<table id="tabs-t1r3_4">
		<tr>
			<td align=center><div id="g5"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>
	
	<!-- Caterman -->
	<table id="tabs-t1r3_5">
		<tr>
			<td align=center><div id="g6"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

	<!-- Other -->
	<table id="tabs-t1r3_6">
		<tr>
			<td align=center><div id="g7"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

<!-- END -->
  </td></tr>
  </table></div>

</div>

<!-- Tab ต่างประเทศ -->
<div id="tabs-2">
<table>
<tr>
<td>
  <table id=tabs-ratio1 width=202px>
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
			<th colspan=3>
			  Profitablity Ratio
			</th>
		  </tr>
		  <tr>
			<td>Gross Profit Margin </td>
			<td><img src=images/up1.png> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Net Profit Margin </td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>EBITDA Margin </td>
			<td><img src=images/up1.png> </td>
			<td>00</td>
		  </tr>
		  <tr>
			<td>EBIT Margin </td>
			<td><img src=images/down1.png> </td>
			<td>00</td>
		  </tr>
		  <tr>
			<td>Return on Equity</td>
			<td></td>
			<td>00</td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Operating Efficiency
			</th>
		  </tr>
		  <tr>
			<td>Return on Assets</td>
			<td><img src=images/down1.png> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Return on Fixed Assets </td>
			<td><img src=images/down1.png> </td>
			<td>14.20 </td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Leverage Ratio
			</th>
		  </tr>
		  <tr>
			<td>Current Ratio</td>
			<td><img src=images/up1.png> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Quick Ratio</td>
			<td><img src=images/down1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>Debt to Equity Ratio (Times)</td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Turnover Ratio
			</th>
		  </tr>
		  <tr>
			<td>A/R Day</td>
			<td> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>A/P Day</td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>Inventory Day</td>
			<td> </td>
			<td>14.20 </td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Growth Rates
			</th>
		  </tr>
		  <tr>
			<td>Sales and Service Income</td>
			<td> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Gross Profit</td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>Net Profit</td>
			<td><img src=images/down1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <tr>
			<td>Total Assets</td>
			<td> </td>
			<td>14.20 </td>
		  </tr>

		  <tr>
			<th colspan=3>
			  Per Share Data
			</th>
		  </tr>
		  <tr>
			<td>Book Value per Share (Bt.)</td>
			<td><img src=images/up1.png> </td>
			<td>25.50 </td>
		  </tr>
		  <tr>
			<td>Earnings per Share (Bt.)</td>
			<td><img src=images/up1.png> </td>
			<td>14.20 </td>
		  </tr>
		  <!-- End Data -->
		</table>

		<!-- End Table -->
	  </td>
	</tr>
  </table>
</td>

<td>
  <table id=tabs-table4 style="position:absolute; left:242px; top:45px;" bordercolor="#000000" frame="box" rules="all">
  <tr><td align=center>
		<table width=1070>
			<tr bgcolor="#8B4513">
				<td colspan="2"><div align=center><font color="#FFE742" size="3"><b>ต่างประเทศ</b></font></div></td>
			</tr>
			<tr>
				<td align=center><div id="g8"></div></td>
				<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
			</tr>
		</table>
  </td></tr>
  </table>
</td>
</tr>
</table>
<!-- -->

<!-- -->
<div style=" position:absolute; top:365px; left:242px;">
<table id="tabs-t2r3">
  <tr height=300><td valign="top" width=1065>
	<ul>
		<li><a href="#tabs-t2r3_1">อังกฤษ</a></li>
		<li><a href="#tabs-t2r3_2">สวิตเซอร์แลนด์</a></li>
		<li><a href="#tabs-t2r3_3">สิงคโปร์</a></li>
		<li><a href="#tabs-t2r3_4">ไต้หวัน</a></li>
		<li><a href="#tabs-t2r3_5">จีน</a></li>
		<li><a href="#tabs-t2r3_6">ฟิลิปปินส์</a></li>
	</ul>

	<!-- Reataurant -->
	<table id="tabs-t2r3_1">
		<tr>
			<td align="center"><div id="g9"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

	<!-- Bakery -->
	<table id="tabs-t2r3_2">
		<tr>
			<td align=center><div id="g10"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

	<!-- Specialty -->
	<table id="tabs-t2r3_3">
		<tr>
			<td align=center><div id="g11"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

	<!-- Trading -->
	<table id="tabs-t2r3_4">
		<tr>
			<td align=center><div id="g12"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>
	
	<!-- Caterman -->
	<table id="tabs-t2r3_5">
		<tr>
			<td align=center><div id="g13"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

	<!-- Other -->
	<table id="tabs-t2r3_6">
		<tr>
			<td align=center><div id="g14"></div></td>
			<td align=left width="150"><img src="<%=request.getContextPath()%>/Dashboard/images/legend_Y-M.jpg"/></td>
		</tr>
	</table>

<!-- END -->
  </td></tr>
  </table></div>

</div>
<!-- End Tab -->
</div>

</body>
</html>