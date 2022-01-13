> 모델링 주소 : https://aquerytool.com/aquerymain/index/?rurl=d08471a4-2100-4115-9c1b-abf30143a7a1
  모델링 암호 : ktirs2

-------------------------------------------------------
(오라클에서 트리거가 작동하는 원리)


-- t_shop Table Create SQL
CREATE TABLE t_shop
(
    shop_seq          NUMBER(15, 0)     NOT NULL, 
    shop_addr         VARCHAR2(200)     NOT NULL, 
    shop_latitude     NUMBER(17, 14)    NOT NULL, 
    shop_longitude    NUMBER(17, 14)    NOT NULL, 
    shop_tel          VARCHAR2(20)      NOT NULL, 
    shop_ceo          VARCHAR2(20)      NOT NULL, 
    user_id           VARCHAR2(20)      NOT NULL, 
     PRIMARY KEY (shop_seq)
)
/

CREATE SEQUENCE t_shop_SEQ
START WITH 1
INCREMENT BY 1;
/

t_shop_SEQ.CURRVAL : 0
t_shop_SEQ.NEXTVAL : 1

CREATE OR REPLACE TRIGGER t_shop_AI_TRG
BEFORE INSERT ON t_shop 
REFERENCING NEW AS N3 FOR EACH ROW 
BEGIN 
    SELECT t_shop_SEQ.NEXTVAL
    INTO :N3.shop_seq
    FROM DUAL;
END;
/

insert into t_shop 
(shop_seq, shop_addr, shop_latitude, shop_longitude, shop_tel, shop_ceo, user_id)
(1, 'shop_addr 1', 1, 1, 'shop_tel 1', 'shop_ceo 1', 'user_id 1'); <--- :NEW



(데이터베이스 최종 쿼리문)

-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- t_user Table Create SQL
CREATE TABLE t_user
(
    user_id      VARCHAR2(20)    NOT NULL, 
    user_pw      VARCHAR2(20)    NOT NULL, 
    user_shop    VARCHAR2(50)    NOT NULL, 
     PRIMARY KEY (user_id)
)
/

COMMENT ON TABLE t_user IS '상점 주인 정보 테이블'
/

COMMENT ON COLUMN t_user.user_id IS '사용자 아이디'
/

COMMENT ON COLUMN t_user.user_pw IS '사용자 비밀번호'
/

COMMENT ON COLUMN t_user.user_shop IS '사용자 무인점포명'
/


-- t_shop Table Create SQL
CREATE TABLE t_shop
(
    shop_seq          NUMBER(15, 0)     NOT NULL, 
    shop_addr         VARCHAR2(200)     NOT NULL, 
    shop_latitude     NUMBER(17, 14)    NOT NULL, 
    shop_longitude    NUMBER(17, 14)    NOT NULL, 
    shop_tel          VARCHAR2(20)      NOT NULL, 
    shop_ceo          VARCHAR2(20)      NOT NULL, 
    user_id           VARCHAR2(20)      NOT NULL, 
     PRIMARY KEY (shop_seq)
)
/

CREATE SEQUENCE t_shop_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER t_shop_AI_TRG
BEFORE INSERT ON t_shop 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT t_shop_SEQ.NEXTVAL
    INTO :NEW.shop_seq
    FROM DUAL;

    INSERT INTO 
    INTO :NEW.shop_seq
    FROM DUAL;
END;
/

--DROP TRIGGER t_shop_AI_TRG;
/

--DROP SEQUENCE t_shop_SEQ;
/

COMMENT ON TABLE t_shop IS '무인 상점 정보 테이블'
/

COMMENT ON COLUMN t_shop.shop_seq IS '상점 순번'
/

COMMENT ON COLUMN t_shop.shop_addr IS '상점 주소'
/

COMMENT ON COLUMN t_shop.shop_latitude IS '상점 위도'
/

COMMENT ON COLUMN t_shop.shop_longitude IS '상점 경도'
/

COMMENT ON COLUMN t_shop.shop_tel IS '상점 전화번호'
/

COMMENT ON COLUMN t_shop.shop_ceo IS '상점 대표자'
/

COMMENT ON COLUMN t_shop.user_id IS '상점 주인 아이디'
/

ALTER TABLE t_shop
    ADD CONSTRAINT FK_t_shop_user_id_t_user_user_ FOREIGN KEY (user_id)
        REFERENCES t_user (user_id)
/


-- t_entrance Table Create SQL
CREATE TABLE t_entrance
(
    ent_object_id    VARCHAR2(50)     NOT NULL, 
    ent_kind         VARCHAR2(1)      NOT NULL, 
    ent_time         DATE             NOT NULL, 
    ent_face_img     VARCHAR2(200)    NOT NULL, 
    user_id          VARCHAR2(20)     NOT NULL, 
    shop_seq         NUMBER(15, 0)    NOT NULL, 
     PRIMARY KEY (ent_object_id)
)
/

COMMENT ON TABLE t_entrance IS '출입 기록 관리 테이블'
/

COMMENT ON COLUMN t_entrance.ent_object_id IS '출입 객체 아이디'
/

COMMENT ON COLUMN t_entrance.ent_kind IS '출입 구분'
/

COMMENT ON COLUMN t_entrance.ent_time IS '출입 시간'
/

COMMENT ON COLUMN t_entrance.ent_face_img IS '출입 얼굴사진'
/

COMMENT ON COLUMN t_entrance.user_id IS '관리자 아이디'
/

COMMENT ON COLUMN t_entrance.shop_seq IS '상점 순번'
/

ALTER TABLE t_entrance
    ADD CONSTRAINT FK_t_entrance_user_id_t_user_u FOREIGN KEY (user_id)
        REFERENCES t_user (user_id)
/

ALTER TABLE t_entrance
    ADD CONSTRAINT FK_t_entrance_shop_seq_t_shop_ FOREIGN KEY (shop_seq)
        REFERENCES t_shop (shop_seq)
/


-- t_detection Table Create SQL
CREATE TABLE t_detection
(
    detection_seq    NUMBER(15, 0)    NOT NULL, 
    detection_tim    DATE             DEFAULT SYSDATE NOT NULL, 
    situation_img    VARCHAR2(200)    NOT NULL, 
    face_img         VARCHAR2(200)    NOT NULL, 
    user_id          VARCHAR2(20)     NOT NULL, 
    shop_seq         NUMBER(15, 0)    NOT NULL, 
    ent_object_id    VARCHAR2(50)     NOT NULL, 
     PRIMARY KEY (detection_seq)
)
/

CREATE SEQUENCE t_detection_SEQ
START WITH 1   
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER t_detection_AI_TRG
BEFORE INSERT ON t_detection 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT t_detection_SEQ.NEXTVAL
    INTO :NEW.detection_seq
    FROM DUAL;
END;
/





--DROP TRIGGER t_detection_AI_TRG;
/

--DROP SEQUENCE t_detection_SEQ;
/

COMMENT ON TABLE t_detection IS '행위 탐지 테이블'
/

COMMENT ON COLUMN t_detection.detection_seq IS '탐지 순번'
/

COMMENT ON COLUMN t_detection.detection_tim IS '탐지 시간'
/

COMMENT ON COLUMN t_detection.situation_img IS '상황사진 경로'
/

COMMENT ON COLUMN t_detection.face_img IS '얼굴이미지 경로'
/

COMMENT ON COLUMN t_detection.user_id IS '관리자 아이디'
/

COMMENT ON COLUMN t_detection.shop_seq IS '상점 순번'
/

COMMENT ON COLUMN t_detection.ent_object_id IS '출입 객체 아이디'
/

ALTER TABLE t_detection
    ADD CONSTRAINT FK_t_detection_user_id_t_user_ FOREIGN KEY (user_id)
        REFERENCES t_user (user_id)
/

ALTER TABLE t_detection
    ADD CONSTRAINT FK_t_detection_shop_seq_t_shop FOREIGN KEY (shop_seq)
        REFERENCES t_shop (shop_seq)
/

ALTER TABLE t_detection
    ADD CONSTRAINT FK_t_detection_ent_object_id_t FOREIGN KEY (ent_object_id)
        REFERENCES t_entrance (ent_object_id)
/


-- t_object Table Create SQL
CREATE TABLE t_object
(
    item_seq         NUMBER(15, 0)    NOT NULL, 
    detection_seq    NUMBER(15, 0)    NOT NULL, 
    item_name        VARCHAR2(50)     NOT NULL, 
    item_cnt         NUMBER(15, 0)    NOT NULL, 
     PRIMARY KEY (item_seq)
)
/

CREATE SEQUENCE t_object_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER t_object_AI_TRG
BEFORE INSERT ON t_object 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT t_object_SEQ.NEXTVAL
    INTO :NEW.item_seq
    FROM DUAL;
END;
/

--DROP TRIGGER t_object_AI_TRG;
/

--DROP SEQUENCE t_object_SEQ;
/

COMMENT ON TABLE t_object IS '물품 정보 테이블'
/

COMMENT ON COLUMN t_object.item_seq IS '물품 순번'
/

COMMENT ON COLUMN t_object.detection_seq IS '탐지 순번'
/

COMMENT ON COLUMN t_object.item_name IS '물품 명'
/

COMMENT ON COLUMN t_object.item_cnt IS '물품 수량'
/

ALTER TABLE t_object
    ADD CONSTRAINT FK_t_object_detection_seq_t_de FOREIGN KEY (detection_seq)
        REFERENCES t_detection (detection_seq)
/



-------------------------------------------------------------
(백앤드 개발자 쿼리문)

-- Insert
INSERT INTO t_user
    (user_id, 
    user_pw, 
    user_shop)
VALUES
    ('user_id 1', 
    'user_pw 1', 
    'user_shop 1');

-- Insert된 Row의 Auto Increment값 조회
SELECT t_user_SEQ.CURRVAL FROM DUAL;

-- Update
UPDATE t_user
SET
    user_id = 'user_id 1', 
    user_pw = 'user_pw 1', 
    user_shop = 'user_shop 1'
WHERE user_id = 'user_id 1';

-- Delete
DELETE FROM t_user
WHERE user_id = 'user_id 1';

-- 1일이 지난 데이터 삭제
DELETE FROM t_user
WHERE <date_column> < SYSDATE - 1;


-- 테이블 복사/백업
CREATE TABLE t_user_20220113_114837 AS 
SELECT * FROM t_user;

-- 백업 테이블에서 원본 테이블로 데이터 복사(Auto Increment 컬럼 제외)
INSERT INTO t_user 
    (user_id, user_pw, user_shop)
SELECT user_id, user_pw, user_shop 
FROM t_user_20220113_114837;


-- 테이블 ROW 갯수 확인
SELECT count(*) 
FROM t_user;

-- 조건에 맞는 ROW 조회
SELECT user_id, user_pw, user_shop
FROM t_user
WHERE user_id = 'user_id 1';

-- 모든 컬럼 PK기준 역순으로 조회
SELECT user_id, user_pw, user_shop
FROM t_user
ORDER BY user_id DESC;

-- 모든 컬럼 100건 조회 - 일반정렬
SELECT user_id, user_pw, user_shop
FROM t_user
WHERE ROWNUM <= 100;

-- 모든 컬럼 100건 조회 - 역순정렬
SELECT user_id, user_pw, user_shop
FROM (
    SELECT ROW_NUMBER() OVER (ORDER BY user_id DESC) AS rn, 
        user_id, user_pw, user_shop
    FROM t_user)
WHERE rn <= 100;

-- SELECT 값에 따라 수정된 다른 값을 출력
SELECT user_id, 
    CASE
        WHEN user_pw = 'A' THEN CONCAT(user_pw, 'Type1')
        WHEN user_pw = 'B' THEN CONCAT(user_pw, 'Type2')
        WHEN user_pw = 'C' THEN CONCAT(user_pw, 'Type3')
        ELSE CONCAT(user_pw, 'Type4') END AS user_pwType, 
    user_shop
FROM t_user;

-- 특정 컬럼 중복 제거
SELECT DISTINCT user_pw
FROM t_user;

-- Group By 문과 Having문을 이용하여 Select
SELECT user_pw, AVG(<number_column>)
FROM t_user
GROUP BY user_pw
HAVING AVG(<number_column>) > 50;

-- 날짜 범위에 해당하는 ROW를 조회
SELECT user_id, user_pw, user_shop
FROM t_user
WHERE <date_column> BETWEEN 
    TO_DATE('2015-10-01 23:59:59','yyyy/mm/dd hh24:mi:ss') AND 
    TO_DATE('2015-11-30 23:59:59','yyyy/mm/dd hh24:mi:ss');
-- 또는 WHERE <date_column> BETWEEN '2015-10-01' AND '2015-11-30';

-- 날짜별 통계
SELECT TO_CHAR(<date_column>, 'yyyy-mm-dd') AS <date_column>, COUNT(*) count
FROM t_user
GROUP BY TO_CHAR(<date_column>, 'yyyy-mm-dd')
ORDER BY <date_column> DESC;

-- Paging을 이용한 Select - 역순정렬 Type 1
SELECT user_id, user_pw, user_shop
FROM (
    SELECT ROWNUM AS rn,
        user_id, user_pw, user_shop
    FROM t_user
    ORDER BY user_id DESC)
WHERE rn >= 1 AND rownum <= 10;
-- WHERE 절에서 1은 조회 시작 Row 번호(1부터 시작), 10은 한 페이지에 가져올 Row 수
-- WHERE rn >= [((PageNumber - 1) * RowsPerPage) + 1] AND rownum [RowsPerPage]
-- RowsPerPage : 한 페이지에 가져올 Row 수
-- PageNumber  : 가져올 페이지 번호

-- Paging을 이용한 Select - 역순정렬 Type 2
SELECT user_id, user_pw, user_shop
FROM (
    SELECT ROW_NUMBER() OVER(ORDER BY user_id DESC) RN, 
        user_id, user_pw, user_shop
    FROM t_user) 
WHERE RN BETWEEN 101 AND 110;
-- WHERE에서 101은 조회 시작 Row 번호(1부터 시작), 110은 조회 마지막 Row 번호
-- WHERE RN BETWEEN [((PageNumber - 1) * RowsPerPage) + 1] AND [((PageNumber - 1) * RowsPerPage) + RowsPerPage]
-- RowsPerPage : 한 페이지에 가져올 Row 수
-- PageNumber  : 가져올 페이지 번호


-- Inner Join을 이용한 조회
SELECT u.user_id, u.user_pw, u.user_shop, 
    d.ent_object_id, d.shop_seq, d.user_id, d.detection_seq, d.detection_tim, d.situation_img, d.face_img, 
    e.shop_seq, e.user_id, e.ent_object_id, e.ent_kind, e.ent_time, e.ent_face_img, 
    s.user_id, s.shop_seq, s.shop_addr, s.shop_latitude, s.shop_longitude, s.shop_tel, s.shop_ceo
FROM t_user u 
    INNER JOIN t_detection d ON u.user_id = d.user_id
    INNER JOIN t_entrance e ON u.user_id = e.user_id AND d.ent_object_id = e.ent_object_id
    INNER JOIN t_shop s ON u.user_id = s.user_id AND d.shop_seq = s.shop_seq AND e.shop_seq = s.shop_seq
WHERE u.user_id = 'user_id 1' AND ROWNUM <= 100;

-- Outer Join을 이용한 조회
SELECT u.user_id, u.user_pw, u.user_shop, 
    d.ent_object_id, d.shop_seq, d.user_id, d.detection_seq, d.detection_tim, d.situation_img, d.face_img, 
    e.shop_seq, e.user_id, e.ent_object_id, e.ent_kind, e.ent_time, e.ent_face_img, 
    s.user_id, s.shop_seq, s.shop_addr, s.shop_latitude, s.shop_longitude, s.shop_tel, s.shop_ceo
FROM t_user u 
    LEFT OUTER JOIN t_detection d ON u.user_id = d.user_id
    LEFT OUTER JOIN t_entrance e ON u.user_id = e.user_id AND d.ent_object_id = e.ent_object_id
    LEFT OUTER JOIN t_shop s ON u.user_id = s.user_id AND d.shop_seq = s.shop_seq AND e.shop_seq = s.shop_seq
WHERE u.user_id = 'user_id 1' AND ROWNUM <= 100;

-- 해당 테이블을 참조하는 테이블의 최신 Row만 조회
SELECT u.user_id, u.user_pw, u.user_shop, 
    d.ent_object_id, d.shop_seq, d.user_id, d.detection_seq, d.detection_tim, d.situation_img, d.face_img, 
    e.shop_seq, e.user_id, e.ent_object_id, e.ent_kind, e.ent_time, e.ent_face_img, 
    s.user_id, s.shop_seq, s.shop_addr, s.shop_latitude, s.shop_longitude, s.shop_tel, s.shop_ceo
FROM t_user u 
    LEFT OUTER JOIN t_detection d ON u.user_id = d.user_id
    LEFT OUTER JOIN t_entrance e ON u.user_id = e.user_id AND d.ent_object_id = e.ent_object_id
    LEFT OUTER JOIN t_shop s ON u.user_id = s.user_id AND d.shop_seq = s.shop_seq AND e.shop_seq = s.shop_seq
    -- t_shop 테이블의 마지막 Row만 조회 하기 위한 JOIN
    LEFT OUTER JOIN t_shop s_lastrow ON 
        (u.user_id = s_lastrow.user_id AND s.shop_seq < s_lastrow.shop_seq)
WHERE u.user_id = 'user_id 1' AND 
    -- t_shop 테이블의 마지막 Row만 조회 하기 위한 WHERE
    s_lastrow.shop_seq IS NULL AND ROWNUM <= 100;

-- t_user 테이블을 참조하는 테이블의 Row 수 구하기
SELECT u.user_id, u.user_pw, u.user_shop, 
    d.ent_object_id, d.shop_seq, d.user_id, d.detection_seq, d.detection_tim, d.situation_img, d.face_img, 
    e.shop_seq, e.user_id, e.ent_object_id, e.ent_kind, e.ent_time, e.ent_face_img, 
    s.user_id, s.shop_seq, s.shop_addr, s.shop_latitude, s.shop_longitude, s.shop_tel, s.shop_ceo, 
    s_count.row_count
FROM t_user u 
    LEFT OUTER JOIN t_detection d ON u.user_id = d.user_id
    LEFT OUTER JOIN t_entrance e ON u.user_id = e.user_id AND d.ent_object_id = e.ent_object_id
    LEFT OUTER JOIN t_shop s ON u.user_id = s.user_id AND d.shop_seq = s.shop_seq AND e.shop_seq = s.shop_seq
    -- t_shop Row 수 구하기
    LEFT OUTER JOIN
        (SELECT user_id, COUNT(user_id) AS row_count
         FROM t_shop
         GROUP BY user_id) s_count
    ON u.user_id = s_count.user_id
ORDER BY u.user_id DESC;

------------------------------------------------------------
> 트리거를 이용한 테이블 값 자동 생성 

INSERT INTO t_shop (shop_addr, shop_latitude, shop_longitude, shop_tel, shop_ceo, user_id) VALUES ('shop_addr 1', 1, 1, 'shop_tel 1', 'shop_ceo 1', 'user_id 1');

CREATE OR REPLACE TRIGGER t_shop_AI_TRG2
AFTER INSERT ON t_user 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    INSERT INTO t_shop(shop_addr, shop_latitude, shop_longitude, shop_tel, shop_ceo, user_id)
    VALUES ('ABCD', 30.113243241324,130.4350293452, '000-000', '홍길동', :NEW.user_id);
END;
/
-----------------------------------------------------------------------------------

스마트인재개발원 멘토 김광진 : router128@hanmail.net 

