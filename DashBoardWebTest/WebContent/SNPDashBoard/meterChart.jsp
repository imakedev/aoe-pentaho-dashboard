<!--
*********************************************************
*	EditDate	: April 2011							*
*	Project		: S&P BI Dashboard						*
*	Version		: Prototype Ver.001						*
*	Programmer	: Kriengkrai							*
*********************************************************
-->
<html>
  <head>
    <title>SNP DashBoard</title>    
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
  
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<META HTTP-EQUIV="EXPIRES" CONTENT="-1" />
<%@ page contentType="text/html; charset=UTF-8" %> 
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/zingchart-html5beta-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart/license.js"></script>
</head>
<body>
<%
String strvalue = new String("0") ;
<<<<<<< .mine
Double target = new Double("0") ;
String actual = new String("0") ;
Double percent = new Double("0") ;
Double red = new Double("0") ;
Double yellow = new Double("0") ;
Double green = new Double("0") ;

String red_color = new String("") ;
String yellow_color = new String("") ;
String green_color = new String("") ;

=======
Double target = new Double("0") ;
Double actual = new Double("0") ;
Double red = new Double("0") ;
Double yellow = new Double("0") ;
Double green = new Double("0") ;

>>>>>>> .r66
if (request.getParameter("gvalue") == null) 
{	
		out.println("Please enter the fields.");
} 
else 
{	
		//out.println("strvalue: <b>"+request.getParameter("gvalue"));  
		strvalue = request.getParameter("gvalue") ;
<<<<<<< .mine
		target = Double.parseDouble(request.getParameter("target")) ;
		actual = request.getParameter("actual") ;
		//percent = Double.parseDouble(request.getParameter("percent")) ;
		red = Double.parseDouble(request.getParameter("red")) ;
		yellow = Double.parseDouble(request.getParameter("yellow")) ;
		green = Double.parseDouble(request.getParameter("green")) ;
		
		red_color = request.getParameter("red_color") ;
		yellow_color = request.getParameter("yellow_color") ;
		green_color = request.getParameter("green_color") ;
=======
		target = Double.parseDouble(request.getParameter("target")) ;
		actual = Double.parseDouble(request.getParameter("actual")) ;
		red = Double.parseDouble(request.getParameter("red")) ;
		yellow = Double.parseDouble(request.getParameter("yellow")) ;
		green = Double.parseDouble(request.getParameter("green")) ;
>>>>>>> .r66
}
%>


<script type="text/javascript">		

var jsonCircle = {
   "graphset":[
      {
         "type":"gauge",
         "border-width":0,
         "plotarea":{
            "margin":"20 0 0 0"
         },
         "background-color":"#CCCCCC #CCCCCC;",
         "fill-type":"radial",
         "scale":{
			"values": [
<<<<<<< .mine
				//"Ratio : Percent(%)"
				//"Percent(%)"
			//	"Performance"
				  "% Actual Value vs Target"=======
				//"Ratio : Percent(%)"
				//"Percent(%)"
				"Performance">>>>>>> .r66
				],
            "item":{
               "font-color":"white",
               "font-family":"helvetica",
               "text-align":"center",
               "font-size":11,
               "bold":true,
               "background-color":"000000",
			   "padding": "2",
               "offset-y":-20,
               "offset-x":0
            }
         },
<<<<<<< .mine
     	 "scale-r":{
            //"values":"0:100:10",
            "values":"0:<%=green%>:<%=(10)%>",
=======
     	 "scale-r":{
            //"values":"0:100:10",
            "values":"0:<%=green%>:<%=(green/10)%>",
>>>>>>> .r66
			"size": 150,
            "aperture":270, //270
			"offset-start": "15",
			"offset-end": "15",
            "max-items":20,
            "ref-angle":-90,
            "background-color":"#CCCCCC #666666",
			"fill-type": "radial",
            "border-color":"#CCCC99",
            "border-width":"4",
            "item":{
               "padding":"1 1",
               "font-color":"black",
               "font-size":12,
               "font-family":"helvetica",
               "text-align":"center",
               "bold":true,
			   "rules": [
					{
					"rule": "%i >= 11",
					"visible": false
					}
			   ]
            },
            "tick":{
               "visible": false,
			   "placement": "inner",
               "line-color":"orange",
               "line-width":2
            },
			"center" : {
	            	"size" : 10,
	            	"background-color" : "#bbbbbb #000000",
	            	"border-color" : "#cccccc",
	            	"border-width" : "1",
	            	"fill-type" : "radial",
	            	"fill-offset-x" : -5,
	            	"fill-offset-y" : -5
	            },
            "ring":{
               "size":17,
               "alpha":-1,
               "border-width":2,
               "border-color":"black",
			   "rules": [			            
					{
<<<<<<< .mine
					"rule": "%v <= <%=red%>",
					"background-color": "#<%=red_color%>"
=======
					"rule": "%v <= <%=red%>",
					"background-color": "red"
>>>>>>> .r66
					},
					{
<<<<<<< .mine
					"rule": "%v >= <%=red%> && %v <= <%=yellow%>",
					"background-color": "#<%=yellow_color%>"
=======
					"rule": "%v >= <%=red%> && %v <= <%=yellow%>",
					"background-color": "yellow"
>>>>>>> .r66
					},
					{
<<<<<<< .mine
					"rule": "%v >= <%=yellow%> && %v <= <%=green%>",
					"background-color": "#<%=green_color%>"
=======
					"rule": "%v >= <%=yellow%> && %v <= <%=green%>",
					"background-color": "green"
>>>>>>> .r66
					},
					{
					"rule": "%v >= 1000",
					"background-color": "0",
					"border-color": "0"
					}
			   ]
            }
         },
         "plot":{
            "csize":"10",
			"tooltip-text": "%t: %v",
			"border-color": "#f00",
			"border-width": 1
         },
         "tooltip":{
			"border-radius": 10,
			"border-color": "black",
			"border-width": "2",
			"font-color": "black",
			"font-weight": "bold",
			"padding": "10",
			"rules": [			         
					{
					"rule": "%v <=100" ,
					"background-color": "lightgreen"
					},
					{
<<<<<<< .mine
					"rule": "%v >= 0 && %v <= <%=red%>",
					"background-color": "#<%=red_color%>"
=======
					"rule": "%v >= 0 && %v <= <%=red%>",
					"background-color": "red"
>>>>>>> .r66
					},
					{
<<<<<<< .mine
					"rule": "%v >= <%=red%> && %v <= <%=yellow%>",
					"background-color": "#<%=yellow_color%>"
=======
					"rule": "%v >= <%=red%> && %v <= <%=yellow%>",
					"background-color": "yellow"
>>>>>>> .r66
					},
					{
<<<<<<< .mine
					"rule": "%v >= <%=yellow%> && %v <= <%=green%>",
					"background-color": "#<%=green_color%>"
=======
					"rule": "%v >= <%=yellow%> && %v <= <%=green%>",
					"background-color": "green"
>>>>>>> .r66
					}
					,
					{
					"rule": "%v >= 400",
					"background-color": "-1",
					"background-color": "orange",
					"border-color": "-1"
					}
			   ]
         },
       
         "series":[
<<<<<<< .mine
              {
            	  "values":[<%=strvalue%>],
=======
              {
            	  "values":[<%=actual%>],
>>>>>>> .r66
			   "size": "120",
               "text":"Score",
			   "background-color": "green"
			 "tooltip-text" : "%t: <%=actual%>"  // กำหนดเพื่อให้แสดงค่าเวลาเอาเมาส์ไปชี้ที่ Chart ค่ะ
				//"alpha": 1,
				//"data-rpm": ["%"]
				},
              {
				"values":[<%=target%>],
   			   "size": "120",
                  "text":"Value",
   			   "background-color": "blue"
   				//"alpha": 1,
   				//"data-rpm": ["%"]
   				}
              /* ,
               {
				"values":[<target%>],
   			   "size": "120",
                  "text":"Value",
   			   "background-color": "blue"
   				//"alpha": 1,
   				//"data-rpm": ["%"]
   				}
              */
			
         ]
      }
   ]
};

//document.write('<p>' + jsonConfig + '</p>');
</script>

<script type="text/javascript">
window.onload = function(){
	zingchart.render({
		id 				: 'showchart',
		data 		    : jsonCircle,
		width	 		: 450,
		height 			: 350
		
	});
}
</script>

<div id="showchart"></div>

</body>
</html>