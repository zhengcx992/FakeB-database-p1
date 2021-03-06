CREATE VIEW VIEW_ARE_FRIENDS AS
SELECT * 
FROM FRIENDS;

CREATE VIEW VIEW_PHOTO_INFORMATION AS
SELECT A.ALBUM_ID, A.ALBUM_OWNER_ID, A.COVER_PHOTO_ID, A.ALBUM_NAME, A.ALBUM_CREATED_TIME, A.ALBUM_MODIFIED_TIME, A.ALBUM_LINK, A.ALBUM_VISIBILITY, P.PHOTO_ID, P.PHOTO_CAPTION, P.PHOTO_CREATED_TIME, P.PHOTO_MODIFIED_TIME, P.PHOTO_LINK
FROM ALBUMS A FULL OUTER JOIN PHOTOS P
ON A.ALBUM_ID = P.ALBUM_ID;

CREATE VIEW VIEW_TAG_INFORMATION AS
SELECT *
FROM TAGS;

CREATE VIEW VIEW_EVENT_INFORMATION AS
SELECT E.EVENT_ID, E.EVENT_CREATOR_ID, E.EVENT_NAME, E.EVENT_TAGLINE, E.EVENT_DESCRIPTION, E.EVENT_HOST, E.EVENT_TYPE, E.EVENT_SUBTYPE, E.EVENT_ADDRESS, C.CITY_NAME, C.STATE_NAME, C.COUNTRY_NAME, E.EVENT_START_TIME, E.EVENT_END_TIME
FROM USER_EVENTS E LEFT JOIN CITIES C
ON E.EVENT_CITY_ID = C.CITY_ID;

CREATE VIEW VIEW_USER_INFORMATION (USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER, CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY, HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY, INSTITUTION_NAME, PROGRAM_YEAR, PROGRAM_CONCENTRATION, PROGRAM_DEGREE)AS
SELECT U.USER_ID, U.FIRST_NAME, U.LAST_NAME, U.YEAR_OF_BIRTH, U.MONTH_OF_BIRTH, U.DAY_OF_BIRTH, U.GENDER, CT.CITY_NAME, CT.STATE_NAME, CT.COUNTRY_NAME, HT.CITY_NAME, HT.STATE_NAME, HT.COUNTRY_NAME, P.INSTITUTION, E.PROGRAM_YEAR, P.CONCENTRATION, P.DEGREE
FROM USERS U 
LEFT JOIN USER_CURRENT_CITIES CURR ON U.USER_ID = CURR.USER_ID
LEFT JOIN CITIES CT ON CURR.CURRENT_CITY_ID = CT.CITY_ID
LEFT JOIN USER_HOMETOWN_CITIES HOME ON HOME.USER_ID = U.USER_ID
LEFT JOIN CITIES HT ON HOME.HOMETOWN_CITY_ID = HT.CITY_ID
LEFT JOIN EDUCATION E ON E.USER_ID = U.USER_ID
LEFT JOIN PROGRAMS P ON E.PROGRAM_ID = P.PROGRAM_ID;