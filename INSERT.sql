/*
Задание №1
 */

--Добавление жанров в таблицу genres
INSERT INTO genres(genre_name)
VALUES ('nu-metal'),
	   ('rock'),
	   ('metal'),
	   ('punk-rock'),
	   ('post-grunge');

--Добавление исполнителей в таблицу artists
INSERT INTO artists(artist_name)
VALUES ('KoRn'),
	   ('Starset'),
	   ('In Flames'),
	   ('Green Day'),
	   ('Nickelback');

--Добавление альбомов в таблицу albums
INSERT INTO albums(album_name, album_year)
VALUES ('Siren Charms', 2014),
	   ('Come Clarity', 2006),
	   ('The Paradigm Shift', 2013),
	   ('Issues', 1999),
	   ('Who Do You Trust', 2019),
	   ('Rise', 2013),
	   ('Divisions', 2019),
	   ('Vessels', 2018),
	   ('Feed The Machine', 2017),
	   ('13 Voices', 2016);

--Добавление треков в таблицу tracks
INSERT INTO tracks(album_id, track_name, track_duration)
VALUES (10, 'A Murder of Crows', 184),
	   (10, '13 Voices', 272),
	   (9, 'Song On Fire', 230),
	   (9, 'Must Be Nice', 222),
	   (8, 'Starlight', 286),
	   (7, 'Stratosphere', 257),
	   (6, 'Rise', 260),
	   (6, 'Battle Cry', 225),
	   (5, 'Elevate', 191),
	   (4, 'Counting', 217),
	   (3, 'Love & Meth', 243),
	   (3, 'Never Never', 221),
	   (2, 'Vacuum', 219),
	   (2, 'Scream', 193),
	   (1, 'Siren Charms', 185),
	   (1, 'My Generation', 193);

--Добавление сборников в таблицу digests
INSERT INTO digests(digest_name, digest_year)
VALUES ('The Greatest Hits', 2004),
	   ('Super Hits', 2015),
	   ('It Was Awesome', 2020),
	   ('Happy Holidays', 2021);

--Заполнение таблицы genres_artists для формирования связи "многие ко многим"
INSERT INTO genres_artists(genre_id, artist_id)
VALUES (1, 1),
	   (2, 1),
	   (3, 1),
	   (2, 2),
	   (5, 2),
	   (3, 3),
	   (5, 3),
	   (4, 4),
	   (5, 4),
	   (5, 5),
	   (2, 5);

--Заполнение таблицы albums_artists для формирования связи "многие ко многим"
INSERT INTO albums_artists(album_id, artist_id)
VALUES (1, 3),
	   (2, 3),
	   (3, 1),
	   (4, 1),
	   (5, 5),
	   (5, 4),
	   (6, 4),
	   (6, 3),
	   (7, 2),
	   (8, 2),
	   (9, 5),
	   (10, 4),
	   (10, 2);

--Заполнение таблицы tracks_digests для формирования связи "многие ко многим"
INSERT INTO tracks_digests(track_id, digest_id)
VALUES (2, 1),
	   (4, 1),
   	   (11, 1),
	   (13, 2),
	   (6, 2),
	   (11, 3),
	   (2, 3),
	   (13, 3),
	   (9, 4),
	   (16, 4);

