package com.multi.jdbc.a_com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBConnectiMysql {
    public static void main(String[] args) {

    Connection con = null;
    PreparedStatement ps = null;

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("1. 드라이버 설정 성공..");

        String url = "jdbc:mysql://localhost:3306/scott?";
        String user = "scott";
        String password = "tiger";
        con = DriverManager.getConnection(url, user, password);
        System.out.println("2. db연결 성공.");

        // 오토커밋을 false로 설정
        con.setAutoCommit(false);
        System.out.println("3. 오토커밋 설정 비활성화.");

        String sql = "insert into MEMBER values (3, '안녕', 'win', 'win',  NOW())";
        ps = con.prepareStatement(sql);
        System.out.println("4. sql문 객체 생성 성공.");
        int result = ps.executeUpdate();

        String sql1 = "insert into MEMBER values (4, '안녕', 'win', 'win',  NOW())";
        ps = con.prepareStatement(sql1);
        System.out.println("4. sql문 객체 생성 성공.");
        int result2 = ps.executeUpdate();

        System.out.println("5. sql문 전송 성공, 결과1>> " + result);
        System.out.println("5. sql문 전송 성공, 결과2>> " + result2);

        // 트랜잭션 커밋
        if (result >= 1 && result2 >= 1) {
            System.out.println("데이터 입력 완료");
            con.commit();
            System.out.println("6. 트랜잭션 커밋 완료.");

        }
        // Query가 제대로 실행되지 않은 경우
        else {
            System.out.println("데이터 입력 실패");
            con.rollback();
        }


    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        if (con != null) {
            try {
                con.rollback(); // 예외 발생 시 롤백
            } catch (SQLException ex) {
                ex.printStackTrace();

            }
            System.out.println("트랜잭션 롤백.");
        }
    } finally {
        try {
            ps.close(); // 먼저닫기
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            e.printStackTrace();


        }
    }
}
}

