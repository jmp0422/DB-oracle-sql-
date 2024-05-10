package com.multi.jdbc.member.controller;

import com.multi.jdbc.member.model.dto.Member;
import com.multi.jdbc.member.service.MemberService;
import com.multi.jdbc.member.view.MemberMenu;

import java.util.ArrayList;

public class MemberController {
    private MemberService memberService = new MemberService();
    public void selectAll() {
        MemberMenu menu = new MemberMenu();
        ArrayList<Member> list;

        list = memberService.selectAll();

        if(!list.isEmpty()){
            menu.displayMemberList(list);
        }else{
            menu.displayNoData();
        }

    }
}
