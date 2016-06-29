
var setting = {
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClick,
			onClick: onClick
		}
	};


	function beforeClick(treeId, treeNode) {
		var check = (treeNode && !treeNode.isParent);
	}
	
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		nodes = zTree.getSelectedNodes();
		var fId = "";
		var fName="";
		for (var i=0, l=nodes.length; i<l; i++) {
			fId += nodes[i].id + ",";
			fName += nodes[i].name + ",";
		}
		if (fId.length > 0 ) fId = fId.substring(0, fId.length-1);
		if (fName.length > 0 ) fName = fName.substring(0, fName.length-1);
		
		$("#fPid").attr('value',fId);
		$("#fPname").attr('value',fName);
		
		hideMenu();
	}
	


	function getDept() {
		var cityObj = $("#fPname");
		var cityOffset = $("#fPname").offset();
		$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}

	
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}

	
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuConten").length>0)) {
			hideMenu();
		}
	}


	$(document).ready(function(){
		var treeObj=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		treeObj.expandAll(true); 
	});
//===================================================================================================================================	
var settingName = {
           		view: {
           			dblClickExpand: false
           		},
           		data: {
           			simpleData: {
           				enable: true
           			}
           		},
           		callback: {
           			beforeClick: beforeClick,
           			onClick: onClickName
           		}
           	};

           var userL;
           
function onClickName(e, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("treeName");
	nodes = zTree.getSelectedNodes();
	var fId = "";
	var fName="";
	for (var i=0, l=nodes.length; i<l; i++) {
		fId += nodes[i].id + ",";
		fName += nodes[i].name + ",";
	}
	if (fId.length > 0 ) fId = fId.substring(0, fId.length-1);
	if (fName.length > 0 ) fName = fName.substring(0, fName.length-1);
	$("#userid").attr('value',fId);
	$("#userName").attr('value',fName);
	for(var j=0;j<userL.length;j++){
		if(userL[j].id==$("#userid").val()){
			$("#clerkCode").val(userL[j].code);//职员代码
			$("#position").val(userL[j].position)//职员类别
			$("#idCard").val(userL[j].idcard);//身份证号
		}
	}
	hideMenuName();
}



           function hideMenuName() {
           	$("#menuName").fadeOut("fast");
           	$("body").unbind("mousedown", onBodyDown);
           }


           function onBodyDownName(event) {
           	if (!(event.target.id == "menuBtn" || event.target.id == "menuName" || $(event.target).parents("#menuConten").length>0)) {
           		hideMenu();
           	}
           }
