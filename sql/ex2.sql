-- Please note that for our database this is the schema we used in order to be able to use filldb.info
-- we can improve this schema in a couple ways!
-- location_province VARCHAR(32) NOT NULL enum {'Alberta', 'British Columbia', 'Manitoba', 'New Brunswick', 'Newfoundland and Labrador', 'Northwest Territories', 'Nova Scotia', 'Nunavut', 'Ontario', 'Prince Edward Island', 'Quebec', 'Saskatchewan', 'Yukon' }
-- The filldb.info filled the provinces with USA states


CREATE TABLE Location (
    location_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    location_province VARCHAR(32) NOT NULL,
    location_city VARCHAR(32) NOT NULL,
    location_streetAddress VARCHAR(32) NOT NULL UNIQUE,
    PRIMARY KEY (location_ID)
);

CREATE TABLE Studio (
    studio_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    studio_name VARCHAR(32) NOT NULL UNIQUE,
    location_ID INT UNSIGNED NOT NULL,
    PRIMARY KEY (studio_ID),
    FOREIGN KEY (location_ID)
        REFERENCES Location (location_ID)
);

CREATE TABLE Genre (
    genre_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    genre_type VARCHAR(32) NOT NULL UNIQUE,
    PRIMARY KEY (genre_ID)
);

CREATE TABLE Hashtag (
    hashtag_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hashtag VARCHAR(32) NOT NULL UNIQUE,
    PRIMARY KEY (hashtag_ID)
);

CREATE TABLE ClientProfile (
    client_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    client_fName VARCHAR(32) NOT NULL,
    client_lNAme VARCHAR(32) NOT NULL,
    client_phoneNumber INT UNSIGNED,
    client_email VARCHAR(64) NOT NULL UNIQUE,
    client_password VARCHAR(64) NOT NULL,
    PRIMARY KEY (client_ID)
);

CREATE TABLE ArtistProfile (
    artist_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    studio_ID INT UNSIGNED NOT NULL,
    artist_rate SMALLINT,
    artist_bio VARCHAR(256),
    artist_fName VARCHAR(32) NOT NULL,
    artist_lName VARCHAR(32) NOT NULL,
    artist_phoneNumber INT UNSIGNED NOT NULL,
    artist_email VARCHAR(64) NOT NULL UNIQUE,
    artist_password VARCHAR(128) NOT NULL,
    PRIMARY KEY (artist_ID),
    FOREIGN KEY (studio_ID)
        REFERENCES Studio (studio_ID)
);

CREATE TABLE Preference (
    client_ID INT UNSIGNED NOT NULL,
    genre_ID INT UNSIGNED NOT NULL,
    location_ID INT UNSIGNED NOT NULL,
    PRIMARY KEY (client_ID),
    FOREIGN KEY (client_ID)
        REFERENCES ClientProfile (client_ID),
    FOREIGN KEY (genre_ID)
        REFERENCES Genre (genre_ID),
    FOREIGN KEY (location_ID)
        REFERENCES Location (location_ID)
);

CREATE TABLE Tattoos (
    tattoo_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    artist_ID INT UNSIGNED NOT NULL,
    tattoo_date DATE NOT NULL,
    tattoo_imagePath VARCHAR(512) NOT NULL UNIQUE,
    genre_ID INT UNSIGNED NOT NULL,
    PRIMARY KEY (tattoo_ID),
    FOREIGN KEY (artist_ID)
        REFERENCES ArtistProfile (artist_ID),
    FOREIGN KEY (genre_ID)
        REFERENCES Genre (genre_ID)
);

CREATE TABLE Hashtagging (
    hashtag_ID INT UNSIGNED NOT NULL,
    tattoo_ID INT UNSIGNED NOT NULL,
    PRIMARY KEY (hashtag_ID , tattoo_ID),
    FOREIGN KEY (hashtag_ID)
        REFERENCES Hashtag (hashtag_ID),
    FOREIGN KEY (tattoo_ID)
        REFERENCES Tattoos (tattoo_ID)
);

CREATE TABLE Following (
    client_ID INT UNSIGNED NOT NULL,
    artist_ID INT UNSIGNED NOT NULL,
    follow_date DATE NOT NULL,
    PRIMARY KEY (client_ID , artist_ID),
    FOREIGN KEY (client_ID)
        REFERENCES ClientProfile (client_ID),
    FOREIGN KEY (artist_ID)
        REFERENCES ArtistProfile (artist_ID)
);

CREATE TABLE Liking (
    client_ID INT UNSIGNED NOT NULL,
    tattoo_ID INT UNSIGNED NOT NULL,
    like_date DATE NOT NULL,
    PRIMARY KEY (client_ID , tattoo_ID),
    FOREIGN KEY (client_ID)
        REFERENCES ClientProfile (client_ID),
    FOREIGN KEY (tattoo_ID)
        REFERENCES Tattoos (tattoo_id)
);

CREATE TABLE ArtistGenre (
    artist_ID INT UNSIGNED NOT NULL,
    genre_ID INT UNSIGNED NOT NULL,
    PRIMARY KEY (artist_ID , genre_ID),
    FOREIGN KEY (artist_ID)
        REFERENCES ArtistProfile (artist_ID),
    FOREIGN KEY (genre_ID)
        REFERENCES Genre (genre_ID)
)



