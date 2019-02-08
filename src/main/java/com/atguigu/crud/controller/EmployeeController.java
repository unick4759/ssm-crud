package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工增删改查请求
 * 
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	/**
	 * 参数数量可变 直接传个容器遍历就行了，搞这些，
	 * 
	 * 容器倒来倒去就行了，
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids") String ids) {
		// 名字横杠咋办？垃圾一次性代码
		if (ids.contains("-")) {
			String[] str_ids = ids.split("-");// 呵呵，一次操作和多次操作，垃圾
			List<Integer> del_ids = new ArrayList<>();
			for (String id : str_ids) {
				del_ids.add(Integer.parseInt(id));
			}

			this.employeeService.deleteBatch(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			this.employeeService.deleteEmp(id);// 这里不能提示转么，
		}
		return Msg.success();
	}

	/**
	 * 孰能生巧，就是干，一切困难，回头看，啥都不是
	 * 
	 * 员工更新
	 * 
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		System.out.println("将要更新的员工数据：" + employee);
		this.employeeService.updateEmp(employee);
		return Msg.success();
	}

	/**
	 * 根据id查询员工
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = this.employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	/**
	 * 检验用户名是否可用
	 * 
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName") String empName) {
		// 先正则表达式，再判断是否需要查询数据库
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名需要是2-5位中文或者6-16位英文和数字的组合");
		}
		boolean b = this.employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "用户名已存在");
		}

	}

	/**
	 * Msg这个法子不错，之前倒是没用过，挺好的，活学活用啊，，
	 * 
	 * 这就是智慧啊，， 经验，智慧，，熟能生巧
	 * 
	 * 员工保存
	 * 
	 * @return
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {

		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名：" + fieldError.getField());
				System.out.println("错误信息：" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorField", map);
		} else {
			this.employeeService.saveEmp(employee);
			return Msg.success();

		}

	}

	/**
	 * 导入jackson包，gson也行
	 * 
	 * @param pn
	 * @param model
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 引入pagehelper分页插件
		// 在查询之前只需要调用，传入页码以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是分页查询
		List<Employee> emps = this.employeeService.getAll();
		// 使用pageInfo包装查询后的结果
		// 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
		// s,s,m,,,,springMVC需要多练习其他两个倒是用的多，springmvc是用的最少的，嗯，
	}

	/**
	 * 查询员工数据（分页查询）
	 * 
	 * @return
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 引入pagehelper分页插件
		// 在查询之前只需要调用，传入页码以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是分页查询
		List<Employee> emps = this.employeeService.getAll();
		// 使用pageInfo包装查询后的结果
		// 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
