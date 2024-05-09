package com.multi.jdbc.b_basic.model.dao;

import com.multi.jdbc.b_basic.model.dto.MemberDto;

import java.sql.*;

public class MemberDao {

    public void insert(String id, String pw, String name, String tel) {

        Connection con=null;
        PreparedStatement ps = null;

        try {
            // 1.Jdbc driver 등록 처리 : 해당 database 벤더 사가 제공하는 클래스 등록
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("1. 드라이버 설정 성공..");
            // 2.등록된 클래스를 이용해서 db연결
            // 드라이버타입@ip주소:포트번호:db이름(SID)
            // orcl:사용자정의설치 , thin : 자동으로 설치 //ip주소 -> localhost 로 변경해도됨
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String user = "scott";
            String password = "tiger";
            con = DriverManager.getConnection(url, user, password);
            System.out.println("2. db연결 성공.");

            // 오토커밋을 false로 설정
            con.setAutoCommit(false);
            System.out.println("3. 오토커밋 설정 비활성화.");
            //sql문 만들기, prepareStatement 준비된 문장
            String sql = "insert into MEMBER values (?, ?, ?, ?,  sysdate)";
            ps = con.prepareStatement(sql);
            //? 에 입력할 순서대로 잘 매핑 시키기
            ps.setInt(1,Integer.parseInt(id));
            ps.setString(2,pw);
            ps.setString(3,name);
            ps.setString(4,tel);

            System.out.println("4. sql문 객체 생성 성공.");
            int result = ps.executeUpdate(); //ps. 객체 실행, 워리 실행, 쿼리 싱행 후 반환값 받아주기



            System.out.println("5. sql문 전송 성공, 결과1>> " + result);


            // 트랜잭션 커밋
            if (result >= 1) {
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

    //탈퇴
    public MemberDto delete(String id) {
        Connection con=null;
        PreparedStatement ps = null;

        try {
            // 1.Jdbc driver 등록 처리 : 해당 database 벤더 사가 제공하는 클래스 등록
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("1. 드라이버 설정 성공..");
            // 2.등록된 클래스를 이용해서 db연결
            // 드라이버타입@ip주소:포트번호:db이름(SID)
            // orcl:사용자정의설치 , thin : 자동으로 설치 //ip주소 -> localhost 로 변경해도됨
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String user = "scott";
            String password = "tiger";
            con = DriverManager.getConnection(url, user, password);
            System.out.println("2. db연결 성공.");

            // 오토커밋을 false로 설정
            con.setAutoCommit(false);
            System.out.println("3. 오토커밋 설정 비활성화.");
            //sql문 만들기, prepareStatement 준비된 문장  ;는 자동으로 들어가니까 안적어줘도 됨
            String sql = "DELETE FROM MEMBER WHERE ID=?";
            ps = con.prepareStatement(sql);
            //? 에 입력할 순서대로 잘 매핑 시키기
            ps.setInt(1,Integer.parseInt(id));


            System.out.println("4. sql문 객체 생성 성공.");
            int result = ps.executeUpdate(); //ps. 객체 실행, 워리 실행, 쿼리 싱행 후 반환값 받아주기



            System.out.println("5. sql문 전송 성공, 결과1>> " + result);


            // 트랜잭션 커밋
            if (result >= 1) {
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


        return null;
    }

    public void insert(MemberDto memberDto) {
        Connection con=null;
        PreparedStatement ps = null;

        try {
            // 1.Jdbc driver 등록 처리 : 해당 database 벤더 사가 제공하는 클래스 등록
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("1. 드라이버 설정 성공..");
            // 2.등록된 클래스를 이용해서 db연결
            // 드라이버타입@ip주소:포트번호:db이름(SID)
            // orcl:사용자정의설치 , thin : 자동으로 설치 //ip주소 -> localhost 로 변경해도됨
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String user = "scott";
            String password = "tiger";
            con = DriverManager.getConnection(url, user, password);
            System.out.println("2. db연결 성공.");

            // 오토커밋을 false로 설정
            con.setAutoCommit(false);
            System.out.println("3. 오토커밋 설정 비활성화.");
            //sql문 만들기, prepareStatement 준비된 문장
            String sql = "insert into MEMBER values (?, ?, ?, ?,  sysdate)";
            ps = con.prepareStatement(sql);
            //? 에 입력할 순서대로 잘 매핑 시키기
            ps.setInt(1,memberDto.getId());
            ps.setString(2,memberDto.getPw());
            ps.setString(3, memberDto.getName());
            ps.setString(4, memberDto.getTel());

            System.out.println("4. sql문 객체 생성 성공.");
            int result = ps.executeUpdate(); //ps. 객체 실행, 워리 실행, 쿼리 싱행 후 반환값 받아주기



            System.out.println("5. sql문 전송 성공, 결과1>> " + result);


            // 트랜잭션 커밋
            if (result >= 1) {
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

    public MemberDto selectOne(String id) {



        Connection con=null;
        PreparedStatement ps = null;
        ResultSet rs =null;
        MemberDto memberDto=null;

        try {
            // 1.Jdbc driver 등록 처리 : 해당 database 벤더 사가 제공하는 클래스 등록
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("1. 드라이버 설정 성공..");
            // 2.등록된 클래스를 이용해서 db연결
            // 드라이버타입@ip주소:포트번호:db이름(SID)
            // orcl:사용자정의설치 , thin : 자동으로 설치 //ip주소 -> localhost 로 변경해도됨
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String user = "scott";
            String password = "tiger";
            con = DriverManager.getConnection(url, user, password);
            System.out.println("2. db연결 성공." +con);

            // 오토커밋을 false로 설정
            con.setAutoCommit(false);
            System.out.println("3. 오토커밋 설정 비활성화.");
            //sql문 만들기, prepareStatement 준비된 문장
            String sql = "SELECT * FROM MEMBER WHERE ID = ?";
            ps = con.prepareStatement(sql);
            //? 에 입력할 순서대로 잘 매핑 시키기
            ps.setInt(1,Integer.parseInt(id));


            System.out.println("4. sql문 객체 생성 성공.");
            rs = ps.executeQuery();             
            //https://www.tutorialspoint.com/jdbc/jdbc-data-types.htm
            if(rs.next()){
                memberDto = new MemberDto();
                memberDto.setId(rs.getInt("ID"));
                memberDto.setPw(rs.getString("PW"));
                memberDto.setTel(rs.getString("TEL"));
                memberDto.setName(rs.getString("NAME"));
                memberDto.setCreateDate(rs.getDate("CREAT_DATE"));
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
        return memberDto;
    }

    public MemberDto login(MemberDto memberDto) {
        MemberDto rsDto=null;

        Connection con=null;
        PreparedStatement ps = null;
        ResultSet rs =null;


        try {
            // 1.Jdbc driver 등록 처리 : 해당 database 벤더 사가 제공하는 클래스 등록
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("1. 드라이버 설정 성공..");
            // 2.등록된 클래스를 이용해서 db연결
            // 드라이버타입@ip주소:포트번호:db이름(SID)
            // orcl:사용자정의설치 , thin : 자동으로 설치 //ip주소 -> localhost 로 변경해도됨
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String user = "scott";
            String password = "tiger";
            con = DriverManager.getConnection(url, user, password);
            System.out.println("2. db연결 성공." +con);

            // 오토커밋을 false로 설정
            con.setAutoCommit(false);
            System.out.println("3. 오토커밋 설정 비활성화.");
            //sql문 만들기, prepareStatement 준비된 문장
            String sql = "SELECT * FROM MEMBER WHERE ID = ? AND PW = ?";
            ps = con.prepareStatement(sql);
            //? 에 입력할 순서대로 잘 매핑 시키기
            ps.setInt(1,memberDto.getId());
            ps.setString(2,memberDto.getPw());


            System.out.println("4. sql문 객체 생성 성공.");
            rs = ps.executeQuery();
            //https://www.tutorialspoint.com/jdbc/jdbc-data-types.htm
            if(rs.next()){
                rsDto = new MemberDto();
                rsDto.setId(rs.getInt("ID"));
                rsDto.setPw(rs.getString("PW"));
                rsDto.setTel(rs.getString("TEL"));
                rsDto.setName(rs.getString("NAME"));
                rsDto.setCreateDate(rs.getDate("CREAT_DATE"));
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




        return rsDto;
    }

    public void update(MemberDto memberDto) {
        Connection con=null;
        PreparedStatement ps = null;

        try {
            // 1.Jdbc driver 등록 처리 : 해당 database 벤더 사가 제공하는 클래스 등록
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("1. 드라이버 설정 성공..");
            // 2.등록된 클래스를 이용해서 db연결
            // 드라이버타입@ip주소:포트번호:db이름(SID)
            // orcl:사용자정의설치 , thin : 자동으로 설치 //ip주소 -> localhost 로 변경해도됨
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String user = "scott";
            String password = "tiger";
            con = DriverManager.getConnection(url, user, password);
            System.out.println("2. db연결 성공.");

            // 오토커밋을 false로 설정
            con.setAutoCommit(false);
            System.out.println("3. 오토커밋 설정 비활성화.");
            //sql문 만들기, prepareStatement 준비된 문장
            String sql = "UPDATE MEMBER SET TEL = ? WHERE ID = ?";
            ps = con.prepareStatement(sql);
            //? 에 입력할 순서대로 잘 매핑 시키기
            ps.setString(1,memberDto.getTel());
            ps.setInt(2,memberDto.getId());


            System.out.println("4. sql문 객체 생성 성공.");
            int result = ps.executeUpdate(); //ps. 객체 실행, 워리 실행, 쿼리 싱행 후 반환값 받아주기



            System.out.println("5. sql문 전송 성공, 결과1>> " + result);


            // 트랜잭션 커밋
            if (result >= 1) {
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
