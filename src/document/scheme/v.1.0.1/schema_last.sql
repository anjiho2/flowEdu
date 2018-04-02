DROP TABLE
    ACADEMY_GROUP;
CREATE TABLE
    ACADEMY_GROUP
    (
        academy_group_id INT(10) unsigned NOT NULL AUTO_INCREMENT,
        academy_group_name VARCHAR(45) NOT NULL,
        academy_thumbnail_file VARCHAR(100),
        PRIMARY KEY (academy_group_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE
    ASSIGNMENT_INFO;
CREATE TABLE
    ASSIGNMENT_INFO
    (
        assignment_idx bigint(10) NOT NULL AUTO_INCREMENT,
        lecture_id bigint NOT NULL,
        reg_member_id bigint NOT NULL,
        assignment_subject VARCHAR(30) NOT NULL,
        assignment_content text NOT NULL,
        assignment_file_name VARCHAR(50) NOT NULL,
        attachment_file_url VARCHAR(100) NOT NULL,
        use_yn TINYINT(1) NOT NULL,
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
        PRIMARY KEY (assignment_idx)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE
    BUS_ATTEND_TIME;
CREATE TABLE
    BUS_ATTEND_TIME
    (
        bus_attend_time_idx bigint NOT NULL AUTO_INCREMENT COMMENT '인덱스',
        station_name VARCHAR(40) NOT NULL COMMENT '정류소명',
        bus_idx bigint NOT NULL COMMENT '버스 인덱스',
        first_time VARCHAR(10) COLLATE latin1_swedish_ci COMMENT '1T',
        second_time VARCHAR(10) COLLATE latin1_swedish_ci COMMENT '2T',
        third_time VARCHAR(10) COLLATE latin1_swedish_ci COMMENT '3T',
        fourth_time VARCHAR(10) COLLATE latin1_swedish_ci COMMENT '4T',
        fifth_time VARCHAR(10) COLLATE latin1_swedish_ci COMMENT '5T',
        sixth_time VARCHAR(10) COLLATE latin1_swedish_ci COMMENT '6T',
        sort_number INT NOT NULL COMMENT '정렬 순서',
        PRIMARY KEY (bus_attend_time_idx),
        INDEX BUS_ATTEND_TIME_ix1 (bus_idx)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='버스 등원 정보 테이블';
DROP TABLE
    BUS_DISMISS_TIME;
CREATE TABLE
    BUS_DISMISS_TIME
    (
        bus_dismiss_time_idx bigint NOT NULL AUTO_INCREMENT COMMENT '인덱스',
        bus_idx bigint NOT NULL COMMENT '버스 인덱스',
        first_time VARCHAR(10) COMMENT '1T',
        second_time VARCHAR(10) COMMENT '2T',
        third_time VARCHAR(10) COMMENT '3T',
        fourth_time VARCHAR(10) COMMENT '4T',
        fifth_time VARCHAR(10) COMMENT '5T',
        sixth_time VARCHAR(10) COMMENT '6T',
        PRIMARY KEY (bus_dismiss_time_idx),
        INDEX BUS_DISMISS_TIME_ix1 (bus_idx)
    )
    ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='버스 하원 정보 테이블';
DROP TABLE
    BUS_INFO;
CREATE TABLE
    BUS_INFO
    (
        bus_idx bigint NOT NULL AUTO_INCREMENT COMMENT '버스 인덱스',
        route_number VARCHAR(15) NOT NULL COMMENT '노선 번호',
        start_route_name VARCHAR(15) NOT NULL COMMENT '노선명(시점)',
        end_route_name VARCHAR(15) NOT NULL COMMENT '노선명(종점)',
        bus_type VARCHAR(10) NOT NULL COMMENT '구분',
        bus_status TINYINT(1) NOT NULL COMMENT '상태',
        apply_start_date DATE NOT NULL COMMENT '적용기간(시작일)',
        apply_end_date DATE NOT NULL COMMENT '적용기간(종료일)',
        bus_memo text COMMENT '메모',
        driver_idx bigint NOT NULL COMMENT '기사 인덱스',
        PRIMARY KEY (bus_idx),
        CONSTRAINT BUS_INFO_ix1 UNIQUE (bus_idx),
        INDEX BUS_INFO_ix2 (driver_idx)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='버스 기본 테이블';
DROP TABLE
    DRIVER_HELPER_INFO;
CREATE TABLE
    DRIVER_HELPER_INFO
    (
        driver_helper_idx bigint NOT NULL AUTO_INCREMENT COMMENT '도우미 인덱스',
        driver_idx bigint NOT NULL COMMENT '기사 인덱스',
        office_id bigint NOT NULL COMMENT '학원 관 인덱스',
        helper_name VARCHAR(15) NOT NULL COMMENT '도우미 이름',
        phone_number VARCHAR(20) NOT NULL COMMENT '핸드폰 번호',
        birth_day DATE NOT NULL COMMENT '생일',
        reg_date DATE NOT NULL COMMENT '등록일',
        zip_code VARCHAR(10) NOT NULL COMMENT '우편번호',
        address VARCHAR(55) NOT NULL COMMENT '주소',
        address_detail VARCHAR(55) NOT NULL COMMENT '상세주소',
        sexual_assult_confirm_date DATE NOT NULL COMMENT '안전필증',
        serve_yn TINYINT(1) NOT NULL COMMENT '재직여부',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (driver_helper_idx),
        CONSTRAINT DRIVER_HELPER_INFO_ix3 UNIQUE (driver_helper_idx),
        INDEX DRIVER_HELPER_INFO_ix1 (driver_idx),
        INDEX DRIVER_HELPER_INFO_ix2 (office_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='통학 도우미 정보 테이블';
DROP TABLE
    DRIVER_INFO;
CREATE TABLE
    DRIVER_INFO
    (
        driver_idx bigint NOT NULL AUTO_INCREMENT COMMENT '기사 인덱스',
        office_id bigint NOT NULL COMMENT '학원 관 인덱스',
        job_position_id INT NOT NULL COMMENT '직책 인덱스',
        driver_name VARCHAR(10) NOT NULL COMMENT '기사 이름',
        phone_number VARCHAR(20) NOT NULL COMMENT '핸드폰 번호',
        birth_day DATE COMMENT '생일',
        reg_date DATE NOT NULL COMMENT '등록일',
        zip_code VARCHAR(10) NOT NULL COMMENT '우편번호',
        address VARCHAR(55) NOT NULL COMMENT '주소',
        address_detail VARCHAR(55) NOT NULL COMMENT '상세주소',
        bus_number VARCHAR(15) NOT NULL COMMENT '차량번호',
        passengers_number INT NOT NULL COMMENT '승차정원',
        safety_certificate_date DATE NOT NULL COMMENT '안전필증',
        serve_yn TINYINT(1) NOT NULL COMMENT '재직여부',
        sexual_assult_confirm_date DATE NOT NULL COMMENT '성범죄조회일',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (driver_idx),
        CONSTRAINT DRIVER_INFO_ix1 UNIQUE (driver_idx),
        INDEX DRIVER_INFO_ix2 (office_id),
        INDEX DRIVER_INFO_ix3 (job_position_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='버스 기사 정보 테이블';
DROP TABLE
    EARLY_CONSULT_MEMO;
CREATE TABLE
    EARLY_CONSULT_MEMO
    (
        early_consult_memo_id bigint NOT NULL AUTO_INCREMENT,
        phone_number VARCHAR(20) NOT NULL,
        memo_type VARCHAR(10) NOT NULL,
        memo_content text NOT NULL,
        create_member_id bigint NOT NULL,
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
        complete_yn TINYINT(1) DEFAULT '0' NOT NULL,
        PRIMARY KEY (early_consult_memo_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE
    FLOWEDU_MEMBER;
CREATE TABLE
    FLOWEDU_MEMBER
    (
        flow_member_id bigint NOT NULL AUTO_INCREMENT COMMENT '회원 아이디',
        office_id bigint NOT NULL COMMENT '관 구분 아이디',
        team_name VARCHAR(20) COMMENT '팀 아이디',
        phone_number VARCHAR(20) NOT NULL COMMENT '로그인 전화번호 사용',
        member_password VARCHAR(255) NOT NULL COMMENT '비밀번호',
        member_name VARCHAR(10) NOT NULL COMMENT '이름',
        member_birthday VARCHAR(15) NOT NULL COMMENT '생년월일',
        member_address VARCHAR(100) NOT NULL COMMENT '주소',
        member_email VARCHAR(45) NOT NULL COMMENT '이메일',
        sexual_assult_confirm_date VARCHAR(15) COMMENT '성범죄경력조회 확인일자',
        education_reg_date VARCHAR(15) COMMENT '교육정 강사등록일자',
        member_type VARCHAR(20) NOT NULL COMMENT '운영자, 선생님인지 구분',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        job_position_id INT NOT NULL,
        member_auth_key VARCHAR(10) NOT NULL,
        join_email_send TINYINT(1) DEFAULT '0' NOT NULL,
        serve_yn TINYINT(1) DEFAULT '1' NOT NULL,
        member_address_detail VARCHAR(100) NOT NULL,
        zip_code VARCHAR(6) NOT NULL,
        PRIMARY KEY (flow_member_id),
        CONSTRAINT FLOWEDU_MEMBER_ix1 UNIQUE (flow_member_id),
        INDEX FLOWEDU_MEMBER_ix2 (office_id),
        INDEX FLOWEDU_MEMBER_ix3 (team_name)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='운영자, 선생님 로그인 정보 테이블';
DROP TABLE
    JOB_POSITION_INFO;
CREATE TABLE
    JOB_POSITION_INFO
    (
        job_position_id INT NOT NULL AUTO_INCREMENT COMMENT '직책 아이디',
        job_position_name VARCHAR(15) NOT NULL COMMENT '직책명',
        PRIMARY KEY (job_position_id),
        CONSTRAINT JOB_POSITION_INFO_ix1 UNIQUE (job_position_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='직책 정보';
DROP TABLE
    LECTURE_ATTEND;
CREATE TABLE
    LECTURE_ATTEND
    (
        lecture_attend_id bigint NOT NULL AUTO_INCREMENT COMMENT '아이디',
        lecture_id bigint NOT NULL COMMENT '강의 아이디',
        student_id bigint NOT NULL COMMENT '학생 아이디',
        attend_day VARCHAR(5) NOT NULL COMMENT '출석요일',
        attend_type VARCHAR(10) NOT NULL COMMENT '출석 타입',
        attend_date DATE NOT NULL COMMENT '출석생성일',
        attend_modify_comment VARCHAR(100),
        modify_date DATETIME,
        attend_start_time VARCHAR(10),
        attend_end_time VARCHAR(10),
        end_attend_type VARCHAR(10),
        PRIMARY KEY (lecture_attend_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='강의 출석 테이블';
DROP TABLE
    LECTURE_DETAIL_INFO;
CREATE TABLE
    LECTURE_DETAIL_INFO
    (
        lecture_detail_id bigint NOT NULL AUTO_INCREMENT COMMENT '아이디',
        lecture_id bigint NOT NULL COMMENT '강의 정보 아이디',
        lecture_room_id bigint NOT NULL COMMENT '강의실 아이디',
        start_time TIME NOT NULL COMMENT '시작시간',
        end_time TIME NOT NULL COMMENT '종료시산',
        lecture_day VARCHAR(5) NOT NULL COMMENT '요일',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (lecture_detail_id),
        CONSTRAINT LECTURE_DETAIL_INFO_ix1 UNIQUE (lecture_detail_id),
        INDEX LECTURE_DETAIL_INFO_ix2 (lecture_room_id),
        INDEX LECTURE_DETAIL_INFO_ix3 (lecture_room_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='강의 관련 맵핑 테이블';
DROP TABLE
    LECTURE_INFO;
CREATE TABLE
    LECTURE_INFO
    (
        lecture_id bigint NOT NULL AUTO_INCREMENT COMMENT '강의 아이디',
        office_id bigint NOT NULL COMMENT '관 구분 코드',
        charge_member_id bigint NOT NULL COMMENT '담임 선생님 아이디',
        manage_member_id bigint COMMENT '관리 선생님 아이디',
        lecture_price_id bigint NOT NULL COMMENT '강의 금액',
        lecture_name VARCHAR(20) NOT NULL COMMENT '강의명',
        lecture_subject VARCHAR(10) NOT NULL COMMENT '강의 과목',
        school_type VARCHAR(10) NOT NULL,
        lecture_grade INT NOT NULL COMMENT '강의 학년',
        lecture_level VARCHAR(10) NOT NULL COMMENT '강의 레벨',
        lecture_operation_type VARCHAR(10) NOT NULL COMMENT '강의 운영형태(월,횟수)',
        lecture_start_date DATE NOT NULL COMMENT '강의시작월일',
        lecture_end_date DATE NOT NULL COMMENT '강의종료월일',
        lecture_limit_student INT NOT NULL COMMENT '강의 정원',
        lecture_status VARCHAR(10) NOT NULL COMMENT '개강/휴강/폐강',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        academy_group_id bigint unsigned NOT NULL,
        PRIMARY KEY (lecture_id),
        CONSTRAINT LECTURE_INFO_ix1 UNIQUE (lecture_id),
        INDEX LECTURE_INFO_ix2 (office_id),
        INDEX LECTURE_INFO_ix3 (charge_member_id),
        INDEX LECTURE_INFO_ix4 (manage_member_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='강의 정보 테이블';
DROP TABLE
    LECTURE_PAYMENT_MONTH;
CREATE TABLE
    LECTURE_PAYMENT_MONTH
    (
        lecture_payment_month_id bigint NOT NULL AUTO_INCREMENT,
        lecture_rel_id bigint NOT NULL,
        create_month VARCHAR(15) NOT NULL,
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
        PRIMARY KEY (lecture_payment_month_id),
        INDEX LECTURE_PAYMENT_MONTH_ix1 (lecture_rel_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE
    LECTURE_PRICE;
CREATE TABLE
    LECTURE_PRICE
    (
        lecture_price_id INT NOT NULL AUTO_INCREMENT COMMENT '강의 금액 아이디',
        lecture_price INT(10) unsigned NOT NULL COMMENT '금액',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (lecture_price_id),
        CONSTRAINT LECTURE_PRICE_ix1 UNIQUE (lecture_price_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='강의 가격 테이블';
DROP TABLE
    LECTURE_ROOM_INFO;
CREATE TABLE
    LECTURE_ROOM_INFO
    (
        lecture_room_id bigint NOT NULL AUTO_INCREMENT COMMENT '강의실 아이디',
        office_id bigint NOT NULL COMMENT '관 아이디',
        lecture_room_name VARCHAR(45) NOT NULL COMMENT '강의실 명',
        room_limit_student INT(5),
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (lecture_room_id),
        CONSTRAINT LECTURE_ROOM_INFO_ix1 UNIQUE (lecture_room_id),
        INDEX LECTURE_ROOM_INFO_ix2 (office_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE
    LECTURE_STUDENT_REL;
CREATE TABLE
    LECTURE_STUDENT_REL
    (
        lecture_rel_id bigint NOT NULL AUTO_INCREMENT COMMENT '아이디',
        lecture_id bigint NOT NULL COMMENT '강의 정보 아이디',
        student_id bigint NOT NULL COMMENT '학생 아이디',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        add_yn TINYINT(1) DEFAULT '1' NOT NULL,
        payment_price INT(10) unsigned DEFAULT '0' NOT NULL,
        payment_yn TINYINT(1) DEFAULT '0' NOT NULL,
        payment_date DATETIME,
        PRIMARY KEY (lecture_rel_id),
        CONSTRAINT LECTURE_STUDENT_REL_ix1 UNIQUE (lecture_rel_id),
        INDEX LECTURE_STUDENT_REL_ix2 (lecture_id),
        INDEX LECTURE_STUDENT_REL_ix3 (student_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='강의와 학생 연결 테이블';
DROP TABLE
    MAIN_MENU_AUTH;
CREATE TABLE
    MAIN_MENU_AUTH
    (
        main_menu_auth_id bigint NOT NULL AUTO_INCREMENT COMMENT '메인 메뉴 권한 아이디',
        main_menu_id INT NOT NULL COMMENT '메인메뉴 아이디',
        flow_member_id bigint NOT NULL COMMENT '회원 아이디',
        create_flow_member_id bigint NOT NULL COMMENT '권한을 입력한 회원아이디',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (main_menu_auth_id),
        INDEX MAIN_MENU_AUTH_ix1 (main_menu_id),
        INDEX MAIN_MENU_AUTH_ix2 (flow_member_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메인 메뉴 권한 테이블';
DROP TABLE
    MAIN_MENU_INFO;
CREATE TABLE
    MAIN_MENU_INFO
    (
        main_menu_id INT NOT NULL AUTO_INCREMENT COMMENT '메인메뉴 아이디',
        main_menu_name VARCHAR(20) NOT NULL COMMENT '메인메뉴 명',
        main_menu_sort INT NOT NULL COMMENT '메인메뉴 순서',
        PRIMARY KEY (main_menu_id),
        CONSTRAINT MAIN_MENU_INFO_ix1 UNIQUE (main_menu_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메인 메뉴 정의 테이블';
DROP TABLE
    OFFICE;
CREATE TABLE
    OFFICE
    (
        office_id bigint NOT NULL AUTO_INCREMENT COMMENT '자동증가값',
        office_name VARCHAR(255) NOT NULL COMMENT '관명',
        office_director_name VARCHAR(10) NOT NULL COMMENT '원장이름',
        office_tel_number VARCHAR(15) NOT NULL COMMENT '관 전화번호',
        zip_code INT(5) NOT NULL,
        office_address VARCHAR(100) NOT NULL COMMENT '주소',
        office_address_detail VARCHAR(100) NOT NULL,
        office_fax_number VARCHAR(40) NOT NULL COMMENT '팩스번호',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        academy_group_id INT(10) unsigned NOT NULL,
        office_memo text,
        certificate_file_name VARCHAR(50),
        certificate_file_url VARCHAR(50),
        reg_member_id bigint NOT NULL,
        PRIMARY KEY (office_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관 상세 정보 테이블';
DROP TABLE
    OFFICE_AUTH;
CREATE TABLE
    OFFICE_AUTH
    (
        office_auth_id bigint NOT NULL AUTO_INCREMENT COMMENT '관 권한 아이디',
        office_id bigint NOT NULL COMMENT '관 아이디',
        flow_member_id bigint NOT NULL COMMENT '회원 아이디',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (office_auth_id),
        INDEX OFFICE_ATUH_ix1 (office_id),
        INDEX OFFICE_ATUH_ix2 (flow_member_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관 권한 테이블';
DROP TABLE
    STUDENT;
CREATE TABLE
    STUDENT
    (
        student_id bigint NOT NULL AUTO_INCREMENT COMMENT '학생 아이디',
        student_name VARCHAR(15) NOT NULL COMMENT '학생 이름',
        student_password VARCHAR(255) NOT NULL COMMENT '학생 비밀번호',
        student_gender VARCHAR(10) NOT NULL COMMENT '학생 성별',
        student_birthday VARCHAR(15) NOT NULL COMMENT '학생 생일',
        home_tel_number VARCHAR(20) COMMENT '집 전화번호',
        student_phone_number VARCHAR(20) COMMENT '학생 전화번호',
        student_email VARCHAR(45) COMMENT '학생 이메일',
        school_name VARCHAR(10) COMMENT '학교 이름',
        school_type VARCHAR(10) NOT NULL COMMENT '학교 타입(초,중,고)',
        student_grade INT(2) NOT NULL COMMENT '학생 학년',
        student_photo_file VARCHAR(255) COMMENT '학생 사진 파일명',
        student_photo_url VARCHAR(45) COMMENT '학생 사진 파일 경로명',
        student_memo text COMMENT '학생 관련 메모',
        mother_name VARCHAR(15) NOT NULL COMMENT '학부모(모)이름',
        mother_phone_number VARCHAR(20) NOT NULL COMMENT '학부모(모)전화번호',
        father_name VARCHAR(15) COMMENT '학부모(부)이름',
        father_phone_number VARCHAR(20) COMMENT '학부모(부)전화번호',
        parent_password VARCHAR(255) COMMENT '학부모 비밀번호',
        etc_name VARCHAR(15),
        etc_phone_number VARCHAR(20),
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
        student_auth_key VARCHAR(15) NOT NULL,
        student_status VARCHAR(10) DEFAULT 'ATTEND' NOT NULL,
        office_id bigint(10) NOT NULL,
        bus_board_yn TINYINT(1) DEFAULT '0' NOT NULL,
        PRIMARY KEY (student_id),
        CONSTRAINT STUDENT_ix1 UNIQUE (student_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='학생 정보';
DROP TABLE
    STUDENT_BROTHER;
CREATE TABLE
    STUDENT_BROTHER
    (
        student_brother_id bigint NOT NULL AUTO_INCREMENT COMMENT '학생 형제 연관 아이디',
        brother_id bigint NOT NULL,
        student_id bigint NOT NULL COMMENT '형제의 학생 아이디',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (student_brother_id),
        CONSTRAINT STUDENT_BROTHER_ix2 UNIQUE (student_brother_id),
        INDEX STUDENT_BROTHER_ix1 (student_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='학생 형제 연관 테이블';
DROP TABLE
    STUDENT_MEMO;
CREATE TABLE
    STUDENT_MEMO
    (
        student_memo_id bigint NOT NULL AUTO_INCREMENT COMMENT '메모 아이디',
        student_id bigint NOT NULL COMMENT '학생 아이디',
        flow_member_id bigint NOT NULL COMMENT '작성자 아이디',
        memo_content VARCHAR(255) NOT NULL COMMENT '메모 내용',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        memo_type VARCHAR(20) NOT NULL,
        process_yn TINYINT(1) DEFAULT '0' NOT NULL,
        memo_title VARCHAR(100) NOT NULL,
        process_flow_member_id bigint NOT NULL,
        process_date DATETIME,
        PRIMARY KEY (student_memo_id),
        INDEX STUDENT_MEMO_ix1 (student_id),
        INDEX STUDENT_MEMO_ix2 (flow_member_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='학생 메모 저장';
DROP TABLE
    STUDENT_MEMO_REPLY;
CREATE TABLE
    STUDENT_MEMO_REPLY
    (
        student_memo_reply_id bigint NOT NULL AUTO_INCREMENT,
        student_memo_id bigint NOT NULL,
        flow_member_id bigint NOT NULL,
        reply_content VARCHAR(255) NOT NULL,
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
        delete_yn TINYINT(1) DEFAULT '0' NOT NULL,
        PRIMARY KEY (student_memo_reply_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE
    STUDENT_SIMPLE_MEMO;
CREATE TABLE
    STUDENT_SIMPLE_MEMO
    (
        student_simple_memo_id bigint NOT NULL AUTO_INCREMENT COMMENT '아이디',
        student_id bigint NOT NULL COMMENT '학생 아이디',
        flow_member_id bigint NOT NULL COMMENT '멤버 아이디',
        memo_content VARCHAR(255) NOT NULL COMMENT '메모내용',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (student_simple_memo_id),
        INDEX STUDENT_SIMPLE_MEMO_ix1 (student_id),
        INDEX STUDENT_SIMPLE_MEMO_ix2 (flow_member_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='심플 학생 메모 테이블';
DROP TABLE
    SUB_MENU_AUTH;
CREATE TABLE
    SUB_MENU_AUTH
    (
        sub_menu_auth_id bigint NOT NULL AUTO_INCREMENT COMMENT '서브메뉴 권한 아이디',
        sub_menu_id INT NOT NULL COMMENT '서브 메뉴 명',
        flow_member_id bigint NOT NULL COMMENT '회원 아이디',
        create_flow_member_id bigint NOT NULL COMMENT '권한을 입력한 회원아이디',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (sub_menu_auth_id),
        INDEX SUB_MENU_AUTH_ix1 (sub_menu_id),
        INDEX SUB_MENU_AUTH_ix2 (flow_member_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='서브 메뉴 권한 테이블';
DROP TABLE
    SUB_MENU_INFO;
CREATE TABLE
    SUB_MENU_INFO
    (
        sub_menu_id INT NOT NULL AUTO_INCREMENT COMMENT '서브 메뉴 아이디',
        sub_menu_name VARCHAR(25) NOT NULL COMMENT '서브 메뉴 명',
        sub_menu_sort INT NOT NULL COMMENT '서브 메뉴 순서',
        main_menu_id INT NOT NULL COMMENT '서브 메뉴의 메인 메뉴 아이디',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        PRIMARY KEY (sub_menu_id),
        CONSTRAINT SUB_MENU_INFO_ix1 UNIQUE (sub_menu_id),
        INDEX SUB_MENU_INFO_ix2 (main_menu_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='서브 메뉴 정보 테이블';
DROP TABLE
    TEAM_INFO;
CREATE TABLE
    TEAM_INFO
    (
        team_id INT NOT NULL AUTO_INCREMENT COMMENT '팀 아이디',
        team_name VARCHAR(15) NOT NULL COMMENT '팀 이름',
        PRIMARY KEY (team_id),
        CONSTRAINT FLOWEDU_TEAM_INFO_ix1 UNIQUE (team_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;
