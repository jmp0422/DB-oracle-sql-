package com.multi.jdbc.member.model.dao;

import com.multi.jdbc.common.exception.MemberException;
import com.multi.jdbc.member.model.dto.Member;

import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;

import static com.multi.jdbc.common.JDBCTemplate.close;

public class MemberDao {
    private Properties prop = null;

    public MemberDao() {


        try {
            prop = new Properties();
            prop.load(new FileReader("resources/query.properties"));
            //  prop.loadFromXML(new FileInputStream("mapper/query.xml"));
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public ArrayList<Member> selectAll(Connection conn) throws MemberException {

        ArrayList<Member> list = null;


        Statement stmt = null;// 실행할 쿼리
        ResultSet rset = null;// Select 한후 결과값 받아올 객체

        //String sql = "SELECT * FROM MEMBER";// 자동으로 세미콜론을 붙여 실행되므로 붙히지않는다
        String sql = prop.getProperty("selectAll");
        try {

// 3. 쿼리문을 실행할 statement 객체 생성
            stmt = conn.createStatement();

// 4.쿼리문 전송, 실행결과를 ResultSet 으로 받기
            rset = stmt.executeQuery(sql);

// 5. 받은결과값을 객체에 옮겨서 저장하기

            list = new ArrayList<Member>();

            while (rset.next()) {

                Member m = new Member();
                m.setUserId(rset.getString("USERID"));
                m.setPassword(rset.getString("PASSWORD"));
                m.setUserName(rset.getString("USERNAME"));
                m.setGender(rset.getString("GENDER"));
                m.setAge(rset.getInt("AGE"));
                m.setEmail(rset.getString("EMAIL"));
                m.setPhone(rset.getString("PHONE"));
                m.setAddress(rset.getString("ADDRESS"));
                m.setHobby(rset.getString("HOBBY"));
                m.setEnrollDate(rset.getDate("ENROLLDATE"));

                list.add(m);
            }

        } catch (SQLException e) {
            // TODO Auto-generated catch block
//            e.printStackTrace();
             throw new MemberException("selectAll 에러 : " + e.getMessage());
        } finally {
            close(rset);
            close(stmt);
        }
        return list;
    }

    public Member selectOne(Connection conn, String memberId) {
        Member rsDto = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = prop.getProperty("selectOne");

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, memberId);
            rs = ps.executeQuery();

            if (rs.next()) {
                rsDto = new Member();
                rsDto.setUserId(rs.getString("USERID"));
                rsDto.setPassword(rs.getString("PASSWORD"));
                rsDto.setUserName(rs.getString("USERNAME"));
                rsDto.setGender(rs.getString("GENDER"));
                rsDto.setAge(rs.getInt("AGE"));
                rsDto.setEmail(rs.getString("EMAIL"));
                rsDto.setPhone(rs.getString("PHONE"));
                rsDto.setAddress(rs.getString("ADDRESS"));
                rsDto.setHobby(rs.getString("HOBBY"));
                rsDto.setEnrollDate(rs.getDate("ENROLLDATE"));

            }


        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
        }


        return rsDto;
    }


    public int insertMember(Connection conn, Member member) {
        int result = 0;
        PreparedStatement ps = null;

        String sql = prop.getProperty("insertMember");
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, member.getUserId());
            ps.setString(2, member.getPassword());
            ps.setString(3, member.getUserName());
            ps.setString(4, member.getGender());
            ps.setInt(5, member.getAge());
            ps.setString(6, member.getEmail());
            ps.setString(7, member.getPhone());
            ps.setString(8, member.getAddress());
            ps.setString(9, member.getHobby());

            result = ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
        }


        return result;
    }

    public int updateMember(Connection conn, Member member) {
        int result = 0;
        PreparedStatement ps = null;

        String sql = prop.getProperty("updateMember");
        try {
            ps = conn.prepareStatement(sql);
            // updateMember=UPDATE MEMBER SET PASSWORD = ? , EMAIL = ?, PHONE = ?, ADDRESS = ? WHERE USERID=?

            ps.setString(1, member.getPassword());
            ps.setString(2, member.getEmail());
            ps.setString(3, member.getPhone());
            ps.setString(4, member.getAddress());
            ps.setString(5, member.getUserId());


            result = ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
        }


        return result;
    }

    public int deleteMember(Connection conn, String memberId) {
        int result = 0;
        PreparedStatement ps = null;

        String sql = prop.getProperty("deleteMember");
        try {
            ps = conn.prepareStatement(sql);
            // deleteMember=DELETE FROM MEMBER WHERE USERID=?

            ps.setString(1, memberId);


            result = ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
        }


        return result;
    }
}
