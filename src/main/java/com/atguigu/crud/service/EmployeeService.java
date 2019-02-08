package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工
	 * 
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO 自动生成的方法存根
		return this.employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存
	 * 
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		// TODO 自动生成的方法存根
		this.employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否可用
	 * 
	 * @param empName
	 * @return
	 */
	public boolean checkUser(String empName) {
		// TODO 自动生成的方法存根

		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = this.employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 按照员工id查询员工
	 * 
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO 自动生成的方法存根
		Employee employee = this.employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * crud我也做过，主要是要ssm才来的，尼玛写的垃圾东西不清晰简洁
	 * 
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO 自动生成的方法存根
		this.employeeMapper.updateByPrimaryKeySelective(employee);
	}

	/**
	 * 员工删除
	 * 
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		// TODO 自动生成的方法存根
		this.employeeMapper.deleteByPrimaryKey(id);
	}

	/**
	 * 批量删除
	 * 
	 * @param ids
	 */
	public void deleteBatch(List<Integer> ids) {
		// TODO 自动生成的方法存根
		// 笔记本，好样的，i3应该就是散热极限了，硅胶暂时不用换
		EmployeeExample example=new EmployeeExample();
		Criteria criteria=example.createCriteria();
		criteria.andEmpIdIn(ids);
		this.employeeMapper.deleteByExample(example);
	}

}
