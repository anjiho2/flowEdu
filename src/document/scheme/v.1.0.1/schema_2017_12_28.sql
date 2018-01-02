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
        team_id INT COMMENT '팀 아이디',
        phone_number VARCHAR(20) NOT NULL COMMENT '로그인 전화번호 사용',
        member_password VARCHAR(255) NOT NULL COMMENT '비밀번호',
        member_name VARCHAR(10) NOT NULL COMMENT '이름',
        member_birthday VARCHAR(15) NOT NULL COMMENT '생년월일',
        member_address VARCHAR(100) NOT NULL COMMENT '주소',
        member_email VARCHAR(45) NOT NULL COMMENT '이메일',
        sexual_assult_confirm_date DATE COMMENT '성범죄경력조회 확인일자',
        education_reg_date DATE COMMENT '교육정 강사등록일자',
        member_type VARCHAR(20) NOT NULL COMMENT '운영자, 선생님인지 구분',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        job_position_id INT,
        PRIMARY KEY (flow_member_id),
        CONSTRAINT FLOWEDU_MEMBER_ix1 UNIQUE (flow_member_id),
        INDEX FLOWEDU_MEMBER_ix2 (office_id),
        INDEX FLOWEDU_MEMBER_ix3 (team_id)
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
        attend_start_time VARCHAR(10) NOT NULL,
        attend_end_time VARCHAR(10),
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
        manage_member_id bigint NOT NULL COMMENT '관리 선생님 아이디',
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
        PRIMARY KEY (lecture_id),
        CONSTRAINT LECTURE_INFO_ix1 UNIQUE (lecture_id),
        INDEX LECTURE_INFO_ix2 (office_id),
        INDEX LECTURE_INFO_ix3 (charge_member_id),
        INDEX LECTURE_INFO_ix4 (manage_member_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='강의 정보 테이블';
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
    OFFICE;
CREATE TABLE
    OFFICE
    (
        office_id bigint NOT NULL AUTO_INCREMENT COMMENT '자동증가값',
        office_name VARCHAR(255) NOT NULL COMMENT '관명',
        office_director_name VARCHAR(10) NOT NULL COMMENT '원장이름',
        office_tel_number VARCHAR(15) NOT NULL COMMENT '관 전화번호',
        office_address VARCHAR(100) NOT NULL COMMENT '주소',
        office_fax_number VARCHAR(40) NOT NULL COMMENT '팩스번호',
        create_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일',
        academy_group_id INT(10) unsigned NOT NULL,
        PRIMARY KEY (office_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관 상세 정보 테이블';
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
        PRIMARY KEY (student_id),
        CONSTRAINT STUDENT_ix1 UNIQUE (student_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='학생 정보';
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
