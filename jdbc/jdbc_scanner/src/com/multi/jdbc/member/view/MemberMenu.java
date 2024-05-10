package com.multi.jdbc.member.view;

import com.multi.jdbc.member.controller.MemberController;
import com.multi.jdbc.member.model.dto.Member;

import java.util.List;
import java.util.Scanner;

public class MemberMenu {



    private static Scanner sc = new Scanner(System.in);
    private MemberController memberController = new MemberController();



    public void mainMenu() {
        int choice;

        do {
            System.out.println("\n*******회원관리프로그램********");
            System.out.println("1.회원 전체 조회");// SELECT
            System.out.println("2.회원 아이디 조회");// SELECT
            System.out.println("3.회원 이름 조회");// SELECT
            System.out.println("4.회원 가입");// INSERT
            System.out.println("5.회원 정보 변경");// UPDATE
            System.out.println("6.회원 탈퇴");// DELETE
            System.out.println("9.프로그램 끝내기");// 종료
            System.out.println("번호선택 : ");

            choice = sc.nextInt();

            switch (choice) {
                case 1:
                    memberController.selectAll();
                    break;
                case 2:
               //     memberController.selectOne(inputMemberId());
                    break;
                case 3:
                    //memberController.selectByName(inputMemberName());
                    break;
                case 4:
             //       memberController.insertMember(inputMember());
                    break;
                case 5:
              //      memberController.updateMember(updateMember());
                    break;
                case 6:
               //     memberController.deleteMember(inputMemberId());
                    break;

                case 7:
               //     memberController.selectAllDeleteMember();
                    break;
                case 9:
                    System.out.println("정말로 끝내시겠습니까??(y/n)");
                    if ('y' == sc.next().toLowerCase().charAt(0)) {
                  //      memberController.exitProgram();
                        return;
                    }

                    break;

                default:
                    System.out.println("번호를 잘못입력하였습니다.");
            }

        } while (true);
    }
    public void displayMemberList(List<Member> list) {
        System.out.println("\n조회된 전체 회원정보는 다음과 같습니다.");
        System.out.println("\n아이디\t이름\t성별\t나이\t이메일\t전화번호\t주소\t취미\t가입일");
        System.out.println("----------------------------------------------------------");

        for(Member m: list) {
            System.out.println(m);
        }

    }

    public void displayNoData() {
        System.out.println("조회된 데이터가 없습니다.");


    }
}
