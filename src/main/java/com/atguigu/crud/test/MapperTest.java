package com.atguigu.crud.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

/**
 * 测试dao层的工作 推荐Spring的项目可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 
 * 1.导入SpringTest模块 2.@ContextConfiguration指定Spring配置文件的位置 3.直接autowired要使用的组件即可
 * 
 * @author Administrator
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	/**
	 * 测试部门mapper
	 */
	@Test
	public void test() {

		// 中文问号不管他了，反正之后要做很多呢，这个也就是过一遍，不管不管，放上去github就是了
		// mysql是绿色版的很方便，但是改不了东西，暂时不折腾，，，先过一遍这些东西，很多，，再搞，，

		// 2.插入员工数据
//		this.employeeMapper.insertSelective(new Employee("Jerry", "M", "Jerry@qq.com", 1));
//		EmployeeMapper mapper = this.sqlSession.getMapper(EmployeeMapper.class);
//		for (int i = 0; i < 1000; i++) {
//			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
//			mapper.insertSelective(new Employee(uid, "M", uid + "@qq.com", 1));
//		}
//		System.out.println("批量完成");
		// 1.插入几个部门
		this.departmentMapper.insertSelective(new Department("开发部"));
		this.departmentMapper.insertSelective(new Department("测试部"));

		System.out.println(departmentMapper);
//		fail("尚未实现");
		// 1.创建SpringIOC容器
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		// 2.从容器中获取mapper
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
//		bean.insertSelective(new Department("开发部"));
	}

}
