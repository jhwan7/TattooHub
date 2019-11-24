-- Aritist contact info
CREATE VIEW ArtistContact AS
    SELECT 
        Artist_Studio.artist_fName,
        Artist_Studio.artist_lName,
        Artist_Studio.artist_phoneNumber,
        Artist_Studio.artist_email,
        Artist_Studio.studio_name,
        Studio_Location.location_province,
        Studio_Location.location_city,
        Studio_Location.location_streetAddress
    FROM
        (SELECT 
            a.artist_fName,
                a.artist_lName,
                a.artist_phoneNumber,
                a.artist_email,
                s.studio_name,
                s.location_ID
        FROM
            ArtistProfile a
        INNER JOIN Studio s ON a.studio_ID = s.studio_ID) AS Artist_Studio
            INNER JOIN
        (SELECT 
            l.location_province,
                l.location_city,
                l.location_streetAddress,
                s.location_ID
        FROM
            Studio s
        INNER JOIN Location l ON s.location_ID = l.location_ID) AS Studio_Location ON Artist_Studio.location_ID = Studio_Location.location_ID;

-- View of all the artists that the client is following
-- Assuming we have the client_ID
CREATE VIEW clientFollows AS
    SELECT 
        ArtistProfile.artist_fName,
        ArtistProfile.artist_lName,
        ArtistProfile.artist_email
    FROM
        (SELECT 
            c.client_ID, f.artist_ID
        FROM
            ClientProfile c
        INNER JOIN FOLLOWING f ON c.client_ID = f.client_ID) AS Client_Follow
            INNER JOIN
        ArtistProfile ON Client_Follow.artist_ID = ArtistProfile.artist_ID
    WHERE
        Client_Follow.client_ID = 1;

-- View Studios in your province/state
-- Assume city choice has been specified
CREATE VIEW locationchoice AS
    SELECT 
        s.studio_name, l.location_city
    FROM
        Studio s
            INNER JOIN
        Location l ON s.location_ID = l.location_ID
    WHERE
        l.location_province = 'CA';