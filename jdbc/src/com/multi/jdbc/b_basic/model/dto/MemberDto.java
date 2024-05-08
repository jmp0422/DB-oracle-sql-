package com.multi.jdbc.b_basic.model.dto;

import java.sql.Date;

public class MemberDto {

    private int id;//null
    private String pw;//null
    private String name;//null
    private String tel;
    private Date createDate;
    public MemberDto(){

    }

    public MemberDto(int id, String pw, String name, String tel) {
        this.id = id;
        this.pw = pw;
        this.name = name;
        this.tel = tel;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getId() {
        return id;
    }

    public String getPw() {
        return pw;
    }

    public String getName() {
        return name;
    }

    public String getTel() {
        return tel;
    }

    public Date getCreateDate() {
        return createDate;
    }

    @Override
    public String toString() {
        return "MemberDto{" +
                "id=" + id +
                ", pw='" + pw + '\'' +
                ", name='" + name + '\'' +
                ", tel='" + tel + '\'' +
                ", createDate=" + createDate +
                '}';
    }
}
