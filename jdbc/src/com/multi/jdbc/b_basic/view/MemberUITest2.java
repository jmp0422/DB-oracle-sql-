package com.multi.jdbc.b_basic.view;

import com.multi.jdbc.b_basic.model.dao.MemberDao;

import javax.swing.*;

public class MemberUITest2 { //회원탈퇴

    public static void main(String[] args) {

        String id = JOptionPane.showInputDialog("아이디 입력");


        MemberDao dao = new MemberDao();
        dao.delete(id);

    }
}
