<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>规划路线</title>
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
<link rel="stylesheet" href="css/map-style.css"/>

    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=c7dd742fd48984414b8b02909d9eac60&plugin=AMap.Walking"></script>
    
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
</head>

<body onload="">
<input type="button" value="点击" onclick="loadEnd()">
<div id="container"></div>
<div id="panel"></div>

<table>
<tr>
        <td>
            <input id="tipinput"/>
            <input type="button" value="更改" onclick="changeEnd()">
        </td>
        </tr>
</table>
 
<div id="T1" style="border:1px solid black;height:40;width:300;padding:5"></div><br />


<script type="text/javascript">



var map = new AMap.Map("container", {
	    resizeEnable: true,
	    center: [121.2152770000,31.2860990000],//地图中心点
	    zoom: 13 //地图显示的缩放级别
	});


function routeplan(){
	var walking = new AMap.Walking({
        map: map,
        panel: "panel"
    }); 
    //根据起终点坐标规划步行路线
    walking.search([ {keyword: '同济大学嘉定校区图书馆'},
                     {keyword: '同济大学嘉定校区10号楼'}]);
}
var xmlhttp;
var newEnd;
var auto = new AMap.Autocomplete({
    input: "tipinput"   
});
function changeEnd(){
	map.clearMap();
	var walking = new AMap.Walking({
        map: map,
        panel: "panel"
    }); 
    //根据起终点坐标规划步行路线
    newEnd=document.getElementById('tipinput').value;
    walking.search([ {keyword: '同济大学嘉定校区10号楼'},
                     {keyword: newEnd}]);
    xmlhttp=null;
    if (window.XMLHttpRequest)
      {// code for Firefox, Opera, IE7, etc.
      xmlhttp=new XMLHttpRequest();
      }
    else if (window.ActiveXObject)
      {// code for IE6, IE5
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
    if (xmlhttp!=null)
      {
    	var url="/MapPlan/setdes?des="+newEnd;
      xmlhttp.onreadystatechange=setDes;
      xmlhttp.open("POST",url,false);
      xmlhttp.send(null);
      }
    else
      {
      alert("Your browser does not support XMLHTTP.");
      }
}
function setDes(){
	
	if (xmlhttp.readyState==4)
	  {// 4 = "loaded"
	  if (xmlhttp.status==200)
	    {// 200 = "OK"
		  alert("okk");
	    }
	  else
	    {
	    alert("Problem retri data:" + xmlhttp.statusText);
	    }
	  }
}



function loadEnd()
{
	map.clearMap();
xmlhttp=null;
if (window.XMLHttpRequest)
  {// code for Firefox, Opera, IE7, etc.
  xmlhttp=new XMLHttpRequest();
  }
else if (window.ActiveXObject)
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
if (xmlhttp!=null)
  {
	var url="/MapPlan/getdes?";
  xmlhttp.onreadystatechange=getDes;
  xmlhttp.open("GET",url,false);
  xmlhttp.send(null);
  }
else
  {
  alert("Your browser does not support XMLHTTP.");
  }
}

function getDes()
{
if (xmlhttp.readyState==4)
  {// 4 = "loaded"
  if (xmlhttp.status==200)
    {// 200 = "OK"
    document.getElementById('T1').innerHTML=xmlhttp.responseText;
    str=xmlhttp.responseText;
	var walking = new AMap.Walking({
        map: map,
        panel: "panel"
    }); 
    //根据起终点坐标规划步行路线
    walking.search([ {keyword: '同济大学嘉定校区10号楼'},
                     {keyword: str}]);
    //步行导航
  
    }
  else
    {
	  alert("aaa")
    alert("Problem retrieving data:" + xmlhttp.statusText);
    }
  }
}


  
</script>
</body>
<script> </script> 
<script language="javascript" for="window" event="onload">;</script>
</html>