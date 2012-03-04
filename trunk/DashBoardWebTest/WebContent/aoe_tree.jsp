<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>jQuery treeTable Plugin Documentation</title>
  <link href="stylesheets/master.css" rel="stylesheet" type="text/css" /> 
  <script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery-1.6.1.min.js"></script>

  <!-- BEGIN Plugin Code -->
  
<link	type="text/css"	href="<%=request.getContextPath()%>/chartLib/css/jquery.treeTable.css" rel="stylesheet"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.treeTable.js"></script>
  <script type="text/javascript">
  var treetable_ids=[];
  var treePerspective={
		  perspectiveArray:[{ id:'',value:''}]
  }
  $(document).ready(function() {
    // TODO Fix issue with multiple treeTables on one page, each with different options
    // Moving the #example3 treeeTable call down will break other treeTables that are expandable...
   
    
   // $(".example").treeTable();
    //$("#ex0-node-1").expand();
  });
   
	  $.fn.toggleBranch = function() {
		    if($(this).hasClass("collapsed")) {
		      $(this).expand();
		    } else {
		      $(this).removeClass("expanded").collapse();
		    }
		    alert(" overid aoe Test"+$(this).attr( "id"));
		    return this;
		  };
  </script>

  <!-- END Plugin Code -->
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
					// else
						// return parentID;
			  	}/*
				 else{
			  		return parentID;
			  	}
				
			 }else {
				 return parentID;
			 } 
			 */
		  }
		 /*
		  else{
			  return parentID;
			*/
		  }
		
				  //child-of-
		 // return parentID;
		}
	  return parentID;
  }
  	function callAddRow(){
  		var aoe_ajax= document.getElementById('aoe_ajax');
  		alert(aoe_ajax.innerHTML)
  		
  		var str="<tr id=\"ex0-node-1-9\" class=\"child-of-ex0-node-1-1-1 parent collapsed\">\
    	      	<td>Chatchai Test</td>\
    	      	<td>Interesting.</td>\
    	    	</tr>";
    	 
   treePerspective.perspectiveArray[0].value=treePerspective.perspectiveArray[0].value+str;
   alert(treePerspective.perspectiveArray[0].value+"</tbody></table>");
   var aoe_ajax= document.getElementById('aoe_ajax');
   aoe_ajax.innerHTML=treePerspective.perspectiveArray[0].value+"</tbody></table>";
   
   //   	alert(treePerspective.perspectiveArray[0].value)
    	/*
		var table=document.getElementById('example1');
        var rowCount = table.rows.length;
        alert(rowCount)
        var row = table.insertRow(rowCount-1);
        row.setAttribute('id', 'ex0-node-1-4');
       row.setAttribute('class', 'child-of-ex0-node-1');
        //child-of-ex0-node-1 parent collapsed
        var cell1 = row.insertCell(0); 
      
        cell1.innerHTML = "aoeee" ;
     //   cell1.align="left";
        var cell2 = row.insertCell(1); 
        cell2.innerHTML = "zzzzz" ;
     //   cell2.align="left";
        var row2 = table.insertRow(rowCount);
        row2.setAttribute('id', 'ex0-node-1-5');
        row2.setAttribute('class', 'child-of-ex0-node-1-1-1');
        var cell1_1 = row2.insertCell(0); 
      
        cell1_1.innerHTML = "aoeee aa" ;
     //   cell1_1.align="left";
        var cell2_2 = row2.insertCell(1); 
        cell2_2.innerHTML = "zzzzz bb" ;
    //    cell2_2.align="left";
      //  attr( attributeName );
    //    $("#ex0-node-1-4").addClass("child-of-ex0-node-1 parent collapsed");
        $("#ex0-node-1-4").addClass("parent");
        $("#ex0-node-1-4").addClass("collapsed");
        alert($("#ex0-node-1-4").attr("class"))
        */
         $(".example").treeTable();  
        /*
        $("#ex0-node-1").expand();
        $("#ex0-node-1-1").expand();
        $("#ex0-node-1-1-1").expand();
        */
       var xx= getParentLoop("ex0-node-1-1-1");
        xx = $.trim(xx); 
       // classValues.split
      // alert(xx.split(" ").length)
       if(xx!=null && xx.length>0){
    	   var elementSplits=xx.split(" ");
    	   var split_size=elementSplits.length;
    	   for(var i=0;i<split_size;i++){
    		 //  alert(elementSplits[i])
    		   $("#"+elementSplits[i]).expand();
    	   }
       }
        /*
        $("ex0-node-1-9".firstChild).click(function() { 
     	    //  alert("aoe Test"+$(this).attr( "id"));
     	   toggleBranchAoe();
     	 // node.toggleBranch();
     	 });
  		*/
       
         
  	  //  $("#ex0-node-1").expand();
  	}
  	function test(){
  		alert("ok")
  	}
  	function callAjax(){
  		treePerspective.perspectiveArray[0].id='example1';
  		
  		var aoe_ajax= document.getElementById('aoe_ajax');
  		var str="<table class=\"example\" id=\"example1\">\
  	  <caption>Simple treeTable Example</caption>\
  	  <thead>\
  	    <tr>\
  	      <th>TreeColumn</th>\
  	      <th>Additional data</th>\
  	    </tr>\
  	  </thead>\
  	  <tbody>\
  	    <tr id=\"ex0-node-1\" class=\"parent collapsed\">\
  	      <td>ex0-node-1</td>\
  	      <td>I live in the second column.</td>\
  	      <tr id=\"ex0-node-1-1\" class=\"child-of-ex0-node-1\">\
	      <td>ex0-node-1-1</td>\
	      <td>Interesting.</td>\
	    </tr>\
	      <tr id=\"ex0-node-1-6\" class=\"child-of-ex0-node-1\">\
	      <td>ex0-node-1-6</td>\
	      <td>That's it!</td>\
	    </tr></tr>\
	  	  <tr id=\"ex0-node-1-1-1\" class=\"child-of-ex0-node-1-1\">\
	      <td>ex0-node-1-1-1</td>\
	      <td>That's it!</td>\
	    </tr>";
	   var str2= "<table class=\"bscTreegrid\" id=\"aa\" border=\"1\" height=\"20\" width=\"100%\">"+
	    "<thead>"+
	    "<tr  align=\"center\" height=\"5\">"+		
	    "<td class=\"tdsubheader\" width=\"43%\">KPI</td>"+		
	    "<td class=\"tdsubheader\" width=\"20px\"></td>"+	
	    "<td class=\"tdsubheader\" width=\"6%\">KPI Weight</td>"+	
	    "<td class=\"tdsubheader\" width=\"6%\">Weight</td>"+
	    "<td class=\"tdsubheader\" width=\"4%\">Freq</td>"+		
	    "<td class=\"tdsubheader\" width=\"7%\">Target</td> 	"+
	    "<td class=\"tdsubheader\" width=\"7%\">Actual</td>		"+
	    "<td class=\"tdsubheader\" width=\"10%\">Target</td>	"+
	    "<td class=\"tdsubheader\" width=\"10%\">Trend</td>"+
	    "<td class=\"tdsubheader\" width=\"12%\">Last Updated</td>"+	
	    "</tr></thead><tbody>"+
	 //   "<tr id=\"1_node_1\" class=\"parent collapsed initialized\" height=\"5\">"+
	    "<tr id=\"1-node-1\" height=\"5\">"+
	    "<td style=\"padding-left: 20px;\" width=\"43%\">"+
	    ""+
	    "Overall</td>"+
	    "<td align=\"right\" width=\"20px\"><a style=\"cursor: pointer;\" id=\"KPIDetail_1\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('1','1097')\">"+
	    "<img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" border=\"0\" width=\"20px\"></a>	"+
	    "</td>"+
	    "<td align=\"center\" width=\"6%\">0.80%</td>"+
	    "<td align=\"center\" width=\"6%\">0.75%</td>"+			
	    "<td align=\"center\" width=\"4%\">M</td>"+
	    "<td align=\"center\" width=\"7%\">14.45</td>"+
	    "<td align=\"center\" width=\"7%\">75.36</td>"+
	    "<td align=\"center\" width=\"7%\"></td>"+
	    "<td align=\"center\" width=\"7%\"></td>"+
	    "<td align=\"center\" width=\"12%\">10/06/2011</td>"+
	    "</tr>"+ 
	    "<tr  height=\"5\" id=\"1_node_3\" class=\"child-of-1-node-1\">"+
	    "<td style=\"padding-left: 20px;\" width=\"43%\">"+
	    ""+
	    "Overall</td>"+
	    "<td align=\"right\" width=\"20px\"><a style=\"cursor: pointer;\" id=\"KPIDetail_1\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('1','1097')\">"+
	    "<img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" border=\"0\" width=\"20px\"></a>	"+
	    "</td>"+
	    "<td align=\"center\" width=\"6%\">0.80%</td>"+
	    "<td align=\"center\" width=\"6%\">0.75%</td>"+			
	    "<td align=\"center\" width=\"4%\">M</td>"+
	    "<td align=\"center\" width=\"7%\">14.45</td>"+
	    "<td align=\"center\" width=\"7%\">75.36</td>"+
	    "<td align=\"center\" width=\"7%\"><canvas height=\"19\" width=\"64\" style=\"display: inline-block; width: 64px; height: 19px; vertical-align: top;\"></canvas></td>"+
	    "<td align=\"center\" width=\"7%\"><div class=\"trendLine_1_0\" linecolor=\"red\">xx</div></td>"+
	    "<td align=\"center\" width=\"12%\">10/06/2011</td>"+
	    "</tr>";
	    
	  str3=  "<table class=\"bscTreegrid_1 cc\" id=\"ss\" border=\"1\" height=\"20\" width=\"100%\">"+	
	  "<thead>"+
	  "<tr class=\"initialized\" align=\"center\" height=\"5\">		<td class=\"tdsubheader\" width=\"43%\">KPI</td>"+	
	  "<td class=\"tdsubheader\" width=\"20px\"></td>			<td class=\"tdsubheader\" width=\"6%\">KPI Weight</td>"+	
	  "<td class=\"tdsubheader\" width=\"6%\">Weight</td>		<td class=\"tdsubheader\" width=\"4%\">Freq</td>		"+
	  "<td class=\"tdsubheader\" width=\"7%\">Target</td> 		<td class=\"tdsubheader\" width=\"7%\">Actual</td>			"+
	  "<td class=\"tdsubheader\" width=\"10%\">Target</td>			<td class=\"tdsubheader\" width=\"10%\">Trend</td>		"+
	  "<td class=\"tdsubheader\" width=\"12%\">Last Updated</td>	</tr></thead><tbody>"+
	   "<tr id=\"1_node_1\" class=\"\" height=\"5\">"+
	    "<td style=\"padding-left: 20px;\" width=\"43%\">"+
	    //<span style=\"margin-left: -15px; padding-left: 15px;\" class=\"expander\"></span>"+
	    ""+
	    "Overall</td>"+
	    "<td align=\"right\" width=\"20px\"><a style=\"cursor: pointer;\" id=\"KPIDetail_1\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('1','1097')\">"+
	    "<img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" border=\"0\" width=\"20px\"></a>	"+
	    "</td>"+
	    "<td align=\"center\" width=\"6%\">0.80%</td>"+
	    "<td align=\"center\" width=\"6%\">0.75%</td>"+			
	    "<td align=\"center\" width=\"4%\">M</td>"+
	    "<td align=\"center\" width=\"7%\">14.45</td>"+
	    "<td align=\"center\" width=\"7%\">75.36</td>"+
	    "<td align=\"center\" width=\"7%\"></td>"+
	    "<td align=\"center\" width=\"7%\"></td>"+
	    "<td align=\"center\" width=\"12%\">10/06/2011</td>"+
	    "</tr>"+ 
	   /*
	    "<tr  height=\"5\" id=\"1_node_3\" class=\"child-of-1_node_1\">"+
	    "<td style=\"padding-left: 20px;\" width=\"43%\">"+
	    ""+
	    "Overall</td>"+
	    "<td align=\"right\" width=\"20px\"><a style=\"cursor: pointer;\" id=\"KPIDetail_1\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('1','1097')\">"+
	    "<img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" border=\"0\" width=\"20px\"></a>	"+
	    "</td>"+
	    "<td align=\"center\" width=\"6%\">0.80%</td>"+
	    "<td align=\"center\" width=\"6%\">0.75%</td>"+			
	    "<td align=\"center\" width=\"4%\">M</td>"+
	    "<td align=\"center\" width=\"7%\">14.45</td>"+
	    "<td align=\"center\" width=\"7%\">75.36</td>"+
	    "<td align=\"center\" width=\"7%\"><canvas height=\"19\" width=\"64\" style=\"display: inline-block; width: 64px; height: 19px; vertical-align: top;\"></canvas></td>"+
	    "<td align=\"center\" width=\"7%\"><div class=\"trendLine_1_0\" linecolor=\"red\">xx</div></td>"+
	    "<td align=\"center\" width=\"12%\">10/06/2011</td>"+
	    "</tr>";
	    */
	   "<tr  height=\"5\" id=\"1_node_3\" class=\"child-of-1_node_1\"><td width=\"43%\" style=\"padding-left: 20px;\" ><div style=\"cursor: pointer;\" onclick=\"showKPIBarChart('1','3','1097','Y')\">Trading</div></td><td width=\"20px\"  align=\"right\"><a style=\"cursor: pointer;\" id=\"KPIDetail_3\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('3','1097')\"><img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" width=\"20px\" BORDER =\"0\"/></a>	</td><td width=\"6%\"  align=\"center\">0.75%</td><td width=\"6%\"  align=\"center\">0.96%</td>			<td width=\"4%\" align=\"center\">Q</td><td width=\"7%\"  align=\"center\">18.8</td>		<td width=\"7%\" align=\"center\">98.94</td><td width=\"7%\"  align=\"center\"><div   class=\"sparklines_1_0\" title=\"98.94%\">18.8,18.6,100.00,70.00,40.00</div></td><td width=\"7%\"  align=\"center\"><div class=\"trendLine_1_0\" LineColor=\"red\" >18,0,0,0,0,0,0,0,0,0,0,0</div></td><td width=\"12%\" align=\"center\">10/06/2011</td></tr><tr  height=\"5\" id=\"1_node_4\" class=\"child-of-1_node_1\"><td width=\"43%\" style=\"padding-left: 20px;\" ><div style=\"cursor: pointer;\" onclick=\"showKPIBarChart('1','4','1097','N')\">Specialty</div></td><td width=\"20px\"  align=\"right\"><a style=\"cursor: pointer;\" id=\"KPIDetail_4\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('4','1097')\"><img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" width=\"20px\" BORDER =\"0\"/></a>	</td><td width=\"6%\"  align=\"center\">0.75%</td><td width=\"6%\"  align=\"center\">0.25%</td>			<td width=\"4%\" align=\"center\">M</td><td width=\"7%\"  align=\"center\">10.9</td>		<td width=\"7%\" align=\"center\">200.92</td><td width=\"7%\"  align=\"center\"><div   class=\"sparklines_1_1\" title=\"200.92%\">10.9,21.9,100.00,70.00,40.00</div></td><td width=\"7%\"  align=\"center\"><div class=\"trendLine_1_1\" LineColor=\"red\" >21,0,0,0,0,0,0,0,0,0,0,0</div></td><td width=\"12%\" align=\"center\">10/06/2011</td></tr></tbody></table>";
	   //<table class="bscTreegrid_1 treeTable" border="1" height="20" width="100%">	<tbody><tr class="initialized" align="center" height="5">		<td class="tdsubheader" width="43%">KPI</td>		<td class="tdsubheader" width="20px"></td>			<td class="tdsubheader" width="6%">KPI Weight</td>		<td class="tdsubheader" width="6%">Weight</td>		<td class="tdsubheader" width="4%">Freq</td>			<td class="tdsubheader" width="7%">Target</td> 		<td class="tdsubheader" width="7%">Actual</td>			<td class="tdsubheader" width="10%">Target</td>			<td class="tdsubheader" width="10%">Trend</td>		<td class="tdsubheader" width="12%">Last Updated</td>	</tr><tr id="1_node_1" class="parent collapsed initialized" height="5"><td style="padding-left: 20px;" width="43%"><span style="margin-left: -15px; padding-left: 15px;" class="expander"></span><div style="cursor: pointer;" onclick="showKPIBarChart('1','1','1097','Y')">Overall</div></td><td align="right" width="20px"><a style="cursor: pointer;" id="KPIDetail_1" rel="facebox" class="KPIDetail" onclick="showKPIDetail('1','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" border="0" width="20px"></a>	</td><td align="center" width="6%">0.80%</td><td align="center" width="6%">0.75%</td>			<td align="center" width="4%">M</td><td align="center" width="7%">14.45</td>		<td align="center" width="7%">75.36</td><td align="center" width="7%"><div class="sparklines_1_0" title="75.36%"><canvas height="19" width="64" style="display: inline-block; width: 64px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="7%"><div class="trendLine_1_0" linecolor="red"><canvas height="19" width="36" style="display: inline-block; width: 36px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="12%">10/06/2011</td></tr><tr  height="5" id="1_node_3" class="child-of-1_node_1"><td width="43%" style="padding-left: 20px;" ><div style="cursor: pointer;" onclick="showKPIBarChart('1','3','1097','Y')">Trading</div></td><td width="20px"  align="right"><a style="cursor: pointer;" id="KPIDetail_3" rel="facebox" class="KPIDetail" onclick="showKPIDetail('3','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" width="20px" BORDER ="0"/></a>	</td><td width="6%"  align="center">0.75%</td><td width="6%"  align="center">0.96%</td>			<td width="4%" align="center">Q</td><td width="7%"  align="center">18.8</td>		<td width="7%" align="center">98.94</td><td width="7%"  align="center"><div   class="sparklines_1_0" title="98.94%">18.8,18.6,100.00,70.00,40.00</div></td><td width="7%"  align="center"><div class="trendLine_1_0" LineColor="red" >18,0,0,0,0,0,0,0,0,0,0,0</div></td><td width="12%" align="center">10/06/2011</td></tr><tr  height="5" id="1_node_4" class="child-of-1_node_1"><td width="43%" style="padding-left: 20px;" ><div style="cursor: pointer;" onclick="showKPIBarChart('1','4','1097','N')">Specialty</div></td><td width="20px"  align="right"><a style="cursor: pointer;" id="KPIDetail_4" rel="facebox" class="KPIDetail" onclick="showKPIDetail('4','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" width="20px" BORDER ="0"/></a>	</td><td width="6%"  align="center">0.75%</td><td width="6%"  align="center">0.25%</td>			<td width="4%" align="center">M</td><td width="7%"  align="center">10.9</td>		<td width="7%" align="center">200.92</td><td width="7%"  align="center"><div   class="sparklines_1_1" title="200.92%">10.9,21.9,100.00,70.00,40.00</div></td><td width="7%"  align="center"><div class="trendLine_1_1" LineColor="red" >21,0,0,0,0,0,0,0,0,0,0,0</div></td><td width="12%" align="center">10/06/2011</td></tr></tbody></table>
	  /*
	    "<tr  height=\"5\" id=\"1_node_3\" class=\"child-of-1-node-1\">"+
	    "<td width=\"43%\" style=\"padding-left: 20px;\" >"+
	    "<span style=\"cursor: pointer;\" onclick=\"showKPIBarChart('1','3','1097','Y')\">Trading</span></td>"+
	    "<td width=\"20px\"  align=\"right\"><a style=\"cursor: pointer;\" id=\"KPIDetail_3\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('3','1097')\"><img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" width=\"20px\" BORDER =\"0\"/></a>	</td><td width=\"6%\"  align=\"center\">0.75%</td><td width=\"6%\"  align=\"center\">0.96%</td>			<td width=\"4%\" align=\"center\">Q</td><td width=\"7%\"  align=\"center\">18.8</td>		<td width=\"7%\" align=\"center\">98.94</td><td width=\"7%\"  align=\"center\"><span   class=\"sparklines_1_0\" title=\"98.94%\">18.8,18.6,100.00,70.00,40.00</span></td><td width=\"7%\"  align=\"center\"><span class=\"trendLine_1_0\" LineColor=\"red\" >18,0,0,0,0,0,0,0,0,0,0,0</span></td><td width=\"12%\" align=\"center\">10/06/2011</td>"+
	    "</tr>"+
	    
	    "<tr  height=\"5\" id=\"1_node_4\" class=\"child-of-1-node-1\">"+
	    "<td width=\"43%\" style=\"padding-left: 20px;\" >"+
	    "<span style=\"cursor: pointer;\" onclick=\"showKPIBarChart('1','4','1097','N')\">Specialty</span></td><td width=\"20px\"  align=\"right\"><a style=\"cursor: pointer;\" id=\"KPIDetail_4\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('4','1097')\"><img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" width=\"20px\" BORDER =\"0\"/></a>	</td><td width=\"6%\"  align=\"center\">0.75%</td><td width=\"6%\"  align=\"center\">0.25%</td>			<td width=\"4%\" align=\"center\">M</td><td width=\"7%\"  align=\"center\">10.9</td>		<td width=\"7%\" align=\"center\">200.92</td><td width=\"7%\"  align=\"center\"><span   class=\"sparklines_1_1\" title=\"200.92%\">10.9,21.9,100.00,70.00,40.00</span></td><td width=\"7%\"  align=\"center\"><span class=\"trendLine_1_1\" LineColor=\"red\" >21,0,0,0,0,0,0,0,0,0,0,0</span></td>"+
	    "<td width=\"12%\" align=\"center\">10/06/2011</td>"+
	    "</tr>"+
	    */
	    "</tbody>"+
	    "</table>";
	var str4="<table class=\"bscTreegrid_1 treeTable\" border=\"1\" height=\"20\" width=\"100%\">"+
			"<thead>	"+
			"<tr align=\"center\" height=\"5\">"+		
			"<td class=\"tdsubheader\" width=\"43%\">KPI</td>"+
			"<td class=\"tdsubheader\" width=\"20px\"></td>	"+
			"<td class=\"tdsubheader\" width=\"6%\">KPI Weight</td>"+	
			"<td class=\"tdsubheader\" width=\"6%\">Weight</td>		"+
			"<td class=\"tdsubheader\" width=\"4%\">Freq</td>		"+
			"<td class=\"tdsubheader\" width=\"7%\">Target</td> 		"+
			"<td class=\"tdsubheader\" width=\"7%\">Actual</td>	"+
			"<td class=\"tdsubheader\" width=\"10%\">Target</td>	"+	
			"<td class=\"tdsubheader\" width=\"10%\">Trend</td>		"+
			"<td class=\"tdsubheader\" width=\"12%\">Last Updated</td>"+
			"</tr></thead>"+
			"<tbody>"+
			//"<tr id=\"1_node_1\" class=\"parent collapsed initialized\" height=\"5\">"+
			"<tr id=\"1_node_1\" class=\"parent collapsed initialized\" height=\"5\">"+
			"<td style=\"padding-left: 20px;\" width=\"43%\"><div style=\"cursor: pointer;\" onclick=\"showKPIBarChart('1','1','1097','Y')\">Overall</div></td>"+
			"<td align=\"right\" width=\"20px\"><a style=\"cursor: pointer;\" id=\"KPIDetail_1\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('1','1097')\"><img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" border=\"0\" width=\"20px\"></a>	</td>"+
			"<td align=\"center\" width=\"6%\">0.80%</td><td align=\"center\" width=\"6%\">0.75%</td>			"+
			"<td align=\"center\" width=\"4%\">M</td><td align=\"center\" width=\"7%\">14.45</td>		"+
			"<td align=\"center\" width=\"7%\">75.36</td>"+
			"<td align=\"center\" width=\"7%\"><div class=\"sparklines_1_0\" title=\"75.36%\"><canvas height=\"19\" width=\"64\" style=\"display: inline-block; width: 64px; height: 19px; vertical-align: top;\"></canvas></div></td>"+
			"<td align=\"center\" width=\"7%\"><div class=\"trendLine_1_0\" linecolor=\"red\"><canvas height=\"19\" width=\"36\" style=\"display: inline-block; width: 36px; height: 19px; vertical-align: top;\"></canvas></div></td>"+
			"<td align=\"center\" width=\"12%\">10/06/2011</td>"+
			"</tr>"+
			
			"<tr style=\"display: none;\" id=\"1_node_3\" class=\"child-of-1_node_1\" height=\"5\">"+
			"<td style=\"padding-left: 20px;\" width=\"43%\"><div style=\"cursor: pointer;\" onclick=\"showKPIBarChart('1','3','1097','Y')\">Trading</div></td>"+
			"<td align=\"right\" width=\"20px\"><a style=\"cursor: pointer;\" id=\"KPIDetail_3\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('3','1097')\"><img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" border=\"0\" width=\"20px\"></a>	</td>"+
			"<td align=\"center\" width=\"6%\">0.75%</td>"+
			"<td align=\"center\" width=\"6%\">0.96%</td>	"+
			"<td align=\"center\" width=\"4%\">Q</td>"+
			"<td align=\"center\" width=\"7%\">18.8</td>"+	
			"<td align=\"center\" width=\"7%\">98.94</td>"+
			"<td align=\"center\" width=\"7%\"><div class=\"sparklines_1_0\" title=\"98.94%\">18.8,18.6,100.00,70.00,40.00</div></td>"+
			"<td align=\"center\" width=\"7%\"><div class=\"trendLine_1_0\" linecolor=\"red\">18,0,0,0,0,0,0,0,0,0,0,0</div></td>"+
			"<td align=\"center\" width=\"12%\">10/06/2011</td>"+
			"</tr>"+
			
			"<tr style=\"display: none;\" id=\"1_node_4\" class=\"child-of-1_node_1\" height=\"5\">"+
			"<td style=\"padding-left: 20px;\" width=\"43%\"><div style=\"cursor: pointer;\" onclick=\"showKPIBarChart('1','4','1097','N')\">Specialty</div></td>"+
			"<td align=\"right\" width=\"20px\"><a style=\"cursor: pointer;\" id=\"KPIDetail_4\" rel=\"facebox\" class=\"KPIDetail\" onclick=\"showKPIDetail('4','1097')\"><img src=\"/DashBoardWebTest/chartLib/images/question_shield.ico\" border=\"0\" width=\"20px\"></a>	</td>"+
			"<td align=\"center\" width=\"6%\">0.75%</td>"+
			"<td align=\"center\" width=\"6%\">0.25%</td>"+
			"<td align=\"center\" width=\"4%\">M</td>"+
			"<td align=\"center\" width=\"7%\">10.9</td>"+	
			"<td align=\"center\" width=\"7%\">200.92</td>"+
			"<td align=\"center\" width=\"7%\"><div class=\"sparklines_1_1\" title=\"200.92%\">10.9,21.9,100.00,70.00,40.00</div></td>"+
			"<td align=\"center\" width=\"7%\"><div class=\"trendLine_1_1\" linecolor=\"red\">21,0,0,0,0,0,0,0,0,0,0,0</div></td>"+
			"<td align=\"center\" width=\"12%\">10/06/2011</td>"+
			"</tr>"+
			"</tbody></table>";    
			//<table class="bscTreegrid_1 treeTable" border="1" height="20" width="100%"><thead>	<tr align="center" height="5">		<td class="tdsubheader" width="43%">KPI</td>		<td class="tdsubheader" width="20px"></td>			<td class="tdsubheader" width="6%">KPI Weight</td>		<td class="tdsubheader" width="6%">Weight</td>		<td class="tdsubheader" width="4%">Freq</td>			<td class="tdsubheader" width="7%">Target</td> 		<td class="tdsubheader" width="7%">Actual</td>			<td class="tdsubheader" width="10%">Target</td>			<td class="tdsubheader" width="10%">Trend</td>		<td class="tdsubheader" width="12%">Last Updated</td>	</tr></thead><tbody><tr id="1_node_1" class="parent collapsed initialized" height="5"><td style="padding-left: 20px;" width="43%"><span style="margin-left: -15px; padding-left: 15px;" class="expander"></span><div style="cursor: pointer;" onclick="showKPIBarChart('1','1','1097','Y')">Overall</div></td><td align="right" width="20px"><a style="cursor: pointer;" id="KPIDetail_1" rel="facebox" class="KPIDetail" onclick="showKPIDetail('1','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" border="0" width="20px"></a>	</td><td align="center" width="6%">0.80%</td><td align="center" width="6%">0.75%</td>			<td align="center" width="4%">M</td><td align="center" width="7%">14.45</td>		<td align="center" width="7%">75.36</td><td align="center" width="7%"><div class="sparklines" title="75.36%"><canvas height="19" width="64" style="display: inline-block; width: 64px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="7%"><div class="trendLine" linecolor="red"><canvas height="19" width="36" style="display: inline-block; width: 36px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="12%">10/06/2011</td></tr><tr  height="5" id="1_node_3" class="child-of-1_node_1"><td width="43%" style="padding-left: 20px;" ><div style="cursor: pointer;" onclick="showKPIBarChart('1','3','1097','Y')">Trading</div></td><td width="20px"  align="right"><a style="cursor: pointer;" id="KPIDetail_3" rel="facebox" class="KPIDetail" onclick="showKPIDetail('3','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" width="20px" BORDER ="0"/></a>	</td><td width="6%"  align="center">0.75%</td><td width="6%"  align="center">0.96%</td>			<td width="4%" align="center">Q</td><td width="7%"  align="center">18.8</td>		<td width="7%" align="center">98.94</td><td width="7%"  align="center"><div   class="sparklines" title="98.94%">18.8,18.6,100.00,70.00,40.00</div></td><td width="7%"  align="center"><div class="trendLine" LineColor="red" >18,0,0,0,0,0,0,0,0,0,0,0</div></td><td width="12%" align="center">10/06/2011</td></tr><tr  height="5" id="1_node_4" class="child-of-1_node_1"><td width="43%" style="padding-left: 20px;" ><div style="cursor: pointer;" onclick="showKPIBarChart('1','4','1097','N')">Specialty</div></td><td width="20px"  align="right"><a style="cursor: pointer;" id="KPIDetail_4" rel="facebox" class="KPIDetail" onclick="showKPIDetail('4','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" width="20px" BORDER ="0"/></a>	</td><td width="6%"  align="center">0.75%</td><td width="6%"  align="center">0.25%</td>			<td width="4%" align="center">M</td><td width="7%"  align="center">10.9</td>		<td width="7%" align="center">200.92</td><td width="7%"  align="center"><div   class="sparklines" title="200.92%">10.9,21.9,100.00,70.00,40.00</div></td><td width="7%"  align="center"><div class="trendLine" LineColor="red" >21,0,0,0,0,0,0,0,0,0,0,0</div></td><td width="12%" align="center">10/06/2011</td></tr></tbody></table>
  	//<table class="bscTreegrid_1 treeTable" border="1" height="20" width="100%">	<tbody><tr class="initialized" align="center" height="5">		<td class="tdsubheader" width="43%">KPI</td>		<td class="tdsubheader" width="20px"></td>			<td class="tdsubheader" width="6%">KPI Weight</td>		<td class="tdsubheader" width="6%">Weight</td>		<td class="tdsubheader" width="4%">Freq</td>			<td class="tdsubheader" width="7%">Target</td> 		<td class="tdsubheader" width="7%">Actual</td>			<td class="tdsubheader" width="10%">Target</td>			<td class="tdsubheader" width="10%">Trend</td>		<td class="tdsubheader" width="12%">Last Updated</td>	</tr><tr id="1_node_1" class="parent collapsed initialized" height="5"><td style="padding-left: 20px;" width="43%"><span style="margin-left: -15px; padding-left: 15px;" class="expander"></span><div style="cursor: pointer;" onclick="showKPIBarChart('1','1','1097','Y')">Overall</div></td><td align="right" width="20px"><a style="cursor: pointer;" id="KPIDetail_1" rel="facebox" class="KPIDetail" onclick="showKPIDetail('1','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" border="0" width="20px"></a>	</td><td align="center" width="6%">0.80%</td><td align="center" width="6%">0.75%</td>			<td align="center" width="4%">M</td><td align="center" width="7%">14.45</td>		<td align="center" width="7%">75.36</td><td align="center" width="7%"><div class="sparklines_1_0" title="75.36%"><canvas height="19" width="64" style="display: inline-block; width: 64px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="7%"><div class="trendLine_1_0" linecolor="red"><canvas height="19" width="36" style="display: inline-block; width: 36px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="12%">10/06/2011</td></tr><tr  height="5" id="1_node_3" class="child-of-1_node_1"><td width="43%" style="padding-left: 20px;" ><div style="cursor: pointer;" onclick="showKPIBarChart('1','3','1097','Y')">Trading</div></td><td width="20px"  align="right"><a style="cursor: pointer;" id="KPIDetail_3" rel="facebox" class="KPIDetail" onclick="showKPIDetail('3','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" width="20px" BORDER ="0"/></a>	</td><td width="6%"  align="center">0.75%</td><td width="6%"  align="center">0.96%</td>			<td width="4%" align="center">Q</td><td width="7%"  align="center">18.8</td>		<td width="7%" align="center">98.94</td><td width="7%"  align="center"><div   class="sparklines_1_0" title="98.94%">18.8,18.6,100.00,70.00,40.00</div></td><td width="7%"  align="center"><div class="trendLine_1_0" LineColor="red" >18,0,0,0,0,0,0,0,0,0,0,0</div></td><td width="12%" align="center">10/06/2011</td></tr><tr  height="5" id="1_node_4" class="child-of-1_node_1"><td width="43%" style="padding-left: 20px;" ><div style="cursor: pointer;" onclick="showKPIBarChart('1','4','1097','N')">Specialty</div></td><td width="20px"  align="right"><a style="cursor: pointer;" id="KPIDetail_4" rel="facebox" class="KPIDetail" onclick="showKPIDetail('4','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" width="20px" BORDER ="0"/></a>	</td><td width="6%"  align="center">0.75%</td><td width="6%"  align="center">0.25%</td>			<td width="4%" align="center">M</td><td width="7%"  align="center">10.9</td>		<td width="7%" align="center">200.92</td><td width="7%"  align="center"><div   class="sparklines_1_1" title="200.92%">10.9,21.9,100.00,70.00,40.00</div></td><td width="7%"  align="center"><div class="trendLine_1_1" LineColor="red" >21,0,0,0,0,0,0,0,0,0,0,0</div></td><td width="12%" align="center">10/06/2011</td></tr></tbody></table>
  	treePerspective.perspectiveArray[0].value=str;
    str=str+"</tbody>\
  	</table>";
  //	alert(str)initialized
 // 	alert()
  	//.collapse();
  		aoe_ajax.innerHTML=str;
  		$('tr[class*=initialized]').removeClass("initialized");
  		//treetable_ids.push('example');
  		//$(".bscTreegrid_1").treeTable();
  		$("#example1").treeTable();
 //     $("#ex0-node-1").addClass("parent collapsed");
  	    //$("#ex0-node-1").expand();
  	//	$("#ex0-node-1-1").expand();
  		//$("#ex0-node-1-1").firstChild();
  		/*
  		$(cell[0].firstChild).click(function() { 
     	    //  alert("aoe Test"+$(this).attr( "id"));
     	  node.toggleBranch();
     	 });
  		*/
  		// <table class="bscTreegrid_1 treeTable" border="1" height="20" width="100%">	<tbody><tr class="initialized" align="center" height="5">		<td class="tdsubheader" width="43%">KPI</td>		<td class="tdsubheader" width="20px"></td>			<td class="tdsubheader" width="6%">KPI Weight</td>		<td class="tdsubheader" width="6%">Weight</td>		<td class="tdsubheader" width="4%">Freq</td>			<td class="tdsubheader" width="7%">Target</td> 		<td class="tdsubheader" width="7%">Actual</td>			<td class="tdsubheader" width="10%">Target</td>			<td class="tdsubheader" width="10%">Trend</td>		<td class="tdsubheader" width="12%">Last Updated</td>	</tr><tr id="1_node_1" class="parent collapsed initialized" height="5"><td style="padding-left: 20px;" width="43%"><div style="cursor: pointer;" onclick="showKPIBarChart('1','1','1097','Y')">Overall</div></td><td align="right" width="20px"><a style="cursor: pointer;" id="KPIDetail_1" rel="facebox" class="KPIDetail" onclick="showKPIDetail('1','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" border="0" width="20px"></a>	</td><td align="center" width="6%">0.80%</td><td align="center" width="6%">0.75%</td>			<td align="center" width="4%">M</td><td align="center" width="7%">14.45</td>		<td align="center" width="7%">75.36</td><td align="center" width="7%"><div class="sparklines_1_0" title="75.36%"><canvas height="19" width="64" style="display: inline-block; width: 64px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="7%"><div class="trendLine_1_0" linecolor="red"><canvas height="19" width="36" style="display: inline-block; width: 36px; height: 19px; vertical-align: top;"></canvas></div></td><td align="center" width="12%">10/06/2011</td></tr><tr style="display: none;" id="1_node_3" class="child-of-1_node_1" height="5"><td style="padding-left: 20px;" width="43%"><div style="cursor: pointer;" onclick="showKPIBarChart('1','3','1097','Y')">Trading</div></td><td align="right" width="20px"><a style="cursor: pointer;" id="KPIDetail_3" rel="facebox" class="KPIDetail" onclick="showKPIDetail('3','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" border="0" width="20px"></a>	</td><td align="center" width="6%">0.75%</td><td align="center" width="6%">0.96%</td>			<td align="center" width="4%">Q</td><td align="center" width="7%">18.8</td>		<td align="center" width="7%">98.94</td><td align="center" width="7%"><div class="sparklines_1_0" title="98.94%">18.8,18.6,100.00,70.00,40.00</div></td><td align="center" width="7%"><div class="trendLine_1_0" linecolor="red">18,0,0,0,0,0,0,0,0,0,0,0</div></td><td align="center" width="12%">10/06/2011</td></tr><tr style="display: none;" id="1_node_4" class="child-of-1_node_1" height="5"><td style="padding-left: 20px;" width="43%"><div style="cursor: pointer;" onclick="showKPIBarChart('1','4','1097','N')">Specialty</div></td><td align="right" width="20px"><a style="cursor: pointer;" id="KPIDetail_4" rel="facebox" class="KPIDetail" onclick="showKPIDetail('4','1097')"><img src="/DashBoardWebTest/chartLib/images/question_shield.ico" border="0" width="20px"></a>	</td><td align="center" width="6%">0.75%</td><td align="center" width="6%">0.25%</td>			<td align="center" width="4%">M</td><td align="center" width="7%">10.9</td>		<td align="center" width="7%">200.92</td><td align="center" width="7%"><div class="sparklines_1_1" title="200.92%">10.9,21.9,100.00,70.00,40.00</div></td><td align="center" width="7%"><div class="trendLine_1_1" linecolor="red">21,0,0,0,0,0,0,0,0,0,0,0</div></td><td align="center" width="12%">10/06/2011</td></tr></tbody></table>
  	}
  </script>
</head>
<body>

<h1>jQuery treeTable Plugin Documentation</h1>
<span id="aoe_ajax"></span>

 <span>
<input type="button" value="Create table" onclick="callAjax()" name="Create"></input><br/>
<input type="button" value="Add Row table xx" onclick="callAddRow()" name="Create"></input>
</html>