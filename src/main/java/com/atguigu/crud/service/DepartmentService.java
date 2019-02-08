package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.dao.DepartmentMapper;

/**
 * 我都是从下到上，按照原先需求分析设计将文档转为代码，逻辑也清晰， 步骤也明了，人道的开发
 * 
 * @author Administrator
 *
 */
@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper departmentMapper;

	public List<Department> getDepts() {
		// TODO 自动生成的方法存根
		List<Department> list = this.departmentMapper.selectByExample(null);
		return list;
	}

}
