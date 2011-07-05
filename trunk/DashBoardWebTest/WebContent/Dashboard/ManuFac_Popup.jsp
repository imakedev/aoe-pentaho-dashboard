<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Manufacturing Dashboard Page</title>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/jquery.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/zingchart-html5beta-min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chartLib/js/license.js"></script>

<%
	String m = request.getParameter("m");
%>

	<style type="text/css">
		/*body{ font: 55% "Trebuchet MS", sans-serif; margin: 50px;}*/
	</style>

</head>

<body bgcolor="#FFFFFF">
	<div align="center"><font size="3"><b><%out.print(m);%></b></font></div><br>
	<table width="700" border="1" align="center" style="text-decoration:none;">
	<tr  bgcolor="#8B4513">
		<th align="center"><font color="#FFFFFF" size="2">หมวด</font></th>
		<th align="center"><font color="#FFFFFF" size="2">เรื่อง</font></th>
		<th align="center"><font color="#FFFFFF" size="2">สาขา</font></th>
		<th align="center"><font color="#FFFFFF" size="2">Product</font></th>
		<th align="center"><font color="#FFFFFF" size="2">วันที่ร้องเรียน</font></th>
		<th align="center"><font color="#FFFFFF" size="2">ผล</font></th>
	</tr>

	<tr>
		<td rowspan="2"><font size="2">สิ่งแปลกปลอม</font></td>
		<td><font size="2">เส้นผม</font></td>
		<td><font size="2">เจริญนคร</font></td>
		<td><font size="2">ข้าวผัดอเมริกัน </font></td>
		<td><font size="2">01/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>

	<tr>
		<td><font size="2">เศษกระดาษ</font></td>
		<td><font size="2">ปิยรมย์ พาร์ค</font></td>
		<td><font size="2">ยำไส้กรอก </font></td>
		<td><font size="2">01/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>
	
	<tr>
		<td><font size="2">จุลินทรีย์</font></td>
		<td><font size="2">ขึ้นรา</font></td>
		<td><font size="2">พันธุ์ทิพย์</font></td>
		<td><font size="2">คุกกี้พรีเมี่ยม ช็อกโกแลตชิพ</font></td>
		<td><font size="2">01/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>
	
	<tr>
		<td><font size="2">กายภาพ</font></td>
		<td><font size="2">แต่งผลิตภัณฑ์ผิด</font></td>
		<td><font size="2">นิคมอัญธานี</font></td>
		<td><font size="2">เค้กฟุตบอล</font></td>
		<td><font size="2">01/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>
	
	<tr>
		<td><font size="2">สุขภาพ</font></td>
		<td><font size="2">ลูกค้าทานแล้วแพ้</font></td>
		<td><font size="2">อื้อจือเหลียง</font></td>
		<td><font size="2">มักโรนีผัดกุ้ง </font></td>
		<td><font size="2">08/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>
	
	<tr>
		<td rowspan="3"><font size="2">อื่น ๆ</font></td>
		<td><font size="2">รสชาติเค็ม</font></td>
		<td><font size="2">อิมพีเรียลเวิลด์สำโรง</font></td>
		<td><font size="2">แกงส้มผักรวมกุ้งสด </font></td>
		<td><font size="2">01/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>
	
	<tr>
		<td><font size="2">ได้รับผลิตภัณฑ์หมดอายุ</font></td>
		<td><font size="2">สีลมคอมเพล็กซ์</font></td>
		<td><font size="2">คุกกี้คลาสสิค</font></td>
		<td><font size="2">02/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>

	<tr>
		<td><font size="2">รสชาติขม</font></td>
		<td><font size="2">สวนหลวง</font></td>
		<td><font size="2">ข้าวผัดหมูเค็ม-ส้มตำ </font></td>
		<td><font size="2">03/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>

	<tr>
		<td rowspan="2"><font size="2">สัตวพาหะ</font></td>
		<td><font size="2">หนอน</font></td>
		<td><font size="2">ท่ามหาราช</font></td>
		<td><font size="2">สลัดไก่อบ </font></td>
		<td><font size="2">03	/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>

	<tr>
		<td><font size="2">แมลงสาบ</font></td>
		<td><font size="2">สปอร์ต แอนด์ สปา</font></td>
		<td><font size="2">สลัดซีซาร์ </font></td>
		<td><font size="2">06/01/54</font></td>
		<td><font size="2">สำเร็จ</font></td>
	</tr>

	</table>
</body>
</html>

