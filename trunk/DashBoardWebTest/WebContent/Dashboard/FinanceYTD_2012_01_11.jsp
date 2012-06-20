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
	<!-- 
	DWR
	-->
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/interface/BalanceScorecardAjax.js"></script>
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/engine.js"></script> 
	<script type="text/javascript"
        	src="<%=request.getContextPath() %>/dwr/util.js"></script>
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
	   // Ajax function
              function callAjax(){
		 BalanceScorecardAjax.list("aoeee",{
		 	callback:function(data){
         			if(data!=null && data.length>0){ 
					alert(data)
				}
			}
		});
	      }
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
			LastActV1 = "349290.69,638730.14";
			ThisActV1 = "393970.68,734613.19";
			TargetV1 = "403274.18,747775.45";
			perVarianceV1 = "-2.31,-3.43";
			perGrowthV1 = "12.79,30.48";

			LastActV2 = "184168.87,340425.87";
			ThisActV2 = "195305.89,364209.77";
			TargetV2 = "203258.65,377935.95";
			perVarianceV2 = "-3.91,-7.22";
			perGrowthV2 = "6.05,14.14";

			LastActV3 = "121112.31,216337.97";
			ThisActV3 = "150401.66,276422.67";
			TargetV3 = "150191.20,271056.92";
			perVarianceV3 = "0.14,4.41";
			perGrowthV3 = "24.18,56.52";

			LastActV4 = "1048726,1488546";
			ThisActV4 = "1148726,1517776";
			TargetV4 = "1000000,1200000";
			perVarianceV4 = "30,39";
			perGrowthV4 = "50,52";

			break;

		case 3 : month = "Mar";
			LastActV1 = "349290.69,638730.14,973470.87";
			ThisActV1 = "393970.68,734613.19,1106822.22";
			TargetV1 = "403274.18,747775.45,1109148.72";
			perVarianceV1 = "-2.31,-3.43,-0.43";
			perGrowthV1 = "12.79,30.48,41.68";

			LastActV2 = "184168.87,340425.87,516548.10";
			ThisActV2 = "195305.89,364209.77,547249.90";
			TargetV2 = "203258.65,377935.95,566720.63";
			perVarianceV2 = "-3.91,-7.22,-10.26";
			perGrowthV2 = "6.05,14.14,18.07";

			LastActV3 = "121112.31,216337.97,328145.18";
			ThisActV3 = "150401.66,276422.67,412797.39";
			TargetV3 = "150191.20,271056.92,393073.96";
			perVarianceV3 = "0.14,4.41,16.17";
			perGrowthV3 = "24.18,56.52,78.50";

			LastActV4 = "1048726,1488546,1518290";
			ThisActV4 = "1148726,1517776,1633675";
			TargetV4 = "1000000,1200000,1400000";
			perVarianceV4 = "30,39,48";
			perGrowthV4 = "50,52,56";

			break;

		case 4 : month = "Apr";
			LastActV1 = "349290.69,638730.14,973470.87,1298524.74";
			ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23";
			TargetV1 = "403274.18,747775.45,1109148.72,1457124.09";
			perVarianceV1 = "-2.31,-3.43,-0.43,-0.98";
			perGrowthV1 = "12.79,30.48,41.68,48.14";

			LastActV2 = "184168.87,340425.87,516548.10,681959.35";
			ThisActV2 = "195305.89,364209.77,547249.90,722805.76";
			TargetV2 = "203258.65,377935.95,566720.63,745216.25";
			perVarianceV2 = "-3.91,-7.22,-10.26,-11.91";
			perGrowthV2 = "6.05,14.14,18.07,24.20";

			LastActV3 = "121112.31,216337.97,328145.18,443303.53";
			ThisActV3 = "150401.66,276422.67,412797.39,537961.46";
			TargetV3 = "150191.20,271056.92,393073.96,512924.79";
			perVarianceV3 = "0.14,4.41,16.17,20.61";
			perGrowthV3 = "24.18,56.52,78.50,87.18";

			LastActV4 = "1048726,1488546,1518290,1653161";
			ThisActV4 = "1148726,1517776,1633675,1762904";
			TargetV4 = "1000000,1200000,1400000,1600000";
			perVarianceV4 = "30,39,48,49";
			perGrowthV4 = "50,52,56,57";

			break;

		case 5 : month = "May";
			LastActV1 = "349290.69,638730.14,973470.87,1298524.74,1618353.90";
			ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23,1807346.37";
			TargetV1 = "403274.18,747775.45,1109148.72,1457124.09,1813205.54";
			perVarianceV1 = "-2.31,-3.43,-0.43,-0.98,-1.43";
			perGrowthV1 = "12.79,30.48,41.68,48.14,58.97";

			LastActV2 = "184168.87,340425.87,516548.10,681959.35,848119.19";
			ThisActV2 = "195305.89,364209.77,547249.90,722805.76,897071.85";
			TargetV2 = "203258.65,377935.95,566720.63,745216.25,923418.89";
			perVarianceV2 = "-3.91,-7.22,-10.26,-11.91,-14.12";
			perGrowthV2 = "6.05,14.14,18.07,24.20,29.08";

			LastActV3 = "121112.31,216337.97,328145.18,443303.53,554989.21";
			ThisActV3 = "150401.66,276422.67,412797.39,537961.46,673730.27";
			TargetV3 = "150191.20,271056.92,393073.96,512924.79,644697.92";
			perVarianceV3 = "0.14,4.41,16.17,20.61,23.64";
			perGrowthV3 = "24.18,56.52,78.50,87.18,108.75";

			LastActV4 = "1048726,1488546,1518290,1653161,1718290";
			ThisActV4 = "1148726,1517776,1633675,1762904,1843418";
			TargetV4 = "1000000,1200000,1400000,1600000,1800000";
			perVarianceV4 = "30,39,48,49,52";
			perGrowthV4 = "50,52,56,57,57";

			break;

		case 6 : month = "Jun";
			LastActV1 = "349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44";
			ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55";
			TargetV1 = "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28";
			perVarianceV1 = "-2.31,-3.43,-0.43,-0.98,-1.43,0.24";
			perGrowthV1 = "12.79,30.48,41.68,48.14,58.97,73.68";

			LastActV2 = "184168.87,340425.87,516548.10,681959.35,848119.19,1011811.52";
			ThisActV2 = "195305.89,364209.77,547249.90,722805.76,897071.85,1077438.67";
			TargetV2 = "203258.65,377935.95,566720.63,745216.25,923418.89,1100649.73";
			perVarianceV2 = "-3.91,-7.22,-10.26,-11.91,-14.12,-12.35";
			perGrowthV2 = "6.05,14.14,18.07,24.20,29.08,39.27";

			LastActV3 = "121112.31,216337.97,328145.18,443303.53,554989.21,669946.36";
			ThisActV3 = "150401.66,276422.67,412797.39,537961.46,673730.27,816867.81";
			TargetV3 = "150191.20,271056.92,393073.96,512924.79,644697.92,780734.83";
			perVarianceV3 = "0.14,4.41,16.17,20.61,23.64,28.86";
			perGrowthV3 = "24.18,56.52,78.50,87.18,108.75,133.26";

			LastActV4 = "1048726,1488546,1518290,1653161,1718290,1917776,1978803";
			ThisActV4 = "1148726,1517776,1633675,1762904,1843418,1962904,2008033";
			TargetV4 = "1000000,1200000,1400000,1600000,1800000,2000000,2200000";
			perVarianceV4 = "30,39,48,49,52,50,51";
			perGrowthV4 = "50,52,56,57,57,58,58";

			break;

		case 7 : month = "Jul";
			LastActV1 = "349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44,2308829.78";
			ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53";
			TargetV1 = "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58";
			perVarianceV1 = "-2.31,-3.43,-0.43,-0.98,-1.43,0.24,-0.60";
			perGrowthV1 = "12.79,30.48,41.68,48.14,58.97,73.68,86.36";

			LastActV2 = "184168.87,340425.87,516548.10,681959.35,848119.19,1011811.52,1193350.11";
			ThisActV2 = "195305.89,364209.77,547249.90,722805.76,897071.85,1077438.67,1281070.71";
			TargetV2 = "203258.65,377935.95,566720.63,745216.25,923418.89,1100649.73,1291836.71";
			perVarianceV2 = "-3.91,-7.22,-10.26,-11.91,-14.12,-12.35,-5.84";
			perGrowthV2 = "6.05,14.14,18.07,24.20,29.08,39.27,51.44";

			LastActV3 = "121112.31,216337.97,328145.18,443303.53,554989.21,669946.36,800007.35";
			ThisActV3 = "150401.66,276422.67,412797.39,537961.46,673730.27,816867.81,971162.07";
			TargetV3 = "150191.20,271056.92,393073.96,512924.79,644697.92,780734.83,948680.77";
			perVarianceV3 = "0.14,4.41,16.17,20.61,23.64,28.86,20.73";
			perGrowthV3 = "24.18,56.52,78.50,87.18,108.75,133.26,151.89";

			LastActV4 = "1048726,1488546,1518290,1653161,1718290,1917776,1978803,2053161,2188546,2278803,2323932,2469060";
			ThisActV4 = "1148726,1517776,1633675,1762904,1843418,1962904,2008033,2143418,2323932,2438033,2533675,2669060";
			TargetV4 = "1000000,1200000,1400000,1600000,1800000,2000000,2200000,2400000,2600000,2800000,3000000,3200000";
			perVarianceV4 = "30,39,48,49,52,50,51,54,54,55,56,58";
			perGrowthV4 = "50,52,56,57,57,58,58,60,62,62,64,65";

			break;

		case 8 : month = "Aug";
			LastActV1 = "349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44,2308829.78,2677581.22";
			ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53,3032309.54";
			TargetV1 = "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58,3041428.29";
			perVarianceV1 = "-2.31,-3.43,-0.43,-0.98,-1.43,0.24,-0.60,-1.95";
			perGrowthV1 = "12.79,30.48,41.68,48.14,58.97,73.68,86.36,105.75";

			LastActV2 = "184168.87,340425.87,516548.10,681959.35,848119.19,1011811.52,1193350.11,1384068.77";
			ThisActV2 = "195305.89,364209.77,547249.90,722805.76,897071.85,1077438.67,1281070.71,1495152.41";
			TargetV2 = "203258.65,377935.95,566720.63,745216.25,923418.89,1100649.73,1291836.71,1495627.61";
			perVarianceV2 = "-3.91,-7.22,-10.26,-11.91,-14.12,-12.35,-5.84,-0.79";
			perGrowthV2 = "6.05,14.14,18.07,24.20,29.08,39.27,51.44,63.69";

			LastActV3 = "121112.31,216337.97,328145.18,443303.53,554989.21,669946.36,800007.35,930295.55";
			ThisActV3 = "150401.66,276422.67,412797.39,537961.46,673730.27,816867.81,971162.07,1132500.77";
			TargetV3 = "150191.20,271056.92,393073.96,512924.79,644697.92,780734.83,948680.77,1116985.90";
			perVarianceV3 = "0.14,4.41,16.17,20.61,23.64,28.86,20.73,16.59";
			perGrowthV3 = "24.18,56.52,78.50,87.18,108.75,133.26,151.89,175.73";

			LastActV4 = "1048726,1488546,1518290,1653161,1718290,1917776,1978803,2053161";
			ThisActV4 = "1148726,1517776,1633675,1762904,1843418,1962904,2008033,2143418";
			TargetV4 = "1000000,1200000,1400000,1600000,1800000,2000000,2200000,2400000";
			perVarianceV4 = "30,39,48,49,52,50,51,54";
			perGrowthV4 = "50,52,56,57,57,58,58,60";

			break;

		case 9 : month = "Sep";
			LastActV1 = "349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44,2308829.78,2677581.22,3138353.13";
			ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53,3032309.54,3574088.40";
			TargetV1 = "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58,3041428.29,3571298.86";
			perVarianceV1 = "-2.31,-3.43,-0.43,-0.98,-1.43,0.24";
			perGrowthV1 = "12.79,30.48,41.68,48.14,58.97,73.68";

			LastActV2 = "184168.87,340425.87,516548.10,681959.35,848119.19,1011811.52,1193350.11,1384068.77,1639735.64";
			ThisActV2 = "195305.89,364209.77,547249.90,722805.76,897071.85,1077438.67,1281070.71,1495152.41,1765041.61";
			TargetV2 = "203258.65,377935.95,566720.63,745216.25,923418.89,1100649.73,1291836.71,1495627.61,1760014.14";
			perVarianceV2 = "-3.91,-7.22,-10.26,-11.91,-14.12,-12.35,-5.84,-0.79,1.29";
			perGrowthV2 = "6.05,14.14,18.07,24.20,29.08,39.27,51.44,63.69,69.25";

			LastActV3 = "121112.31,216337.97,328145.18,443303.53,554989.21,669946.36,800007.35,930295.55,1090851.02";
			ThisActV3 = "150401.66,276422.67,412797.39,537961.46,673730.27,816867.81,971162.07,1132500.77,1329007.02";
			TargetV3 = "150191.20,271056.92,393073.96,512924.79,644697.92,780734.83,948680.77,1116985.90,1318893.91";
			perVarianceV3 = "0.14,4.41,16.17,20.61,23.64,28.86,20.73,16.59,13.91";
			perGrowthV3 = "24.18,56.52,78.50,87.18,108.75,133.26,151.89,175.73,198.12";

			LastActV4 = "1048726,1488546,1518290,1653161,1718290,1917776,1978803,2053161,2188546";
			ThisActV4 = "1148726,1517776,1633675,1762904,1843418,1962904,2008033,2143418,2323932";
			TargetV4 = "1000000,1200000,1400000,1600000,1800000,2000000,2200000,2400000,2600000";
			perVarianceV4 = "30,39,48,49,52,50,51,54,54";
			perGrowthV4 = "50,52,56,57,57,58,58,60,62";

			break;

		case 10 : month = "Oct";
			LastActV1 = "349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44,2308829.78,2677581.22,3138353.13,3527905.41";
			ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53,3032309.54,3574088.40,3979020.08";
			TargetV1 = "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58,3041428.29,3571298.86,3955662.91";
			perVarianceV1 = "-2.31,-3.43,-0.43,-0.98,-1.43,0.24,-0.60,-1.95,0.30,5.65";
			perGrowthV1 = "12.79,30.48,41.68,48.14,58.97,73.68,86.36,105.75,123.33,127.28";

			LastActV2 = "184168.87,340425.87,516548.10,681959.35,848119.19,1011811.52,1193350.11,1384068.77,1639735.64,1841064.76";
			ThisActV2 = "195305.89,364209.77,547249.90,722805.76,897071.85,1077438.67,1281070.71,1495152.41,1765041.61,1970321.45";
			TargetV2 = "203258.65,377935.95,566720.63,745216.25,923418.89,1100649.73,1291836.71,1495627.61,1760014.14,1948599.98";
			perVarianceV2 = "-3.91,-7.22,-10.26,-11.91,-14.12,-12.35,-5.84,-0.79,1.29,10.15";
			perGrowthV2 = "6.05,14.14,18.07,24.20,29.08,39.27,51.44,63.69,69.25,71.21";

			LastActV3 = "121112.31,216337.97,328145.18,443303.53,554989.21,669946.36,800007.35,930295.55,1090851.02,1231543.54";
			ThisActV3 = "150401.66,276422.67,412797.39,537961.46,673730.27,816867.81,971162.07,1132500.77,1329007.02,1476720.16";
			TargetV3 = "150191.20,271056.92,393073.96,512924.79,644697.92,780734.83,948680.77,1116985.90,1318893.91,1458129.95";
			perVarianceV3 = "0.14,4.41,16.17,20.61,23.64,28.86,20.73,16.59,13.91,20.00";
			perGrowthV3 = "24.18,56.52,78.50,87.18,108.75,133.26,151.89,175.73,198.12,203.11";

			LastActV4 = "1048726,1488546,1518290,1653161,1718290,1917776,1978803,2053161,2188546,2278803";
			ThisActV4 = "1148726,1517776,1633675,1762904,1843418,1962904,2008033,2143418,2323932,2438033";
			TargetV4 = "1000000,1200000,1400000,1600000,1800000,2000000,2200000,2400000,2600000,2800000";
			perVarianceV4 = "30,39,48,49,52,50,51,54,54,558";
			perGrowthV4 = "50,52,56,57,57,58,58,60,62,62";

			break;

		case 11 : month = "Nov";
			LastActV1 = "349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44,2308829.78,2677581.22,3138353.13,3527905.41,3889966.29";
			ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53,3032309.54,3574088.40,3979020.08,4399473.14";
			TargetV1 = "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58,3041428.29,3571298.86,3955662.91,4354784.30";
			perVarianceV1 = "-2.31,-3.43,-0.43,-0.98,-1.43,0.24,-0.60,-1.95,0.30,5.65,10.99";
			perGrowthV1 = "12.79,30.48,41.68,48.14,58.97,73.68,86.36,105.75,123.33,127.28,143.40";

			LastActV2 = "184168.87,340425.87,516548.10,681959.35,848119.19,1011811.52,1193350.11,1384068.77,1639735.64,1841064.76,2016831.54";
			ThisActV2 = "195305.89,364209.77,547249.90,722805.76,897071.85,1077438.67,1281070.71,1495152.41,1765041.61,1970321.45,2160301.31";
			TargetV2 = "203258.65,377935.95,566720.63,745216.25,923418.89,1100649.73,1291836.71,1495627.61,1760014.14,1948599.98,2139211.26";
			perVarianceV2 = "-3.91,-7.22,-10.26,-11.91,-14.12,-12.35,-5.84,-0.79,1.29,10.15,9.81";
			perGrowthV2 = "6.05,14.14,18.07,24.20,29.08,39.27,51.44,63.69,69.25,71.21,79.30";

			LastActV3 = "121112.31,216337.97,328145.18,443303.53,554989.21,669946.36,800007.35,930295.55,1090851.02,1231543.54,1354135.91";
			ThisActV3 = "150401.66,276422.67,412797.39,537961.46,673730.27,816867.81,971162.07,1132500.77,1329007.02,1476720.16,1621790.48";
			TargetV3 = "150191.20,271056.92,393073.96,512924.79,644697.92,780734.83,948680.77,1116985.90,1318893.91,1458129.95,1593961.48";
			perVarianceV3 = "0.14,4.41,16.17,20.61,23.64,28.86,20.73,16.59,13.91,20.00,26.80";
			perGrowthV3 = "24.18,56.52,78.50,87.18,108.75,133.26,151.89,175.73,198.12,203.11,221.44";

			LastActV4 = "1048726,1488546,1518290,1653161,1718290,1917776,1978803,2053161,2188546,2278803,2323932";
			ThisActV4 = "1148726,1517776,1633675,1762904,1843418,1962904,2008033,2143418,2323932,2438033,2533675";
			TargetV4 = "1000000,1200000,1400000,1600000,1800000,2000000,2200000,2400000,2600000,2800000,3000000";
			perVarianceV4 = "30,39,48,49,52,50,51,54,54,55,56";
			perGrowthV4 = "50,52,56,57,57,58,58,60,62,62,64";

			break;

		case 12 : month = "Dec";
			LastActV1 = "349290.69,638730.14,973470.87,1298524.74,1618353.90,1947549.44,2308829.78,2677581.22,3138353.13,3527905.41,3889966.29,4397887.58";
			ThisActV1 = "393970.68,734613.19,1106822.22,1452892.23,1807346.37,2184968.55,2592061.53,3032309.54,3574088.40,3979020.08,4399473.14,4967272.82";
			TargetV1 = "403274.18,747775.45,1109148.72,1457124.09,1813205.54,2184607.28,2595162.58,3041428.29,3571298.86,3955662.91,4354784.30,4953878.04";
			perVarianceV1 = "-2.31,-3.43,-0.43,-0.98,-1.43,0.24,-0.60,-1.95,0.30,5.65,10.99,5.77";
			perGrowthV1 = "12.79,30.48,41.68,48.14,58.97,73.68,86.36,105.75,123.33,127.28,143.40,155.19";

			LastActV2 = "184168.87,340425.87,516548.10,681959.35,848119.19,1011811.52,1193350.11,1384068.77,1639735.64,1841064.76,2016831.54,2260720.53";
			ThisActV2 = "195305.89,364209.77,547249.90,722805.76,897071.85,1077438.67,1281070.71,1495152.41,1765041.61,1970321.45,2160301.31,2429048.80";
			TargetV2 = "203258.65,377935.95,566720.63,745216.25,923418.89,1100649.73,1291836.71,1495627.61,1760014.14,1948599.98,2139211.26,2434727.19";
			perVarianceV2 = "-3.91,-7.22,-10.26,-11.91,-14.12,-12.35,-5.84,-0.79,1.29,10.15,9.81,0.76";
			perGrowthV2 = "6.05,14.14,18.07,24.20,29.08,39.27,51.44,63.69,69.25,71.21,79.30,89.49";

			LastActV3 = "121112.31,216337.97,328145.18,443303.53,554989.21,669946.36,800007.35,930295.55,1090851.02,1231543.54,1354135.91,1543788.11";
			ThisActV3 = "150401.66,276422.67,412797.39,537961.46,673730.27,816867.81,971162.07,1132500.77,1329007.02,1476720.16,1621790.48,1843136.92";
			TargetV3 = "150191.20,271056.92,393073.96,512924.79,644697.92,780734.83,948680.77,1116985.90,1318893.91,1458129.95,1593961.48,1819620.21";
			perVarianceV3 = "0.14,4.41,16.17,20.61,23.64,28.86,20.73,16.59,13.91,20.00,26.80,24.89";
			perGrowthV3 = "24.18,56.52,78.50,87.18,108.75,133.26,151.89,175.73,198.12,203.11,221.44,238.16";

			LastActV4 = "1048726,1488546,1518290,1653161,1718290,1917776,1978803,2053161,2188546,2278803,2323932,2469060";
			ThisActV4 = "1148726,1517776,1633675,1762904,1843418,1962904,2008033,2143418,2323932,2438033,2533675,2669060";
			TargetV4 = "1000000,1200000,1400000,1600000,1800000,2000000,2200000,2400000,2600000,2800000,3000000,3200000";
			perVarianceV4 = "30,39,48,49,52,50,51,54,54,55,56,58";
			perGrowthV4 = "50,52,56,57,57,58,58,60,62,62,64,65";

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
			location.href = '<%=request.getContextPath()%>/Dashboard/FinanceYTD.jsp?y='+y+'&months='+months+'&country='+country+'#tabs-2';
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
				}
			},
			"series":[
				{
					"type":"bar",
					"values":[<%=LastActV1%>],
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV1%>],
					"text":"ActualYTD 10",
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
					"text":"%Variance YTD",
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
					"text":"%GrowthYTD",
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
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV2%>],
					"text":"ActualYTD 10",
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
					"text":"%Variance YTD",
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
					"text":"%GrowthYTD",
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
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV3%>],
					"text":"ActualYTD 10",
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
					"text":"%Variance YTD",
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
					"text":"%GrowthYTD",
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
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"ActualYTD 10",
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
					"text":"%Variance YTD",
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
					"text":"%GrowthYTD",
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
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"ActualYTD 10",
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
					"text":"%Variance YTD",
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
					"text":"%GrowthYTD",
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
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"ActualYTD 10",
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
					"text":"%Variance YTD",
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
					"text":"%GrowthYTD",
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
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"ActualYTD 10",
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
					"text":"%Variance YTD",
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
					"text":"%GrowthYTD",
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
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"ActualYTD 10",
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
					"text":"%Variance YTD",
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
					"text":"%GrowthYTD",
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
					"text":"ActualYTD 09",
					"background-color":"#66CC00",
					"stacked":0
				},
				{
					"type":"bar",
					"values":[<%=ThisActV4%>],
					"text":"ActualYTD 10",
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
					"text":"%Variance YTD",
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
					"text":"%GrowthYTD",
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
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart01
			});
			zingchart.render({
				id : 'g2',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart02
			});
			zingchart.render({
				id : 'g3',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart03
			});
			zingchart.render({
				id : 'g4',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart04
			});
			zingchart.render({
				id : 'g5',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart05
			});
			zingchart.render({
				id : 'g6',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart06
			});
			zingchart.render({
				id : 'g7',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart07
			});
			zingchart.render({
				id : 'g8',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart08
			});
			zingchart.render({
				id : 'g9',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g10',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g11',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g12',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g13',
				//output	: 'svg',
				width 	: 850,
				height 	: 270,
				data : chart09
			});
			zingchart.render({
				id : 'g14',
				//output	: 'svg',
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
			<option value="6" selected="selected">YTD</option>
			<option value="7">Monthly</option>
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
		<tr>
			<td align=center>aoe</td>
			<td align=left width="150"><input type="button" value="call Ajax" onclick="callAjax()"/></td>
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
