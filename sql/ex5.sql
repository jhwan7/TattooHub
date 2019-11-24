-- List all artists that have stated there genre 'realism'
SELECT 
    artist_fName, artist_lName
FROM
    ArtistProfile
WHERE
    artist_ID IN (SELECT 
            artist_ID
        FROM
            ArtistGenre
        WHERE
            genre_id = (SELECT 
                    genre_ID
                FROM
                    Genre
                WHERE
                    genre_type = 'realism'))

-- The artist names and the studio they work in
SELECT 
    studio_name, artist_fName, artist_lName
FROM
    Studio
        JOIN
    ArtistProfile ON (Studio.studio_ID = ArtistProfile.studio_ID)

-- Counting the number of follows for each artist 
SELECT 
    artist_ID,
    artist_fName,
    artist_lName,
    COUNT(*) AS TotalFollows
FROM
    (SELECT 
        ArtistProfile.artist_ID,
            ArtistProfile.artist_fName,
            ArtistProfile.artist_lName,
            Following.client_ID
    FROM
        ArtistProfile
    INNER JOIN Following ON ArtistProfile.artist_ID = Following.artist_ID) Artist_Follows
GROUP BY artist_ID , artist_fName , artist_lName
ORDER BY artist_ID ASC

-- Return all hashtags on a tattoo based on its image path 
SELECT 
    hashtag
FROM
    Hashtag
WHERE
    hashtag_ID = (SELECT 
            hashtag_ID
        FROM
            Hashtagging
        WHERE
            tattoo_ID = (SELECT 
                    tattoo_ID
                FROM
                    Tattoos
                WHERE
                    tattoo_imagePath = '1'))

-- List of most liked tattoos for each genre 
SELECT 
    Tattoos_Likes.tattoo_ID,
    Tattoos_Likes.tattoo_date,
    Tattoos_Likes.tattoo_imagePath,
    Tattoos_Likes.Num_Likes,
    Genre.genre_type
FROM
    Genre
        INNER JOIN
    (SELECT 
        Tattoos.tattoo_ID,
            Tattoos.tattoo_date,
            tattoos.tattoo_imagePath,
            tattoos.genre_ID,
            Tattoos_w_Likes.Num_Likes
    FROM
        Tattoos
    INNER JOIN (SELECT 
        tattoo_ID, COUNT(*) AS Num_Likes
    FROM
        Liking
    GROUP BY tattoo_ID) AS Tattoos_w_Likes ON Tattoos.tattoo_ID = Tattoos_w_Likes.tattoo_ID) AS Tattoos_Likes ON Genre.genre_ID = Tattoos_Likes.genre_ID
    ORDER BY genre_type , Num_Likes DESC;

-- List all artists and there tattoo style (genre) 
SELECT 
    AP.artist_ID,
    AP.artist_fName,
    AP.artist_lName,
    Genre.genre_type
FROM
    (ArtistProfile AP
    INNER JOIN ArtistGenre USING (artist_ID))
        INNER JOIN
    Genre USING (genre_ID)
ORDER BY AP.artist_ID ASC