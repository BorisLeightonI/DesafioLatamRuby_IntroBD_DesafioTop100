CREATE DATABASE peliculas;
\c peliculas
CREATE TABLE IF NOT EXISTS peliculas(
id SERIAL PRIMARY KEY,
pelicula VARCHAR(100),
estreno_año INT,
director VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS reparto(
pelicula_id INT,
actor VARCHAR(30),
CONSTRAINT fk_peliculas
    FOREIGN KEY(pelicula_id)
        REFERENCES peliculas(id)
);

-- ARCHIVOS EN ESCRITORIO!!
COPY peliculas
FROM '/home/user/Escritorio/peliculas.csv' DELIMITER ',' CSV HEADER;
    
COPY reparto
FROM '/home/user/Escritorio/reparto.csv' DELIMITER ',' CSV HEADER;

-- 4
SELECT pelicula,estreno_año,director,reparto.actor  FROM peliculas LEFT JOIN reparto ON id=reparto.pelicula_id WHERE id=2;

--5 Listar los titulos de las películas donde actúe Harrison Ford.
SELECT pelicula FROM peliculas LEFT JOIN reparto ON id=reparto.pelicula_id WHERE reparto.actor='Harrison Ford';

-- 6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100
SELECT director,COUNT(*) AS Peliculas_en_top_100 from peliculas GROUP BY director ORDER BY COUNT(*) DESC LIMIT(10);

--7. Indicar cuantos actores distintos hay 
SELECT COUNT(DISTINCT actor) AS actores_distintos FROM reparto;

--8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.(1 punto)
SELECT pelicula FROM peliculas WHERE estreno_año BETWEEN 1990 AND 1999 ORDER BY pelicula;

--9. Listar el reparto de las películas lanzadas el año 2001 
SELECT DISTINCT(reparto.actor)  FROM peliculas LEFT JOIN reparto ON id=reparto.pelicula_id WHERE peliculas.estreno_año=2001;

--10. Listar los actores de la película más nueva 
SELECT DISTINCT(reparto.actor)  FROM peliculas LEFT JOIN reparto ON id=reparto.pelicula_id WHERE peliculas.estreno_año=(SELECT MAX(estreno_año) FROM peliculas);
