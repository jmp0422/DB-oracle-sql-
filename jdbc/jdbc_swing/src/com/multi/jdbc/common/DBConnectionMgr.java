/**tion Pool의 이해
   - 최초 데이터베이스 접속시 TCP/IP Socket통신을 함으로 연결부분에서 많은 시간이 지체됩니다.
     따라서 동시접속자수가 많아지면 접속 시간이 지연되고, 접속 Error등이 쉽게 발생할 수 있습니다.

   - 데이터베이스 접속 설정 객체를 미리 만들어 연결을 하여 메모리(버퍼)상에 등록하여 둠으로 클라이언트가 빠르게
      데이터베이스 접속을 할 수 있습니다.

   - 데이터베이스 커넥션 수를 제한할 수 있어 과다한 접속으로 인한 서버의 자원 고갈을 막을 수 있습니다. 

   - 데이터베이스 접속 모듈을 공통화해 데이터베이스 서버의 환경이 바뀔경우 유지보수를 쉽게 할 수 있습니다.


     JSP -----> JDBC -----> Oracle
                                           1521
                                          -----> Ms-SQL
                                           1433
                                          -----> My-SQL
                                           3306

 


     JSP -----> JDBC -----> Socket -----> ServerSocket -----> Oracle
                                         ---------------------------
                                                 1521, 1433, 3306
                         

 

1. Connection Pool의 원리
JSP 페이지 <----> DBConnectionMgr.java ----┬--- Connection 1 ---┐
                                                                   │                             │
                                                                   ├--- Connection 2 ---┼--- DataBase
                                                                   │                             │
                                                                   └--- Connection 3 ---┘

 

- DBConnectionMgr.class
  . DB Connection을 생성, 삭제하는 역활을 합니다.
  . Connection(접속) 객체를 요구하는 JSP 등 Client페이지의
    요청을 받는 역활을 합니다.

 

- ConnectionObject.class
  . DB Connection 객체를 가지고 있습니다.
  . 가지고 있는 데이터베이스 Connection 객체가 사용중인지의
    상태값을 boolean 타입으로 가지고 있습니다.
  . ConnectionObject는 접속객체를 10개를 만들기로 선언을 하면
    10개가 생성되어 Vector에 저장됩니다.

 

  - Connection Pool의 작동 원리

Client -----> DBConnectionMgr pool = DBConnectionMgr.getInstance();

--> conn = pool.getConnection();

-----> connections Vector를 검사 -----> ConnectionObject

-----> connection = c;, inUse = useFlag;
 
-----> 사용하지 않는 ConnectionObject를 반환

 

 


2. 하나의 객체만 생성하는 Singleton 패턴
   - 개체를 하나만 생성하여 모든 사용자가 공유합니다.
   - 자원을 절약할수 있으며 동기화 처리를 해주어야 합니다.
  
    멤버 변수
    private static DBConnectionMgr instance = null;

    멤버 메소드
    public static DBConnectionMgr getInstance() {
        //Connection Pool이 생성되어 있는지 검사
        if (instance == null) { //생성되어 있지 않다면
            synchronized (DBConnectionMgr.class) {//Lock 설정
                if (instance == null) {//수영장이 없으면
                    instance = new DBConnectionMgr();//수영장 생성
                }
            }
        }
   }

 

 


3. 객체 버퍼링
    //Vector의 초기값으로 10을 지정합니다.
    private Vector connections = new Vector(10);

 


class ConnectionObject {
    public java.sql.Connection connection = null;
    public boolean inUse = false; //Connection 의 사용 여부

    //useFlag: Client가 객체를 사용하는지 여부 지정
    //true는 현재 Client가 사용하고 있는 객체라는 뜻
    public ConnectionObject(Connection c, boolean useFlag) {
        connection = c;
        inUse = useFlag;
    }
}

 
[출처] [11] Connection Pool의 제작 및 이해|작성자 샴폐인



 * Copyright(c) 2001 iSavvix Corporation (http://www.isavvix.com/)
 *
 *                        All rights reserved
 *
 * Permission to use, copy, modify and distribute this material for
 * any purpose and without fee is hereby granted, provided that the
 * above copyright notice and this permission notice appear in all
 * copies, and that the name of iSavvix Corporation not be used in
 * advertising or publicity pertaining to this material without the
 * specific, prior written permission of an authorized representative of
 * iSavvix Corporation.
 *
 * ISAVVIX CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES,
 * EXPRESS OR IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT
 * NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR ANY PARTICULAR PURPOSE, AND THE WARRANTY AGAINST
 * INFRINGEMENT OF PATENTS OR OTHER INTELLECTUAL PROPERTY RIGHTS.  THE
 * SOFTWARE IS PROVIDED "AS IS", AND IN NO EVENT SHALL ISAVVIX CORPORATION OR
 * ANY OF ITS AFFILIATES BE LIABLE FOR ANY DAMAGES, INCLUDING ANY
 * LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL DAMAGES RELATING
 * TO THE SOFTWARE.
 *
 */
package com.multi.jdbc.common;

import java.sql.*;
import java.util.Properties;
import java.util.Vector;
public class DBConnectionMgr {
    private Vector connections = new Vector(10); //Connection 10
    private String _driver = "com.mysql.cj.jdbc.Driver",
    _url = "jdbc:mysql://localhost:3306/scott?",
    _user = "scott",
    _password = "tiger";
    private boolean _traceOn = false;
    private boolean initialized = false;
    private int _openConnections = 10;
    private static DBConnectionMgr instance = null;

    public DBConnectionMgr() {
    }

    /** Use this method to set the maximum number of open connections before
     unused connections are closed.
     */

    public static DBConnectionMgr getInstance() {
        if (instance == null) {
            synchronized (DBConnectionMgr.class) {
                if (instance == null) {
                    instance = new DBConnectionMgr();
                }
            }
        }
        return instance;
    }

    public void setOpenConnectionCount(int count) {
        _openConnections = count;
    }

    public void setEnableTrace(boolean enable) {
        _traceOn = enable;
    }

    /** Returns a Vector of java.sql.Connection objects */
    public Vector getConnectionList() {
        return connections;
    }

    /** Opens specified "count" of connections and adds them to the existing pool */
    public synchronized void setInitOpenConnections(int count)
            throws SQLException {
        Connection c = null;
        ConnectionObject co = null;
        
        for (int i = 0; i < count; i++) {
            c = createConnection();
            co = new ConnectionObject(c, false);
            connections.addElement(co);
            trace("ConnectionPoolManager: Adding new DB connection to pool (" + connections.size() + ")");
        }
    }

    /** Returns a count of open connections */
    public int getConnectionCount() {
        return connections.size();
    }

    /** Returns an unused existing or new connection.  */
    public synchronized Connection getConnection()
            throws Exception {
        if (!initialized) {
            Class c = Class.forName(_driver);
            DriverManager.registerDriver((Driver) c.newInstance());
            initialized = true;
        }
        Connection c = null;
        ConnectionObject co = null;
        boolean badConnection = false;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            // If connection is not in use, test to ensure it's still valid!
            if (!co.inUse) {
                try {
                    badConnection = co.connection.isClosed();
                    if (!badConnection)
                        badConnection = (co.connection.getWarnings() != null);
                } catch (Exception e) {
                    badConnection = true;
                    e.printStackTrace();
                }
                // Connection is bad, remove from pool
                if (badConnection) {
                    connections.removeElementAt(i);
                    trace("ConnectionPoolManager: Remove disconnected DB connection #" + i);
                    continue;
                }
                c = co.connection;
                co.inUse = true;
                trace("ConnectionPoolManager: Using existing DB connection #" + (i + 1));
                break;
            }
        }

        if (c == null) {
            c = createConnection();
            co = new ConnectionObject(c, true);
            connections.addElement(co);
            trace("ConnectionPoolManager: Creating new DB connection #" + connections.size());
        }
        return c;
    }

    /** Marks a flag in the ConnectionObject to indicate this connection is no longer in use */
    public synchronized void freeConnection(Connection c) {
        if (c == null)
            return;

        ConnectionObject co = null;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            if (c == co.connection) {
                co.inUse = false;
                break;
            }
        }

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            if ((i + 1) > _openConnections && !co.inUse)
                removeConnection(co.connection);
        }
    }

    public void freeConnection(Connection c, PreparedStatement p, ResultSet r) {
        try {
            if (r != null) r.close();
            if (p != null) p.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection c, Statement s, ResultSet r) {
        try {
            if (r != null) r.close();
            if (s != null) s.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection c, PreparedStatement p) {
        try {
            if (p != null) p.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection c, Statement s) {
        try {
            if (s != null) s.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /** Marks a flag in the ConnectionObject to indicate this connection is no longer in use */
    public synchronized void removeConnection(Connection c) {
        if (c == null)
            return;

        ConnectionObject co = null;
        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            if (c == co.connection) {
                try {
                    c.close();
                    connections.removeElementAt(i);
                    trace("Removed " + c.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            }
        }
    }

    private Connection createConnection()
            throws SQLException {
        Connection con = null;
        
        try {
            if (_user == null)
                _user = "";
            if (_password == null)
                _password = "";

            Properties props = new Properties();
            props.put("user", _user);
            props.put("password", _password);

            con = DriverManager.getConnection(_url, props);
        } catch (Throwable t) {
            throw new SQLException(t.getMessage());
        }
        return con;
    }

    /** Closes all connections and clears out the connection pool */
    public void releaseFreeConnections() {
        trace("ConnectionPoolManager.releaseFreeConnections()");

        Connection c = null;
        ConnectionObject co = null;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            if (!co.inUse)
                removeConnection(co.connection);
        }
    }

    /** Closes all connections and clears out the connection pool */
    public void finalize() {
        trace("ConnectionPoolManager.finalize()");

        Connection c = null;
        ConnectionObject co = null;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            try {
                co.connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            co = null;
        }
        connections.removeAllElements();
    }

    private void trace(String s) {
        if (_traceOn)
            System.err.println(s);
    }
}

class ConnectionObject {
    public Connection connection = null;
    public boolean inUse = false;

    public ConnectionObject(Connection c, boolean useFlag) {
        connection = c;
        inUse = useFlag;
    }
}