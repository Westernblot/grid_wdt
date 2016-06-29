
/**
 * 说明：通用JS抽取
 * author：WS
 */



/**
 * 删除
 * @param url
 * @param trId:可选参数
 * 
 */
function doDelete(url,trId){
	
	if(typeof(trId) == 'undefined'){//如果找不到trId
		trId = getId('delete');
		if(trId==false){
			return;
		}
	}

    //执行删除操作
	if(confirm("确定删除吗？")){
		$.ajax({
		url:url,
		data:{'fIds':trId},
		dataType:'json',
		type:'post',
		success:function(data){
			if(data>0){
				alert('删除成功！');
				location.reload();
			}else{
				alert('删除失败！');
			}
		},
		error:function(){
			alert('系统错误！');
		}
	    });
    }
	
}

/**
 * 勾选已选择ID
 */
function getId(msg){
	var count = 0;
	var trId = '';
	var chks = $('input[name="chk"]');
	for ( var i = 0; i < chks.length; i++) {
		if($(chks[i]).attr('checked')){
			//alert($(chks[i]).attr('checked'));
			count++;
			trId += $(chks[i]).parent().parent().attr('id')+",";//获取tr的id，即数据id
		}
	}
	if(msg=='update'){
		if(count==0){
			alert('请选择操作项！');
			return false;
		}else if(count>1){
			alert('只能选择一个操作项！');
			return false;
		}else{
			return trId.substring(0, trId.length-1);
		}
	}else if(msg=='delete'){
		if(count==0){
			alert('请选择操作项！');
			return false;
		}else{
			return trId.substring(0, trId.length-1);
		}
	}
	
}

/**
 * JS 取系统当前时间 如： 2014-08-20
 */
function getNowDate(){
	var md=new Date();
	var yyyy=md.getFullYear();
	var MM=(md.getMonth()+1)<10?"0"+(md.getMonth()+1):(md.getMonth()+1);
	var DD=md.getDate()<10?"0"+md.getDate():md.getDate();
	var nowDate=yyyy+"-"+MM+"-"+DD;
	return nowDate;
}


