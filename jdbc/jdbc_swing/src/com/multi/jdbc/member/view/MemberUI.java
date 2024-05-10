package com.multi.jdbc.member.view;

import com.multi.jdbc.member.model.dao.MemberDao;
import com.multi.jdbc.member.model.dto.MemberDto;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class MemberUI {

    public void initializeUI() {

        // JFrame
        JFrame f = new JFrame();
        f.setSize(400, 800);
        f.setTitle("나의 회원정보UI");
        f.getContentPane().setBackground(Color.GREEN);

        // FlowLayout
        FlowLayout flow = new FlowLayout();
        f.setLayout(flow);
        // Font
        // JLabel 5, JTextField 4, JButton 2
        JLabel l1 = new JLabel("이미지 들어갈 곳");
        JLabel l2 = new JLabel("회원ID : ");
        JLabel l3 = new JLabel("회원PW : ");
        JLabel l4 = new JLabel("회원이름: ");
        JLabel l5 = new JLabel("회원TEL: ");

        JTextField t1 = new JTextField(10); // 10은 글자수
        JTextField t2 = new JTextField(10);
        JTextField t3 = new JTextField(10);
        JTextField t4 = new JTextField(10);

        JButton b1 = new JButton("회원가입 요청");
        JButton b2 = new JButton("회원탈퇴 요청");
        JButton b3 = new JButton("회원수정 요청");
        JButton b4 = new JButton("회원검색 요청");
        JButton b5 = new JButton("회원전체리스트요청");
        b1.setBackground(Color.yellow);
        b1.setForeground(Color.BLUE);
        b1.setOpaque(true);
        b2.setBackground(Color.yellow);
        b2.setForeground(Color.BLUE);
        b2.setOpaque(true);
        b3.setBackground(Color.yellow);
        b3.setForeground(Color.BLUE);
        b3.setOpaque(true);
        b4.setBackground(Color.yellow);
        b4.setForeground(Color.BLUE);
        b4.setOpaque(true);
        b5.setForeground(Color.BLUE);
        b5.setOpaque(true);

        t1.setBackground(Color.pink);
        t1.setForeground(Color.red);
        t2.setBackground(Color.pink);
        t2.setForeground(Color.red);
        t3.setBackground(Color.pink);
        t3.setForeground(Color.red);
        t4.setBackground(Color.pink);
        t4.setForeground(Color.red);

        Font font = new Font("맑은 고딕", Font.BOLD, 30);

        l1.setFont(font);
        l2.setFont(font);
        l3.setFont(font);
        l4.setFont(font);
        l5.setFont(font);

        t1.setFont(font);
        t2.setFont(font);
        t3.setFont(font);
        t4.setFont(font);

        b1.setFont(font);
        b2.setFont(font);
        b3.setFont(font);
        b4.setFont(font);
        b5.setFont(font);

        f.add(l1);
        f.add(l2);
        f.add(t1);
        f.add(l3);
        f.add(t2);
        f.add(l4);
        f.add(t3);
        f.add(l5);
        f.add(t4);
        f.add(b1);
        f.add(b2);
        f.add(b3);
        f.add(b4);
        f.add(b5);

        b1.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // 회원가입
                //1. 입력한 값받기
                String id = t1.getText();
                String pw = t2.getText();
                String name = t3.getText();
                String tel = t4.getText();
                //2. dto에 값 담기
                MemberDto memberDto = new MemberDto();
                memberDto.setId(id);
                memberDto.setPw(pw);
                memberDto.setName(name);
                memberDto.setTel(tel);
                //3. dao객체 생성해서 insert 만들어서 전달하기
                MemberDao memberDao = new MemberDao();

                //4. result가 1이면, 회원가입 성공이라고 띄우고, 아니면 실패 띄우기
                int result = memberDao.insert(memberDto);
                if (result == 1) {
                    JOptionPane.showMessageDialog(f, "회원가입성공!");
                } else {
                    JOptionPane.showMessageDialog(f, "회원가입실패!");
                }
            }
        });

        b2.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                //탈퇴
                //1. 입력한 값받기
                String id = JOptionPane.showInputDialog("탈퇴할 id를 입력하세요");

                MemberDao memberDao = new MemberDao();
                int result = memberDao.delete(id);

                if (result == 1) {
                    JOptionPane.showMessageDialog(f, "회원탈퇴성공!");
                } else {
                    JOptionPane.showMessageDialog(f, "회원탈퇴실패!");
                }


            }
        });

        b3.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                //수정
                String id = JOptionPane.showInputDialog("수정할 id를 입력하세요");
                String tel = JOptionPane.showInputDialog("수정할 tel을 입력하세요");

                MemberDao memberDao = new MemberDao();
                MemberDto memberDto = new MemberDto();
                memberDto.setId(id);
                memberDto.setTel(tel);

                int result = memberDao.update(memberDto);

                if (result == 1) {
                    JOptionPane.showMessageDialog(f, "회원수정성공!");

                    MemberDto rsDto = memberDao.selectOne(id);
                    JOptionPane.showMessageDialog(f, rsDto);
                } else {
                    JOptionPane.showMessageDialog(f, "회원수정실패!");
                }
            }
        });

        b4.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                //검색
                String id = JOptionPane.showInputDialog("검색할 id를 입력하세요");

                MemberDao memberDao = new MemberDao();
                MemberDto rsDto = memberDao.selectOne(id);

                if (rsDto == null) {
                    JOptionPane.showMessageDialog(f, "회원검색실패!");
                } else {
                    JOptionPane.showMessageDialog(f, rsDto);
                }
            }
        });

        b5.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                //검색
                MemberList memberList = new MemberList();
                memberList.selectList();
            }
        });


        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.setVisible(true);

    }

}
