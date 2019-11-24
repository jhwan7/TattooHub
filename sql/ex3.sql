-- filling using column indexing
INSERT INTO Genre (genre_type) VALUES ('traditional');
INSERT INTO Genre (genre_type) VALUES ('realism');

-- filling in without column
INSERT INTO Location VALUES (null, 'Ontario', 'London', '152 John Street');
INSERT INTO Location VALUES (null, 'Ontario', 'London', '102 Talbot Street');

INSERT INTO Studio  VALUES (null, 'Red Door', 1);
INSERT INTO Studio VALUES (null, 'Good Point', 2);

INSERT INTO ArtistProfile VALUES (null, 1, null, null, 'Mathieu', 'Girard', 2896810310, 'mgirar3@uwo.ca', 'user123');
INSERT INTO ArtistProfile VALUES (null, 2, null, null, 'Hailey', 'Prod', 2892293310, 'hproud@uwo.ca', 'user123');

INSERT INTO ClientProfile VALUES (null, 'Ewhan', 'Han', 2055108750, 'ehan@uwo.ca', 'client123');
INSERT INTO ClientProfile VALUES (null, 'Alex', 'Hwang', 3055108750, 'ahwang10@uwo.ca', 'client123');
INSERT INTO ClientProfile VALUES (null, 'Ryan', 'Newman', 1055108750, 'ehan@uwo.ca', 'client123');
INSERT INTO ClientProfile VALUES (null, 'Dimitar', 'Dimitrov', 1056108750, 'ehan@uwo.ca', 'client123');
INSERT INTO ClientProfile VALUES (null, 'Martin', 'Dimitrov', 2015108750, 'ehan@uwo.ca', 'client123');
INSERT INTO ClientProfile VALUES (null, 'Danika', 'Brooks', 2047108750, 'ehan@uwo.ca', 'client123');

INSERT INTO Following VALUES (1, 1);
INSERT INTO Following VALUES (2, 1);
INSERT INTO Following VALUES (3, 1);
INSERT INTO Following VALUES (4, 1);
INSERT INTO Following VALUES (4, 2);
INSERT INTO Following VALUES (5, 2);
INSERT INTO Following VALUES (6, 2);

-- Insert into following the client and artist information
-- Motivation: when a client follows an artist, create an instance of the client following the artist
-- Assumption: we know the client_ID and the artist_email
INSERT INTO Following 
    SELECT CP.client_ID, AP.artist_ID, CURDATE()
    FROM ClientProfile CP, ArtistProfile AP
    WHERE CP.client_ID = '1' AND AP.artist_email = 'alene31@example.net'