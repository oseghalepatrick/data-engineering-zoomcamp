{{ config(materialized='view') }}

SELECT
  tconst,
  cast(averageRating as numeric) as average_rating,
  cast(numVotes as integer) as number_of_votes,
  CASE
    WHEN averageRating >= 8 THEN 5
    WHEN averageRating >= 6 THEN 4
    WHEN averageRating >= 4 THEN 3
    WHEN averageRating >= 2 THEN 2
  ELSE
  1
END
  AS rating_level
FROM
  {{ source('staging','title_ratings_data') }}
LIMIT
  1000