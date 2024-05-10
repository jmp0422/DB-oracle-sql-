package com.multi.jdbc.member.view;

import com.multi.jdbc.member.model.dao.MemberDao;
import com.multi.jdbc.member.model.dto.MemberDto;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;

public class MemberList {
    private  JTable table;
    private  JScrollPane scrollPane = null;
    private  String header[] = {"아이디", "패스워드", "이름", "전화번호"};
    private  JPanel panel;

    public void selectList() {
        JFrame f = new JFrame();
        f.setSize(528, 700);

        panel = new JPanel();
        f.getContentPane().add(panel, BorderLayout.CENTER);

        panel.setSize(528, 700);


        JLabel lblNewLabel_1 = new JLabel("");
        lblNewLabel_1.setIcon(new ImageIcon("images/img.jpg"));
        panel.add(lblNewLabel_1);

        JLabel lblNewLabel = new JLabel("검색결과");
        lblNewLabel.setFont(new Font("굴림", Font.BOLD, 20));
        lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
        f.getContentPane().add(lblNewLabel, BorderLayout.NORTH);
        //f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JButton btnNewButton = new JButton("삭제");
        panel.add(btnNewButton);

        setListTable();


        btnNewButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                panel.remove(scrollPane);


                //클릭한 위치의 행번호
                int rowNo = table.getSelectedRow();
                Object value1 = (Object) table.getModel().getValueAt(rowNo, 0);
                MemberDao dao = new MemberDao();
                int result = dao.delete(value1.toString());
                if (result == 1) {
                    JOptionPane.showMessageDialog(f, "회원삭제 성공");
                } else {
                    JOptionPane.showMessageDialog(f, "회원삭제 실패");
                }

                setListTable();


            }
        });


        f.setVisible(true);
    }

    public  void setListTable() {


        MemberDao dao = new MemberDao();
        ArrayList<MemberDto> list = dao.list();

        Object[][] all = new String[list.size()][4];
        for (int i = 0; i < all.length; i++) {
            all[i][0] = list.get(i).getId();
            all[i][1] = list.get(i).getPw();
            all[i][2] = list.get(i).getName();
            all[i][3] = list.get(i).getTel();
        }

        DefaultTableModel model = new DefaultTableModel(all, header);
        if (table == null) {
            System.out.println("table == null)");

            table = new JTable(model);
            scrollPane = new JScrollPane(table);
            scrollPane.setPreferredSize(new Dimension(500, 200));  // 스크롤 팬의 선호 크기 설정

        } else {
            System.out.println(" table.setModel(model)");

            table.setModel(model);
            System.out.println("setViewportView");
            scrollPane.setViewportView(table);  // 기존 스크롤 팬에 새로운 테이블 뷰 설정

        }
        panel.add(scrollPane);
        panel.revalidate();  // 레이아웃을 새로 계산
        panel.repaint();  // 컴포넌트를 다시 그림


        table.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                //클릭한 위치의 행번호
                int rowNo = table.getSelectedRow();
                //클릭한 위치의 열번호
                int colNo = table.getSelectedColumn();
                //행,열에 해당하는 값 추출
                Object value = (Object) table.getModel().getValueAt(rowNo, colNo);
                System.out.println(value);

                //한 row가지고 오기
                Object value1 = (Object) table.getModel().getValueAt(rowNo, 0);
                Object value2 = (Object) table.getModel().getValueAt(rowNo, 1);
                Object value3 = (Object) table.getModel().getValueAt(rowNo, 2);
                Object value4 = (Object) table.getModel().getValueAt(rowNo, 3);
                System.out.println(value1 + " " + value2 + " " + value3 + " " + value4);
            }
        });

    }
}
