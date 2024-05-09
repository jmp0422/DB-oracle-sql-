package com.multi.jdbc.b_basic.view;

import com.multi.jdbc.b_basic.model.dao.MemberDao;
import com.multi.jdbc.b_basic.model.dto.MemberDto;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class MemberUI {
	private static JTextField t1;
	private static JTextField t2;
	private static JTextField t3;
	private static JTextField t4;

	//public static void main(String[] args) {
	public static void open() {
		JFrame f = new JFrame(); // f객체 생성
		f.getContentPane().setBackground(Color.GREEN);
		f.setSize(516, 595); //가로 500, 세로 600
		f.getContentPane().setLayout(null);
		
		JLabel lblNewLabel = new JLabel("회원정보");
		lblNewLabel.setFont(new Font("굴림", Font.BOLD, 47));
		lblNewLabel.setBounds(116, 27, 238, 53);
		f.getContentPane().add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("아이디");
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
		
		JLabel lblNewLabel_1_1 = new JLabel("패스워드");
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
		
		JLabel lblNewLabel_1_2 = new JLabel("이름");
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
		
		JLabel lblNewLabel_1_3 = new JLabel("전화번호");
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
		
		JButton btnNewButton = new JButton("회원가입");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int id = Integer.parseInt(t1.getText());
				String pw = t2.getText();
				String name = t3.getText();
				String tel = t4.getText();

				MemberDto memberDto = new MemberDto(id,pw,name,tel);
				MemberDao memberDao = new MemberDao();
				memberDao.insert(memberDto);

			}
		});
		btnNewButton.setFont(new Font("굴림", Font.BOLD, 23));
		btnNewButton.setBackground(Color.ORANGE);
		btnNewButton.setForeground(Color.RED);
		btnNewButton.setBounds(12, 436, 155, 94);
		f.getContentPane().add(btnNewButton);
		
		JButton btnNewButton_1 = new JButton("회원탈퇴");
		btnNewButton_1.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {

				String id = JOptionPane.showInputDialog("탈퇴할 id입력");
				MemberDao memberDao = new MemberDao();
				MemberDto rsDto = memberDao.delete(id);

				t1.setText(String.valueOf(rsDto.getId()));
				t2.setText(rsDto.getPw());
				t3.setText(rsDto.getName());
				t4.setText(rsDto.getTel());

			}
		});
		btnNewButton_1.setFont(new Font("굴림", Font.BOLD, 23));
		btnNewButton_1.setBackground(Color.ORANGE);
		btnNewButton_1.setForeground(Color.RED);
		btnNewButton_1.setBounds(179, 436, 148, 94);
		f.getContentPane().add(btnNewButton_1);
		
		JButton btnNewButton_1_1 = new JButton("회원정보");
		btnNewButton_1_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String id = JOptionPane.showInputDialog("검색할 id입력");
				MemberDao memberDao = new MemberDao();
				MemberDto rsDto = memberDao.selectOne(id);

				t1.setText(String.valueOf(rsDto.getId()));
				t2.setText(rsDto.getPw());
				t3.setText(rsDto.getName());
				t4.setText(rsDto.getTel());
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
