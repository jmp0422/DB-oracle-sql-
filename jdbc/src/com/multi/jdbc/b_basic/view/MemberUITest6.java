package com.multi.jdbc.b_basic.view;

import com.multi.jdbc.b_basic.model.dao.MemberDao;
import com.multi.jdbc.b_basic.model.dto.MemberDto;

import java.util.Scanner;

public class MemberUITest6 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("id / tel 순으로 입력하세요.");
        String id = sc.next();
        String tel = sc.next();

        MemberDao memberDao = new MemberDao();
        MemberDto memberDto = new MemberDto();
        memberDto.setId(Integer.parseInt(id));
        memberDto.setTel(tel);

        memberDao.update(memberDto);
    }
}
