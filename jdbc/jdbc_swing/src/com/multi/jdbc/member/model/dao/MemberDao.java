package com.multi.jdbc.member.model.dao;

import com.multi.jdbc.common.DBConnectionMgr;
import com.multi.jdbc.member.model.dto.MemberDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberDao {

    Connection con = null;
    DBConnectionMgr dbcp;

    public MemberDao() {

        try {
            dbcp = DBConnectionMgr.getInstance();
            con = dbcp.getConnection();

            con.setAutoCommit(false);
        } catch (Exception e) {
            System.out.println("memberDao 기본생성자 : connection 에러발생");
        }
    }

    public int insert(MemberDto memberDto) {
        int result = 0;

        PreparedStatement ps = null;


        try {
            String sql = "Insert into member values(null,?,?,?,?,now())";
            ps = con.prepareStatement(sql);
            ps.setString(1, memberDto.getId());
            ps.setString(2, memberDto.getPw());
            ps.setString(3, memberDto.getName());
            ps.setString(4, memberDto.getTel());


            result = ps.executeUpdate();

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }


        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("insert시 에러발생");

            try {
                con.rollback();
            } catch (SQLException ex) {
                e.printStackTrace();
            }
        } finally {
            dbcp.freeConnection(con, ps);
        }


        return result;
    }


    public int delete(String id) {
        int result = 0;
        PreparedStatement ps = null;


        try {
            String sql = "DELETE FROM MEMBER WEHRE ID = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, id);


            result = ps.executeUpdate();

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }


        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("insert시 에러발생");

            try {
                con.rollback();
            } catch (SQLException ex) {
                e.printStackTrace();
            }
        } finally {
            dbcp.freeConnection(con, ps);
        }
        return result;
    }

    public int update(MemberDto memberDto) {
        int result = 0;
        PreparedStatement ps = null;


        try {
            String sql = "UPDATE MEMBER SET TEL = ? WHERE ID = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, memberDto.getTel());
            ps.setString(2, memberDto.getId());


            result = ps.executeUpdate();

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }


        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("insert시 에러발생");

            try {
                con.rollback();
            } catch (SQLException ex) {
                e.printStackTrace();
            }
        } finally {
            dbcp.freeConnection(con, ps);
        }
        return result;
    }

    public MemberDto selectOne(String id) {
        MemberDto rsDto = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        MemberDto memberDto = null;


        try {
            String sql = "SELECT * FROM MEMBER WHERE ID = ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                rsDto = new MemberDto();
                rsDto.setId(rs.getString("ID"));
                rsDto.setPw(rs.getString("PW"));
                rsDto.setTel(rs.getString("TEL"));
                rsDto.setName(rs.getString("NAME"));
            }


        } catch (SQLException e) {
            System.out.println("에러발생");
        } finally {
            dbcp.freeConnection(con, ps, rs);
        }
        return rsDto;
    }

    public ArrayList<MemberDto> list() {
        ArrayList<MemberDto> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;


        try {
            String sql = "SELECT * FROM MEMBER";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                MemberDto memberDto = new MemberDto();
                memberDto.setId(rs.getString("ID"));
                memberDto.setPw(rs.getString("PW"));
                memberDto.setTel(rs.getString("TEL"));
                memberDto.setName(rs.getString("NAME"));

                list.add(memberDto);
            }


        } catch (SQLException e) {
            System.out.println("에러발생");
        } finally {
            dbcp.freeConnection(con, ps, rs);
        }


        return list;
    }
}
