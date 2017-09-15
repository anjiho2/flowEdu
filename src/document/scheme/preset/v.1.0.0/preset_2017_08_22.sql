INSERT INTO JOB_POSITION_INFO (job_position_id, job_position_name) VALUES (1, '팀원');
INSERT INTO JOB_POSITION_INFO (job_position_id, job_position_name) VALUES (2, '파트장');
INSERT INTO JOB_POSITION_INFO (job_position_id, job_position_name) VALUES (3, '팀장');
INSERT INTO JOB_POSITION_INFO (job_position_id, job_position_name) VALUES (4, '실장');
INSERT INTO JOB_POSITION_INFO (job_position_id, job_position_name) VALUES (5, '본부장');

INSERT INTO LECTURE_PRICE (lecture_price_id, lecture_price, create_date) VALUES (1, 15000, now());
INSERT INTO LECTURE_PRICE (lecture_price_id, lecture_price, create_date) VALUES (2, 200000, now());
INSERT INTO LECTURE_PRICE (lecture_price_id, lecture_price, create_date) VALUES (3, 300000, now());
INSERT INTO LECTURE_PRICE (lecture_price_id, lecture_price, create_date) VALUES (4, 400000, now());
INSERT INTO LECTURE_PRICE (lecture_price_id, lecture_price, create_date) VALUES (5, 500000, now());
INSERT INTO LECTURE_PRICE (lecture_price_id, lecture_price, create_date) VALUES (6, 150000, now());
INSERT INTO LECTURE_PRICE (lecture_price_id, lecture_price, create_date) VALUES (7, 1111, now());
INSERT INTO LECTURE_PRICE (lecture_price_id, lecture_price, create_date) VALUES (8, 5456456, now());

INSERT INTO LECTURE_ROOM_INFO (lecture_room_id, office_id, lecture_room_name, create_date) VALUES (1, 8, '수아초등관101호', '2017-08-09 15:16:03');
INSERT INTO LECTURE_ROOM_INFO (lecture_room_id, office_id, lecture_room_name, create_date) VALUES (2, 8, '수아초등관102호', '2017-08-09 15:16:14');
INSERT INTO LECTURE_ROOM_INFO (lecture_room_id, office_id, lecture_room_name, create_date) VALUES (3, 8, '수아초등관103호', '2017-08-09 15:16:23');
INSERT INTO LECTURE_ROOM_INFO (lecture_room_id, office_id, lecture_room_name, create_date) VALUES (4, 8, '1003', '2017-08-11 15:07:05');
INSERT INTO LECTURE_ROOM_INFO (lecture_room_id, office_id, lecture_room_name, create_date) VALUES (5, 8, '수아중등관1000호', '2017-08-11 15:07:32');
INSERT INTO LECTURE_ROOM_INFO (lecture_room_id, office_id, lecture_room_name, create_date) VALUES (6, 8, 'sdfsdf', '2017-08-14 15:31:09');
INSERT INTO LECTURE_ROOM_INFO (lecture_room_id, office_id, lecture_room_name, create_date) VALUES (7, 8, '10001', '2017-08-16 10:10:20');
INSERT INTO LECTURE_ROOM_INFO (lecture_room_id, office_id, lecture_room_name, create_date) VALUES (8, 9, '테스트반101호', '2017-08-16 10:20:43');
INSERT INTO LECTURE_ROOM_INFO (lecture_room_id, office_id, lecture_room_name, create_date) VALUES (9, 9, '테스트반202호', '2017-08-16 10:20:51');

INSERT INTO TEAM_INFO (team_id, team_name) VALUES (1, '1팀');
INSERT INTO TEAM_INFO (team_id, team_name) VALUES (2, '2팀');
INSERT INTO TEAM_INFO (team_id, team_name) VALUES (3, '3팀');
INSERT INTO TEAM_INFO (team_id, team_name) VALUES (4, '4팀');
INSERT INTO TEAM_INFO (team_id, team_name) VALUES (5, '5팀');

INSERT INTO FLOWEDU_MEMBER (flow_member_id, office_id, team_id, phone_number, member_password, member_name, member_birthday, member_address, member_email, sexual_assult_confirm_date, education_reg_date, member_type, create_date, job_position_id) VALUES (3, 3, 1, '1', 'QgftPCP4UdMo6JctU7IyEg==', '개발계정', '2012-01-01', '경기도 성남시 분당구 수내동', 'test@test.com', '2012-01-01', '2012-01-01', 'ADMIN', '2017-08-04 17:26:44', 1);


