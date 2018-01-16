package com.flowedu.service;

import com.flowedu.dto.EmailSendDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@Service
public class EmailService {

    private static final Logger logger = LoggerFactory.getLogger(EmailService.class);

    @Autowired
    protected JavaMailSender mailSender;

    public void SendEMail(EmailSendDto emailSendDto) throws Exception {
        logger.info("이메일 발송 시작");
        MimeMessage msg = mailSender.createMimeMessage();

        try {
            String message = "<div style=\"border:solid 1px;width:700px;overflow: hidden;background: #fff;\">";
            message += "<h2 style=\"border-bottom:solid 1px;width:100%;padding:20px 0 20px 20px;\">플로우교육</h2>";
            message += "<div style=\"width:400px;margin:50px 150px;\">";
            message += "<h3>" + emailSendDto.getFlowEduMemberDto().getMemberName() + "님</h3>";
            message += "<h4>회원 아이디는 다음과 같습니다.</h4><br>";
            message += "<table border=\"1\">";
            message += "<tr>";
            message += "<td>이름</td>";
            message += "<td>" + emailSendDto.getFlowEduMemberDto().getMemberName() + "</td>";
            message += "</tr>";
            message += "<tr>";
            message += "<td rowspan=\"3\">아이디</td>";
            message += "<td>등록번호 : " + emailSendDto.getFlowEduMemberDto().getMemberAuthKey() + "</td>";
            message += "</tr>";
            message += "<tr>";
            message += "<td>휴대혼번호 : " + emailSendDto.getFlowEduMemberDto().getPhoneNumber() + "</td>";
            message += "</tr>";
            message += "<tr>";
            message += "<td>이메일 주소 : " + emailSendDto.getFlowEduMemberDto().getMemberEmail() + "</td>";
            message += "</tr>";
            message += "</table><br>";

            message += "<p>플로우교육은 쉽고 간편한 로그인을 위해<br>등록번호, 휴대폰번호, 이메일 주소 중 하나로<br>로그인이 가능하도록 서비스를 제공하고 있습니다.</p><br>";
            message += "<button style=\"background: #ccc;padding:10px 70px;\"><a href=\"http://169.56.71.251:8080/flowEdu/\">플로우교육 AMS 바로가기</a></button>";
            message += "<p style=\"margin:20px 0;\">본 메일은 발신전용 메일 입니다.<br>관련문의는 고객센터(031-698-3403)를 이용해 주세요.</p>";
            message += "<div style=\"border-top:1px dashed;padding-top:20px;\">\n" +
                    "                플로우교육<br>경기도 성남시 분당구 수내동 16-6 N타워빌딩<br>COPYRIGTH&copy; FLOW EDU All rights reserved.\n" +
                    "            </div>";
            message += " </div>\n" +
                    "    </div>";

            msg.setSubject(emailSendDto.getSubject());
            //msg.setText(emailSendDto.getContent());
            msg.setContent(message, "text/html; charset=UTF-8");
            msg.setRecipients(
                    MimeMessage.RecipientType.TO,
                    InternetAddress.parse(emailSendDto.getReceiver())
            );
            //참조자 입력
            if (emailSendDto.getToCc() != null) {
                InternetAddress[] address = new InternetAddress[emailSendDto.getToCc().size()];
                int cnt = 0;
                for (String ccUser : emailSendDto.getToCc()) {
                    address[cnt] = new InternetAddress(ccUser);
                    cnt++;
                }
                msg.setRecipients(MimeMessage.RecipientType.CC, address);
            }
        } catch (MessagingException e) {
            // TODO: handle exception
            logger.info("MessagingException");
            e.printStackTrace();
        }
        try {
            mailSender.send(msg);
        } catch (MailException e) {
            // TODO: handle exception
            logger.info("MailException발생");
            e.printStackTrace();
        }
        logger.info("이메일 발송 끝");
    }

}
