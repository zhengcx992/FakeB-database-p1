INSERT INTO USERS(USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER) 
SELECT DISTINCT USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER 
FROM project1.PUBLIC_USER_INFORMATION;


INSERT INTO CITIES(CITY_NAME, STATE_NAME, COUNTRY_NAME) 
SELECT DISTINCT II.CURRENT_CITY, II.CURRENT_STATE, II.CURRENT_COUNTRY
FROM project1.PUBLIC_USER_INFORMATION II
UNION
SELECT DISTINCT I.HOMETOWN_CITY, I.HOMETOWN_STATE, I.HOMETOWN_COUNTRY
FROM project1.PUBLIC_USER_INFORMATION I
UNION
SELECT DISTINCT E.EVENT_CITY, E.EVENT_STATE, E.EVENT_COUNTRY
FROM project1.PUBLIC_EVENT_INFORMATION E;


INSERT INTO USER_CURRENT_CITIES(USER_ID, CURRENT_CITY_ID)
SELECT DISTINCT I.USER_ID, C.CITY_ID
FROM project1.PUBLIC_USER_INFORMATION I JOIN CITIES C
ON I.CURRENT_CITY = C.CITY_NAME
AND I.CURRENT_STATE = C.STATE_NAME
AND I.CURRENT_COUNTRY = C.COUNTRY_NAME;


INSERT INTO USER_HOMETOWN_CITIES(USER_ID, HOMETOWN_CITY_ID)
SELECT DISTINCT I.USER_ID, C.CITY_ID
FROM project1.PUBLIC_USER_INFORMATION I JOIN CITIES C
ON I.HOMETOWN_CITY = C.CITY_NAME
AND I.HOMETOWN_STATE = C.STATE_NAME
AND I.HOMETOWN_COUNTRY = C.COUNTRY_NAME;


INSERT INTO PROGRAMS(INSTITUTION, CONCENTRATION, DEGREE) 
SELECT DISTINCT INSTITUTION_NAME, PROGRAM_CONCENTRATION, PROGRAM_DEGREE
FROM project1.PUBLIC_USER_INFORMATION
WHERE INSTITUTION_NAME IS NOT NULL;

INSERT INTO EDUCATION(USER_ID, PROGRAM_ID, PROGRAM_YEAR)
SELECT DISTINCT I.USER_ID, P.PROGRAM_ID, I.PROGRAM_YEAR
FROM project1.PUBLIC_USER_INFORMATION I JOIN PROGRAMS P
ON I.INSTITUTION_NAME = P.INSTITUTION
AND I.PROGRAM_CONCENTRATION = P.CONCENTRATION
AND I.PROGRAM_DEGREE = P.DEGREE;

INSERT INTO FRIENDS(USER1_ID, USER2_ID) 
SELECT DISTINCT USER1_ID, USER2_ID
FROM project1.PUBLIC_ARE_FRIENDS;

SET AUTOCOMMIT OFF;

INSERT INTO ALBUMS(ALBUM_ID, ALBUM_OWNER_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, COVER_PHOTO_ID) 
SELECT DISTINCT ALBUM_ID, OWNER_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, COVER_PHOTO_ID
FROM project1.PUBLIC_PHOTO_INFORMATION;


INSERT INTO PHOTOS(PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK) 
SELECT DISTINCT PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK
FROM project1.PUBLIC_PHOTO_INFORMATION;

COMMIT;

SET AUTOCOMMIT ON;

INSERT INTO TAGS(TAG_PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X, TAG_Y) 
SELECT DISTINCT PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE
FROM project1.PUBLIC_TAG_INFORMATION;


INSERT INTO USER_EVENTS(EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_ADDRESS, EVENT_CITY_ID, EVENT_START_TIME, EVENT_END_TIME) 
SELECT DISTINCT E.EVENT_ID, E.EVENT_CREATOR_ID, E.EVENT_NAME, E.EVENT_TAGLINE, E.EVENT_DESCRIPTION, E.EVENT_HOST, E.EVENT_TYPE, E.EVENT_SUBTYPE, E.EVENT_ADDRESS, C.CITY_ID, E.EVENT_START_TIME, E.EVENT_END_TIME
FROM project1.PUBLIC_EVENT_INFORMATION E JOIN CITIES C
ON E.EVENT_CITY = C.CITY_NAME
AND E.EVENT_STATE = C.STATE_NAME
AND E.EVENT_COUNTRY = C.COUNTRY_NAME;