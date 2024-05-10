package com.multi.jdbc.member.model.dao;

import com.multi.jdbc.common.DBConnectionMgr;
import com.multi.jdbc.member.model.dto.MemberDto;

import java.sql.Connection;

public class MemberDao {

    Connection con = null;
    DBConnectionMgr dbcp;

    public MemberDao (){

        try {
            dbcp = DBConnectionMgr.getInstance();
            con = dbcp.getConnection();
            con.setAutoCommit(false);
        } catch (Exception e) {
            System.out.println("memberDao 기본생성자 : connection 에러발생");
        }
    }

    public static int insert(MemberDto memberDto) {
        int result = 0;

        return result;
    }
}
