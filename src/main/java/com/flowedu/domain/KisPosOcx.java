package com.flowedu.domain;

import lombok.Data;

/**
 * Created by jihoan on 2017. 11. 8..
 */
@Data
public class KisPosOcx {
    //단말기 번호
    private Long catId;
    //카드번호
    private Long cardNo;
    //할부개월
    private String installMent;
    //거래금액
    private int transAmt;
    //승인번호
    private Long authNo;
    //거래일자
    private Long replyDate;
    //매입사 코드
    private String accepterCode;
    //발급사 코드
    private String issureCode;
    //발급사 명
    private String issureName;
    //거래일련번호
    private String transNo;
    //가맹점 번호
    private Long merchantRegNo;
    //거래로그
    private String recvData;
    //결제 종류
    private String authType;
}
