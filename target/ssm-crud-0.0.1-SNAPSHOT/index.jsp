<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
		http://localhost:3306/crud
 -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">

					<!-- 表单内容。。。。。。。。。 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_update_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="email_update_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input name="email" type="text" class="form-control"
									id="email_update_input" placeholder="email@xxx.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender1_add_input" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<!-- 部门 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-6">
								<!-- 部门提交部门id -->
								<select name="dId" class="form-control" id="dept_add_select">

								</select>

							</div>
						</div>


					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 应该放尾部吧 -->
	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">

					<!-- 表单内容。。。。。。。。。 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input name="empName" type="text" class="form-control"
									id="empName_add_input" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input name="email" type="text" class="form-control"
									id="email_add_input" placeholder="email@xxx.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender1_add_input" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<!-- 部门 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-6">
								<!-- 部门提交部门id -->
								<select name="dId" class="form-control" id="dept_add_select">

								</select>

							</div>
						</div>


					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>

			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>

							<th><input type="checkbox" id="check_all"></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
						<!-- 数据，， -->
					</thead>
					<tbody></tbody>
				</table>
			</div>

		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>

			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>

		</div>


	</div>
	<script type="text/javascript">
		var totalRecord;//总记录数，用于跳转页数，新增操作用
		var currentPage;//当前页，修改操作用
		//1.页面加载完成以后，发送请求，返回数据
		$(function() {
			//去首页
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条信息
					build_page_nav(result);
				}
			});
		}

		function build_emps_table(result) {
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$
					.each(
							emps,
							function(index, item) {
								var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");

								//alert(item.empName);
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								//var gender=item.gender=='M'?"男":"女";
								var genderTd = $("<td></td>").append(
										item.gender == 'M' ? "男" : "女");
								var emailTd = $("<td></td>").append(item.email);
								var deptNameTd = $("<td></td>").append(
										item.department.deptName);
								var editBtn = $("<button></button>")
										.addClass(
												"btn btn-primary btn-sm edit_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-pencil"))
										.append(" 编辑");
								//写尼玛的垃圾代码，乱的一批
								editBtn.attr("edit-id", item.empId);

								var delBtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.append(
												$("<span></span> ")
														.addClass(
																"glyphicon glyphicon-trash"))
										.append(" 删除");
								//使用同一个不就行了么，垃圾
								delBtn.attr("del-id", item.empId);
								var btnTd = $("<td></td>").append(editBtn)
										.append(" ").append(delBtn);
								//append方法执行完成以后还是返回原来的元素
								$("<tr></tr>").append(checkBoxTd).append(
										empIdTd).append(empNameTd).append(
										genderTd).append(emailTd).append(
										deptNameTd).append(btnTd).appendTo(
										"#emps_table tbody");
							});
		}
		//解析 显示分页信息（左下）
		function build_page_info(result) {
			//直接在一个函数中写清空整个页面然后调用一次不就行了，
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageInfo.pageNum + "页，总"
							+ result.extend.pageInfo.pages + "页，总"
							+ result.extend.pageInfo.total + "条记录");
			totalRecord = result.extend.pageInfo.pages + 1;//总是最后一页
			currentPage = result.extend.pageInfo.pageNum;
		}
		//解析显示分页条，并控制其他实现
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			//page_nav_area
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));

			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//设置点击事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				//设置点击事件
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
			}
			//添加首页和上一页
			ul.append(firstPageLi).append(prePageLi);
			//1,2,3,4,5
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				//设置点击函数
				numLi.click(function() {
					to_page(item);
				})
				ul.append(numLi);
			});

			//添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			//把ul加入到nav元素中
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		//C++清屏
		function reset_form(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		//添加员工按钮，点击新增按钮，弹出模态框
		$("#emp_add_modal_btn").click(function() {

			//每次都要清屏，c++
			reset_form("#empAddModal form");
			$("#empAddModal form")[0].reset();
			//发送ajax请求，查出部门信息，显示在下拉列表中

			//查部门信息，并且还要传进去一个参数，呵呵，垃圾，
			//这种就是半封装，最讨厌这种东西，没有使用体验
			getDepts("#empAddModal select");
			//弹出模态框
			$("#empAddModal").modal({
				backdrop : "static"
			});
		});
		//查出所有的部门信息并显示在下拉列表中
		//这种视频如果按照流程需求概要走更好

		//ele传入这个元素，，，呵呵，其实返回数据还不是想怎么用就怎么用
		//功能太复杂就容易耦合，
		function getDepts(ele) {

			//方法到处写，找都不好找，垃圾，代码不规范，垃圾
			//cls
			$(ele).empty();//这些都可以优化一下，不然查太多次了，

			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//console.log(result);
					//显示部门信息在下拉列表中
					//$("#dept_add_select")
					//$("#empAddModal select")
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}

		//校验表单数据
		function validate_add_form() {
			//1.拿到要校验的数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			//alert(regName.test(empName));
			if (!regName.test(empName)) {
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_add_input", "error",
						"用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "");
			}
			//2.校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		};

		//校验元素，清空之前的设置
		//根本不行，邮箱校验一半相当于废的，
		//要用点击离开后事件响应，之前实现过，onblur

		function show_validate_msg(ele, status, msg) {
			//清除
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			//前端就是拘泥于各种语法，

			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		//校验用户名是否可用
		$("#empName_add_input").change(
				function() {
					//发送ajax请求校验用户名是否可用，，
					//其实和c++写学生管理系统真的差不多，前端，面向过程
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "empName=" + empName,
						type : "POST",
						success : function(result) {
							//直接判断不好，应该用方法封装起来，解耦
							if (result.code == 100) {
								show_validate_msg("#empName_add_input",
										"success", "用户名可用");
								$("#emp_save_btn").attr("ajax-va", "success");
							} else {
								show_validate_msg("#empName_add_input",
										"error", result.extend.va_msg);
								$("#emp_save_btn").attr("ajax-va", "error");
							}
						}
					});
				});

		$("#emp_save_btn")
				.click(
						function() {
							//1.先校验数据
							if (!validate_add_form()) {
								return false;
							}

							//1.判断之前的ajax用户名校验是否成功
							if ($(this).attr("ajax-va") == "error") {
								return false;//数据校验不通过则不能发送请求
							}

							//1.打包数据，提交请求post，
							//springmvc处理请求，找对应方法调用层直到orm
							//2.发送ajax请求
							//alert($("#empAddModal form").serialize());
							$
									.ajax({
										url : "${APP_PATH}/emp",
										type : "POST",
										data : $("#empAddModal form")
												.serialize(),
										success : function(result) {

											if (result.code == 100) {

												//alert(result.msg);
												//处理成功后，关闭模态框，跳转显示插入的数据页面
												$("#empAddModal").modal('hide');
												//总页面数加一就行了，
												to_page(totalRecord);

											} else {
												//显示失败信息
												//console.log(result);
												if (undefined != result.extend.errorFields.email) {
													//显示邮箱错误信息
													show_validate_msg(
															"#email_add_input",
															"error",
															result.extend.errorFields.email);
												}
												if (undefined != result.extend.errorFields.empName) {
													//显示用户名错误信息
													//应该拒绝所有字符串，只用引用，拒绝硬编码
													show_validate_msg(
															"#empName_add_input",
															"error",
															result.extend.errorFields.empName);
												}
											}

										}
									});

						});

		//加载完成后再绑定才有效，刚学jq三岁小孩都知道，说一大堆不切合实际开发的垃圾，装模作样
		$(document).on("click", ".edit_btn", function() {
			//empName_update_static

			//1.查部门信息，显示
			getDepts("#empUpdateModal select");
			//2.查员工信息，显示
			getEmp($(this).attr("edit-id"));

			//3.把员工的id传递给模态框的更新按钮
			//少写一个字母，，，

			//这种错误，，，真滴坑，，ide
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

			//alert("edit");//一步一试，麻烦啊，

			//封装，重用，，，重复，，套路，，
			//共性，抽象，语言，，可扩展性，，解耦，，适应性，，
			//但是，始终是无招胜有招，，有招就有破绽，，hh
			//代码一写出来，就是死的，，所以未来应该是无代码的，，嗯，我相信这一点
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});

		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					//console.log(result);
					var empData = result.extend.emp;
					//jq,,熟能生巧啊，，代码量，就是干！不干就gg
					//这世界不是游戏，没有对手
					//小兵就在那里，一级也总能打的过十八级的小兵，
					//并获得经验
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val(
							[ empData.gender ]);
					$("#empUpdateModal select").val([ empData.dId ]);
				}
			});
		}

		//点击更新，更新员工信息
		$("#emp_update_btn").click(function() {
			//验证邮箱是否合法
			//2.校验邮箱
			//代码缺少重用，不行，这垃圾代码优雅个屁啊

			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "");
			}
			//2.发送ajax请求保存更新的员工数据
			//开发禁止出现硬编码，

			//企业常在河边走，哪有不湿鞋，所以大头难当啊，并且要做好规范的
			//多层的检查，不断提高，，还要有一定的承受，愈合能力，，，
			//hhh，难，，
			$.ajax({
				url : "${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type : "PUT",
				data : $("#empUpdateModal form").serialize(),
				success : (function(result) {
					//alert(result.msg);
					//1.关闭对话框，跳转最后一页，这两个步骤可以封装起来，
					$("#empUpdateModal").modal('hide');
					to_page(currentPage);
				})
			});
		});

		//单个删除
		$(document).on("click", ".delete_btn", function() {
			//1.弹出是否确认删除对话框
			//alert($(this).parents("tr").find("td:eq(1)").text());
			//垃圾，面向过程，一次性代码，，
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			//编辑删除使用同一个不就行了
			if (confirm("确认删除【" + empName + "】吗？")) {
				//确认删除，发送ajax
				$.ajax({
					url : "${APP_PATH}/emp/" + empId,
					type : "DELETE",
					success : function(result) {
						//alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			}
		});

		//全选，全不选
		$("#check_all").click(function() {
			//$(".check_item")
			//alert($(this).prop("checked"));
			//赋值
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		//check_item 这个功能没必要
		$(document)
				.on(
						"click",
						".check_item",
						function() {
							//判断个数
							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);
						});
		//批量删除按钮
		$("#emp_delete_all_btn").click(
				function() {
					//$(".check_item:checked")

					var empNames = "";
					var del_idstr = "";
					$.each($(".check_item:checked"), function() {
						//面向过程，妥妥无疑
						//alert($(this).parents("tr").find("td:eq(2)").text());
						empNames += $(this).parents("tr").find("td:eq(2)")
								.text()
								+ "，";
						//收集员工id，锤石，，
						del_idstr += $(this).parents("tr").find("td:eq(1)")
								.text()
								+ "-";
					});
					//来了，，这种东西，也知道字符串截取，不过应该有更好的，，，
					//当然，更好的底层也是，但我的意思是更抽象的可重用的可扩展的
					//扩展性，重用性，
					//我觉得这里完全可以优化，真讨厌这种修剪字眼的行为
					empNames = empNames.substring(0, empNames.length - 1);
					del_idstr = del_idstr.substring(0, del_idstr.length - 1);
					if (confirm("确认删除【" + empNames + "】吗？")) {
						//少了一个斜杠，，，，405，，，我靠，，，，，真的，，，，，真的，，，坑，，，解释语言，，前端，
						//删除
						$.ajax({
							url : "${APP_PATH}/emp/" + del_idstr,
							type : "DELETE",
							success : function(result) {
								alert(result.msg);
								to_page(currentPage);
							}
						});
					}
				});
	</script>


</body>
</html>