-- Change client profile information
-- Specifically, the client's email
-- Motivation: client can change their username/email to a new one

UPDATE ClientProfile
SET client_email = 'ervin.lakin@gmail.com'
where client_email = 'amir.kassulke@example.com'

--Delete the follows of an artist that a client follows
-- Assuming, the artist is followed by the client
-- Motivation: client can unfollow an artist

DELETE FROM Following 
WHERE
    client_ID = '1'
    AND artist_ID = (SELECT 
        artist_ID
    FROM
        artistprofile
    
    WHERE
        artist_email = 'pierce70@example.net')

-- Delete the instance of likes of tattoos whom are created by a artist that a client follows
-- Assumption: we know the client and the artist
-- Motivation: unlike all tattoos of a specific artist
DELETE FROM liking 
WHERE
    client_ID = 719
    AND tattoo_ID IN (SELECT 
        tattoo_ID
    FROM
        tattoos
    
    WHERE
        artist_ID = (SELECT 
            artist_ID
        FROM
            artistprofile
        
        WHERE
            artist_email = 'parker.norris@example.net'))