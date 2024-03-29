<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<title>Dynatree - Example</title>
<!-- 
	<script src="/DashBoardWebTest/chartLib/js/dynatree/jquery.js" type="text/javascript"></script>
	<script src="/DashBoardWebTest/chartLib/js/dynatree/jquery-ui.custom.js" type="text/javascript"></script>
	<script src="/DashBoardWebTest/chartLib/js/dynatree/jquery.cookie.js" type="text/javascript"></script>
 -->
 <script src="/DashBoardWebTest/chartLib/js/jquery-1.6.1.min.js" type="text/javascript"></script>
 <script src="/DashBoardWebTest/chartLib/js/jquery-ui.js" type="text/javascript"></script>
 
 
	<link href="/DashBoardWebTest/chartLib/js/dynatree/skin/ui.dynatree.css" rel="stylesheet" type="text/css">
	<script src="/DashBoardWebTest/chartLib/js/dynatree/jquery.dynatree.min.js" type="text/javascript"></script>

	<!-- Start_Exclude: This block is not part of the sample code -->
	<link href="/DashBoardWebTest/chartLib/js/dynatree/prettify.css" rel="stylesheet">
	<script src="/DashBoardWebTest/chartLib/js/dynatree/prettify.js" type="text/javascript"></script>
	<link href="/DashBoardWebTest/chartLib/js/dynatree/sample.css" rel="stylesheet" type="text/css">
	<script src="/DashBoardWebTest/chartLib/js/dynatree/sample.js" type="text/javascript"></script>
	<!-- End_Exclude -->

<script type="text/javascript">
	$(function(){
		// Initialize the tree inside the <div>element.
		// The tree structure is read from the contained <ul> tag.
		$("#tree").dynatree({
			title: "Programming Sample",
			onActivate: function(node) {
				$("#echoActive").text(node.data.title);
//				alert(node.getKeyPath());
				if( node.data.url )
					window.open(node.data.url, node.data.target);
			},
			onDeactivate: function(node) {
				$("#echoSelected").text("-");
			},
			onFocus: function(node) {
				$("#echoFocused").text(node.data.title);
			},
			onBlur: function(node) {
				$("#echoFocused").text("-");
			},
			onLazyRead: function(node){
				var fakeJsonResult = [
					{ title: 'Lazy node 1', isLazy: true },
					{ title: 'Simple node 2', select: true }
				];
//				alert ("Let's pretend we're using this AJAX response to load the branch:\n " + jsonResult);
				function fakeAjaxResponse() {
					return function() {
						node.addChild(fakeJsonResult);
						// Remove the 'loading...' status:
						node.setLazyNodeStatus(DTNodeStatus_Ok);
					};
				}
				window.setTimeout(fakeAjaxResponse(), 1500);
			}
		});

		$("#btnAddCode").click(function(){
			// Sample: add an hierarchic branch using code.
			// This is how we would add tree nodes programatically
			var rootNode = $("#tree").dynatree("getRoot");
			var childNode = rootNode.addChild({
				title: "Programatically addded nodes",
				tooltip: "This folder and all child nodes were added programmatically.",
				isFolder: true
			});
			childNode.addChild({
				title: "Document using a custom icon",
				icon: "customdoc1.gif"
			});
		});

		$("#btnAddObject").click(function(){
			// Sample: add an hierarchic branch using an array
			var obj = [
				{ title: 'Lazy node 1', isLazy: true },
				{ title: 'Lazy node 2', isLazy: true },
				{ title: 'Folder node 3', isFolder: true,
					children: [
						{ title: 'node 3.1' },
						{ title: 'node 3.2',
							children: [
								{ title: 'node 3.2.1' },
								{ title: 'node 3.2.2',
									children: [
										{ title: 'node 3.2.2.1' }
									]
								}
							]
						}
					]
				}
			];
			$("#tree").dynatree("getRoot").addChild(obj);
		});

		$("#btnActiveNode").click(function(){
			$("#tree").dynatree("getTree").activateKey("id4.3.2");
//			$("#tree").dynatree("getTree").getNodeByKey("id4.3.2").activate();
		});
		$("#btnSetTitle").click(function(){
			var node = $("#tree").dynatree("getActiveNode");
			if( !node ) return;
			node.setTitle(node.data.title + ", " + new Date());
			// this is a shortcut for
			// node.fromDict({title: node.data.title + new Date()});
		});
		$("#btnFromDict").click(function(){
			var node = $("#tree").dynatree("getActiveNode");
			if( !node ) return;
			// Set node data and - optionally - replace children
			node.fromDict({
				title: node.data.title + new Date(),
				children: [{title: "t1"}, {title: "t2"}]
			});
		});

		$("#btnShowActive").click(function(){
			var node = $("#tree").dynatree("getActiveNode");
			if( node ){
				alert("Currently active: " + node.data.title);
			}else{
				alert("No active node.");
			}
		});

		$("#btnDisable").toggle(function(){
				$("#tree").dynatree("disable");
				$(this).text("Enable");
				return false;
			}, function(){
				$("#tree").dynatree("enable");
				$(this).text("Disable");
				return false;
			});
		$("#btnToggleExpand").click(function(){
			$("#tree").dynatree("getRoot").visit(function(node){
				node.toggleExpand();
			});
			return false;
		});
		$("#btnCollapseAll").click(function(){
			$("#tree").dynatree("getRoot").visit(function(node){
				node.expand(false);
			});
			return false;
		});
		$("#btnExpandAll").click(function(){
			$("#tree").dynatree("getRoot").visit(function(node){
				node.expand(true);
			});
			return false;
		});
		$("#btnSortActive").click(function(){
			var node = $("#tree").dynatree("getActiveNode");
			// Custom compare function (optional) that sorts case insensitive
			var cmp = function(a, b) {
				a = a.data.title.toLowerCase();
				b = b.data.title.toLowerCase();
				return a > b ? 1 : a < b ? -1 : 0;
			};
			node.sortChildren(cmp, false);
		});
		$("#btnSortAll").click(function(){
			var node = $("#tree").dynatree("getRoot");
			node.sortChildren(null, true);
		});
	});
</script>
</head>

<body class="example">
	<h1>Dynatree API</h1>
	<p class="description">
		This example demonstrates the usage of some DynaTree and DynaTreeNode
		API functions.
	</p>

	<p>
		<a href="#" id="btnExpandAll">Expand all</a> -
		<a href="#" id="btnCollapseAll">Collapse all</a> -
		<a href="#" id="btnToggleExpand">Toggle expand</a>
		<br>
		<a href="#" id="btnSortAll">Sort tree</a>
		<a href="#" id="btnSortActive">Sort current node</a>
		<br>
		<a href="#" id="btnDisable">Disable</a>
	</p>
	<div id="tree">
		<ul>
			<li>This simple node (and the following) have been created from html.
			<li id="id1" title="This is item #1">item1 with key and tooltip
			<li id="id2">item2 with key 'id2'

			<li id="id3" class="folder">Standard Folder with some children
				<ul>
					<li id="id3.1">Sub-item 3.1
					<li id="id3.2">Sub-item 3.2
				</ul>

			<li id="id4">item 4. Note that also non-folders (i.e. 'documents') may have child nodes
				<ul>
					<li id="id4.1">Sub-item 4.1
					<li id="id4.2">Sub-item 4.2
					<li id="id4.3">Sub-item 4.3
						<ul>
							<li id="id4.3.1">Sub-item 4.3.1
							<li id="id4.3.2">Sub-item 4.3.2
							<ul>
								<li id="id4.3.2.1">Sub-item 4.3.2.1
								<li id="id4.3.2.2">Sub-item 4.3.2.2
							</ul>
						</ul>
					<li id="id4.4">Sub-item 4.4
				</ul>

			<li id="id5" class="expanded folder">Advanced examples
				<ul>
					<li data="key: 'node5.1'">item5.1: Using data attribute as an alternative way to specify a key.
					<li data="key: 'node5.3', isFolder: true">item5.1: Using data attribute as an alternative way to specify a folder.
					<li id="id5.2">Sub-item 5.2
					<li>Item without a key. Keys are optional (generated automatically), but may be used in the callbacks
				</ul>
		</ul>
	</div>

	<div>Active node: <span id="echoActive">-</span></div>
	<div>Focused node: <span id="echoFocused">-</span></div>
	<p>
		<button id="btnAddCode">Add nodes programmatically</button>
		<button id="btnAddObject">Add nodes using arrays</button>
		<button id="btnActiveNode">Activate item id4.3.2</button>
		<button id="btnShowActive">Show active node...</button>
		<button id="btnSetTitle">Set active node title</button>
		<button id="btnFromDict">Modify active node fom dict</button>
	</p>
	<!-- Start_Exclude: This block is not part of the sample code -->
	<hr>
	<p class="sample-links  no_code">
		<a class="hideInsideFS" href="http://dynatree.googlecode.com">jquery.dynatree.js project home</a>
		<a class="hideOutsideFS" href="#">Link to this page</a>
		<a class="hideInsideFS" href="samples.html">Example Browser</a>
		<a href="#" id="codeExample">View source code</a>
	</p>
	<pre id="sourceCode" class="prettyprint" style="display:none"></pre>
	<!-- End_Exclude -->
	<table id="FinancialTree" width="100%" height="20"  border="1">

	
			<tr height="5" align="center">
				<td class="tdsubheader">KPI</td>
				<td class="tdsubheader"></td>	
				<td class="tdsubheader">Weight</td>		
				<td class="tdsubheader">Freq</td>		
				<td  class="tdsubheader">Target</td> 
				<td  class="tdsubheader">Actual</td>		
				<td  class="tdsubheader">% Target</td>	
				<td class="tdsubheader">Trend</td>
				<td class="tdsubheader" >Last Updated</td>
			</tr>
			</table>
</body>
</html>
