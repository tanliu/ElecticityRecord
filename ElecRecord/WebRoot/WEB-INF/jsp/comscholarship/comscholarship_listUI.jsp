
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/header_js.jsp"%>
<html>
<head>
<script type="text/javascript" >
<!-- action之间的跳转 ，用于换页-->
var queryAction="${basePath}comscholarship/comscholarship_listUI.action";
var deleteAction="${basePath}comscholarship/comscholarship_delete.action";
var importUrl="${basePath}comscholarship/comscholarship_importExcel.action";
</script>
<meta charset="utf-8">
<link rel="stylesheet" href="${basePath}css/base.css" />
<link rel="stylesheet" href="${basePath}css/info-mgt.css" />
<link rel="stylesheet" href="${basePath}css/alter.css" />
<link rel="stylesheet" href="${basePath}css/WdatePicker.css" />
<link rel="stylesheet" type="text/css"
	href="${basePath}css/jquery.dialog.css" />
<!-- 行之间的显示效果与选中行的效果 -->
<style type="text/css">
        .even{ background:#FFF;color:#000;}  /* 偶数行样式*/
        .odd{ background:#eff6fa;color:#000;}  /* 奇数行样式*/
        .selected{background:#DDDDDD;color:#003333} /*选中行样式*/
</style>
<style type="text/css">
table tbody tr td{
	 text-align: center;
}
table thead tr th{
	 text-align: center;
}
</style>

<script type="text/javascript" src="${basePath}js/WdatePicker.js"></script>
<script type="text/javascript" src="${basePath}js/jquery.pagination.js"></script>
<script type="text/javascript" src="${basePath}js/core.js"></script>
<script type="text/javascript" src="${basePath}js/jquery.dialog.js"></script>
<title>普通奖学金信息管理</title>
</head>

<body>
<div class="title"><h2>普通奖学金信息管理</h2></div>
<!-- 跳转页面时表单提交数据，换页显示数据 -->
 <form id="queryForm" action="${basePath}system/user_listUI.action" method="post">
<div class="query">
	<div class="query-conditions ue-clear" style="width:100%">
        <div class="conditions staff ue-clear" style="width:20%">
            <label>姓名：</label>
        <input type="text" name="commonScholarship.stuName" placeholder="请输入姓名进行查询" value="${querycon.stuName}" style="width:200px;height:30px"/>
        </div>
        
       <div class="conditions name ue-clear" style="width:20%">
         <label>获奖名称：</label>
        <input  hidden="hidden"  value="${querycon.rewardName}" name="commonScholarship.rewardName" style="width:200px;height:30px">
        <div class="select-wrap">
        	<div class=" select-title ue-clear" ><span>${querycon.rewardName}</span><i class="icon"></i></div>
            <ul class="select-list" >
                <li id="">请选择</li>
            	<li id="特等奖学金">特等奖学金</li>
                <li id="一等奖学金">一等奖学金</li>
                <li id="二等奖学金">二等奖学金</li>
                <li id="三等奖学金">三等奖学金</li>
            </ul>
        </div>
  </div>
  
  <div class="conditions name ue-clear" style="width:20%">
       <label>专业：</label>
       <input  hidden="hidden" value="${querycon.major}" name="commonScholarship.major">
        <div class="select-wrap">
				<div class="select-title" >
					<span id="span1">${querycon.major}</span><i class="icon"></i>
					</div>
					<ul class="select-list" id="list1">
					 <li id="">请选择</li>
					    <s:iterator value="#request.major" var="major">
					      <li id="<s:property value='#major.ddlName'/>"><s:property value="#major.ddlName"/></li>
					    </s:iterator>
					</ul>					
				</div>
  </div>
   </div>
    <div class="query-btn ue-clear">
    	<a href="javascript:query()" class="confirm">查询</a>
    </div>
</div>
<div class="table-operate ue-clear">
	<a href="javascript:add()" class="add">添加</a>
    <a href="javascript:del()" class="del confirm save">删除</a>
    <a href="javascript:;" class="import clear clear">导入</a>
<!--     <a href="javascript:;" class="upload">上传</a> -->
</div>

<div class="table-box">
	<table>
    	<thead>
        	<tr>
			 <th  width="5%"><input type="checkbox" id="selAll" class="checkall" onclick="doSelectAll()"/></th>
            	
            	 <th width="10%" >姓名</th>
            	 <th width="20%" class="num">学号</th>
				<th width="20%" >专业</th>
				<th width="15%" align="center">获奖名称</th>
				<th width="30%" >备注</th>
				<th width="10%">编辑</th>					
            </tr>
        </thead>
        <tbody>
           <s:iterator value="pageUtils.items" var="commonScholarship">
        	<tr>
			<td class="num"><input type="checkbox" name="selectedRow" value='<s:property value='#commonScholarship.id'/>'/></td>
              	<td ><s:property value="#commonScholarship.stuName"/></td>
              	<td><s:property value="#commonScholarship.studentNo"/></td>
				<td><s:property value="#commonScholarship.major"/></td>
				<td><s:property value="#commonScholarship.rewardName"/></td>
				<td><s:property value="#commonScholarship.memo"/></td>
				<!-- 跳转到editor对应的action。并将对应的查询条件数据传到action -->
				<td><a href="javascript:editor('<s:property value='#commonScholarship.id'/>')"><img src="../images/edtico.png"/></a></td>
            </tr> 
            </s:iterator>        
        </tbody>
    </table>
    
</div>
<!-- 跳转页面  页码    （将这语句置于form表单之内  才能提交页码）-->
<jsp:include page="/common/pagination.jsp"></jsp:include>
</form>
<script type="text/javascript" src="${basePath}js/core.js"></script>
<script type="text/javascript" src="${basePath}js/jquery.dialog.js"></script>
<script type="text/javascript" src="${basePath}js/jquery.pagination.js"></script>
<script type="text/javascript" src="${basePath}js/jquery-form.js"></script>
<jsp:include page="/common/inputdialog.jsp"></jsp:include>

</body>

<script type="text/javascript">

/* 批量选中*/
function doSelectAll(){
	$("input[name=selectedRow]").prop("checked", $("#selAll").is(":checked"));
} 
//单击及双击的JS样式
	$(function(){
      //单击
        $("tr:odd").addClass("odd");  /* 奇数行添加样式*/
        $("tr:even").addClass("even"); /* 偶数行添加样式*/

       
        //双击跳转到详情页面
        $('tbody>tr').dblclick(function() {
        //双击得到当前行数据的id
       	 var $id=$(this).children("td").children("input").val();
       	//跳转到详情页
       	window.open("${basePath}comscholarship/comscholarship_detailUI.action?commonScholarship.id="+$id);
        });
        
        
        
        //点击改变选中样式
        $('tbody>tr').click(function() {
            $(this)
                    .addClass('selected')
                    .siblings().removeClass('selected')
                    .end();
        });
	})
	//向couscholarship_editorUI.action提交信息
function editor(id){
		var url="${basePath}comscholarship/comscholarship_editorUI.action?commonScholarship.id="+id;
		$("#queryForm").attr("action",url);
 	$("#queryForm").submit();  
} 

//向couscholarship_addUI.action提交信息
function add(){
		var url="${basePath}comscholarship/comscholarship_addUI.action";
		$("#queryForm").attr("action",url);
 	$("#queryForm").submit();  
} 

//向couscholarship_listUI.action提交信息
function query(){
	 	$("#pageNo").val(1);
	  	$("#queryForm").attr("action",queryAction);
	 	$("#queryForm").submit(); 
	}
//向couscholarship_delete().action提交信息
function del(){
	
	$('.delDialog').Dialog('open'); 
} 
 </script>
</html>

 