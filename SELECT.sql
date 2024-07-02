/*
Задание №2
 */

--Название и продолжительность самого длительного трека
SELECT track_name, track_duration
FROM tracks
WHERE track_duration = (SELECT MAX(track_duration) FROM tracks);

--Название треков, продолжительность которых не менее 3,5 минут
--Исправлено: исправлен оператор сравнения
SELECT track_name
FROM tracks
WHERE track_duration >= 210;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT digest_name 
FROM digests
WHERE digest_year BETWEEN 2018 AND 2020;

--Исполнители, чьё имя состоит из одного слова
SELECT artist_name
FROM artists
WHERE artist_name NOT LIKE '% %';

--Название треков, которые содержат слово «мой» или «my»
--Исправлено: исправлен основной запрос, добавлены варианты с использованием функции и регулярного выражения
SELECT track_name
FROM tracks t 
WHERE track_name ILIKE 'my' OR 
	  track_name ILIKE '% my' OR 
	  track_name ILIKE 'my %' OR 
	  track_name ILIKE '% my %';
	 
SELECT track_name
FROM tracks t 
WHERE string_to_array(lower(track_name), ' ') && ARRAY['my','мой'];

SELECT track_name
FROM tracks t 
WHERE track_name ~* '(\mmy\M|\mмой\M)';

/*
Задание №3
*/

--Количество исполнителей в каждом жанре
SELECT genre_name, COUNT(a.artist_id)
FROM genres_artists ga
JOIN genres g ON g.genre_id = ga.genre_id 
JOIN artists a ON ga.artist_id = a.artist_id
GROUP BY g.genre_name;

--Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(track_name)
FROM albums a
LEFT JOIN tracks t ON a.album_id = t.album_id
WHERE album_year BETWEEN 2019 AND 2020;

--Средняя продолжительность треков по каждому альбому
SELECT album_name, AVG(track_duration) 
FROM albums a
LEFT JOIN tracks t ON a.album_id = t.album_id
GROUP BY album_name;

--Все исполнители, которые не выпустили альбомы в 2020 году
--Исправлено: заменено на вариант с использованием вложенного запроса
SELECT artist_name
FROM artists a 
WHERE artist_name NOT IN (
						  SELECT artist_name 
						  FROM albums_artists aa 
						  JOIN artists a2 ON aa.artist_id = a2.artist_id
						  JOIN albums a3 ON aa.album_id = a3.album_id
						  WHERE album_year = 2020
						 );

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
SELECT digest_name
FROM tracks_digests td 
JOIN digests d ON d.digest_id = td.digest_id 
JOIN tracks t ON td.digest_id = t.track_id 
JOIN albums al ON t.album_id = al.album_id 
JOIN albums_artists aa ON al.album_id = aa.album_id 
JOIN artists ar ON aa.artist_id = ar.artist_id 
WHERE artist_name = 'Starset'
GROUP BY digest_name;

/*
Задание №4
*/

--Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT al.album_name
FROM albums_artists aa 
JOIN albums al ON aa.album_id = al.album_id
JOIN artists ar ON aa.artist_id = ar.artist_id 
WHERE ar.artist_name IN (
						 SELECT ar.artist_name
						 FROM genres_artists ga 
						 JOIN artists ar ON ga.artist_id = ar.artist_id 
						 JOIN genres g ON ga.genre_id = g.genre_id 
						 GROUP BY ar.artist_name
						 HAVING COUNT(g.genre_name) > 2
						)
GROUP BY al.album_name;

--Наименования треков, которые не входят в сборники
SELECT track_name 
FROM tracks_digests td 
FULL JOIN tracks t ON t.track_id = td.track_id 
FULL JOIN digests d ON td.digest_id = d.digest_id 
WHERE digest_name IS NULL;

--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько
SELECT ar.artist_name
FROM albums_artists aa 
JOIN artists ar ON aa.artist_id = ar.artist_id 
JOIN albums al ON aa.album_id  = al.album_id 
JOIN tracks t ON al.album_id = t.album_id
WHERE t.track_duration = (
						   SELECT MIN(track_duration)
						   FROM tracks t
						  )
GROUP BY ar.artist_name;

--Названия альбомов, содержащих наименьшее количество треков
SELECT album_name
FROM tracks t
JOIN albums a ON a.album_id = t.album_id 
GROUP BY a.album_name
HAVING COUNT(t.track_id) = (
							SELECT MIN(quantity)
							FROM (
								  SELECT COUNT(t.track_id) quantity
								  FROM tracks t
								  GROUP BY t.album_id
								 )
							);