package com.example.listtasksactivity.util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Util {

    public static Date convertStringDateToSQLDate(String date) throws ParseException {

        java.util.Date dateInJava = new SimpleDateFormat("DD/MM/YYYY").parse(date);
        java.sql.Date dateInSQl = new java.sql.Date(dateInJava.getTime());

        return dateInSQl;


    }

}
