package com.multi.jdbc.b_basic.view;

import com.multi.jdbc.b_basic.model.dao.BoardDao;
import com.multi.jdbc.b_basic.model.dto.BoardDto;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class BoardUI {

    private  JTextField t1;
    private  JTextField t2;
    private  JTextField t3;
    private  JTextField t4;

    public void open() {
        JFrame f = new JFrame(); // f객체 생성
        f.getContentPane().setBackground(Color.GREEN);
        f.setSize(516, 595); // 가로 500, 세로 600
        f.getContentPane().setLayout(null);


        JLabel lblNewLabel = new JLabel("게시판");
        lblNewLabel.setFont(new Font("굴림", Font.BOLD, 47));
        lblNewLabel.setBounds(116, 27, 238, 53);
        f.getContentPane().add(lblNewLabel);

        JLabel lblNewLabel_1 = new JLabel("번호");
        lblNewLabel_1.setFont(new Font("굴림", Font.BOLD, 25));
        lblNewLabel_1.setBounds(38, 140, 134, 38);
        f.getContentPane().add(lblNewLabel_1);



        t1 = new JTextField();
        t1.setForeground(Color.BLUE);
        t1.setBackground(Color.YELLOW);
        t1.setFont(new Font("굴림", Font.BOLD, 25));
        t1.setBounds(199, 140, 233, 38);
        f.getContentPane().add(t1);
        t1.setColumns(10);

        JLabel lblNewLabel_1_1 = new JLabel("제목");
        lblNewLabel_1_1.setFont(new Font("굴림", Font.BOLD, 25));
        lblNewLabel_1_1.setBounds(38, 207, 134, 38);
        f.getContentPane().add(lblNewLabel_1_1);

        t2 = new JTextField();
        t2.setForeground(Color.BLUE);
        t2.setFont(new Font("굴림", Font.BOLD, 25));
        t2.setColumns(10);
        t2.setBackground(Color.YELLOW);
        t2.setBounds(199, 207, 233, 38);
        f.getContentPane().add(t2);

        JLabel lblNewLabel_1_2 = new JLabel("내용");
        lblNewLabel_1_2.setFont(new Font("굴림", Font.BOLD, 25));
        lblNewLabel_1_2.setBounds(38, 282, 134, 38);
        f.getContentPane().add(lblNewLabel_1_2);

        t3 = new JTextField();
        t3.setForeground(Color.BLUE);
        t3.setFont(new Font("굴림", Font.BOLD, 25));
        t3.setColumns(10);
        t3.setBackground(Color.YELLOW);
        t3.setBounds(199, 282, 233, 38);
        f.getContentPane().add(t3);

        JLabel lblNewLabel_1_3 = new JLabel("작성자");
        lblNewLabel_1_3.setFont(new Font("굴림", Font.BOLD, 25));
        lblNewLabel_1_3.setBounds(38, 353, 134, 38);
        f.getContentPane().add(lblNewLabel_1_3);

        t4 = new JTextField();
        t4.setForeground(Color.BLUE);
        t4.setFont(new Font("굴림", Font.BOLD, 25));
        t4.setColumns(10);
        t4.setBackground(Color.YELLOW);
        t4.setBounds(199, 353, 233, 38);
        f.getContentPane().add(t4);

        JButton btnNewButton = new JButton("등록");
        btnNewButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {

            }
        });

        btnNewButton.setFont(new Font("굴림", Font.BOLD, 23));
        btnNewButton.setBackground(Color.ORANGE);
        btnNewButton.setForeground(Color.RED);
        btnNewButton.setBounds(12, 436, 155, 94);
        f.getContentPane().add(btnNewButton);

        JButton btnNewButton_1 = new JButton("삭제");
        btnNewButton_1.setFont(new Font("굴림", Font.BOLD, 23));
        btnNewButton_1.setBackground(Color.ORANGE);
        btnNewButton_1.setForeground(Color.RED);
        btnNewButton_1.setBounds(179, 436, 148, 94);
        f.getContentPane().add(btnNewButton_1);

        JButton btnNewButton_1_1 = new JButton("검색");
        btnNewButton_1_1.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String no = JOptionPane.showInputDialog("검색할 no입력");
                int no1 = Integer.parseInt(no);
                BoardDao boardDao = new BoardDao();
                BoardDto rsDto = boardDao.selectOne(no1);

                if(rsDto !=null){
                    t1.setText(String.valueOf(rsDto.getNo()));
                }

            }
        });
        btnNewButton_1_1.setForeground(Color.RED);
        btnNewButton_1_1.setFont(new Font("굴림", Font.BOLD, 23));
        btnNewButton_1_1.setBackground(Color.ORANGE);
        btnNewButton_1_1.setBounds(339, 436, 148, 94);
        f.getContentPane().add(btnNewButton_1_1);
        f.setVisible(true);

    }
}
