package com.multi.jdbc.b_basic.view;

import com.multi.jdbc.b_basic.model.dao.MemberDao;
import com.multi.jdbc.b_basic.model.dto.MemberDto;

import javax.swing.*;

public class MemberUITest7 { //로그인

    public static void main(String[] args) {

        String id = JOptionPane.showInputDialog("아이디 입력");
        String pw = JOptionPane.showInputDialog("패스워드 입력");


        MemberDao dao = new MemberDao();
        MemberDto memberDto = new MemberDto();
        memberDto.setId(Integer.parseInt(id));
        memberDto.setPw(pw);
        MemberDto rsDto = dao.login(memberDto);

        System.out.println(rsDto);

        //어떤 경우에 "로그인실패" 출력
        if (rsDto == null) {
            System.out.println("로그인 실패");
            JOptionPane.showMessageDialog(null,"로그인실패");
            MemberUI member = new MemberUI();
            member.open();


        } else {
            System.out.println("로그인 성공");
            JOptionPane.showMessageDialog(null,"로그인성공");
            BoardUI board = new BoardUI();
            board.open();
        }

        //else "로그인 성공"


    }
}
