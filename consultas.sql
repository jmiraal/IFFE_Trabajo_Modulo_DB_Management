


/********************************************************************/
/** Primer país de destino de cada usuario.                  ********/
/** Porcentaje usuarios que eligen cada uno de los países    ********/
/** por primera vez.                  *******************************/
/********************************************************************/

WITH first_country_by_user
AS
   (
         SELECT   u.id             AS id_user,
                  c.country        AS country_first_booking,         
                  MIN(d.date)      AS date_first_booking
         FROM     fact_user_data u
         JOIN     dim_country c
         ON       c.id = u.id_country_destination
         JOIN     dim_date d
		 ON       d.id = u.id_date_first_booking
         GROUP BY id_user
   )
SELECT   country_first_booking                         AS country_first_booking, 
         count(*)                                      AS num_users,
         ROUND(100 * COUNT(*) / CAST(SUM(count(*)) 
                             OVER () AS FLOAT), 2)     AS percentage
FROM     first_country_by_user
GROUP BY country_first_booking;