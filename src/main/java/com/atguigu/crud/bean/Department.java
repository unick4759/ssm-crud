package com.atguigu.crud.bean;

public class Department {
    private Integer deptId;

    private String deptName;
    
    

    public Department(String deptName) {
		super();
		this.deptName = deptName;
	}

	public Department(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}

	public Department() {
		super();
		// TODO 自动生成的构造函数存根
	}

	public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}