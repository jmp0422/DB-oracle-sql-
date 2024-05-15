package com.multi.jdbc.member.controller;

import com.multi.jdbc.common.exception.MemberException;
import com.multi.jdbc.member.model.dto.Member;
import com.multi.jdbc.member.service.MemberService;
import com.multi.jdbc.member.view.MemberMenu;

import java.util.ArrayList;

public class MemberController {
    private MemberService memberService;

    {
        try {
            memberService = new MemberService();
        } catch (MemberException e) {
            throw new RuntimeException(e);
        }
    }

    public void selectAll() {
        MemberMenu menu = new MemberMenu();
        ArrayList<Member> list;

        try {
            list = memberService.selectAll();
            if(!list.isEmpty()){
                menu.displayMemberList(list);
            }else{
                menu.displayNoData();
            }
        } catch (MemberException e) {
            menu.displayError("회원전체 조회 실패, 관리자에게 문의하세요");
            e.printStackTrace();
        }



    }

    public void selectOne(String memberId) {
        MemberMenu menu = new MemberMenu();
        Member m = memberService.selectOne(memberId);
        if( m != null ){
            menu.displayMember(m);
        }else{
            menu.displayNoData();
        }
    }

    public void insertMember(Member member) {
        int result = memberService.insertMember(member);
        if(result > 0){
            new MemberMenu().displaySuccess("회원가입 성공");
        }
    }

    public void updateMember(Member member) {
        int result = memberService.updateMember(member);
        if(result > 0){
            new MemberMenu().displaySuccess("회원수정 성공");
        }
    }

    public void deleteMember(String memberId) {
        int result = memberService.deleteMember(memberId);
        if(result > 0){
            new MemberMenu().displaySuccess("회원삭제 성공");
        }
    }
    public void exitProgram(){
        memberService.exitProgram();
    }
}
