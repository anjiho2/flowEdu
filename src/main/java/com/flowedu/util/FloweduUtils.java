package com.flowedu.util;

public class FloweduUtils {

    public static String convertLectureDay(String engDay) {
        if (!"".equals(engDay)) return null;
        String korDay = null;
        switch (engDay) {
            case "MON" :
                korDay = "월요일";
                break;
            case "TUE" :
                korDay = "월요일";
                break;
            case "WEN" :
                korDay = "월요일";
                break;
            case "THU" :
                korDay = "월요일";
                break;
            case "FRI" :
                korDay = "월요일";
                break;
            case "SAT" :
                korDay = "월요일";
                break;
            case "SUN" :
                korDay = "일요일";
                break;
        }
        return korDay;
    }
}
