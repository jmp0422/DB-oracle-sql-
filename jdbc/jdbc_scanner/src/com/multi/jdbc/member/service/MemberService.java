package com.multi.jdbc.member.service;

import com.multi.jdbc.common.exception.MemberException;
import com.multi.jdbc.member.model.dao.MemberDao;
import com.multi.jdbc.member.model.dto.Member;

import java.sql.Connection;
import java.util.ArrayList;

import static com.multi.jdbc.common.JDBCTemplate.*;
/* Service 클래스에서 메소드 작성 방법
 * 1) Controller로 부터 인자를 전달받음
 * 2) Connection 객체 생성
 * 3) Dao 객체 생성
 * 4) Dao로 생성한 Connection 객체와 인자를 전달
 * 5) Dao 수행 결과를 가지고 비즈니스 로직 및 트랜잭션 관리를 함 */

public class MemberService {
    private final MemberDao memberDao;

    public MemberService() throws MemberException {
        memberDao = new MemberDao();
    }

    public ArrayList<Member> selectAll() throws MemberException {
        Connection conn = getConnection();
        ArrayList<Member> list = memberDao.selectAll(conn);

        return list;

    }

    public Member selectOne(String memberId) {
        Connection conn = getConnection();
        Member m = memberDao.selectOne(conn, memberId);
        return m;
    }


    public int insertMember(Member member) {
        Connection conn = getConnection();
        int result = memberDao.insertMember(conn, member);

        if(result > 0) commit(conn);
        else rollback(conn);

        return result;
    }

    public int updateMember(Member member) {
        Connection conn = getConnection();
        int result = memberDao.updateMember(conn, member);

        if(result > 0) commit(conn);
        else rollback(conn);

        return result;
    }

    public int deleteMember(String memberId) {
        Connection conn = getConnection();
        int result = memberDao.deleteMember(conn, memberId);

        if(result > 0) commit(conn);
        else rollback(conn);

        return result;
    }
    public void exitProgram(){
        close(getConnection());
    }
}
