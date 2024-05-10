package com.multi.jdbc.a_com;

public class DBCP {

    private static DBCP instance = null;


    private DBCP(){}

    public static DBCP getInstance(){

        if(instance == null){
            instance = new DBCP();
        }

        return instance;
    }
}