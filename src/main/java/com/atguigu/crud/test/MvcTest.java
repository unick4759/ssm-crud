package com.atguigu.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml" })
public class MvcTest {

	// 传入Springmvc的ioc
	@Autowired
	WebApplicationContext context;
	// 虚拟mvc请求
	MockMvc mockMvc;

	@Before
	public void initMockMvc() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void test() throws Exception {
		// 模拟请求，拿到返回值
		MvcResult result = this.mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		// 请求成功以后，请求域中会有pageInfo，可以取出pageInfo来验证数据
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码：" + pi.getPageNum());
		System.out.println("总页码：" + pi.getPages());
		System.out.println("总记录数：" + pi.getTotal());
		System.out.println("在页面需要连续显示的页码");
		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(" " + i);
		}
		// 获取员工数据
		List<Employee> list = pi.getList();
		for (Employee e : list) {
			System.out.println(e.getEmpId() + ":" + e.getEmpName());
		}
		// fail("尚未实现");
	}

}
